@FE01
Feature: Add Contact

  Background: login, setup and cleanup tasks
    Given url baseUrl
    * def testUser = read('classpath:test-data/test-users.json')[0]
    * callonce read('classpath:util/truncate-contacts.feature'){user : #(testUser)}
    * def testContact = read('classpath:test-data/test-contacts.json')[0]
    * def loginUser = callonce read('classpath:util/login-user.feature'){email : #(testUser.email), password: #(testUser.password)}
    * configure headers = {Authorization : #(loginUser.response.token)}

  @FE01SE01
  Scenario: Add new contact successfully
    Add a new contact and verify that it can be retreived from the API

    Given path 'contacts'
    And request testContact
    When method post
    Then match responseStatus == 201
    * def id = response._id
    # verify retreival
    Given path 'contacts', id
    When method get
    Then match responseStatus == 200

  #todo - verify error message
  @FE01SE02
  Scenario Outline: Add new contact with missing <detail>
    Try adding new contacts with missing mandatory values, no such request should be accepted

    * def invalidTestContact = testContact
    * remove invalidTestContact.<detail>
    Given path 'contacts'
    And request invalidTestContact
    When method post
    Then match responseStatus == 400
    # verify error message
    * def message = karate.jsonPath(response, "$..<detail>.message")
    * match message[0] == <message>

    Examples: 
      | detail    | message                         |
      | firstName | "Path `firstName` is required." |
      | lastName  | "Path `lastName` is required."  |

  @FE01SE03
  Scenario Outline: Add new contact with invalid <detail>
    Try adding new contacts with invalid field values, no such request should be accepted

    * def invalidTestContact = testContact
    * set invalidTestContact.<detail> = <invalid-value>
    Given path 'contacts'
    And request invalidTestContact
    When method post
    Then match responseStatus == 400
    # verify error message
    * def message = karate.jsonPath(response, "$..<detail>.message")
    * match message[0] == <message>

    Examples: 
      | detail | invalid-value  | message                   |
      | email  | "invalidemail" | "Email is invalid"        |
      | phone  | "invalidphone" | "Phone number is invalid" |