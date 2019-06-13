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

    $(".sortable").sortable({
        items: 'tbody > tr',
        connectWith: ".sortable",
        receive: function (event, ui) {
            $(this).find("tbody").append(ui.item);
            hideOrShowDropRow();
        }
    });

    hideOrShowDropRow();
});


function hideOrShowDropRow() {
    $(".sortable").each(function () {
        var dropRow = $(this).find(".drop-row"),
                hasRows = $(this).find("tbody tr").length;

        hasRows ? dropRow.hide() : dropRow.show();
    });
}

function getChartData() {

    $.ajax({
        url: _ctx + "/rest/graph/getColumns/" + getColumnIds(),
        type: "GET",
        success: function (data) {
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

function getColumnIds() {

    var ids = "";
    isfirst = true;

    $("#targetTable tr").each(function (rowIndex, r) {

        id = $(this).find("td").last().text();

        if (id > 0 && isfirst) {
            ids = id;
            isfirst = false;
        } else if (id > 0 && !isfirst) {
            ids = ids + "," + id;
        }
    });

    console.log(ids);

    return ids;
}