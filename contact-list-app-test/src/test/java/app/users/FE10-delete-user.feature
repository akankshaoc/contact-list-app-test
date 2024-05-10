@FE10
Feature: Delete User

  Background: 
    Given url baseUrl
    * def testUser = read('classpath:test-data/test-users.json')[9]
    * def loginUser = callonce read('classpath:util/login-user.feature'){email : #(testUser.email), password: #(testUser.password)}
		* configure headers = {Authorization : #(loginUser.response.token)}
		
  @FE10SE01
  Scenario: Deleted User cannot sign in
    Given path 'users', 'me'
    When method delete
    Then status 200
    * def loginAfterDelete = call read('classpath:util/login-user.feature'){email : #(testUser.email), password: #(testUser.password)}
    * match loginAfterDelete.responseStatus == 401
