/**
 * Created by Javelin on 4.3.2017.
 */

var express = require('express');
var router = express.Router();
var pool = require('../config-postgreSQL');
var binder = require('model-binder');

router.get('/', function (req,res){
    res.render('playerMap');
});

router.get('/showtable', function (req,res){
    var pokemons = new (require('../models/pokemons.js'))();
    pokemons.user = req.authUser;
    pokemons.showUserPokemons(function (data) {
        res.send(data);
    }, function (err) {
        res.sendStatus(400);
    });
});

router.post('/getpokemonlocation', binder(require('../models/pokemons.js')), function (req,res){
    var pokemons = req.requestModel;
    pokemons.user = req.authUser;
    pokemons.userLat = req.body.lat;
    pokemons.userLng = req.body.lng;
    pokemons.getLocation(function (data) {
        res.send(data);
    }, function (err) {
        res.sendStatus(400);
    });
});

router.get('/getotherplayerslocation', function (req,res){
    var users =  new (require('../models/users.js'))();
    users.user = req.authUser;
    users.getOtherUsersLocation(function (data) {
        res.send(data);
    }, function (err) {
        res.sendStatus(400);
    });
});

router.post('/catchpokemon', binder(require('../models/pokemons.js')), function (req,res){
    var pokemons = req.requestModel;
    pokemons.id = req.body.id;
    pokemons.user = req.authUser;
    pokemons.catch(function (data) {
        res.send(data);
    }, function (err) {
        res.sendStatus(400);
    });
});

router.post('/givecustomname', binder(require('../models/pokemons.js')), function (req,res){
    var pokemons = req.requestModel;
    pokemons.customName = req.body.customName;
    pokemons.user = req.authUser;
    pokemons.pokemontypeid = req.body.pokemontypeid;
    pokemons.giveCustomName(function () {
        res.sendStatus(200);
    }, function (err) {
        res.sendStatus(400);
    });
});

router.post('/sendchallenge', binder(require('../models/challenge.js')), function (req,res){
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
});

router.get('/logout', function (req, res) {
    var users = new (require('../models/users.js'))();
    users.user = req.authUser;
    users.logOut(function(){
       res.redirect('/');
    }, function () {
        res.sendStatus(400);
    });

});

module.exports = router;