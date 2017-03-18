/**
 * Created by Javelin on 16.3.2017.
 */


var pool = require('../config-postgreSQL');
var util = require('../helpers/util');

function users() {
    var $this = this;
    this.user = "";

    this.getOtherUsersLocation = function (success, error) {
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
}

module.exports = users;

