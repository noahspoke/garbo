var app = require('express')();
var redis = require('redis');
var scanner = require('redis-scanner');

var client = redis.createClient();

client.on('error', function (error) {
	console.log("Error: " + error);
});

app.set('port', (process.env.PORT || 5000));

app.get('/search', function (req, res) {

});

app.post('/add', function (req, res) {

});

app.listen(app.get('port'), function () {
	console.log("Server started on port " + app.get('port'));
});