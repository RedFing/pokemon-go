/**
 * Created by Javelin on 4.2.2017.
 */
var express = require('express');
var router = express.Router();
var pool = require('../config-postgreSQL');

router.get('/', function(req, res) {
    pool.query('Select name from pokemontype', function(err, result) {
        res.render('playerPokemon', {result: result.rows});
    });
});

router.post('/add', function(req, res) {
    pool.query('Select id from pokemontype where name =$1',[req.body.pokename], function(err, result) {
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

router.delete('/delete', function(req, res) {
    pool.query("delete from playerpokemon where pokemontypeid = $1 and username= $2", [req.body.pokeid, req.body.uname], function(err, result) {
        if(err)
            res.sendStatus(400);
        else
            res.sendStatus(200);
    });
});

router.post('/show', function(req, res) {
    pool.query("Select pokemontypeid, name, customname from playerpokemon INNER JOIN pokemontype on playerpokemon.pokemontypeid = pokemontype.id where playerpokemon.username=$1", [req.body.uname], function(err, result) {
        if(err)
            res.sendStatus(400);
        else{
            res.send(result.rows);
        }
    });
});


module.exports = router;