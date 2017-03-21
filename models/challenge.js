/**
 * Created by Javelin on 16.3.2017.
 */

var pool = require('../config-postgreSQL');

function challenge() {
    var $this = this;
    this.sender = this.recipient = this.response = "";
    this.dateofcreation = null;
    this.delivered = false;
    this.id = 0;

    this.create = function (success, error) {
        pool.query('insert into challenges (sender,recipient,dateofcreation,delivered,response)values($1,$2,localtimestamp, false, $3)',
            [$this.sender, $this.recipient, 'none'], function(err, result){
                success();
            });
    };

    this.getByRecipient = function (success, error) {
        pool.query('update challenges set delivered=true where delivered=false and recipient=$1 returning *',
            [$this.recipient], function(err, result){
                success(result.rows);
            });
    };

    this.acceptChallenge = function (success, error) {
        pool.query('update challenges set response=$1 where id=$2',
            ['accept', $this.id], function(err, result){
                if (err) console.log(err);
                success();
            });
    };

    this.declineChallenge = function (success, error) {
        pool.query('update challenges set response=$1 where id=$2',
            ["decline", $this.id], function(err, result){
                success();
            });
    };
}

module.exports = challenge;