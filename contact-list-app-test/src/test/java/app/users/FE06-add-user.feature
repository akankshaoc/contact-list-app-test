@FE06
Feature: Add User

  Background: setup
    * def signedUpUser = read('classpath:test-data/test-users.json')[5]

  @FE06SE01
  Scenario: Add new user successfully
    Add new user and verify that the user is able to log in

    * def alexanderHamilton = {firstName : 'alexander', lastName : 'hamilton', email : 'alexander.hamilton.177@revolution.com', password : 'elizashetellsmystory'}
    * def signUpUser = call read('classpath:util/sign-up-user.feature') {user : #(alexanderHamilton)}
    * match signUpUser.responseStatus == 201
    * def loginUser = callonce read('classpath:util/login-user.feature'){email : #(alexanderHamilton.email), password: #(alexanderHamilton.password)}
    * match loginUser.responseStatus == 200
    # cleanup - delete alexanderHamilton
    * callonce read('classpath:util/delete-user.feature'){user : #(alexanderHamilton)}

  @FE06SE02
  Scenario Outline: Add new user with missing <detail>
    Try adding new user with missing details, no such request should be accepted

    * def elizaSchuyler = {firstName : 'eliza', lastName : 'schuyler', email : 'eliza.schuyler.76@revolution.com', password : 'theworlhasnoplaceinourbed'}
    * remove elizaSchuyler.<detail>
    * def signUpUser = call read('classpath:util/sign-up-user.feature') {user : #(elizaSchuyler)}
    * def message = karate.jsonPath(signUpUser.response, "$..<detail>.message")
    * match message[0] == <message>

    Examples: 
      | detail    | message                         |
      | firstName | 'Path `firstName` is required.' |
      | lastName  | 'Path `lastName` is required.'  |
      | email     | 'Path `email` is required.'     |
      | password  | 'Path `password` is required.'  |

  @FE06SE03
  Scenario Outline: Add new user with invalid <detail>
    Try adding new user with invalid details, no such request should be accepted

    * def elizaSchuyler = {firstName : 'eliza', lastName : 'schuyler', email : 'eliza.schuyler@revolution.com', password : 'theworlhasnoplaceinourbed'}
    * set elizaSchuyler.<detail> = <invalid-value>
    * def signUpUser = call read('classpath:util/sign-up-user.feature') {user : #(elizaSchuyler)}
    * def message = karate.jsonPath(signUpUser.response, "$..<detail>.message")
    * match message[0] == <message>

    Examples: 
      | detail   | invalid-value  | message                                                                     |
      | email    | "invlaidEmail" | 'Email is invalid'                                                          |
      | password | "12345"        | 'Path `password` (`12345`) is shorter than the minimum allowed length (7).' |

  @FE06SE04
  Scenario: Add new user with email already in use
    * def signUpUser = call read('classpath:util/sign-up-user.feature') {user : #(signedUpUser)}
    * match signUpUser.response.message == "Email address is already in use"
