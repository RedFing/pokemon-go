var crypto = require('crypto');
var moment = require('moment');
var util = require('../helpers/util');
var pool = require('../config-postgreSQL');


function authenticator(settings) {
    return function(req, res, next) {
        var routeToCheck = "";
        for (var i = 0; i < settings.routes.length; i++) {
            if (req.path.toLowerCase() == settings.routes[i].toLowerCase()) { // case sensitive
                routeToCheck = settings.routes[i];
                break;
            }
        }
        if (routeToCheck != ""){
            if (!req.cookies.authCookie) {
                res.sendStatus(403);
                return;
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

module.exports = authenticator;