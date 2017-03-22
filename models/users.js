/**
 * Created by Javelin on 16.3.2017.
 */


var pool = require('../config-postgreSQL');
var util = require('../helpers/util');

function users() {
    var $this = this;
    this.user = "";
    this.username = this.firstname = this.lastname = this.pass = "";

    this.getOtherUsersLocation = function (success, error) {
        var response = [];
        console.log("getting location");
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
            console.log("sending response");
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
    /*
    this.createUser = function (success, error) {
        pool.query('insert into player values ($1,$2,$3,$4,0,0,false)', [uname, firstname, lastname, util.hashPassword(pass)], function(err, result) {
            if(err) {
                console.log(err);
                res.sendStatus(400);
                //error();
            }
            else {
                res.sendStatus(200);
                //success();
            }
        });
    };

    this.deleteUser = function (username, res) {
        pool.query("delete from player where username = $1" , [username], function(err, result) {
            if(err)
                res.sendStatus(400);
            else
                res.sendStatus(200);
        });
    };
    this.editUser = function (unameOld, unameNew, firstnameNew, lastnameNew, res) {
        pool.query("update player set username=$1, firstname=$2, lastname=$3 where username=$4 returning *", [unameNew, firstnameNew, lastnameNew, unameOld], function(err, result) {
            if(err)
                res.sendStatus(500);
            else
                res.send(result.rows[0]);
        });

    };
    this.showUsers = function () {
        return function (req,res) {
            pool.query('Select * from player', function(err, result) {
                res.render('player', {result: result.rows});
            });

        };

    };*/
}





module.exports = users;

