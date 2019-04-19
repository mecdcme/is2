var _ctx = $("meta[name='ctx']").attr("content");
/* variabili defini nella pagina html thymeleaf
  var _text_addUser = [[#{user.title.adduser}]];
  	 var _text_editUser = [[#{user.title.edituser}]];
  	 var _text_savinguser = [[#{user.button.savinguser}]];
  	 var _text_saveUser = [[#{user.button.saveuser}]];
*/
var table;

var tabled_changed = false;
$(document)
        .ready(
                function () {
                    setMenuActive("users-list");

                    table = $('#userslist')
                            .DataTable(
                                    {
                                        // dom : 'Bfrtip',
                                        dom: "<'row'<'col-sm-6'B><'col-sm-6'f>>"
                                                + "<'row'<'col-sm-12'tr>>"
                                                + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
                                        responsive: true,
                                        buttons: [{
                                                extend: 'csvHtml5',
                                                filename: 'usersList',
                                                title: 'usersList',
                                                exportOptions: {
                                                    columns: [0, 1, 2, 3, 4]
                                                }
                                            }, {
                                                extend: 'excelHtml5',
                                                filename: 'usersList',
                                                title: 'usersList',
                                                exportOptions: {
                                                    columns: [0, 1, 2, 3, 4]
                                                }
                                            }, {
                                                extend: 'pdfHtml5',
                                                filename: 'usersList',
                                                title: 'usersList',
                                                exportOptions: {
                                                    columns: [0, 1, 2, 3, 4]
                                                }
                                            }],
                                        "ajax": {
                                            "dataType": 'json',
                                            "contentType": "application/json; charset=utf-8",
                                            "type": "GET",
                                            "url": _ctx + "/users",
                                            "dataSrc": function (json) {

                                                return json;
                                            }
                                        },
                                        "columns": [
                                            {
                                                'data': 'userid'
                                            },
                                            {
                                                'data': 'name'
                                            },
                                            {
                                                'data': 'surname'
                                            },
                                            {
                                                'data': 'email'
                                            },
                                            {
                                                'data': 'role.role'
                                            },
                                            {
                                                "render": function (data,
                                                        type, row) {
                                                    var txt = '<a   href="javascript:void(0)" title="Edit" onclick="javascript:edit_user('
                                                            + row.userid
                                                            + ');"><i class="fa fa-pencil"></i></a>'
                                                            + '&nbsp;&nbsp;<a   href="javascript:void(0)" title="Change Password" onclick="javascript:open_changepassword('
                                                            + row.userid
                                                            + ',\''
                                                            + row.email
                                                            + '\');"><i class="fa fa-key"></i></a>';
                                                    if (row.userid != $('#myId').val())
                                                        txt += '&nbsp;&nbsp; <a   href="javascript:void(0)" title="Delete" onclick="javascript:open_delete('
                                                                + row.userid
                                                                + ',\''
                                                                + row.email
                                                                + '\');"><i class="fa fa-trash-o"></i></a>';

                                                    return txt;
                                                },
                                                "orderable": false
                                            }
                                          
                                        ]
                                    });

                    table.buttons().container().appendTo(
                            '#userslist_wrapper .col-sm-6:eq(0)');

                    $('#modal_user').on('hide.bs.modal', function () {
                        if (tabled_changed)
                            close();
                    })
                    $('#modalDelete_form').on('hide.bs.modal', function () {
                        $('#delEmail').empty();
                        $('#delId').empty();
                        $('#msgsDel').empty();

                    })

                    $("#change_password_group  input[type=password]")
                            .keyup(
                                    function () {

                                        $('#msgsCp').empty();
                                        $("#btnChangePassword").prop(
                                                "disabled", true);

                                        if (($("#passwordcp").val().trim().length >= 3)) {
                                            if ($("#passwordcp").val() == $(
                                                    "#passwordcp1").val()) {

                                                $("#btnChangePassword").prop(
                                                        "disabled", false);
                                            }
                                        }
                                    });
                    $(".password_group  input[type=password]")
                            .keyup(
                                    function () {


                                        $("#btnSave").prop(
                                                "disabled", true);
                                        $(".password_group ").addClass('has-error');
                                        if (($("#form_password").val().trim().length >= 3)) {
                                            if ($("#form_password").val() == $(
                                                    "#form_password1").val()) {

                                                $("#btnSave").prop(
                                                        "disabled", false);
                                                $(".password_group ").removeClass('has-error');
                                            }
                                        }
                                    });

                });// fine ready

function add_user() {
    save_method = 'add';
     $('#form')[0].reset(); // reset form on modals
    $('[name="email"]').prop("readonly", false);

    $('.form-group').removeClass('has-error'); // clear error class
    $('.help-block').empty(); // clear error string
    $('[name="userid"]').val('');;
    $('#modal_user').modal('show'); // show bootstrap modal
    $('.password_group').show(); // show password block
    $('#form_password').val(''); // show password block

    $('#modal_user .modal-title').html('<i class="fa fa-user-plus"></i> '+_text_addUser);
    //$('#modal_user .modal-title').text('Add User'); // Set Title to Bootstrap modal title
    $('#msgs').empty();
    tabled_changed = false;
}

