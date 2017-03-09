var crypto = require('crypto');
var moment = require('moment');
var util = require('../helpers/util');
var pool = require('../config-postgreSQL');


function authenticator(settings) {
    return function(req, res, next) {
        var routeToCheck = selectRoute(req, settings);
        if (routeToCheck != ""){
            if (!req.cookies.authCookie) {
                res.sendStatus(403);
                return;
            }
            if (routeToCheck == '/login'){
                if (!validateEmail(req.body.unmLogin)) {
                    res.sendStatus(403);
                    return;
                }
                else {
                    var password = req.body.passLogin;
                    const hash = crypto.createHmac('sha256', settings.hashSecret).update(password).digest('hex');
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
            }
            var token = util.decipherCookie(req.cookies.authCookie);
            if (moment().isAfter(token.valid)) {
                res.sendStatus(403);
                return;
            }
            pool.query("Select * from player where username=$1", [token.username], function (err, result) {
                if (result.rows[0].username != token.username)
                    res.sendStatus(403);
                else {
                    req.authUser = token.username;
                    next();
                }
            });
        }
        else
            next();
    }
}

function selectRoute(req, settings){
    for (var i = 0; i < settings.routes.length; i++) {
        if (req.path.toLowerCase() == settings.routes[i].toLowerCase()) { // case sensitive
            return settings.routes[i];

        }
    }
    return "";
}


function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}



module.exports = authenticator;