
var mongoose = require('mongoose')
  , Schema   = mongoose.Schema

  , validate = require('mongoose-validator').validate
  , bcrypt   = require('bcrypt')
  , url 	 = require('url');


var userSchema = Schema({
	name      : {
		first : { type: String, index: 'text', required: true, trim: true },
		last  : { type: String, index: 'text', required: true, trim: true }
	},
	email     : { type: String, index: 'text', required: true },
	password  : { type: String, required: true  },
	reset 	  : {
		token  : { type: String },
		expire : { type: Date   }
	},
	city      : { type: String },
	country   : { type: String },
	gender    : { type: String },
	picture   : { type: String, default: 'defaultPicture.jpg' },
	cover     : { type: String, default: 'defaultCover.jpg'},
	about	  : { type: String },
	guides    : [{ type: Schema.ObjectId, ref: 'Guide'}],
	favorites : [{ type: Schema.ObjectId, ref: 'Guide'}],
	created   : { type: Date, required: true, default: Date.now },
	updated   : { type: Date, required: true, default: Date.now }
});


userSchema.virtual('name.full')
.set(function(name) {
	var split = name.split(' ');
	this.name.first = split[0];
	this.name.last  = split[1];
})
.get(function() {
	return this.name.first + ' ' + this.name.last;
});

userSchema.virtual('absolute')
.get(function() {
	return this.name.first + ' ' + this.name.last;
});


userSchema.methods.generateHash = function(password) {
	return bcrypt.hashSync(password, bcrypt.genSaltSync(10));
};

userSchema.methods.validatePassword = function(password) {
	return bcrypt.compareSync(password, this.password)
};

userSchema.methods.changePassword = function(oldPassword, newPassword, next) {
	if(!this.validatePassword(oldPassword))
		return next(err);

	this.password = this.generateHash(newPassword);

	this.save(function(err) {
    	if (err) next(err);
    	return next(null, this);
    });
};


module.exports = mongoose.model('User', userSchema);