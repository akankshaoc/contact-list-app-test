Feature: Sign Up a new User

  Scenario: `sign up user ${user.firstName} ${user.lastName}`
    Given url 'https://thinking-tester-contact-list.herokuapp.com'
    And path 'users'
    And request user
    * method post
