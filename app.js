var app = require('express')();
var redis = require('redis');
var scanner = require('redis-scanner');

var client = redis.createClient();

scanner.bindScanners(client);

client.on('error', function (error) {
	console.log("Error: " + error);
});

client.hset('user:noah.spochart', 'gender', 'm', redis.print);
client.hset('user:noah.spochart', 'police', 'false', redis.print);

app.set('port', (process.env.PORT || 5000));

app.get('/all', function(req, res) {
	client.hgetall('user:noah.spochart', function(err, result) {
		res.send(result);
	});
});

app.get('/search', function (req, res) {

});

app.post('/add', function (req, res) {

});

app.listen(app.get('port'), function () {
	console.log("Server started on port " + app.get('port'));
});