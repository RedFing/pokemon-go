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
    var pokemons = new (require('../models/pokemon.js'))();
    pokemons.user = req.authUser;
    pokemons.showUserPokemons(function (data) {
        res.send(data);
    }, function (err) {
        res.sendStatus(400);
    });
});

router.post('/getpokemonlocation', binder(require('../models/pokemon.js')), function (req, res){
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
    var users = new (require('../models/user.js'))();
    users.user = req.authUser;
    users.getOtherUsersLocation(function (data) {
        res.send(data);
    }, function (err) {
        res.sendStatus(400);
    });
});

router.post('/catchpokemon', binder(require('../models/pokemon.js')), function (req, res){
    var pokemons = req.requestModel;
    pokemons.id = req.body.id;
    pokemons.user = req.authUser;
    pokemons.catch(function (data) {
        res.send(data);
    }, function () {
        res.sendStatus(400);
    });
});

router.post('/givecustomname', binder(require('../models/pokemon.js')), function (req, res){
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
        challenge.acceptChallenge(function (data) {
            res.send(data);
        }, function () {
            res.sendStatus(400);
        });
    }
    else {
        challenge.declineChallenge(function () {
            res.sendStatus(200);
        }, function () {
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
    },function(){
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

    }, function () {

    });
});


router.get('/logout', function (req, res) {
    var users = new (require('../models/user.js'))();
    users.user = req.authUser;
    users.logOut(function(){
       res.redirect('/');
    }, function () {
        res.sendStatus(400);
    });

});

module.exports = router;