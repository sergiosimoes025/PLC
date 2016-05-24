
var assert 	 = require('assert')
  , mongoose = require('mongoose')
  , User 	 = require('../app/models/user');


describe('User', function() {

	mongoose.connect('mongodb://localhost/pigero-test');

	var dummyUser = new User({
		name 	 : { first: 'Fernando', last: 'Martins' },
		email    : 'nazgul.cod@gmail.com',
		password : 'pass', 
		city     : 'Braga',
		country  : 'Portugal',
		gender   : 'Male'
	});

	after(function(done){
	    User.remove(function(err){
	        mongoose.connection.close();
	        done();
	    });        
	});

	describe('.save()', function() {
		it('should save without error', function(done) {
			dummyUser.save(done);
		});
	});

	describe('.findOne()', function() {
		it('should match entries', function(done) {
			User.findOne({ email: dummyUser.email }, function(err, user) {
				if (err) throw err;
				assert.equal(user.email, dummyUser.email);
				done();
			});
		});
	});
	
});

