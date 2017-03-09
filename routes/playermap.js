/**
 * Created by Javelin on 4.3.2017.
 */

var express = require('express');
var router = express.Router();
var pool = require('../config-postgreSQL');
var crypto = require('crypto');
var util = require('../util');

router.get('/', function (req,res){
    res.render('playerMap');
});


router.get('/showTable', function (req,res){
    var niz = [];
    var kuki = util.decipherCookie(req.cookies.kuki);
    pool.query('select pokemontype.name, playerpokemon.customname from pokemontype INNER JOIN ' +
        'playerpokemon on pokemontype.id = playerpokemon.pokemontypeid where username=$1', [kuki.username], function(err, result) {
        for (var i = 0; i < result.rows.length; i++) {
            niz[i] = result.rows[i];
        }
        res.send(niz);
    });
});

router.post('/getPokemonLocation', function (req,res){
    var id = Math.floor(Math.random() * 20) + 1;
    pool.query('select name, x, y from pokemontype where id=$1', [id], function(err, result1){
        var lok = util.randomLocationInRadius100m(req.body);
        pool.query("insert into sentpokemons (pokemontypeid, lat, lon, expired, expiretimestamp) " +
            "values($1, $2, $3, $4, CURRENT_TIMESTAMP + interval '10 minutes')", [id, lok.lat, lok.lng, false], function(err, result2){
            pool.query("select id from sentpokemons order by id desc limit 1", function (err, result3){
                var rez = {id: result3.rows[0].id, name: result1.rows[0].name, x: result1.rows[0].x, y: result1.rows[0].y, lok: lok};
                res.send(rez);
            });
        });
    });
});

router.post('/catchPokemon', function (req,res){
    var chance = Math.random();
    if (chance < 0.35){
        pool.query('delete from sentpokemons where id=$1', [req.body.id], function(err, result){
            res.send({success: false});
        });
    }
    else {
        pool.query('select pokemontypeid from sentpokemons where id=$1', [req.body.id], function(err, result1){
            var kuki = util.decipherCookie(req.cookies.kuki);
            pool.query('insert into playerpokemon values($1,$2)', [kuki.username, result1.rows[0].pokemontypeid], function(err, result2){
                pool.query('select name from pokemontype where id=$1', [result1.rows[0].pokemontypeid], function(err, result3){
                    res.send({success: true, name: result3.rows[0].name, pokemontypeid: result1.rows[0].pokemontypeid});
                });
            });
        });
    }
});

router.post('/givecustomname', function (req,res){
    var kuki = util.decipherCookie(req.cookies.kuki);
    pool.query('update playerpokemon set customname=$1 where username=$2 and pokemontypeid=$3',
               [req.body.customName, kuki.username, req.body.pokemontypeid], function(err, result){
        res.sendStatus(200);
    });
});




module.exports = router;