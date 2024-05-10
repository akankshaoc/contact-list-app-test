@FE07
Feature: Get User Detail

  Background: login
    Given url baseUrl
    # setup
    * def testUser = read('classpath:test-data/test-users.json')[6]
    # user login
    * def loginUser = callonce read('classpath:util/login-user.feature'){email : #(testUser.email), password: #(testUser.password)}
    * configure headers = {Authorization : #(loginUser.response.token)}

  @FE07SE01
  Scenario: Verify if users can fetch their details
    Fetch user details after logging in and verify if all the details retreived are correct

    Given path 'users', 'me'
    When method get
    Then status 200
    And match response ==
      """
      {
	      "_id": "#string",
	      "firstName": #(testUser.firstName),
	      "lastName": #(testUser.lastName),
	      "email": #(testUser.email),
	      "__v": "#number"
      }
      """
