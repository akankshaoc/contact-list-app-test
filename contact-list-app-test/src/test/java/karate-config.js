function fn() {
	var env = karate.env; // get system property 'karate.env'
	karate.log('karate.env system property was:', env);
	if (!env) {
		env = 'dev';
	}
	var config = {
		env: env,
		baseUrl: 'https://thinking-tester-contact-list.herokuapp.com'
	}
	if (env == 'dev') {
		// customize
		// e.g. config.foo = 'bar';
	} else if (env == 'e2e') {
		// customize
	}
	
	// signing up all test users
	
	karate.callSingle('classpath:util/signUpAllUsers.js');	
	
	return config;
}