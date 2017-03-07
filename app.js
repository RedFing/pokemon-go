var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var index = require('./routes/index');
var player = require('./routes/player');
var pokemontype = require('./routes/pokemontype');
var playerpokemon = require('./routes/playerpokemon');
var playermap = require('./routes/playermap');

var pool = require('./config-postgreSQL');
const crypto = require('crypto');


const secret = 'abcdefg';
var moment = require('moment');
moment().format();

var app = express();

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

app.use(function (req,res, next) {

    nizRuta = ['/ok', '/player', '/pokemontype', '/playerpokemon', '/playerMap'];
    for (var i = 0; i < nizRuta.length; i++){
        if (req.path == nizRuta[i]){
            if (!req.cookies.kuki){
                res.sendStatus(403);
                return;
            }
            var cipher = crypto.createCipher('aes192', 'a password');
            var decipher = crypto.createDecipher('aes192', 'a password');
            console.log(1,"zasticena ruta", req.path);
            var encrypted = req.cookies.kuki;
            var decrypted = decipher.update(encrypted, 'hex', 'utf8');
            decrypted += decipher.final('utf8');
            var token = JSON.parse(decrypted);
            console.log(5,token);
            if (moment().isAfter(token.valid)){
                console.log("EXPIRED COOKIE");
                res.sendStatus(403);
            }
            pool.query("Select * from player where username=$1" , [token.username], function (err, result) {
                if (result.rows[0].username != token.username) {
                    res.sendStatus(403);
                }
            });
            break;
        }
    }
    next();
});

app.use('/', index);
app.use('/player', player);
app.use('/pokemontype', pokemontype);
app.use('/playerpokemon', playerpokemon);

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
