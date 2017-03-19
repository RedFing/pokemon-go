/**
 * Created by Javelin on 16.3.2017.
 */

var pool = require('../config-postgreSQL');
var util = require('../helpers/util');

function pokemons() {
    var $this = this;
    this.user = this.name = this.customName = "";
    this.id = this.x = this.y = this.userLat = this.userLng = this.pokemontypeid = 0;

    this.showUserPokemons = function (success, error){
        pool.query('select pokemontype.name, playerpokemon.customname from pokemontype INNER JOIN ' +
            'playerpokemon on pokemontype.id = playerpokemon.pokemontypeid where username=$1', [$this.user], function(err, result) {
            if (err){
                error();
            }
            else {
                success(result.rows);
            }
        });
    };

    this.catch = function (success, error) {
        var chance = Math.random();
        if (chance < 0.35) {
            pool.query('delete from sentpokemons where id=$1', [this.id], function (err, result) {
                success(false);
            });
        }
        else {
            pool.query('select pokemontypeid, expiretimestamp from sentpokemons where id=$1 and expiretimestamp > localtimestamp', [this.id], function (err, result1) {
                if (result1.rows.length == 0) {
                    error();
                    return;
                }
                pool.query('insert into playerpokemon values($1,$2)', [$this.user, result1.rows[0].pokemontypeid], function (err, result2) { // napravi konekciju playera sa pokemonom
                    pool.query('select name from pokemontype where id=$1', [result1.rows[0].pokemontypeid], function (err, result3) { //uzmi ime prema idu
                        pool.query('delete from sentpokemons where id=$1', [$this.id]); //uhvacen i nema ga vise
                        success({
                            success: true,
                            name: result3.rows[0].name,
                            pokemontypeid: result1.rows[0].pokemontypeid
                        });
                    });
                });
            });
        }
    };

    this.getLocation = function (success, error) {
        pool.query('update player set lat=$1, lon=$2 where username=$3', [$this.userLat, $this.userLng, $this.user]); // update player location
        pool.query('select * from pokemontype order by id asc', function (err, result) {
            var chances = generateChances(result.rows); // generate chances array
            var randomId = chances[Math.floor(Math.random() * chances.length)]; // select random array element
            var selectedPokemon = result.rows[randomId - 1]; // select pokemon with random id
            var lok = util.randomLocationInRadius100m({lat: $this.userLat, lng: $this.userLng}); // generate random spawn location
            pool.query("insert into sentpokemons (pokemontypeid, lat, lon, expired, expiretimestamp) " +
                "values($1, $2, $3, $4, CURRENT_TIMESTAMP + interval '10 minutes') returning id", [randomId, lok.lat, lok.lng, false], function (err, result2) {
                success({
                    id: result2.rows[0].id,
                    name: selectedPokemon.name,
                    x: selectedPokemon.x,
                    y: selectedPokemon.y,
                    lok: lok
                });
            });
        });
    };

    this.giveCustomName = function (success, error) {
        pool.query('update playerpokemon set customname=$1 where username=$2 and pokemontypeid=$3',
            [$this.customName, $this.user, $this.pokemontypeid], function(err, result){
            if (err){
                error();
            }
            else {
                success();
            }
        });
    }
}

function generateChances(tableRows) {
    var chances = [];
    for (var i = 0; i < tableRows.length; i++){
        var rarity = tableRows[i].rarity;
        for (var j = 0; j < rarity; j++){
            chances.push(tableRows[i].id);
        }
    }
    return chances;
}

module.exports = pokemons;

