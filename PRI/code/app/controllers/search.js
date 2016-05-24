
var async = require('async')

  , Guide = require('../models/guide')
  , User  = require('../models/user');


exports.find = function(req, res, next) {
	var query = req.params.query;

	async.parallel({
		guides: function(callback) {
			Guide.aggregate([
				{ $match: { $text: { $search: query } } },
				{ $sort:  { score: { $meta: 'textScore'} } },
				{ $project : 
					{ 
						_id   : 1, 
						title : 1, 
						description: 1,
						avg: 1,
						places: 1
					} 
				}
			], callback);
		},
		users: function(callback) {
			User.aggregate([
				{ $match: { $text: { $search: query } } },
				{ $sort:  { score: { $meta: 'textScore'} } },
				{ $project : 
					{ 
						_id   : 1, 
						name  : 1,
						picture : 1,
						city: 1,
						country: 1				
					} 	
				}
			], callback);
		}
	}, function(err, results) {
		if (err) return next(err);

		res.jsonp(results);
	});
};