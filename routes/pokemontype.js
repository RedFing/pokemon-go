/**
 * Created by Javelin on 4.2.2017.
 */
var express = require('express');
var router = express.Router();
var pool = require('../config-postgreSQL');

router.get('/', function(req, res) {
    pool.query('Select * from pokemontype', function(err, result) {
        if(err) {
            res.sendStatus(400);
        }
        else{
            res.render('pokemonType', {result: result.rows});
        }
    });
});

router.post('/add', function(req, res) {
    pool.query('insert into pokemontype values ($1,$2)', [req.body.pokeid, req.body.pokename], function(err, result) {
        if(err)
            res.sendStatus(400);
        else
            res.sendStatus(200);
    });
});

router.delete('/delete', function(req, res) {
    pool.query("delete from pokemontype where id = $1" , [req.body.pokeid], function(err, result) {
        if(err)
            res.sendStatus(400);
        else
            res.sendStatus(200);
    });
});

router.post('/edit', function(req, res) {
    pool.query("update pokemontype set id=$1, name=$2 where id=$3", [req.body.pokeidNew, req.body.pokenameNew ,req.body.pokeidOld], function(err, result) {
        if(err)
            res.sendStatus(400);
        else
            res.sendStatus(200);
    });
});


module.exports = router;