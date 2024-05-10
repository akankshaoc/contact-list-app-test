Feature: `delete ${user.firstName}'s contact with id ${id}`

  Background: login
    Given url baseUrl
    * def loginUser = call read('classpath:util/login-user.feature'){email : #(user.email), password: #(user.password)}
    * configure headers = {Authorization : #(loginUser.response.token)}

  Scenario: 
    Given path 'contacts', id
    When method delete
