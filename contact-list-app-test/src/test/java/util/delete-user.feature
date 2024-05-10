Feature: `delete user ${user.firstName}`

  Background: login
    Given url baseUrl
    * def loginUser = call read('classpath:util/login-user.feature'){email : #(user.email), password: #(user.password)}
    * configure headers = {Authorization : #(loginUser.response.token)}

  Scenario: 
    Given path 'users', 'me'
    When method delete
