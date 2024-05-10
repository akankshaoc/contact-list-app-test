@FE04
Feature: Update Contact

  Background: login and adding contact
    Given url baseUrl
    # setup
    * def testUser = read('classpath:test-data/test-users.json')[2]
    * def testContact1 = read('classpath:test-data/test-contacts.json')[0]
    * def testContact2 = read('classpath:test-data/test-contacts.json')[1]
    # adding contact
    * def addContact = callonce read('classpath:util/add-contact.feature') {user : #(testUser), contact : #(testContact1)}
    * def contactId = addContact.response._id
    # user login
    * def loginUser = callonce read('classpath:util/login-user.feature'){email : #(testUser.email), password: #(testUser.password)}
    * configure headers = {Authorization : #(loginUser.response.token)}

  @FE04SE01
  Scenario Outline: Make patch requests to update <feild>
    Make Patch requests to update fields, verify if the update has been successful and the id remains unchanged

    Given path 'contacts', contactId
    And request { <feild> : <value> }
    When method patch
    Then status 200
    * match response.<feild> == <value>
    * match response._id == contactId

    Examples: 
      | feild     | value                 |
      | firstName | 'akanksha'            |
      | lastName  | 'sharma'              |
      | birthdate | '2001-10-29'          |
      | email     | 'akanhsha@sharma.com' |
      | phone     | '4455667788'          |

  @FE04SE02
  Scenario: Make put request to update a contact
    Make Put request, verify changes in primary feilds
		
		Given path 'contacts', contactId
		And request testContact2
		When method patch
		Then status 200
		* match response.firstName == testContact2.firstName
		* match response.lastName == testContact2.lastName
    
