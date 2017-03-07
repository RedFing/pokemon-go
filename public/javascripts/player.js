function openEditModal(i) {
    //console.log("otvaram modal");
    var rowID = "tRow" + i;
    var row = document.getElementById(rowID);
    $('#unmEdit').val(row.cells[0].innerHTML);
    $('#frstnmEdit').val(row.cells[1].innerHTML);
    $('#lstnmEdit').val(row.cells[2].innerHTML);
    var button = "<button type='button' class='btn' data-dismiss='modal' onclick='editRow("+i+")'>Edit</button>";
    var footer = document.getElementById('editModalFooter');
    footer.innerHTML = button;
    $('#editPlayerModal').modal();
}

function editRow(i){
    //console.log("editujem red");
    var rowID = "tRow" + i;
    var row = document.getElementById(rowID);
    var dataToSend = {
        action: 'edit',
        unameOld: row.cells[0].innerHTML,
        unameNew: $('#unmEdit').val(),
        firstnameNew: $('#frstnmEdit').val(),
        lastnameNew: $('#lstnmEdit').val()
    };
    $.ajax({
        type: "POST",
        url: "/player/edit",
        data: dataToSend,
        success: function (data) {
            row.cells[0].innerHTML = dataToSend.unameNew;
            row.cells[1].innerHTML = dataToSend.firstnameNew;
            row.cells[2].innerHTML = dataToSend.lastnameNew;
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
        uname: row.cells[0].innerHTML,
        firstname: row.cells[1].innerHTML,
        lastname: row.cells[2].innerHTML
    };
    $.ajax({
        type: "DELETE",
        url: "/player/delete",
        data: dataToSend,
        success: function (data) {
            row.parentNode.removeChild(row);
        },
        error: function () {
            alert('Cannot delete data from table!');
        }
    });
}

function addPlayer(){
    //console.log("dodajem igraca");
    var dataToSend = {
        action: 'add',
        uname: document.getElementById('unm').value,
        firstname: document.getElementById('frstnm').value,
        lastname: document.getElementById('lstnm').value};
    //console.log(dataToSend);
    $.ajax({
        type: "POST",
        url: "/player/add",
        data: dataToSend,
        success: function (data) {
            var tabela = document.getElementById('playerTable');
            var lastRow = tabela.rows.length;
            var newRow  = tabela.insertRow(lastRow);
            newRow.id = "tRow" + lastRow;
            newRow.insertCell(0).innerHTML = dataToSend.uname;
            newRow.insertCell(1).innerHTML = dataToSend.firstname;
            newRow.insertCell(2).innerHTML = dataToSend.lastname;
            newRow.insertCell(3).innerHTML = "<button type='button' class='btn' onclick='openEditModal("+lastRow+")'>Edit</button>";
            newRow.insertCell(4).innerHTML = "<button type='button' class='btn' onclick='deleteRow("+lastRow+")'>Delete</button>";
        },
        error: function () {
            alert('Cannot insert data into table!');
        }
    });
}