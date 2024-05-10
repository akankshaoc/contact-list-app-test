Feature: get the details of logged in user

  Scenario: 
    Given url baseUrl
    And path 'users', 'me'
    When method get
