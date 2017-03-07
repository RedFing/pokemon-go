/**
 * Created by Javelin on 4.3.2017.
 */

var express = require('express');
var router = express.Router();
var pool = require('../config-postgreSQL');
const crypto = require('crypto');

router.get('/', function (req,res){
    res.render('playerMap');
});


router.get('/showTable', function (req,res){
    var niz = [];
    var decipher = crypto.createDecipher('aes192', 'a password');
    var encrypted = req.cookies.kuki;
    var decrypted = decipher.update(encrypted, 'hex', 'utf8');
    decrypted += decipher.final('utf8');
    var token = JSON.parse(decrypted);
    pool.query('select pokemontype.name, playerpokemon.customname from pokemontype INNER JOIN ' +
        'playerpokemon on pokemontype.id = playerpokemon.pokemontypeid where username=$1', [token.username], function(err, result) {
        for (var i = 0; i < result.rows.length; i++) {
            niz[i] = result.rows[i];
        }
        res.send(niz);
    });
});

router.post('/getPokemonLocation', function (req,res){
    var id = Math.floor(Math.random() * (1 + 20 - 1)) + 1;
    pool.query('select name, x, y from pokemontype where id=$1', [id], function(err, result1){
        var lok = randomLocationInRadius100m(req.body);
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
    console.log(req.body.id);
    var chance = Math.random();
    console.log(chance);
    if (chance < 0.35){
        console.log("if");
        pool.query('delete from sentpokemons where id=$1', [req.body.id], function(err, result){
            res.send({success: false});
        });
    }
    else {
        console.log("else");
        pool.query('select pokemontypeid from sentpokemons where id=$1', [req.body.id], function(err, result1){
            var decipher = crypto.createDecipher('aes192', 'a password');
            var decrypted = decipher.update(req.cookies.kuki, 'hex', 'utf8');
            decrypted += decipher.final('utf8');
            var token = JSON.parse(decrypted);
            console.log(token.username, result1.rows[0].pokemontypeid);
            pool.query('insert into playerpokemon values($1,$2)', [token.username, result1.rows[0].pokemontypeid], function(err, result2){
                pool.query('select name from pokemontype where id=$1', [result1.rows[0].pokemontypeid], function(err, result3){
                    res.send({success: true, name: result3.rows[0].name});
                });
            });
        });
    }
});


function randomLocationInRadius100m(center){
    cLat = center.lat;
    cLng = center.lng;
    do {
        console.log("random");
        lat = Math.random() * (2 * 0.00085) + (center.lat - 0.00085);
        lng = Math.random() * (2 * 0.0012) + (center.lng - 0.0012);
    }
    while (getDistanceFromLatLonInKm(cLat, cLng, lat, lng) > 0.09);
    return rez = {lat, lng};
}

function getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2-lat1);  // deg2rad below
    var dLon = deg2rad(lon2-lon1);
    var a =
            Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
            Math.sin(dLon/2) * Math.sin(dLon/2)
        ;
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    var d = R * c;
    return d;
}

function deg2rad(deg) {
    return deg * (Math.PI/180)
}

module.exports = router;