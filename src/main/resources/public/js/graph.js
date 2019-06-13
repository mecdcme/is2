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

    var table = $("#variableTable").DataTable({
        dom: "<'row'<'col-sm-12'tr>>"
                + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        autoWidth: false,
        responsive: true,
        paging: false,
        ordering: false,
        rowReorder: {
            selector: 'td:nth-child(2)'
        },
        columnDefs: [{
                orderable: false,
                className: 'reorder',
                targets: [1]
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


});

function cambiaPosizione() {
    var ordineIds = "";
    var ids = $("#variableTable").find(
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

function getChartData() {
    
    $.ajax({
        url: _ctx + "/rest/graph/getColumns/57,56",
        type: "GET",
        success: function (data) {
            alert("Working");
            $.each(data, function (i, column) {
                console.log("Column name: " + column.nome);
                console.log("Column data: " + column.datiColonna);
            });
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });
}

function getColumnIds(){
    
    var ids = "";
    isfirst = true;

    $("#variableTable tr").each(function (rowIndex, r){
        
        id = $(this).find("td").last().text();

        if(id > 0 && isfirst){
            ids = id;
            isfirst = false;
        } else if (id > 0 && !isfirst){
            ids = ids + "," + id;
        }
    });
    
    console.log(ids);
    
    return ids;
}