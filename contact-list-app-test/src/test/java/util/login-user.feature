Feature: login user with given email and password

  Scenario: `login user with ${email} and ${password}`
    Given url baseUrl
    And path 'users', 'login'
    And request {email : #(email), password : #(password)}
    When method post