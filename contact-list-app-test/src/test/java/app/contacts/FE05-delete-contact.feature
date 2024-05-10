@FE05
Feature: Delete Contact

  Background: login and adding contact
    Given url baseUrl
    # setup
    * def testUser = read('classpath:test-data/test-users.json')[2]
    * def testContact = read('classpath:test-data/test-contacts.json')[0]
    # adding contact
    * def addContact = callonce read('classpath:util/add-contact.feature') {user : #(testUser), contact : #(testContact)}
    * def contactId = addContact.response._id
    # user login
    * def loginUser = callonce read('classpath:util/login-user.feature'){email : #(testUser.email), password: #(testUser.password)}
    * configure headers = {Authorization : #(loginUser.response.token)}

  @FE05SE01
  Scenario: Make delete request for a contact
    Make a delete request, verify that the contact can no longer be retreived
    
    Given path 'contacts', contactId
    When method delete
    Then status 200
    Given path 'contacts', contactId
    When method get
    Then status 404
