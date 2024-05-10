@FE09
Feature: User Log Out

  Background: login
    Given url baseUrl
    # setup
    * def testUser = read('classpath:test-data/test-users.json')[8]
    # user login - set token
    * def loginUser = callonce read('classpath:util/login-user.feature'){email : #(testUser.email), password: #(testUser.password)}
    * configure headers = {Authorization : #(loginUser.response.token)}

  @FE09SE01
  Scenario: Logged Out user cannot access unauthorised routes
    Log Out a user and try using the previous session's Auth token to access unauthorized routes

    Given path 'users', 'logout'
    When method post
    Then status 200
    * def routes = [{route :'users/me'}, {route :'contacts'}]
    * def getAtRoute = call read('classpath:util/get-at-route.feature') routes
    * def responseStatuses = get getAtRoute[*].responseStatus
    * match each responseStatuses == 401
