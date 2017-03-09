$('document').ready(function(){
    console.log("docR");
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
                size: new google.maps.Size(64,58),
                origin: new google.maps.Point(0,0)
            };
            var marker = new google.maps.Marker({
                position: pos,
                map: map,
                icon: ikonica
            });
            var krug = new google.maps.Circle({
                strokeColor: '#0000FF',
                strokeOpacity: 0.2,
                strokeWeight: 2,
                fillColor: '#0000FF',
                fillOpacity: 0.1,
                map: map,
                center: pos,
                radius: 100
            });
                getPokemonLocation(pos, map);
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
        error: function (data) {
        }
    });
}

function giveNameToPokemon(pokemontypeid, customName) {
    var dataTosend = {customName: customName, pokemontypeid: pokemontypeid};
    console.log(dataTosend)
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

