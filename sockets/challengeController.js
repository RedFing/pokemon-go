/**
 * Created by Javelin on 27.3.2017.
 */
var pool = require('../config-postgreSQL');


//MAIN
function challengeController (io) {
    io.on("connect", function (socket) {
        updateUserSocketId(socket);
        console.log("A user",socket.authUser, "connected with id:", socket.id);
        socket.on("sendChallenge", function (data) {
            deliverChallenge(socket, data);
            socket.join('fightRoom');
        });
        socket.on("acceptChallenge", function (data){
            recipientAccepted(data);
            socket.join('fightRoom');
            //io.in('fightRoom').emit('startFight', 'the fight may begin');
            deliverPokemons(socket, data);
        });
        socket.on("pokemonChosen", function (data){
            selectFighters(io, socket, data);
        });

    });
}

//------------ Helper functions

function updateUserSocketId(socket){
    var user = new (require('../models/user.js'))();
    user.user = socket.authUser;
    user.socketid = socket.id;
    // update database TODO add body to func below
    user.updateSocketId(function(data){},function (data){});
}

function deliverChallenge(socket, data){
    var challenge = new (require('../models/challenge.js'))();
    challenge.sender = socket.authUser;
    challenge.recipient = data.recipient;
    challenge.sendersocketid = socket.id;
    challenge.create(function (data) {
        socket.emit("sendChallenge-ack", {status: 200}); //ack goes to sender that challenge was received
        var user = new (require('../models/user.js'))();
        user.username = challenge.recipient;
        user.getSocketId(function (data) { // find the recipient
            var recipientSocketId = data.socketid;
            challenge.recipientsocketid = data.socketid;
            challenge.getByRecipient(function(data){
                socket.to(recipientSocketId).emit("deliverChallenge", data); // deliver challenge to recipient
            },
            function (data) {
                //TODO add error notification
                console.log(data);
            });

        }, function (data) {
            //TODO add error notification
            console.log(data); // debug
        });
    }, function (err) {
        socket.emit("sendChallenge-ack", {status: 400}); //error message to sender
    });
}

function recipientAccepted(data){
    var challenge = new (require('../models/challenge.js'))();
    challenge.id = data.id;
    //TODO add body to functions below
    challenge.accept(function(){}, function(){});
}

function deliverPokemons(socket, data){
    var challenge = new (require('../models/challenge.js'))();
    challenge.id = data.id;
    challenge.getPlayersById(function(data){
        var sender = {username: data.sender, socketid: data.sendersocketid};
        var recipient = {username: data.recipient, socketid: data.recipientsocketid};
        var user = new (require('../models/user.js'))();
        user.username = sender.username;
        user.getPokemons(function (data) {
            //deliver pokemons to sender so he can choose one for fight
            var response = {challengeid: challenge.id, pokemons: data};
            socket.to(sender.socketid).emit("deliverPokemons", response);
        }, function (data) {
            //TODO add error notification
        });
        user.username = recipient.username;
        user.getPokemons(function (data) {
            //deliver recipients pokemons so he can choose one for fight
            var response = {challengeid: challenge.id, pokemons: data};
            socket.emit("deliverPokemons", response);
        }, function (data) {
            //TODO add error notification
        });
    }, function () {
        //TODO add error notification
    });
}

function selectFighters(io, socket, data) {
    var challenge = new (require('../models/challenge.js'))();
    challenge.player = socket.authUser;
    challenge.id = data.challengeid;
    // if both players have chosen their pokemons then start the fight
    challenge.selectFighters(socket.authUser, data.pokemonid, function (data) {
        if (data.senderpokemontype != null && data.recipientpokemontype != null){
            startFight(io, data.senderpokemontype, data.recipientpokemontype);
        }
    }, function (data) {
        //TODO add error notification
    })
}

function startFight(io, senderpoke, recipientpoke){
    var pokemon = new (require('../models/pokemon.js'))();
    var senderPokemon;
    pokemon.id = senderpoke;
    //get senders pokemon data (nape hp atack defense...)
    pokemon.getById(function (data) {
        senderPokemon = data;
        pokemon.id = recipientpoke;
        //get recipients pokemon data (nape hp atack defense...)
        pokemon.getById(function (data) {
            var recipientPokemon = data;
            //Broadcast in room (sends data to both players)
            io.in('fightRoom').emit("startFight", {senderPokemon: senderPokemon, recipientPokemon: recipientPokemon});
        }, function (data) {
            //TODO add error notification
        });
    }, function (data) {
        //TODO add error notification
    });

}

module.exports = challengeController;

