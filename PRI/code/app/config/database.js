

module.exports = {
	mongodb: {
		'development' : 'mongodb://localhost/pigero',
		'production'  : process.env.MONGOHQ_URL
	},
	redis: {
		'development' : 'redis://127.0.0.1:6379/0',
		'production'  : process.env.REDISCLOUD_URL
	}
};