/**
 * Copyright 2019 ISTAT
 *
 * Licensed under the EUPL, Version 1.1 or – as soon they will be approved by
 * the European Commission - subsequent versions of the EUPL (the "Licence");
 * You may not use this work except in compliance with the Licence. You may
 * obtain a copy of the Licence at:
 *
 * http://ec.europa.eu/idabc/eupl5
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the Licence is distributed on an "AS IS" basis, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * Licence for the specific language governing permissions and limitations under
 * the Licence.
 *
 * @author Francesco Amato <framato @ istat.it>
 * @author Mauro Bruno <mbruno @ istat.it>
 * @author Paolo Francescangeli  <pafrance @ istat.it>
 * @author Renzo Iannacone <iannacone @ istat.it>
 * @author Stefano Macone <macone @ istat.it>
 * @version 1.0
 */
var _ctx = $("meta[name='ctx']").attr("content");
var toggle = true;

$(document).ready(function () {

    var ID = 1; // _idfile;
    $("#contenuto_file").hide();

    var table = $("#worksetTabList").DataTable({
        dom: "<'row'<'col-sm-5'B><'col-sm-7'f>>"
                + "<'row'<'col-sm-12'tr>>"
                + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        autoWidth: false,
        responsive: true,
        paging: false,
        rowReorder: {        	
            selector: 'td:nth-child(2)'
        },
        columnDefs: [{
                "orderable": false,
                className: 'reorder',
                "targets": [1]
            }],
        buttons: [{
                className: 'btn-extenal-function btn-light',
                text: '<i class="fa fa-plus"></i><span> Variabile</span>',
                action: function (e, dt, node, config) {
                    openDlgAddVariabileWorkset();
                }
            }],
        createdRow: function (row, data, dataIndex) {
            $(row).attr('id', 'row-' + dataIndex);
        }
    });

    table.on('row-reorder', function (e, diff, edit) {
        var result = 'Reorder started on row: ' + edit.triggerRow.data()[1] + '<br>';

        for (var i = 0, ien = diff.length; i < ien; i++) {
            var rowData = table.row(diff[i].node).data();
            result += rowData[1]
                    + ' updated to be in position '
                    + diff[i].newData + ' (was '
                    + diff[i].oldData + ')<br>';
        }
        cambiaPosizione();
    });

    var listVarSize = $("#check_vrs").val();
    if (listVarSize == 0) {
        $("#processiList").find("a[name='link']").addClass("disabled");
    }

    $('#btn_delete').click(function () {
        var idelab = $("#idelab").val();
        var idstepvar = $("#idstepvar").val();
        window.location = _ctx
                + '/ws/eliminaAssociazione/' + idelab
                + "/" + idstepvar;
    });

    $('#btn_delete_param').click(function () {
        var idelab = $("#idelab").val();
        var idparam = $("#idparam").val();
        window.location = _ctx
                + '/ws/eliminaParametro/' + idelab
                + "/" + idparam;
    });

    $("#parametriTabList").DataTable({
        dom: "<'row'<'col-sm-6'B><'col-sm-6'f>>"
                + "<'row'<'col-sm-12'tr>>"
                + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        autoWidth: false,
        responsive: true,
        paging: false,
        rowReorder: true,
        columnDefs: [{
                "orderable": false,
                className: 'reorder',
                targets: [1,2,3,4,5,6]
            }],
        buttons: [{
                className: 'btn-extenal-function btn-light',
                text: '<i class="fa fa-plus"></i><span> Parametro</span>',
                action: function (e, dt, node, config) {
                    openDlgAddParametriWorkset();
                }
            }],
        'createdRow': function (row, data, dataIndex) {
            $(row).attr('id', 'row-' + dataIndex);
        }
    });

    $("#dataFile").DataTable({
        drawCallback: function () {
            $(".loading").hide();
        },
        dom: "<'row'<'col-sm-4'B><'col-sm-4'f><'col-sm-4'<'pull-right'l>> >"
                + "<'row'<'col-sm-12'tr>>"
                + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        responsive: true,
        ordering: false,
        searching: false,
        lengthChange: true,
        pageLength: 25,
        serverSide: true,
        ajax: _ctx + "/rest/datasetvalori/" + ID,
        "columns": eval(getHeaders('dataFile')),
        processing: true,
        buttons: [{
                extend: 'csvHtml5',
                filename: 'download',
                title: 'download',
                action: function (e, dt, node, config) {
                    scaricaFile('csv');
                }
            }]
    });

    var idElaborazione = 1; // _idElaborazione;

    $("#worksetTab").DataTable({
        drawCallback: function () {
            $(".loading").hide();
        },
        dom: "<'row'<'col-sm-4'B><'col-sm-4'f><'col-sm-4'<'pull-right'l>> >"
                + "<'row'<'col-sm-12'tr>>"
                + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        responsive: true,
        "ordering": false,
        searching: false,
        lengthChange: true,
        pageLength: 25,
        serverSide: true,
        ajax: _ctx + "/rest/ws/worksetvalori/" + idElaborazione,
        "columns": eval(getHeaders('worksetTab')),
        processing: true,
        buttons: [{
                extend: 'csvHtml5',
                filename: 'download',
                title: 'download',
                action: function (e, dt, node, config) {
                    scaricaFile('csv');
                }
            }]
    });

    $("#nome-var").on("input", function () {
        controllaCampo();
    });

    $('#value-text').on("keyup", function (e) {
        controllaCampoParam();
    });

    $('#value-text-mod').on("keyup", function (e) {
        controllaCampoModParam();
    });

});
function cambiaPosizione() {
    var ordineIds = "";
    var ids = $("#worksetTabList").find(
            "input[name='stepid']");
    for (var i = 0; i < ids.length; i++) {
        ordineIds += i + "=" + ids[i].value + "|";
    }
    ordineIds = ordineIds.slice(0, -1);
    updateOrdineRighe(ordineIds);
}

