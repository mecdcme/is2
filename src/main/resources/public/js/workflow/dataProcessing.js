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
 * @author Paolo Francescangeli <pafrance @ istat.it>
 * @author Renzo Iannacone <iannacone @ istat.it>
 * @author Stefano Macone <macone @ istat.it>
 * @version 1.0
 */
var _ctx = $("meta[name='ctx']").attr("content");
var toggle = true;
var associazioneVarRoleBean = [];
var tmpVarSel = {};
var checkedPrefix = false;
var tabTemplate = "<li><a href='#{href}'><span class='prefix' style='#{prefixStyle}'>#{prefixTab}</span>#{label} @ <span title='#{roleName}'>#{roleCode}</span></a> <span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>";

var paramDialog='add';
$(document).ready(function () {

    $("#contenuto_file").hide();
    showPanel('variabili');

    $('form input').on('keypress', function (e) {
        return e.which !== 13;
    });

    $('#add-param > input').on("change paste keyup", function () {
        alert($(this).val());
    });

    $('#edit-param > input').on("change paste keyup", function () {
        alert($(this).val());
    });

    $("#variablesTable").DataTable({
        dom: "<'row'<'col-sm-5'B><'col-sm-7'f>>"
                + "<'row'<'col-sm-12'tr>>"
                + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        paging: false,
        rowReorder: false,
        columnDefs: [
        	  { orderable: true, targets: [0,1,2] },
              { orderable: false, targets: '_all' }
        ],
        buttons: [{
                className: 'btn btn-sm btn-block btn-outline-info',
                text: '<i class="fa fa-plus"></i><span> '+_variable_btn+'</span>',
                action: function (e, dt, node, config) {
                    openDlgAddVariabileWorkset();
                }
            }],
        createdRow: function (row, data, dataIndex) {
            $(row).attr('id', 'row-' + dataIndex);
        }
    });

    var listVarSize = $("#check_vrs").val();
    if (listVarSize == 0) {
        $("#processiList").find("a[name='link']").addClass("disabled");
    }

    $('#btn_delete').click(function () {
        var idelab = $("#idelab").val();
        var idstepVar = $("#idstepVar").val();
        window.location = _ctx
                + '/ws/eliminaAssociazione/' + idelab
                + "/" + idstepVar;
    });

    $('#btn_delete_param').click(function () {
        var idelab = $("#idelab").val();
        var idparam = $("#idparam").val();
        window.location = _ctx
                + '/ws/eliminaParametro/' + idelab
                + "/" + idparam;
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
        ordering: false,
        searching: false,
        lengthChange: true,
        pageLength: 25,
        serverSide: true,
        ajax: _ctx + "/rest/ws/worksetvalori/" + idElaborazione,
        columns: eval(getHeaders('worksetTab')),
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

    $('#value-text').on("keyup", function (e) {
        controllaCampoParam();
    });

    $('#value-text-mod').on("keyup", function (e) {
        controllaCampoModParam();
    });

    tabs = $("#tabs").tabs();
    tabs.on("click", "span.ui-icon-close", function () {
        var panelId = $(this).closest("li").remove().attr("aria-controls");
        $("#" + panelId).remove();
        removeSelVarFromTab(panelId);
        tabs.tabs("refresh");
    });

   checkedPrefix =  $('#check-prefix-dataset').prop('checked');
   $(".prefix").toggle(checkedPrefix); 

   
   $('add-parametri-workset-modal').on('dialogclose', function(event) {
	  alert("add"); 
	});
   $('mod-parametri-workset-modal').on('dialogclose', function(event) {
	   alert("addddd"); 
	});
   
});


function openAddParameter(identifier) {
    var idParam = $(identifier).data('param-id');
    var idRole = $(identifier).data('role-id');
    var nameParameter = $(identifier).data('param-name');
    $('#param-text-add').text(nameParameter);
    $('#param-value').val(nameParameter + '|' + idParam + '|' + idRole);
    var jsontemplateText = _paramTemplateMap[replaceAll(nameParameter," ","_")];
    $('#add-param').empty();
    var jsonObj = JSON.parse(jsontemplateText, function (key, value) {
        if (key === "addRow") {
            return eval('(' + value + ')');
        } else if (key === "removeRow") {
            return eval('(' + value + ')');
        } else if (key === "dataSource") {
            return eval(value);
        } else if (key === "postRender") {
            return eval(value);    
        } else {
            return value;
        }
    });
    $('#add-param').alpaca(jsonObj);
    paramDialog='add';
    $("#add-parametri-workset-modal").modal('show');
}

function openSetRuleset(identifier) {
    var idParam = $(identifier).data('param-id');
    var idRole = $(identifier).data('role-id');
    var nameParameter = $(identifier).data('param-name');

    $("#set-ruleset").modal('show');
}

function associaVar() {
    var roleSelectedName = $("#roleSelectedName").val();
    console.log("roleSelectedName", roleSelectedName);
    var roleSelectedId = $("#roleSelectedId").val();
    console.log("roleSelectedId", roleSelectedId);
    var roleSelectedCode = $("#roleSelectedCode").val();
    var idElab = $("#dataProcessingId").val();
    var prefixDataset = $("#check-prefix-dataset").is(':checked');
    
    console.log("idElab", idElab);
    $("#btn_dlg_ins").removeClass('hide');
    $("#role_" + roleSelectedId).removeClass('active');
    $("#roleSelectedId").val("");
    $('#btn_dlg_assoc').addClass('disabled');
    $('#btn_dlg_assoc').attr("disabled", "disabled");
    $("#tab-msg").addClass('hide');
    jQuery.each(variablesArr, function (i, obj) {
        var idTab = obj['idVar'];
        console.log("idTab", idTab);
        var labelTab = obj['labelTab'];
        var prefixTab = obj['prefixTab'];
        console.log("labelTab", labelTab); 
        var prefixStyle =checkedPrefix?'':'display: none;';
        var li = $(tabTemplate.replace(/#\{href\}/g, "#" + idTab).replace(/#\{label\}/g, labelTab).replace(/#\{prefixTab\}/g, prefixTab).replace(/#\{prefixStyle\}/g, prefixStyle).replace(/#\{roleCode\}/g, roleSelectedName).replace(/#\{roleName\}/g, roleSelectedName));
        console.log(li);
        tabs.find(".ui-tabs-nav").append(li);
        tabs.tabs("refresh");
        tmpVarSel['#var_' + idTab] = $('#var_' + idTab).clone();
        $('#var_' + idTab).remove();
    });
    associazioneVarRoleBean.push({'idElaborazione': idElab,'prefixDataset':prefixDataset, 'ruolo': {'idRole': roleSelectedId, 'name': roleSelectedName, 'variables': variablesArr}});
    console.log("associazioneVarRoleBean", associazioneVarRoleBean);
}

function removeSelVarFromTab(id) {
    tmpVarSel['#var_' + id].prependTo("#selectable");
    $('#var_' + id).removeClass('ui-selected');
    delete tmpVarSel['#var_' + id];
    delete associazioneVarRoleBean[id];
    if (Object.entries(tmpVarSel).length === 0 && tmpVarSel.constructor === Object) {
        $("#btn_dlg_ins").addClass('hide');
        $("#tab-msg").removeClass('hide');
    }
    const index = associazioneVarRoleBean.findIndex(x => x.idVar === id);
    if (index !== undefined)
        associazioneVarRoleBean.splice(index, 1);
}

function associaVarToRole() {
    var id_elaborazione = $("#dataProcessingId").val();
    var myUrl = $("meta[name='ctx']").attr("content") + "/ws/associaVariabiliRuolo";
    $.ajax({
        url: myUrl,
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        type: "POST",
        async: false,
        data: JSON.stringify(associazioneVarRoleBean),
        success: function () {
            console.log("success! ");
          window.location.href = $("meta[name='ctx']").attr("content") + "/ws/editworkingset/" + id_elaborazione;
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log('Error!', errorThrown);
        }
    });
}

function replaceAll(str, cerca, sostituisci) {
	  return str.split(cerca).join(sostituisci);
	}

function openDlgModParametriWorkset(identifier) {
    var idParam = $(identifier).data('id-param');
    var idWorkset = $(identifier).data('id-workset');
    var nameParameter = $(identifier).data('name-workset');
    $('#param-text-edit').text(nameParameter);
    var jsontemplateText = _paramTemplateMap[replaceAll(nameParameter," ","_")];
    var jsontemplate = JSON.parse(jsontemplateText);
    var schema = jsontemplate["schema"];
    var options = jsontemplate["options"];
    if (!options)
        options = "";
    var data = $(identifier).data('value-param');
    if (!data)
        data = "";
    var postRender = jsontemplate["postRender"];
    
    if (!postRender) postRender="";// eval(postRender);
    $('#edit-parameters').val(idWorkset);
    var dataContent = "{\"data\":" + JSON.stringify(data) + ",\"schema\":" + JSON.stringify(schema) + ",\"options\":" + JSON.stringify(options) + ",\"postRender\":" + JSON.stringify(postRender) + "}";
    $('#edit-param').empty();
    var jsonObj = JSON.parse(dataContent, function (key, value) {
        if (key === "addRow") {
            return eval('(' + value + ')');
        } else if (key === "removeRow") {
            return eval('(' + value + ')');
        } else if (key === "dataSource") {
            return eval(value);
        } else if (key === "postRender") {
            return eval(value);
        } else {
            return value;
        }
    });
    $('#edit-param').alpaca(jsonObj);
    $("#idStepRunMod").val(idParam);
    paramDialog='mod';
    $("#mod-parametri-workset-modal").modal("show");
}

function mostraDialogEliminaParametro(identifier) {
    var idParam = $(identifier).data('id-param');
    var idelab = $(identifier).data('id-elab');
    var nameParam = $(identifier).data('name-param');

    $("#idparam").val(idParam);
    $("#idelab").val(idelab);
    $("#nomeParametro").text(nameParam);

    $("#modal-cancella-parametro").modal("show");
}


function cambiaPosizione() {
    var ordineIds = "";
    var ids = $("#variablesTable").find(
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
    // controllaCampoParam();
    $(".rolelist").removeClass('active');
    $(".varlist").removeClass('active');
    $("#varSelectedId").val('');
    $("#varSelectedName").val('Nessuna variabile selezionata');
    $("#roleSelectedId").val('');
    $("#roleSelectedName").val('Nessun ruolo selezionato');
    $("#add-parametri-workset-modal").modal('show');
    $("#select-param").change();
}


function controllaCampoModParam() {
    if ($("#value-text-mod") && $("#value-text-mod").val().length > 0) {
        $("#btn_dlg_mod_assoc_param").removeClass('disabled');
        $("#btn_dlg_mod_assoc_param").removeAttr('disabled');
    } else {
        $("#btn_dlg_mod_assoc_param").addClass('disabled');
        $("#btn_dlg_mod_assoc_param").attr("disabled", "disabled");
    }
}

function setSelectedVar(ordine, nome, id, labelFile) {
    $(".varlist").removeClass('active');
    $("#var_" + id).addClass('active');
    $("#varSelectedId").val(id);
    $("#varSelectedName").val(nome);
    $("#varLabelFile").val(labelFile);
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

function setSelectedRole(nomeR, idR,code) {
    $(".rolelist").removeClass('active');
    $("#role_" + idR).addClass('active');
    $("#roleSelectedId").val(idR);
    $("#roleSelectedName").val(nomeR);
    $("#roleSelectedCode").val(code);
    if ($('.ui-selected').length > 0) {
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

function setSelectedRuleset(idR) {
    $(".rulesetlist").removeClass('active');
    $("#ruleset_" + idR).addClass('active');
    $("#id-ruleset-selected").val(idR);
   
}

function inserisciRuoloVar() {
    var var_id = $("#varSelectedId").val();
    var var_nome = $("#varSelectedName").val();
    var role_id = $("#roleSelectedId").val();
    var role_nome = $("#roleSelectedName").val();
    var id_elaborazione = $("#dataProcessingId").val();
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
    var id_elaborazione = $("#dataProcessingId").val();
    var input_content = $("#update_associazione_vars").html();
    input_content += "<input type='hidden' name='dataProcessing' value='" + id_elaborazione
            + "'/></span><input type='hidden' name='status' value='N'/></span>";

    $("#update_associazione_vars").html(input_content);
    eseguiFunzioneUpdate();
}

function eliminaRiga(id) {
    var table = $('#variablesTable').DataTable();
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
    var id_elaborazione = $("#dataProcessingId").val();
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
            
            $(jQuery.parseJSON(JSON.stringify(data))).each(function () {
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

function submitSetRuleSet() {
    $("#formSetRuleset").submit();
}

function inserisciParams() {
    var value = JSON.stringify($('#add-param').alpaca().getValue());

    $("#valoreParam").val(value);
    $("#formAssociaParam").submit();
}

function modificaParam() {
    var value = JSON.stringify($('#edit-param').alpaca().getValue());
    $("#valoreParamMod").val(value);
    $("#formModAssociaParam").submit();
}

function mostraDialogEliminaAssociazione(idelab, idstepVar, nomestepvar) {
    $("#namestepR").text(nomestepvar);
    $("#idelab").val(idelab);
    $("#idstepVar").val(idstepVar);
    $("#modalCancellaAssociazione").modal("show");
}

function controllaCampoParam() {
    if ($("#value-text").val() && $("#value-text").val().length > 0 && $("#value-text").val() != '') {
        $("#btn_dlg_assoc_param").removeClass('disabled');
        $("#btn_dlg_assoc_param").removeAttr('disabled');
    } else {
        $("#btn_dlg_assoc_param").addClass('disabled');
        $("#btn_dlg_assoc_param").attr("disabled", "disabled");
    }
}

function mostraDialogModificaAssociazione(idelab, idstepVar, nomestepvar, idruolo) {

    $("#nome-var").val(nomestepvar);
    $("#idruolomod").val(idruolo).change();
    $("filtro:checked").val(idruolo);
    $("#mod_idvariabile").val(idstepVar);
    $("#mod_valore_old").val(nomestepvar);
    $("#mod_nomevariabile").val(nomestepvar);
    $("#varModSelectedId").val('');
    $("#varModSelectedName").text('Nessuna variabile selezionata');
    $("#roleModSelectedId").val('');
    $("#roleModSelectedName").text('Nessun ruolo selezionato');
    $("#modifica-viarabile-workset-modal").modal('show');
}

function showPanel(idPanel) {
    hidePanels();
    $("#card-" + idPanel).show();
    $("#header-" + idPanel + " span").addClass("header-strong");
}

function hidePanels() {
    $("#card-variabili").hide();
    $("#header-variabili span").removeClass("header-strong");
    $("#card-parametri").hide();
    $("#header-parametri span").removeClass("header-strong");
    $("#card-ruleset").hide();
    $("#header-ruleset span").removeClass("header-strong");
    $("#card-execution").hide();
    $("#header-execution span").removeClass("header-strong");
}

$(function () {
    $(".ui-widget-content").click(function () {
        $(this).toggleClass("ui-selected");
    });

    $("#selectable").bind("mousedown", function (e) {
        e.metaKey = true;
    }).selectable({
        stop: function () {
            var result = $("#select-result").empty();
            variablesArr = new Array();
            $("li.ui-selected", this).each(function () {
                var currSel = $(this).attr("value");
                tmpArr = currSel.split('~');
                variablesArr.push({'idVar': tmpArr[0], 'name': tmpArr[1], 'labelTab': tmpArr[2], 'prefixTab': tmpArr[3]});
            });
            if ($("#roleSelectedId").val() != null && $("#roleSelectedId").val() !== '') {
                $("#btn_dlg_assoc").removeClass('disabled');
                $("#btn_dlg_assoc").attr("disabled", false);
            }
        }
    });
       
   
    $('#check-vars-select-all').click(function() {
        var checked = $(this).prop('checked');
        
        selectSelectableElement($("#selectable"), $("#selectable li"),checked);
      });
    
    $('#check-prefix-dataset').click(function() {
        checkedPrefix = $(this).prop('checked');
        $(".prefix").toggle(checkedPrefix);  
      });
});

function selectSelectableElement (selectableContainer, elementsToSelect,checked)
{
   if(checked){
    // add ui-selecting class to the elements to select
     $(elementsToSelect).removeClass("ui-unselecting").addClass("ui-selecting").addClass("ui-selected");
  }
   else{
      $(elementsToSelect).removeClass("ui-selected").removeClass("ui-selecting").addClass("ui-unselecting");
  }
   // trigger the mouse stop event (this will select all .ui-selecting elements, and deselect all .ui-unselecting elements)
   selectableContainer.data("ui-selectable")._mouseStop(null);
}


