/**
 * Created by Javelin on 16.3.2017.
 */


var pool = require('../config-postgreSQL');
var util = require('../helpers/util');

function user() {
    var $this = this;
    this.user = "";
    this.username = this.firstname = this.lastname = this.pass = "";
    this.oldUsername = "";
    this.lat = this.lon = "";

    this.getNearby = function (success, error) {
        var response = [];
        pool.query('Select * from player where isonline=true', function(err, result){
            var userLoc;
            for (var i = 0; i < result.rows.length; i++){
                if (result.rows[i].username == $this.user){
                    userLoc = {lat: result.rows[i].lat, lng: result.rows[i].lon};
                }
            }
            for (var i = 0; i < result.rows.length; i++){
                if (result.rows[i].username != $this.user){
                    if (util.checkIfInRadius(userLoc.lat, userLoc.lng, result.rows[i].lat, result.rows[i].lon)){
                        var userData = {username: result.rows[i].username, lat: result.rows[i].lat, lon: result.rows[i].lon};
                        response.push(userData);
                    }
                }
            }
            success(response);
        });
    };

    this.logOut = function (success, error) {
        pool.query('update player set isonline=false where username=$1', [$this.user], function(err, result){
            if (err){
                error();
            }
            else {
                success();
            }
        });
    };

    this.create = function (success, error) {//TODO vratiti error sa baze
        pool.query('insert into player values ($1,$2,$3,$4,0,0,false)', [$this.username, $this.firstname, $this.lastname, util.hashPassword($this.pass)], function(err, result) {
            if(err) {
                console.log(err);
                //res.sendStatus(400);
                error(400);
            }
            else {
                //res.sendStatus(200);
                success(200);
            }
        });
    };

    this.delete = function (success, error) {
        pool.query("delete from player where username = $1" , [$this.username], function(err, result) {
            if(err)
                error(400);
            else
                success(200);
        });
    };
    this.edit = function (success, error) {
        pool.query("update player set username=$1, firstname=$2, lastname=$3 where username=$4 returning *", [$this.username, $this.firstname,
            $this.lastname, $this.oldUsername], function(err, result) {
            if(err)
                error(400);
            else
                success(result.rows[0]);
        });

    };
    this.showUsers = function (success, error) {
        pool.query('Select * from player', function(err, result) {
            if(err)
                error(err);
            else
                success(result.rows);
        });

    };
    this.updateLocation = function (success, error) {
        pool.query('update player set lat = $1, lon = $2 where username=$3', [$this.lat, $this.lon, $this.username], function (err, result) {
            if(err) {
                console.log(err);
                error(err);
            }
            else
                success(200);

        })

    };


}

module.exports = user;
