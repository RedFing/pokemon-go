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
    var pokemon = new (require('../models/pokemon.js'))();
    pokemon.user = req.authUser;
    pokemon.getByUser(function (data) {
        res.send(data);
    }, function (err) {
        res.sendStatus(400);
    });
});

router.post('/spawnpokemon', binder(require('../models/pokemon.js')), function (req, res){
    var pokemon = req.requestModel;
    pokemon.user = req.authUser;
    pokemon.spawn({lat: req.body.lat, lng: req.body.lng
        }, function (data) {
            res.send(data);
        }, function (err) {
            res.sendStatus(400);
    });
});

router.get('/getotherplayerslocation', function (req,res){
    var users = new (require('../models/users.js'))();
    users.user = req.authUser;
    users.getOtherUsersLocation(function (data) {
        res.send(data);
    }, function (err) {
        res.sendStatus(400);
    });
});

router.post('/catchpokemon', binder(require('../models/pokemon.js')), function (req, res){
    var pokemon = req.requestModel;
    pokemon.id = req.body.id; //ne treba
    pokemon.user = req.authUser; //poslati i pokeid i sentid
    pokemon.catch(function (data) {
        res.send(data);
    }, function (err) {
        res.sendStatus(400);
    });
});

router.post('/givecustomname', binder(require('../models/pokemon.js')), function (req, res){
    var pokemon = req.requestModel;
    pokemon.customName = req.body.customName;
    pokemon.user = req.authUser;
    pokemon.pokemontypeid = req.body.pokemontypeid;
    pokemon.giveCustomName(function () {
        res.sendStatus(200);
    }, function (err) {
        res.sendStatus(400);
    });
});

router.post('/sendchallenge', binder(require('../models/challenge.js')), function (req,res){
   var challenge = req.requestModel;
   challenge.sender = req.authUser;
   challenge.recipient = req.body.recipient;
   challenge.create(function (data) {
       res.send(data);
   }, function (err) {
       res.sendStatus(400);
   });
});

router.get('/getchallenge', function (req,res){
    var challenge = new (require('../models/challenge.js'))();
    challenge.recipient = req.authUser;
    challenge.getByRecipient(function (data) {
        res.send(data);
    }, function (err) {
        res.sendStatus(400);
    });
});

router.post('/respondtochallenge', binder(require('../models/challenge.js')), function (req,res){
    var challenge = req.requestModel;
    challenge.id = req.body.id;
    challenge.recipient = req.authUser;
    challenge.response = req.body.response;
    if (challenge.response == 'accept'){
        challenge.accept(function (data) {
            res.send(data);
        }, function (err) {
            res.sendStatus(400);
        });
    }
    else {
        challenge.decline(function () {
            res.sendStatus(200);
        }, function (err) {
            res.sendStatus(400);
        });
    }
});

router.post('/checkforaccept', binder(require('../models/challenge.js')), function (req,res){
    var challenge = req.requestModel;
    challenge.id = req.body.id;
    challenge.sender = req.authUser;
    challenge.checkForAccept(function(data){
        res.send(data);
    },function(err){
        res.sendStatus(400);
    });
});

router.post('/selectpokemon', binder(require('../models/challenge.js')), function (req,res){
    var challenge = req.requestModel;
    if (req.body.usertype == 'senderP'){
        challenge.sender = req.authUser;
        challenge.senderPokemontype = req.body.pokemonid;
    }
    else {
        challenge.recipient = req.authUser;
        challenge.recipientPokemontype = req.body.pokemonid;
    }
    challenge.id = req.body.challengeid;
    challenge.selectFighters(function () {

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