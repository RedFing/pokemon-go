/**
 * Created by Javelin on 16.3.2017.
 */
var pool = require('../config-postgreSQL');
var util = require('../helpers/util');

//TODO priority!!! change model name to player instead of user, reason: user.user or user.username
//TODO delete the user attribute, user only username

function user() {
    var $this = this;
    this.user = ""; //TODO delete this
    this.username = this.firstname = this.lastname = this.pass = "";
    this.oldUsername = "";
    this.lat = this.lon = "";
    this.socketid = "";

    this.getNearby = function (success, error) {
        var response = [];
        pool.query('Select * from player where isonline=true and username != $1', [$this.user], function(err, result){
            if (err){
                error(err);
            }
            else {
                for (var i = 0; i < result.rows.length; i++) {
                    if (result.rows[i].username != $this.user) {
                        if (util.checkIfInRadius($this.lat, $this.lon, result.rows[i].lat, result.rows[i].lon)) {
                            var userData = {
                                username: result.rows[i].username,
                                lat: result.rows[i].lat,
                                lon: result.rows[i].lon
                            };
                            response.push(userData);
                        }
                    }
                }
                success(response);
            }
        });
    };

    this.getSocketId = function (success, error) {
        pool.query('select socketid from player where username=$1', [$this.username], function(err, result){
            if (err){
                console.log(error(err));
            }
            else {
                success({socketid: result.rows[0].socketid});
            }

        });
    };

    this.updateSocketId = function (success, error) {
        pool.query("update player set socketid=$1 where username=$2 returning *", [$this.socketid, $this.user], function (err, result) {
            if(err){
                error(err);
            }
            else {
                success();
            }
        });
    };

    this.getPokemons = function(success, error){
        pool.query('select name, pokemontypeid from pokemontype INNER JOIN playerpokemon on pokemontype.id = playerpokemon.pokemontypeid ' +
        'where playerpokemon.username=$1', [$this.username], function(err, result){
            if (err){
                error(err);
            }
            else {
                success(result.rows);
            }
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
                error(err);
            }
            else {
                success();
            }
        });
    };

    this.delete = function (success, error) {
        pool.query("delete from player where username = $1" , [$this.username], function(err, result) {
            if(err)
                error(err);
            else
                success();
        });
    };

    this.edit = function (success, error) {
        pool.query("update player set username=$1, firstname=$2, lastname=$3 where username=$4 returning *", [$this.username, $this.firstname,
            $this.lastname, $this.oldUsername], function(err, result) {
            if(err)
                error(err);
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
                success();

        })
    };

}

module.exports = user;

