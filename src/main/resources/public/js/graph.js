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
        var dropRow = $(this).find(".drop-row");
        var hasRows = $(this).find("tbody tr").length;
        hasRows ? dropRow.hide() : dropRow.show();
    });
}

function getDensityPlot() {

}

function getBoxPlot() {
    $.ajax({
        url: _ctx + "/rest/graph/getColumns/" + getColumnIds(),
        type: "POST",
        success: function (data) {
            boxplotP(data)
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });
}
function getScatter() {

    $.ajax({
        url: _ctx + "/rest/graph/getCoordinates/" + getColumnIds(),
        type: "POST",
        success: function (data) {
            scatterP(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });
}

function getBar() {
    $.ajax({
        url: _ctx + "/rest/graph/getCoordinates/" + getColumnIds(),
        type: "POST",
        success: function (data) {
            barP(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });
}

function getData() {

    var graphmeta = getMetaData()

    $.ajax({
        url: _ctx + "/rest/graph/getData/" + graphmeta.filters + "/" + graphmeta.xAxis + "/" + graphmeta.yAxis,
        type: "GET",
        success: function (data) {
            if (Object.keys(data.filter).length) //check if object is empty
                console.log(data.filter);
            if (Object.keys(data.xaxis).length) //check if object is empty
                console.log(data.xaxis);
            if (Object.keys(data.yaxis).length) //check if object is empty
                console.log(data.yaxis);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });
}

function getMetaData() {

    var meta = {
        filters: "",
        xAxis: "",
        yAxis: "",
    };

    meta.filters = getFields("filter");
    meta.xAxis = getFields("targetX");
    meta.yAxis = getFields("targetY");

    return meta;
}

function getFields(idDiv) {
    var ids = "";
    $("#" + idDiv + " tr").each(function (rowIndex, r) {
        if ($(this).find("span").attr("value") > 0)
            ids = $(this).find("span").attr("value") + "," + ids;
    });

    if (ids !== "") {
        ids = ids.substring(0, ids.length - 1);
    } else {
        ids = "0";
    }

    console.log(ids);
    return ids;
}

function boxplotP(data) {

    var length = data.length;
    var globalBox = [];
    var layout = {
        title: 'BOX PLOT',
        showlegend: true
    };
    for (var i = 0; i < length; i++) {
        var groupBox = {
            y: data[i].datiColonna,
            name: data[i].nome,
            type: 'box',
            hoverinfo: 'skip'
        };
        globalBox.push(groupBox);
    }
    Plotly.newPlot('datagraph', globalBox, layout, {scrollZoom: true});
}

function scatterP(data) {

    var globalBox = [];
    var layout = {
        title: 'SCATTER',
        showlegend: false
    };
    var groupBox = {
        x: data.x,
        y: data.y,
        mode: 'markers',
        type: 'scatter',
    };
    globalBox.push(groupBox);
    Plotly.newPlot('datagraph', globalBox, layout, {scrollZoom: true});

}

function barP(data) {

    var globalBox = [];
    var layout = {
        title: 'BAR',
        showlegend: true
    };
    var groupBox = {
        x: data.x,
        y: data.y,
        type: 'bar',
        hoverinfo: 'skip'
    };
    globalBox.push(groupBox);
    Plotly.newPlot('datagraph', globalBox, layout, {scrollZoom: true});
}