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


router.get('/', function(req, res) {
    res.render('index');
});

router.post('/login', function(req, res) {
    res.redirect('/playermap');
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



module.exports = router;
