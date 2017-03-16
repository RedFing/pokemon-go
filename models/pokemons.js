/**
 * Created by Javelin on 16.3.2017.
 */


var pool = require('../config-postgreSQL');

function pokemons() {
    var $this = this;
    this.user = "";
    this.id = 0;
    this.name = "";
    this.x = 0;
    this.y = 0;

    this.catch = function (success, error) {
        var chance = Math.random()
        console.log("sansa", chance);
        if (chance < 0.35) {
            console.log("usao u if ");
            pool.query('delete from sentpokemons where id=$1', [this.id], function (err, result) {
                success(false);
            });
        }
        else {
            console.log("usao u else", this.id);

            pool.query('select pokemontypeid, expiretimestamp from sentpokemons where id=$1 and expiretimestamp > localtimestamp', [this.id], function (err, result1) {
                if (result1.rows.length == 0) {
                    error();
                    return;
                }
                console.log($this.user , result1.rows[0].pokemontypeid);
                pool.query('insert into playerpokemon values($1,$2)', [this.user, result1.rows[0].pokemontypeid], function (err, result2) { // napravi konekciju playera sa pokemonom
                    console.log("poslije inserta");
                    pool.query('select name from pokemontype where id=$1', [result1.rows[0].pokemontypeid], function (err, result3) { //uzmi ime prema idu
                        console.log("poslije selecta");
                        pool.query('delete from sentpokemons where id=$1', [this.id]); //uhvacen i nema ga vise
                        console.log("poslije deletea");
                        success({
                            success: true,
                            name: result3.rows[0].name,
                            pokemontypeid: result1.rows[0].pokemontypeid
                        });
                    });
                });
            });
        }
    }
}

module.exports = pokemons;

