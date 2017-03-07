/**
 * Created by Javelin on 4.2.2017.
 */
var express = require('express');
var router = express.Router();
var pool = require('../config-postgreSQL');

router.get('/', function(req, res) {
    var niz = [];
    pool.query('Select * from player', function(err, result) {
        for (var i = 0; i < result.rows.length; i++) {
            niz[i] = result.rows[i];
            console.log(niz[i]);
        }
        res.render('player', {niz: niz});
    });
});

router.post('/add', function (req, res) {
    pool.query('insert into player values ($1,$2,$3,$4)', [req.body.uname, req.body.firstname, req.body.lastname, "a"], function(err, result) {
        if(err)
            res.sendStatus(400);
        else
            res.sendStatus(200);
    });
});

router.delete('/delete', function (req,res) {
    pool.query("delete from player where username = $1" , [req.body.uname], function(err, result) {
        if(err)
            res.sendStatus(400);
        else
            res.sendStatus(200);
    });
})

router.post('/edit', function(req, res) {
    var {unameOld, unameNew, firstnameNew, lastnameNew} = req.body;
    pool.query("update player set username=$1, firstname=$2, lastname=$3 where username=$4", [unameNew, firstnameNew, lastnameNew, unameOld], function(err, result) {
        if(err)
            res.sendStatus(500);
        else
            res.sendStatus(200);
    });
});

module.exports = router;