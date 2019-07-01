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
var passGraphType;

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
            boxplotP(data);
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

    barP(getData());

}

function getData(graphType, action) {

    if (action === 1) {

        var graphmeta = getMetaData();
        $.ajax({
            url: _ctx + "/rest/graph/getData/" + graphmeta.filters + "/" + graphmeta.xAxis + "/" + graphmeta.yAxis,
            type: "GET",
            success: function (data) {
                drawGraph(graphType, data);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert('Error loading data');
            }
        });

    }

    if (action === 0) {
        
        showGraph(graphType);
        passGraphType = graphType;

    }

}

function getMetaData() {

    var meta = {
        filters: "",
        xAxis: "",
        yAxis: ""
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


function drawGraph(graphType, data) {

    var globalBox = [];

    if (Object.keys(data.filter).length)
        console.log(data.yaxis);
    if (Object.keys(data.xaxis).length)
        console.log(data.yaxis);
    if (Object.keys(data.yaxis).length)
        console.log(data.yaxis);

    switch (graphType) {
        case 'box':
            $.each(data.yaxis, function (key, value) {
                var groupBox = {
                    y: value,
                    name: key,
                    type: graphType,
                    hoverinfo: 'skip'
                };
                globalBox.push(groupBox);
            });
            var layout = {
                title: graphType.toUpperCase(),
                showlegend: true
            };
            break;
        case 'scatter':
            var x = [];
            var keys = [];
            $.each(data.xaxis, function (key, value) {
                x.push(value);
                keys.push(key);
            });
            var y = [];
            $.each(data.yaxis, function (key, value) {
                y.push(value);
            });
            for (var i = 0; i < x.length; i++) {
                var groupBox = {
                    x: x[i],
                    y: y[i],
                    name: keys[i],
                    mode: 'markers',
                    type: graphType,
                    hoverinfo: 'skip'
                };
                globalBox.push(groupBox);
            }
            ;
            var layout = {
                title: graphType.toUpperCase(),
                showlegend: true
            };
            break;
        case 'bar':
            var x;
            $.each(data.xaxis, function (key, value) {
                x = value;
            });
            $.each(data.yaxis, function (key, value) {
                var groupBox = {
                    x: x,
                    y: value,
                    name: key,
                    type: graphType,
                    hoverinfo: 'skip'
                };
                globalBox.push(groupBox);
            });
            var layout = {
                title: graphType.toUpperCase(),
                showlegend: true
            };

            break;
    }
    Plotly.newPlot('datagraph', globalBox, layout, {scrollZoom: true});
}
function showGraph(graphType) {

    $('.card-container').addClass("invisible");
    $('#targetX').addClass("invisible");
    $('#targety').addClass("invisible");
    $('#filter').addClass("invisible");    
    $('.graph-button').addClass("invisible");     
    
    
    

    switch (graphType) {
        case 'box':
            $('.card-container').removeClass("invisible");
            $('.yaxis').removeClass("invisible");
            $('.graph-button').removeClass("invisible");
            break;
        case 'scatter':
            $('.card-container').removeClass("invisible");
            $('.xaxis').removeClass("invisible");
            $('.yaxis').removeClass("invisible");
            $('.graph-button').removeClass("invisible");
            break;
        case 'bar':
            $('.card-container').removeClass("invisible");
            $('.xaxis').removeClass("invisible");
            $('.yaxis').removeClass("invisible");
            $('.graph-button').removeClass("invisible");
            break;
    }

}