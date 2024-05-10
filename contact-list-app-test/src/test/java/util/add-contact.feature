Feature: `adds ${user.firstName}'s contact ${contact.firstName}`

  Background: login
    Given url baseUrl
    * def loginUser = call read('classpath:util/login-user.feature'){email : #(user.email), password: #(user.password)}
    * configure headers = {Authorization : #(loginUser.response.token)}

  Scenario: 
    Given path 'contacts'
    And request contact
    When method post