function updateOrdineRighe(ordineIds) {
    $.ajax({
        url: _ctx + "/rest/ws/updaterowlist",
        type: "POST",
        data: "ordineIds=" + ordineIds,
        success: function (data) {
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });
}
function isNumber(o) {
    return o == '' || !isNaN(o - 0);
}
function controllaInputText() {
    if ($("#nome-var").val().length > 0) {
        $("#btn_dlg_assoc_mod").removeClass('disabled');
        $("#btn_dlg_assoc_mod").removeAttr('disabled');
    }
}
function attivaBottone() {
    var contenuto = $("#vars_content").text();
    $("#btn_rimuovi_ass").show();
    if (contenuto == "") {
        $("#btn_rimuovi_ass").hide();
    }
}
function getHeaders(tab) {
    var text = '[';
    $("#" + tab + " th").map(function () {
        text += '{"data": "' + $(this).text() + '"},';
    });
    if (text.length > 1)
        text = text.substring(0, text.length - 1);
    text += ']';
    return text;
}

function openDlgAddVariabileWorkset() {
    $(".rolelist").removeClass('active');
    $(".varlist").removeClass('active');
    $("#varSelectedId").val('');
    $("#varSelectedName").val('Nessuna variabile selezionata');
    $("#roleSelectedId").val('');
    $("#roleSelectedName").val('Nessun ruolo selezionato');
    $("#btn_dlg_assoc").addClass('disabled');
    $("#btn_dlg_assoc").attr("disabled", "disabled");
    $("#add-viarabile-workset-modal").modal('show');
}

function openDlgAddParametriWorkset() {
    controllaCampoParam();
    var size = $("#sizeParam").val();
    alert($("#sizeParam").val());
    $(".rolelist").removeClass('active');
    $(".varlist").removeClass('active');
    $("#varSelectedId").val('');
    $("#varSelectedName").val('Nessuna variabile selezionata');
    $("#roleSelectedId").val('');
    $("#roleSelectedName").val('Nessun ruolo selezionato');
    $("#add-parametri-workset-modal").modal('show');
}

function openDlgModParametriWorkset(idelab, idParam, nomeParam, valoreParam) {
    $("#value-text-mod").val(valoreParam);
    controllaCampoModParam();
    $("#select-param-mod option:contains(" + nomeParam + ")").attr('selected', 'selected');
    $("#idStepvarMod").val(idParam);
    $("#mod-parametri-workset-modal").modal("show");
}

function controllaCampoModParam() {
    if ($("#value-text-mod").val().length > 0) {
        $("#btn_dlg_mod_assoc_param").removeClass('disabled');
        $("#btn_dlg_mod_assoc_param").removeAttr('disabled');
    } else {
        $("#btn_dlg_mod_assoc_param").addClass('disabled');
        $("#btn_dlg_mod_assoc_param").attr("disabled", "disabled");
    }
}

function setSelectedVar(ordine, nome, id) {
    $(".varlist").removeClass('active');
    $("#var_" + id).addClass('active');
    $("#varSelectedId").val(id);
    $("#varSelectedName").val(nome);
    if ($("#varSelectedId").val().length > 0 && $("#roleSelectedId").val().length > 0) {
        $("#btn_dlg_assoc").removeClass('disabled');
        $("#btn_dlg_assoc").attr("disabled", false);
    }
}

function setSelectedVarMod(ordine, nome, id) {
    $(".varlist").removeClass('active');
    $("#mod_var_" + id).addClass('active');
    $("#varModSelectedId").val(id);
    $("#varModSelectedName").text(nome);
    if ($("#varModSelectedId").val().length > 0 || $("#roleModSelectedId").val().length > 0) {
        $("#btn_dlg_assoc_mod").removeClass('disabled');
        $("#btn_dlg_assoc_mod").attr("disabled", false);
    }
}

function setSelectedRole(nomeR, idR) {
    $(".rolelist").removeClass('active');
    $("#role_" + idR).addClass('active');
    $("#roleSelectedId").val(idR);
    $("#roleSelectedName").val(nomeR);
    if ($("#varSelectedId").val().length > 0 && $("#roleSelectedId").val().length > 0) {
        $("#btn_dlg_assoc").removeClass('disabled');
        $("#btn_dlg_assoc").attr("disabled", false);
    }
}

function setModSelectedRole(nomeR, idR) {
    $("#mod_idruolo").val(idR);
    $(".rolelist").removeClass('active');
    $("#mod_role_" + idR).addClass('active');
    $("#roleModSelectedId").val(idR);
    $("#roleModSelectedName").text(nomeR);
    if ($("#varModSelectedId").val().length > 0 || $("#roleModSelectedId").val().length > 0)
        $("#btn_dlg_assoc_mod").removeClass('disabled');
}

function inserisciRuoloVar() {
    var var_id = $("#varSelectedId").val();
    var var_nome = $("#varSelectedName").val();
    var role_id = $("#roleSelectedId").val();
    var role_nome = $("#roleSelectedName").val();
    var id_elaborazione = $("#idelaborazione").val();
    var content = $("#vars_content").html();
    var input_content = $("#associazione_vars").html();

    input_content += "<input type='hidden' name='ruolo' value='" + role_id
            + "'/><input type='hidden' name='variabile' value='" + var_id
            + "'/>" + "<input type='hidden' name='valore' value='" + var_nome
            + "'/>" + "<input type='hidden' name='elaborazione' value='"
            + id_elaborazione
            + "'/></span><input type='hidden' name='stato' value='N'/></span>";

    $("#associazione_vars").html(input_content);
    $("#vars_content").html(content);
    eseguiFunzione();
}
function modificaRuoloVar() {
    var var_id = $("#varModSelectedId").val();
    var var_nome = $("#varModSelectedName").text();
    var role_id = $("#roleModSelectedId").val();
    var role_nome = $("#roleModSelectedName").text();
    var id_elaborazione = $("#idelaborazione").val();
    var input_content = $("#update_associazione_vars").html();
    input_content += "<input type='hidden' name='elaborazione' value='" + id_elaborazione
            + "'/></span><input type='hidden' name='stato' value='N'/></span>";

    $("#update_associazione_vars").html(input_content);
    eseguiFunzioneUpdate();
}

function eliminaRiga(id) {
    var table = $('#worksetTabList').DataTable();
    table.row('#row-' + id).remove().draw();
}

function openSceltaRuolo(ordine, nome, id) {
    $("#temp_var").val(id);
    $("#variabile").text(nome);
    $("#scelta-ruolo-modal").modal('show');
}

function associaRuoloVar(nomeR, idR) {
    var var_val = $("#temp_var").val();
    var name_var = $("#variabile").text();
    var id_elaborazione = $("#idelaborazione").val();
    $("#vars_content").html();
    $("#ruolo").val(idR);
    var content = $("#vars_content").html();
    var input_content = $("#associazione_vars").html();
    // aggiungo una riga alla tabella con la variabile corrispondente
    if ($("#tab_associated tr.input_" + idR).length == 0) {

        $('#tab_associated > tbody:last-child').append(
                '<tr class="input_'
                + idR
                + '"><td>'
                + nomeR
                + '</td><td></td><td><input id="input_'
                + idR
                + '" type="text" data-role="tagsinput"></input></td></tr>');
        $('#input_' + idR).tagsinput();
        // Intercetta il remove e rimuove anche la variabile input associata
        $('#input_' + idR).on('itemRemoved', function (event) {
            rimuoviInputVarAssociata(idR, var_val);
            if ($('#input_' + idR).val().trim().length == 0)
                $(this).closest("tr").remove();
        });
    }
    $('#input_' + idR).tagsinput('add', name_var);

    // Se la variabile input esiste già non la crea ma aggiunge solo il
    // contenuto altrimenti la crea
    if ($("#span_" + idR + "_" + var_val + "").length == 0) {
        // aggiungo un input text per la variabile
        input_content += "<span id='span_" + idR + "_" + var_val
                + "'><input type='hidden' name='ruolo' value='" + idR
                + "'/><input type='hidden' name='variabile' value='" + var_val
                + "'/>" + "<input type='hidden' name='elaborazione' value='"
                + id_elaborazione + "'/></span>";
        $("#associazione_vars").html(input_content);
    } else {
        // Se l'id esiste già aggiungo semplicemente il contenuto
        var input_var = "<input type='hidden' name='ruolo' value='" + idR
                + "'/><input type='hidden' name='variabile' value='" + var_val
                + "'/>" + "<input type='hidden' name='elaborazione' value='"
                + id_elaborazione + "'/></span>";
        $("#span_" + idR + "_" + var_val + "").html(input_var);
    }

    $("#vars_content").html(content);
    $("#scelta-ruolo-modal").modal("hide");

}
function rimuoviInputVarAssociata(idr, idvar) {
    $("#span_" + idr + "_" + idvar + "").html("");
}
function caricaBProcessiByFunzione() {
    var id_funzione = $("#funzioni :selected").val();
    $.ajax({
        url: _ctx + "/rest/ws/loadBProcess/" + id_funzione,
        type: "GET",
        dataType: "JSON",
        success: function (data) {
            var content = "<div class='col-lg-4'><label class='control-label'>"
                    + "<span id='process'>Business Process:</span></label></div><div class='col-lg-8'>"
                    + "<select id='processi' name='processo' class='form-control'>";
            $(jQuery.parseJSON(JSON.stringify(data))).each(
                    function () {
                        var id = this.id;
                        var descr = this.descr;
                        content += "<option value='" + id + "'>" + descr + "</option>";
                    });
            content += "</select></div>";
            $("#bprocess").html(content);
            // carico direttamente la combo bsteps
            caricaBStepsByProcess();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });
}
function caricaBStepsByProcess() {
    var id_process = $("#processi :selected").val();
    $.ajax({
        url: _ctx + "/rest/ws/loadBSteps/" + id_process,
        type: "GET",
        dataType: "JSON",
        success: function (data) {
            var content = "<div class='col-lg-4'><label class='control-label'>"
                    + "<span id='step'>Business Steps:</span></label></div><div class='col-lg-8'>"
                    + "<select id='sel_step' name='step' class='form-control'>";
            $(jQuery.parseJSON(JSON.stringify(data))).each(function () {
                var id = this.id;
                var descr = this.descr;
                content += "<option value='" + id + "'>"
                        + descr + "</option>";
            });
            content += "</select></div>";
            $("#bstep").html(content);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });
}
function visualizzaVariabiliAssociate() {
    var id_process = $("#processi :selected").val();
    $.ajax({
        url: _ctx + "/rest/ws/loadBSteps/" + id_process,
        type: "GET",
        dataType: "JSON",
        success: function (data) {
            var content = "<div class='col-lg-4'><label class='control-label'>"
                    + "<span id='step'>Business Steps:</span></label></div><div class='col-lg-8'>"
                    + "<select id='sel_step' name='step' class='form-control'>";
            $(jQuery.parseJSON(JSON.stringify(data))).each(function () {
                var id = this.id;
                var descr = this.descr;
                content += "<option value='" + id + "'>"
                        + descr + "</option>";
            });
            content += "</select></div>";
            $("#bstep").html(content);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });
}
function eliminaAssociazioni() {
    $("#vars_content").html("");
    $("#associazione_vars").html("");
    attivaBottone();
}
function eseguiFunzione() {
    $("#formAssociaRuolo").submit();
}
function eseguiFunzioneUpdate() {
    $("#formUpdateAssociaRuolo").submit();
}

function inserisciParams() {
    $("#valoreParam").val($("#value-text").val());
    $("#formAssociaParam").submit();
}

function modificaParam() {
    $("#valoreParamMod").val($("#value-text-mod").val());
    $("#formModAssociaParam").submit();
}

function mostraDialogEliminaAssociazione(idelab, idstepvar, nomestepvar) {
    $("#nomeStepVar").text(nomestepvar);
    $("#idelab").val(idelab);
    $("#idstepvar").val(idstepvar);
    $("#modalCancellaAssociazione").modal("show");
}

function mostraDialogEliminaParametro(idelab, idParam, nomeParam) {
    $("#idparam").val(idParam);
    $("#idelab").val(idelab);
    $("#nomeParametro").text(nomeParam);
    $("#modalCancellaParametro").modal("show");
}

function test() {
    alert($("#nome-var").val().length);
    ($("#filtro1").prop("checked") != false || $("#filtro0").prop("checked") != false)
            && $("#nome-var").val().length > 0
}

function mostraDialogModificaAssociazioneOld(idelab, idstepvar, nomestepvar,
        idruolo, flagricerca) {
    $("#mod_idruolo").val(idruolo);
    $("#mod_idvariabile").val(idstepvar);
    $("#mod_nomevariabile").val(nomestepvar);
    $(".rolelist").removeClass('active');
    $(".varlist").removeClass('active');
    $("#mod_var_" + idstepvar).addClass('active');
    $("#mod_role_" + idruolo).addClass('active');
    $("#varModSelectedId").val('');
    $("#varModSelectedName").text('Nessuna variabile selezionata');
    $("#roleModSelectedId").val('');
    $("#roleModSelectedName").text('Nessun ruolo selezionato');
    $("#btn_dlg_assoc_mod").addClass('disabled');
    $("#btn_dlg_assoc_mod").attr("disabled", "disabled");
    $("#modifica-viarabile-workset-modal").modal('show');
}
function controllaCampo() {
    if (($("#filtro1").is(':checked') == true || $("#filtro0").is(':checked') == true)
            && $("#nome-var").val().length > 0) {
        $("#btn_dlg_assoc_mod").removeClass('disabled');
        $("#btn_dlg_assoc_mod").removeAttr('disabled');
    } else {

        $("#btn_dlg_assoc_mod").addClass('disabled');
        $("#btn_dlg_assoc_mod").attr("disabled", "disabled");
    }

}

function controllaCampoParam() {
    if ($("#value-text").val().length > 0 && $("#value-text").val() != '') {
        $("#btn_dlg_assoc_param").removeClass('disabled');
        $("#btn_dlg_assoc_param").removeAttr('disabled');
    } else {
        $("#btn_dlg_assoc_param").addClass('disabled');
        $("#btn_dlg_assoc_param").attr("disabled", "disabled");
    }
}

function mostraDialogModificaAssociazione(idelab, idstepvar, nomestepvar, idruolo, flagricerca) {

    $("#nome-var").val(nomestepvar);
    if (($("#filtro1").is(':checked') == true || $("#filtro0").is(':checked') == true) && $("#nome-var").val().length > 0) {
        $("#btn_dlg_assoc_mod").removeClass('disabled');
        $("#btn_dlg_assoc_mod").removeAttr('disabled');
    } else {
        $("#btn_dlg_assoc_mod").addClass('disabled');
        $("#btn_dlg_assoc_mod").attr("disabled", "disabled");
    }

    $("#idruolomod").val(idruolo).change();
    if (flagricerca != 'null') {
        $("#filtro" + flagricerca).attr("checked", "checked");
    } else {
        $("#filtro0").attr("checked", "checked");
    }

    controllaCampo();

    $("filtro:checked").val(idruolo);
    $("#mod_idvariabile").val(idstepvar);
    $("#mod_valore_old").val(nomestepvar);
    $("#mod_nomevariabile").val(nomestepvar);
    $("#varModSelectedId").val('');
    $("#varModSelectedName").text('Nessuna variabile selezionata');
    $("#roleModSelectedId").val('');
    $("#roleModSelectedName").text('Nessun ruolo selezionato');
    $("#modifica-viarabile-workset-modal").modal('show');
}

function showVariabili(){
    $("#card-variabili").show();
    $("#header-variabili span").addClass("header-strong");
    $("#card-parametri").hide();
    $("#header-parametri span").removeClass("header-strong");
}
function showParametri(){
    $("#card-variabili").hide();
    $("#header-variabili span").removeClass("header-strong");
    $("#card-parametri").show();
    $("#header-parametri span").addClass("header-strong");
}