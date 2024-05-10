Feature: `delete all contacts of ${user}`

  Background: login
    Given url baseUrl
    * def loginUser = call read('classpath:util/login-user.feature'){email : #(user.email), password: #(user.password)}
    * configure headers = {Authorization : #(loginUser.response.token)}

  Scenario: 
    Given path 'contacts'
    When method get
    * def contactIds = get response[*]._id
    * karate.forEach(contactIds, id => karate.call('classpath:util/delete-contact.feature', {user : user, id : id}))
