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
        pool.query('insert into challenges (sender,recipient,dateofcreation,delivered,response)values($1,$2,localtimestamp, false, $3) returning id',
            [$this.sender, $this.recipient, 'none'], function(err, result){
                success(result.rows[0]);
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
                pool.query('select name, pokemontypeid from pokemontype INNER JOIN playerpokemon on pokemontype.id = playerpokemon.pokemontypeid ' +
                    'where playerpokemon.username=$1', [$this.recipient], function (err, result) {
                    success(result.rows);
                });

            });
    };

    this.declineChallenge = function (success, error) {
        pool.query('update challenges set response=$1 where id=$2',
            ["decline", $this.id], function(err, result){
                success();
            });
    };

    this.checkForAccept = function (success, error) {
        pool.query('select * from challenges where id=$1', [$this.id], function(err, result){
            if (result.rows.length > 0) {
                if (result.rows[0].response == 'accept'){
                    pool.query('select name, pokemontypeid from pokemontype INNER JOIN playerpokemon on pokemontype.id = playerpokemon.pokemontypeid ' +
                        'where playerpokemon.username=$1', [$this.sender], function (err, result1) {
                        console.log(result.rows1);
                        success({id: $this.id, response: result.rows[0].response, pokemons: result1.rows});
                    });
                }
                else {
                    success({recipient: result.rows[0].recipient, response: result.rows[0].response});
                }
            }
            else {
                success({});
            }
        });
    };
}

module.exports = challenge;