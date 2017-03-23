/**
 * Created by Javelin on 17.3.2017.
 */

var express = require('express');
var router = express.Router();
var pool = require('../config-postgreSQL');
var binder = require('model-binder');


router.get('/', function(req, res) {
    res.render('adminPanel');
});

router.get('/player/',binder(require('../models/user')), function(req, res) {
    var user = req.requestModel;
    user.showUsers(function (success) {
        res.render('player', {result: success});
    }, function (error) {
        res.send(error);
    });
});
router.post('/player/add', binder(require('../models/user')), function (req, res) {
    var user = req.requestModel;
    user.username = req.body.uname;
    user.firstname = req.body.firstname;
    user.lastname = req.body.lastname;
    user.pass = req.body.password;
    user.createUser(function (success) {
        res.sendStatus(success);

    }, function (error) {
        res.sendStatus(error);
    });
});

router.delete('/player/delete',binder(require('../models/user')), function (req, res) {
    var user = req.requestModel;
    user.username = req.body.uname;
    user.deleteUser(function (success) {
        res.sendStatus(success);
    }, function (error) {
        res.sendStatus(error);
    });
});

router.post('/player/edit', binder(require('../models/user')), function(req, res) {
    //var {unameOld, unameNew, firstnameNew, lastnameNew} = req.body;
    var user = req.requestModel;
    user.oldUsername = req.body.unameOld;
    user.username = req.body.unameNew;
    user.firstname = req.body.firstnameNew;
    user.lastname = req.body.lastnameNew;
    user.editUser(function (success) {
        res.send(success);
    }, function (error) {
        res.sendStatus(error);
    });
});

router.get('/playerpokemon/', function(req, res) {
    pool.query('Select name from pokemontype', function(err, result) {
        res.render('playerPokemon', {result: result.rows});
    });
});

router.post('/playerpokemon/add', function(req, res) {
    pool.query('Select id from pokemontype where name=$1',[req.body.pokename], function(err, result) {
        if(err)
            res.sendStatus(400);
        else{
            pool.query('insert into playerpokemon (username, pokemontypeid, customname) values ($1,$2,$3)', [req.body.uname, result.rows[0].id, req.body.customname], function(err, result) {
                    if (err)
                        res.sendStatus(400);
                    else
                        res.sendStatus(200);
                }
            );
        }
    });
});

router.delete('/playerpokemon/delete', function(req, res) {
    pool.query("delete from playerpokemon where pokemontypeid = $1 and username= $2", [req.body.pokeid, req.body.uname], function(err, result) {
        if(err)
            res.sendStatus(400);
        else
            res.sendStatus(200);
    });
});

router.post('/playerpokemon/show', function(req, res) {
    pool.query("Select pokemontypeid, name, customname from playerpokemon INNER JOIN pokemontype on playerpokemon.pokemontypeid = pokemontype.id where playerpokemon.username=$1", [req.body.uname], function(err, result) {
        if(err)
            res.sendStatus(400);
        else{
            res.send(result.rows);
        }
    });
});

router.get('/pokemontype/', function(req, res) {
    pool.query('Select * from pokemontype order by id asc', function(err, result) {
        if(err) {
            res.sendStatus(400);
        }
        else{
            res.render('pokemonType', {result: result.rows});
        }
    });
});

router.post('/pokemontype/add', function(req, res) {
    console.log(req.body);
    pool.query('insert into pokemontype values ($1,$2,0,0,$3,$4,$5,$6,$7)',
               [req.body.pokeid, req.body.pokename, req.body.pokerarity, req.body.pokecatchchance,
                req.body.pokehp, req.body.pokeattack, req.body.pokedefense], function(err, result) {
        if(err)
            res.sendStatus(400);
        else
            res.sendStatus(200);
    });
});

router.delete('/pokemontype/delete', function(req, res) {
    pool.query("delete from pokemontype where id = $1" , [req.body.pokeid], function(err, result) {
        if(err)
            res.sendStatus(400);
        else
            res.sendStatus(200);
    });
});

router.post('/pokemontype/edit', function(req, res) {
    pool.query("update pokemontype set id=$1, name=$2, rarity=$3, catchchance=$4, hp=$5, attack=$6, defense=$7 where id=$8",
        [req.body.pokeidNew, req.body.pokenameNew, req.body.pokerarityNew, req.body.pokecatchchanceNew,
            req.body.pokehpNew, req.body.pokeattackNew, req.body.pokedefenseNew, req.body.pokeidOld], function(err, result) {
        if(err)
            res.sendStatus(400);
        else
            res.sendStatus(200);
    });
});

module.exports = router;