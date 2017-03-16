/**
 * Created by Javelin on 16.3.2017.
 */

var pool = require('../config-postgreSQL');

function challenge() {
    var $this = this;
    this.sentby = "";
    this.at = null;
    this.sentto = "";
    this.delivered = false;
    this.id = 0;

    this.create = function (success, error) {
        pool.query('insert into challenges (sentby,sentto,at,delivered)values($1,$2,localtimestamp, false)',
            [$this.sentby, $this.sentto], function(err, result){
                success();
            });
    };
    this.getByRecipient = function (success, error) {
        pool.query('update challenges set delivered=true where delivered=false and sentto=$1 returning *',
            [$this.sentto], function(err, result){
                success(result.rows);
            });
    };
}

module.exports = challenge;