function edit_user(id) {
    save_method = 'update';
    $('#form')[0].reset(); // reset form on modals
    $('.form-group').removeClass('has-error'); // clear error class
    $('.help-block').empty(); // clear error string

    $('#form_password').val('password'); // show password block
    $('.password_group').hide(); // show password block
    $('#msgs').empty();
    tabled_changed = false;
    // Ajax Load data from ajax
    $.ajax({
        url: _ctx + "/users/" + id,
        type: "GET",
        dataType: "JSON",
        success: function (data) {
            $('[name="userid"]').val(data.userid);
            $('[name="name"]').val(data.name);
            $('[name="surname"]').val(data.surname);
            $('[name="email"]').val(data.email);
            $('[name="email"]').prop("readonly", true);
            $('[name="role"] option[value=' + data.role.role + ']').prop(
                    'selected', true);
            
            $('#modal_user').modal('show'); // show bootstrap modal when
            // complete loaded            
            $('#modal_user .modal-title').html('<i class="fa  fa-edit "></i> '+_text_editUser);
            //$('#modal_user .modal-title').text('Edit User'); // Set title to Bootstrap            
            // modal title
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error get data from ajax');
        }
    });
}

function reload_table() {
    // /users/restlist
    table.ajax.reload(null, false); // reload datatable ajax

    // ricarica_pagina();
}

function ricarica_pagina() {
    // /users/restlist
    location.reload();
}

function close() {
    // /users/restlist

    ricarica_pagina();
}

function ricarica_tabella() {
    // /users/restlist

    location.reload();
}
function save() {

    $('#btnSave').text(_text_savinguser); // change button text
    $('#btnSave').attr('disabled', true); // set button disable
    tabled_changed = false;
    var url = _ctx + "/users";
    var method;

    if (save_method == 'add') {
      //  url = _ctx + "/users/restNewUser";
    	method="POST";
    } else {
        //url = _ctx + "/users/restUpdateUser";
    	method="PUT";
    }

    // ajax adding data to database
    $.ajax({
        url: url,
        type:  method,
        data: $('#form').serialize(),
        dataType: "JSON",
        success: function (data) {
            var nerror = 0;
            $("#msgs").empty();
            if (data) {
                $.each(data,
                        function (index, msg) {
                            var classs = 'alert alert-info';
                            if (msg.type == 'INFO')
                                classs = 'alert alert-success';
                            else if (msg.type == 'ERROR') {
                                classs = 'alert alert-danger';
                                nerror++;
                            }
                            var div = $('<div class="' + classs + '"><strong>'
                                    + msg.type + '</strong>: ' + msg.text
                                    + ' </div>"');
                            $("#msgs").append(div);

                        });
            }
            $('#btnSave').text(_text_saveUser); // change button text
            tabled_changed = true;
            if (save_method != 'add' || nerror > 0)
                $('#btnSave').attr('disabled', false); // set button enable

        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error adding / update data '+textStatus);
            $('#btnSave').text(_text_saveUser); // change button text
            $('#btnSave').attr('disabled', false); // set button enable
        }
    });
}

function open_delete(id, email) {
    $('#btnDelete').show(); // set button enable
    $('#delEmail').text(email); // change button text
    $('#delId').val(id);
    $('#modalDelete_form').modal('show'); // show bootstrap modal
    $('#msgsDel').empty();
}

function delete_user() {
    var id = $('#delId').val();
    $.ajax({
        url: _ctx + "/users/" + id,
        type: "DELETE",
        dataType: "JSON",
        success: function (data) {
            $("#msgsDel").empty();
            if (data) {
                $.each(data,
                        function (index, msg) {
                            var classs = 'alert alert-info';
                            if (msg.type == 'INFO')
                                classs = 'alert alert-success';
                            else if (msg.type == 'ERROR')
                                classs = 'alert alert-danger';
                            var div = $('<div class="' + classs + '"><strong>'
                                    + msg.type + '</strong>: ' + msg.text
                                    + ' </div>"');
                            $("#msgsDel").append(div);
                        });
            }
            $('#btnDelete').hide(); // set button enable
            reload_table();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error deleting data');
        }
    });
}

function open_changepassword(id, email) {
    $('.password_group').show();
    $('#btnDelete').show(); // set button enable
    $('#cpEmail').text(email); // change button text
    $('#cpId').val(id);
    $('#modalCp_form').modal('show'); // show bootstrap modal
    $('#msgsCp').empty();
    $('#passwordcp').val('');
    $('#passwordcp1').val('');
}

function update_password() {
    var id = $('#cpId').val();
    var password = $('#passwordcp').val();
    $.ajax({
        url: _ctx + "/users/reset_password/"+id,
        type: "POST",
        dataType: "JSON",
        data: {
           'passw': password
        },
        success: function (data) {
            $("#msgsCp").empty();
            if (data) {
                writeMsgs(data, "msgsCp");
                $('#passwordcp').val('');
                $('#passwordcp1').val('');
                $("#btnChangePassword").prop("disabled", true);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            writeMsgsError("Error deleting data", "msgsCp");
        }
    });
}
