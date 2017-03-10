$('document').ready(function(){
    $.ajax({
        type: "GET",
        url: "/playermap/showtable",
        success: function (data) {
            var tbody = document.getElementById('playerPokemons');
            for (var i = 0; i < data.length; i++){
                var tr = document.createElement('tr');
                var td1 = document.createElement('td');
                var td2 = document.createElement('td');
                td1.innerHTML = data[i].name;
                td2.innerHTML = data[i].customname;
                tr.appendChild(td1);
                tr.appendChild(td2);
                tbody.appendChild(tr);
            }
            initMap();
        },
        error: function () {
            alert('Cannot show data from table!');
        }
    });
});

var map;
function initMap() {
    console.log("init map");
    var pozicijaIgraca;
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 18
    });
        navigator.geolocation.getCurrentPosition(function (position) {
            var pos = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
            };
            pozicijaIgraca = pos;
            map.setCenter(pos);
            var ikonica = {
                url: "../you-marker.png",
                size: new google.maps.Size(48,48),
                origin: new google.maps.Point(0,0)
            };
            new google.maps.Marker({
                position: pos,
                map: map,
                icon: ikonica
            });
            new google.maps.Circle({
                strokeColor: '#0000FF',
                strokeOpacity: 0.2,
                strokeWeight: 2,
                fillColor: '#0000FF',
                fillOpacity: 0.1,
                map: map,
                center: pos,
                radius: 100
            });
            new google.maps.Circle({
                strokeColor: '#00FF00',
                strokeOpacity: 0.2,
                strokeWeight: 2,
                fillColor: '#00FF00',
                fillOpacity: 0.05,
                map: map,
                center: pos,
                radius: 3000
            });
                getPokemonLocation(pos, map);
                getOtherPlayersLocation(map);
        });
}

function getPokemonLocation(pos, map){
    var dataTosend = pos;
    $.ajax({
        type: "POST",
        url: "/playermap/getpokemonlocation",
        data: dataTosend,
        success: function(data){
            id = data.id;
            lok = data.lok;
            var ikonica = {
                url: "../pokemoni.png",
                size: new google.maps.Size(80,80),
                origin: new google.maps.Point(data.x * 80, data.y * 80)
            };
            marker = new google.maps.Marker({
                position: lok,
                map: map,
                icon: ikonica
            });
            marker.addListener('click', function() {
                $('#catchPokemonModalHeading').text(data.name);
                var ime = data.name.toLocaleLowerCase() + ".png";
                $('.wrapper-img').html('<img src="../all-pokemons/'+ime+'" class="bigPicPokemon">');
                $('#catchPokemonModal').modal();
            });
        },
        error: function (data) {
        }
    });
}

function getOtherPlayersLocation(map){
    $.ajax({
        type: "GET",
        url: "/playermap/getotherplayerslocation",
        success: function(data) {
            console.log(data);
            for (var i = 0; i < data.length; i++){
                var playerUsername = data[i].username;
                var lok = {lat: data[i].lat+ 0.0005, lng: data[i].lon};
                console.log(lok);
                marker = new google.maps.Marker({
                    position: lok,
                    map: map,
                    zIndex: 10000,
                });
                console.log("stavio marker");
                marker.addListener('click', function() {
                    playerInfo(playerUsername);
                });
            }
        },
        error: function (data) {
        }
    });
}

function catchPokemon() {
    var dataTosend = {id: id};
    $.ajax({
        type: "POST",
        url: "/playermap/catchpokemon",
        data: dataTosend,
        success: function(data){
            if (data.success == true){
                console.log("u ifu");
                var msg = "You caught a pokemon: " + data.name;
                alert(msg);
                var customName = prompt("How shall we name it?");
                if (customName != "") {
                    console.log("pozivam custom name");
                    giveNameToPokemon(data.pokemontypeid, customName);
                }
                var tbody = document.getElementById('playerPokemons');
                var tr = document.createElement('tr');
                var td1 = document.createElement('td');
                var td2 = document.createElement('td');
                td1.innerHTML = data.name;
                td2.innerHTML = customName;
                tr.appendChild(td1);
                tr.appendChild(td2);
                tbody.appendChild(tr);
            }
            else {
                alert("Pokemon has escaped!");
            }
            $("#catchPokemonModal").modal('hide');
            marker.setMap(null);
        },
        error: function () {
            alert("Pokemon is not here anymore!");
            $("#catchPokemonModal").modal('hide');
            marker.setMap(null);
        }
    });
}

function playerInfo(username) {
    $("#playerInfoModal").modal('show');
    $("#playerInfoModalHeading").text("Player: " + username);
    $("#playerInfoModalFooter").html('<button onclick="sendChallenge(\''+username+'\')">Send challenge</button>');
}

function sendChallenge(username){
    console.log("usao");
    $.ajax({
        type: "POST",
        url: "/playermap/sendchallenge",
        data: {username: username},
        success: function(data){
            $('#playerInfoModal').modal('hide');
        },
        error: function (data) {
        }
    });
}

function giveNameToPokemon(pokemontypeid, customName) {
    var dataTosend = {customName: customName, pokemontypeid: pokemontypeid};
    console.log(dataTosend);
    $.ajax({
        type: "POST",
        url: "/playermap/givecustomname",
        data: dataTosend,
        success: function(data){
        },
        error: function (data) {
        }
    });
}

