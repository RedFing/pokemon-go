function openEditModal(i) {
    var rowID = "tRow" + i;
    var row = document.getElementById(rowID);
    $('#pokeidEdit').val(row.cells[0].innerHTML);
    $('#pokenameEdit').val(row.cells[1].innerHTML);
    var button = "<button type='button' class='btn' data-dismiss='modal' onclick='editRow("+i+")'>Edit</button>";
    var footer = document.getElementById('editModalFooter');
    footer.innerHTML = button;
    $('#editPokemonTypeModal').modal();
}


function editRow(i){
    var rowID = "tRow" + i;
    var row = document.getElementById(rowID);
    var dataToSend = {
        action: 'edit',
        pokeidOld: row.cells[0].innerHTML,
        pokeidNew: $('#pokeidEdit').val(),
        pokenameNew: $('#pokenameEdit').val()
    };
    $.ajax({
        type: "POST",
        url: "/pokemontype/edit",
        data: dataToSend,
        success: function (data) {
            row.cells[0].innerHTML = dataToSend.pokeidNew;
            row.cells[1].innerHTML = dataToSend.pokenameNew;
        },
        error: function () {
            alert('Cannot edit data in table!');
        }
    });
}


function deleteRow(i){
    //console.log("delete " + i);
    var rowID = "tRow" + i;
    var row = document.getElementById(rowID);
    var dataToSend = {
        action: 'delete',
        pokeid: row.cells[0].innerHTML,
        name: row.cells[1].innerHTML
    };
    //console.log(dataToSend);
    $.ajax({
        type: "DELETE",
        url: "/pokemontype/delete",
        data: dataToSend,
        success: function (data) {
            row.parentNode.removeChild(row);
        },
        error: function () {
            alert('Cannot delete data from table!');
        }
    });
}


function addPokemonType(){
    //console.log("dodajem pokemona");
    var dataToSend = {
        action: 'add',
        pokeid: document.getElementById('pokeid').value,
        pokename: document.getElementById('pokename').value};
    //console.log(dataToSend);
    $.ajax({
        type: "POST",
        url: "/pokemontype/add",
        data: dataToSend,
        success: function (data) {
            var tabela = document.getElementById('pokemonTypeTable');
            var lastRow = tabela.rows.length;
            var newRow  = tabela.insertRow(lastRow);
            newRow.id = "tRow" + lastRow;
            newRow.insertCell(0).innerHTML = dataToSend.pokeid;
            newRow.insertCell(1).innerHTML = dataToSend.pokename;
            newRow.insertCell(2).innerHTML = "<button type='button' class='btn' onclick='openEditModal("+lastRow+")'>Edit</button>";
            newRow.insertCell(3).innerHTML = "<button type='button' class='btn' onclick='deleteRow("+lastRow+")'>Delete</button>";
        },
        error: function () {
            alert('Cannot insert data into table!');
        }
    });
}
