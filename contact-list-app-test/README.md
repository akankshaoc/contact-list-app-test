# Contact List App Test

This is an automated test application to validate the functionality of the [contact list app API](https://documenter.getpostman.com/view/4012288/TzK2bEa8)

## Scope of Tests

### Contacts

> All of the following features are available for a logged in user, and therefore, all tests are conducted assuming the same

1. Add Contact
2. Get Contact List
3. Get Contact
4. Update Contact - Using Patch and Put
5. Delete Contact

### Users

1. Add User
2. Get User Profile
3. Update User
4. Log Out User
5. Log In User
6. Delete User

## Test Scenarios

Refer to the [test scenario sheet]()

## Running Locally

- clone repository
- from the root, `./contcat-list-app`, run command `mvn test`
- if you wish to run a particular scenario or feature, refer to the [test scenario sheet]() for tag, `e.g. @FE01, @FE02SE01` and run tests with the following command `mvn test -Dkarate.options='--tags @IDTAG'`