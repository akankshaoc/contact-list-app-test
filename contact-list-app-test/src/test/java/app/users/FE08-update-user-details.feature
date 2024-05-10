@FE08 @parallel=false
Feature: Update User details

  Background: setup
    Given url baseUrl
    # setup
    * def testUser = read('classpath:test-data/test-users.json')[7]
    * def testUserPersistent = read('classpath:test-data/test-users.json')[7]
    * def angelicaSchuyler = {email : 'angelica.shuyler02@revolution.com', password : 'illneverbesatisfied'}

  @FE08SE01
  Scenario Outline: Update user <detail>
    Update User's details and verify that the new details retreived match the updated details

    * def loginUser = call read('classpath:util/login-user.feature'){email : #(testUser.email), password: #(testUser.password)}
    Given path 'users', 'me'
    And request {<detail> : <value>}
    * header Authorization = loginUser.response.token
    When method patch
    Then status 200
    And match response contains {<detail> : <value>}

    Examples: 
      | detail    | value      |
      | firstName | 'angelica' |
      | lastName  | 'schuyler' |

  @FE08SE02
  Scenario Outline: Update user <credentials>
    Update User's credentails and verify that they can only login with their new credentials now

    * def loginUser = callonce read('classpath:util/login-user.feature'){email : #(testUser.email), password: #(testUser.password)}
    Given path 'users', 'me'
    * set testUser.<credentials> = angelicaSchuyler.<credentials>
    And request {<credentials> : <value>}
    * header Authorization = loginUser.response.token
    When method patch
    Then status 200
    * def loginNew = call read('classpath:util/login-user.feature'){email : #(testUser.email), password: #(testUser.password)}
    * def loginOld = call read('classpath:util/login-user.feature'){email : #(testUserPersistent.email), password: #(testUserPersistent.password)}
    Then match loginNew.responseStatus == 200
    Then match loginOld.responseStatus == 401
    # restoration
    * header Authorization = loginNew.response.token
    Given path 'users', 'me'
    And request testUserPersistent
    When method patch
    * set testUser.<credentials> = testUserPersistent.<credentials>

    Examples: 
      | credentials | value                        |
      | email       | #(angelicaSchuyler.email)    |
      | password    | #(angelicaSchuyler.password) |
