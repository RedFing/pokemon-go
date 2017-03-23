var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var index = require('./routes/index');
var adminpanel = require('./routes/adminpanel')
var playermap = require('./routes/playermap');

var pool = require('./config-postgreSQL');
const crypto = require('crypto');

const secret = 'abcdefg';
var moment = require('moment');

var app = express();

var authenticator = require('./helpers/authenticator');
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(authenticator({
    routes: ['/ok', '/login', '/register', '/player', '/pokemontype', '/playerpokemon', '/playerMap', '/playerMap/showtable',
             '/playerMap/spawnpokemon', '/playerMap/catchpokemon', '/playerMap/givecustomname', '/playermap/logout',
             '/playermap/getotherplayerslocation', '/playermap/sendchallenge', '/playermap/getchallenge', '/playermap/checkforaccept',
             '/playermap/respondtochallenge', '/playermap/selectpokemon', '/playermap/updateuserlocation'],
    encSecret: 'a password',
    hashSecret: 'abcdefg'
}));

app.use('/', index);
app.use('/adminpanel', adminpanel);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});


// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
