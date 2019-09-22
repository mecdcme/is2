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

$(document).ready(function () {

	var table = $("#metadataTab").DataTable({
        dom: "<'row'<'col-sm-12'<'pull-left'f>>>"
                + "<'row'<'col-sm-12'tr>>"
                + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        autoWidth: false,
        responsive: true,
        paging: false,
        rowReorder:  {
        	selector: 'td:nth-child(2)'        	   
        },
        columnDefs: [{
            orderable: false,
            className: 'reorder', 
            targets: [1]
        }],
        'createdRow': function (row, data, dataIndex) {
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

    $("#sumSelection").on("change", function () {
        $("#sumSelectedId").val($('#sumSelection').val());
        $("#sumSelectedName").text($('#sumSelection').text());
        $("#btn_dlg_assoc").removeClass('disabled');
        $("#btn_dlg_assoc").addClass('active');
    });

    $('#filtro1').change(function () {
        if ($('#sumSelection').val() != null) {
            $("#btn_dlg_assoc").removeClass('disabled');
            $("#btn_dlg_assoc").addClass('active');
        }
        if ($("input[name='flagRicerca']:checked").val()) {
            $("#sumFiltro").val("1");
        }

    });

    $('#filtro0').change(function () {
        if ($('#sumSelection').val() != null) {
            $("#btn_dlg_assoc").removeClass('disabled');
            $("#btn_dlg_assoc").addClass('active');
        }
        if ($("input[name='flagRicerca']:checked").val()) {
            $("#sumFiltro").val("0");
        }
    });

});

function cambiaPosizione() {
    var ordineIds = "";
    var ids = $("#metadataTab").find(
            "input[name='colsid']");
    for (var i = 0; i < ids.length; i++) {
        ordineIds += i + "=" + ids[i].value + "|";
    }
    ordineIds = ordineIds.slice(0, -1);
    updateOrdineRighe(ordineIds);
}
function updateOrdineRighe(ordineIds) {
    $.ajax({
        url: _ctx + "/rest/dataset/updaterowlist",
        type: "POST",
        data: "ordineIds=" + ordineIds,
        success: function (data) {
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });
}

function attivaBottone() {
    var contenuto = $("#vars_content").text();
    $("#btn_rimuovi_ass").show();
    if (contenuto == "") {
        $("#btn_rimuovi_ass").hide();
    }
}

function associaVarSum(idVar, idSum, nome, filtro) {
    $(".rolelist").removeClass('active');
    $(".varlist").removeClass('active');
    $("#varSelectedId").val(idVar);
    $("#varSelected").val(nome);
    $("#sumSelectedId").val(idSum);
    $("#sumSelection").val(idSum);
    $("#sumSelectedName").text('Nessun ruolo selezionato');
    $("#btn_dlg_assoc").addClass('disabled');
    $("#sum_" + idSum).addClass('active');

    if (filtro == "1") {
        $("#filtro1").prop("checked", true);
    }
    if (filtro == "0") {
        $("#filtro0").prop("checked", true);
    }
    if (filtro == "null") {
        $("#filtro1").prop("checked", false);
        $("#filtro0").prop("checked", false);
    }

    $("#add-viarabile-sum-modal").modal('show');
}

function openDlgAddVariabileSum() {
    $(".rolelist").removeClass('active');
    $(".varlist").removeClass('active');
    $("#varSelectedId").val('');
    $("#varSelectedName").text('Nessuna variabile selezionata');
    $("#roleSelectedId").val('');
    $("#roleSelectedName").text('Nessun ruolo selezionato');
    $("#btn_dlg_assoc").addClass('disabled');
    $("#add-viarabile-sum-modal").modal('show');
}

function setSelectedSum(nomeS, idS) {
    $(".rolelist").removeClass('active');
    $("#sum_" + idS).addClass('active');
    $("#sumSelectedId").val(idS);
    $("#sumSelectedName").text(nomeS);
    if ($("#varSelectedId").val().length > 0 && $("#sumSelectedId").val().length > 0)
        $("#btn_dlg_assoc").removeClass('disabled');
}

function inserisciVarSum() {
    if ($("#sumSelectedId").val() == "null") {
        $("#sumSelectedId").val("0");
    }
    if ($("#filtro1:checked").val()) {
        $("#sumFiltro").val("1");
    }
    if ($("#filtro0:checked").val()) {
        $("#sumFiltro").val("0");
    }
    var content = $("#vars_content").html();

    $("#vars_content").html(content);
    $("#formAssociaVarSum").submit();
}
