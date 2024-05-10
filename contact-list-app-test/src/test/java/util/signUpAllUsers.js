function signUpTestUsers (){
	const users = karate.read('classpath:test-data/test-users.json');
	for(const user of users) {
		karate.call('classpath:util/sign-up-user.feature', {user : user});
	}
}