/**
 * Created by Javelin on 4.2.2017.
 */
var express = require('express');
var router = express.Router();
var pool = require('../config-postgreSQL');

router.get('/', function(req, res) {
    var niz = [];
    pool.query('Select name from pokemontype', function(err, result) {
        for (var i = 0; i < result.rows.length; i++) {
            niz[i] = result.rows[i];
        }
        res.render('playerPokemon', {niz: niz});
    });
});

router.post('/add', function(req, res) {
    pool.query('Select id from pokemontype where name =$1',[req.body.pokename], function(err, result) {
        if(err)
            res.sendStatus(400);
        else{
            console.log(req.body);
            var pokeid = result.rows[0].id;
            pool.query('insert into playerpokemon (username, pokemontypeid, customname) values ($1,$2,$3)', [req.body.uname, pokeid, req.body.customname], function(err, result) {
                    if (err)
                        res.sendStatus(400);
                    else
                        res.sendStatus(200);
                }
            );
        }
    });
});

router.delete('/delete', function(req, res) {
    pool.query("delete from playerpokemon where pokemontypeid = $1 and username= $2", [req.body.pokeid, req.body.uname], function(err, result) {
        if(err)
            res.sendStatus(400);
        else
            res.sendStatus(200);
    });
});

router.post('/show', function(req, res) {
    var niz = [];
    pool.query("Select pokemontypeid, name, customname from playerpokemon INNER JOIN pokemontype on playerpokemon.pokemontypeid = pokemontype.id where playerpokemon.username=$1", [req.body.uname], function(err, result) {
        if(err)
            res.sendStatus(400);
        else{
            for (var i = 0; i < result.rows.length; i++) {
                niz[i] = result.rows[i];
            }
            res.send(niz);
        }
    });
});


module.exports = router;