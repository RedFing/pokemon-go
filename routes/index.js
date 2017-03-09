var express = require('express');
var router = express.Router();

var player = require('../routes/player');
var pokemontype = require('../routes/pokemontype');
var playerpokemon = require('../routes/playerpokemon');
var playermap = require('../routes/playermap');

var moment = require('moment');

var pool = require('../config-postgreSQL');
var util = require('../helpers/util');

router.use('/player', player);
router.use('/pokemontype', pokemontype);
router.use('/playerpokemon', playerpokemon);
router.use('/playermap', playermap);

const crypto = require('crypto');

const secret = 'abcdefg';

router.get('/', function(req, res) {
    res.render('pocetna');
});

router.post('/login', function(req, res) {
    if(!validateEmail(req.body.unmLogin))
        res.sendStatus(403);
    else {
        var password = req.body.passLogin;
        const hash = crypto.createHmac('sha256', secret).update(password).digest('hex');
        pool.query("Select * from player where username=$1" , [req.body.unmLogin], function (err, result) {
            if (result.rows[0].password == hash) {
                res.cookie('authCookie', util.cipherCookie(req.body.unmLogin));
                res.redirect('/playermap');

            }
            else {
                res.sendStatus(403);
            }
        });
    }
});

router.post('/register', function(req, res) {
    if(!validateEmail(req.body.unmRegister))
        res.sendStatus(400);
    else {
        var password = req.body.passRegister;
        const hash = crypto.createHmac('sha256', secret).update(password).digest('hex');
        pool.query('insert into player values ($1,$2,$3,$4)', [req.body.unmRegister, req.body.frstnmRegister, req.body.lstnmRegister, hash], function (err, result) {
            if (err)
                res.sendStatus(400);
            else {
                var cipher = crypto.createCipher('aes192', 'a password');
                var encrypted = cipher.update(req.body.unmRegister, 'utf8', 'hex');
                encrypted += cipher.final('hex');
                res.cookie('authCookie', encrypted);
                res.redirect('/');
            }
        });
    }
});

function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

module.exports = router;
