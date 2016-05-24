
var mongoose = require('mongoose'),
	Schema   = mongoose.Schema;


var followSchema = Schema({
	user: { type: Schema.ObjectId, ref: 'User', index: true, required: true },
	following: [{ type: Schema.ObjectId, ref: 'User' }],
	followers: [{ type: Schema.ObjectId, ref: 'User' }]
});


followSchema.virtual('followingcount')
.get(function() {
	return this.following.length;
});

followSchema.virtual('followerscount')
.get(function() {
	return this.followers.length;
});


module.exports = mongoose.model('Follow', followSchema);