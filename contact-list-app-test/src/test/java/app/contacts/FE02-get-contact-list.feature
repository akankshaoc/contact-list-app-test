@FE02
Feature: Get Contact List

  Background: login, cleanup and re-population tasks
    Given url baseUrl
    # setup
    * def testUser = read('classpath:test-data/test-users.json')[1]
    * def testContacts = read('classpath:test-data/test-contacts.json')
    # cleanup
    * callonce read('classpath:util/truncate-contacts.feature'){user : #(testUser)}
    # repopulation
    * def addContactData = karate.map(testContacts, contact => {return {user : testUser, contact : contact}})
    * callonce read('classpath:util/add-contact.feature') addContactData
    # user login
    * def loginUser = callonce read('classpath:util/login-user.feature'){email : #(testUser.email), password: #(testUser.password)}
    * configure headers = {Authorization : #(loginUser.response.token)}

  @FE02SE01
  Scenario: All retreived Contacts belong to the user
    Retreive the contact list of users, verify that the owner of all the contacts is the logged in user. i.e, No contact of any other user has been retreived

    Given path 'contacts'
    When method get
    * match each response contains { owner : #(loginUser.response.user._id) }

  @FE02SE02
  Scenario: All of the user's contact retreivable
    All the contacts that belong to a particular user must be retreived

    Given path 'contacts'
    When method get
    * def retreivedContacts = karate.map(response, (contact) => {return {firstName : contact.firstName, lastName : contact.lastName}})
    * def insertedContacts = karate.map(testContacts, (contact) => {return {firstName : contact.firstName, lastName : contact.lastName}})
    Then match retreivedContacts contains only insertedContacts
