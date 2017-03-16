/**
 * Created by Javelin on 4.3.2017.
 */

var express = require('express');
var router = express.Router();
var pool = require('../config-postgreSQL');
var crypto = require('crypto');
var util = require('../helpers/util');
var moment = require('moment');
var binder = require('model-binder');

router.get('/', function (req,res){
    res.render('playerMap');
});

router.get('/showtable', function (req,res){
    pool.query('select pokemontype.name, playerpokemon.customname from pokemontype INNER JOIN ' +
        'playerpokemon on pokemontype.id = playerpokemon.pokemontypeid where username=$1', [req.authUser], function(err, result) {
        res.send(result.rows);
    });
});

router.post('/getpokemonlocation', function (req,res){
    var id = Math.floor(Math.random() * 20) + 1;
    pool.query('select name, x, y from pokemontype where id=$1', [id], function(err, result1){
        pool.query('update player set lat=$1, lon=$2 where username=$3', [req.body.lat, req.body.lng, req.authUser]);
        var lok = util.randomLocationInRadius100m(req.body);
        pool.query("insert into sentpokemons (pokemontypeid, lat, lon, expired, expiretimestamp) " +
            "values($1, $2, $3, $4, CURRENT_TIMESTAMP + interval '10 minutes') returning id", [id, lok.lat, lok.lng, false], function(err, result2){
            var rez = {id: result2.rows[0].id, name: result1.rows[0].name, x: result1.rows[0].x, y: result1.rows[0].y, lok: lok};
            res.send(rez);
        });
    });
});

router.get('/getotherplayerslocation', function (req,res){
    var response = [];
    pool.query('Select * from player where isonline=true', function(err, result){
        var userLoc;
        for (var i = 0; i < result.rows.length; i++){
            if (result.rows[i].username == req.authUser){
                userLoc = {lat: result.rows[i].lat, lng: result.rows[i].lon};
            }
        }
        for (var i = 0; i < result.rows.length; i++){
            if (result.rows[i].username != req.authUser){
                if (util.checkIfInRadius(userLoc.lat, userLoc.lng, result.rows[i].lat, result.rows[i].lon)){
                    var userData = {username: result.rows[i].username, lat: result.rows[i].lat, lon: result.rows[i].lon };
                    response.push(userData);
                }
            }
        }
        res.send(response);
    });
});

router.post('/catchpokemon', function (req,res){
    var pokemons = new (require('../models/pokemons.js'))();
    pokemons.id = req.body.id;
    pokemons.user = req.authUser;
    pokemons.catch(function (data) {
        res.send(data);
    }, function (err) {
        res.sendStatus(400);
    });
});


/*
 var chance = Math.random();
 if (chance < 0.35){
 pool.query('delete from sentpokemons where id=$1', [req.body.id], function(err, result){
 res.send({success: false});
 });
 }
 else {
 pool.query('select pokemontypeid, expiretimestamp from sentpokemons where id=$1 and expiretimestamp > localtimestamp', [req.body.id], function(err, result1){
 if (result1.rows.length == 0) {
 res.sendStatus(400);
 return;
 }
 pool.query('insert into playerpokemon values($1,$2)', [req.authUser, result1.rows[0].pokemontypeid], function(err, result2){
 pool.query('select name from pokemontype where id=$1', [result1.rows[0].pokemontypeid], function(err, result3){
 pool.query('delete from sentpokemons where id=$1', [req.body.id]);
 res.send({success: true, name: result3.rows[0].name, pokemontypeid: result1.rows[0].pokemontypeid});
 });
 });
 });
 }*/




router.post('/givecustomname', function (req,res){
    pool.query('update playerpokemon set customname=$1 where username=$2 and pokemontypeid=$3',
               [req.body.customName, req.authUser, req.body.pokemontypeid], function(err, result){
        res.sendStatus(200);
    });
});

router.post('/sendchallenge', binder(require('../models/challenge.js')), function (req,res){
   //console.log(req.requestModel);
   var challenge = req.requestModel;
   challenge.sentby = req.authUser;
   challenge.create(function (data) {
       res.sendStatus(200);
   }, function (err) {
       res.sendStatus(400);
   });
});

router.get('/getchallenge', function (req,res){
    var challenge = new (require('../models/challenge.js'))();
    challenge.sentto = req.authUser;
    challenge.getByRecipient(function (data) {
        res.send(data);
    }, function (err) {
        res.sendStatus(400);
    });
   /* pool.query('update challenges set delivered=true where delivered=false and sentto=$1 returning *',
        [req.authUser], function(err, result){
            res.send(result.rows);
        });*/
});

router.get('/logout', function (req, res) {
   pool.query('update player set isonline=false where username=$1', [req.authUser], function(err, result){
       res.redirect('/');
   });
});

module.exports = router;