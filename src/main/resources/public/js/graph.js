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
var filterChecked;
var entryPoint = [];
var passData;

$(document).ready(function () {

    $('#checkbox-filter').change(function () {
        filterChecked = $(this).is(':checked');
        $('#filter').toggleClass("invisible");
    });
    $('#select-data-filter').change(function () {
        /*
        alert($("#select-data-filter option:selected").val());
        alert($("#select-data-filter option:selected").index());
        */
        drawGraphByFilter($("#select-data-filter option:selected").val(),$("#select-data-filter option:selected").index());
    });
    $(".sortable").sortable({
        items: 'tbody > tr',
        connectWith: ".sortable",
        //revert:true,
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
    var loadingdata = false;
    
    xAxis = [];
    yAxis = [];
    /*
    alert(data);
    alert("pass" + passData);
    */
    
    $('#select-filter').removeClass('invisible');
    $('#select-data-filter').children('option:not(:first)').remove();
    
    var ctr=-1;
    entryPoint=[];
    
    $.each(data.filter, function (keys, values) {
        ctr=-1;        
        $.each(values, function (key, value) {
            ctr++;
            if ($('#select-data-filter').find("option[value='" + value + "']").length) {
            } else {
                //alert(ctr);
                entryPoint.push(ctr);                
                $('#select-data-filter')
                        .append($("<option></option>")
                                .attr("value", value)
                                .text(value));
            }
        });
        entryPoint.push(ctr+1);            
        //alert(entryPoint);
    });
    
    
    
    
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
                loadingdata = true;
            });
            var layout = {
                //title: graphType.toUpperCase(),
                showlegend: true
            };
            break;
        case 'scatter':
            var x = [];
            var y = [];
            $.each(data.xaxis, function (key, value) {
                x.push(value);
                xAxis.push(key);
            });            
            $.each(data.yaxis, function (key, value) {
                y.push(value);
                yAxis.push(key);
            });
            for (var i = 0; i < x.length; i++) {
                var groupBox = {
                    x: x[i],
                    y: y[i],
                    
                    //name: keys[i],
                    
                    mode: 'markers',
                    type: graphType,
                    hoverinfo: 'skip'
                    /*
                     ,
                     transforms: [{
                     type: 'filter',
                     target: 'y',
                     operation: '>',
                     value: 25
                     }]
                     */
                };
                globalBox.push(groupBox);
                loadingdata = true;
            };
            var layout = {
                //title: graphType.toUpperCase(),
                showlegend: true,
                
                xaxis: {
                        title: {
                          text: xAxis[0],
                          font: {
                            family: 'Courier New, monospace',
                            size: 18,
                            color: '#7f7f7f'
                          }
                        }
                      },
                      yaxis: {
                        title: {
                          text: yAxis[0],
                          font: {
                            family: 'Courier New, monospace',
                            size: 18,
                            color: '#7f7f7f'
                          }
                        }
                      }
                
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
                loadingdata = true;
            });
            var layout = {
                //title: graphType.toUpperCase(),
                showlegend: true
            };
            break;
    }


    if (loadingdata === true) {
        Plotly.newPlot('datagraph');
        Plotly.newPlot('datagraph', globalBox, layout, {scrollZoom: true});
        passData = data;
    } else {
        alert("selezionare i dati");
    }

}




function drawGraphByFilter(passValue,index) {
    
    
    //alert(entryPoint);  
    
    var fromItem = entryPoint[index-1];
    var toItem =  entryPoint[index]-1;
    var globalBox = [];
    
    xAxis = [];
    yAxis = [];
    
    
    var loadingdata = false;
    switch (passGraphType) {
        case 'box': 
            $.each(passData.yaxis, function (key, value) {        
                var groupBox = {
                    y: value.slice(fromItem, toItem),
                    name: key,
                    type: passGraphType,
                    hoverinfo: 'skip'
                };
                globalBox.push(groupBox);
                loadingdata = true;
            });
            var layout = {
                //title: graphType.toUpperCase(),
                showlegend: true
            };
            break;
        case 'scatter':
            var x = [];
            var y = [];                      
            $.each(passData.xaxis, function (key, value) {   
                x.push(value.slice(fromItem, toItem));
                xAxis.push(key);
            });
            $.each(passData.yaxis, function (key, value) {
                y.push(value.slice(fromItem, toItem));
                yAxis.push(key);
            });
            for (var i = 0; i < x.length; i++) {
                var groupBox = {
                    x: x[i],
                    y: y[i],
                    name: passValue,
                    mode: 'markers',
                    type: passGraphType,
                    hoverinfo: 'skip'
                
                };
                globalBox.push(groupBox);
                loadingdata = true;
            };
            var layout = scatterLayout();
            break;
        case 'bar':
            var x;
            $.each(passData.xaxis, function (key, value) {
                x = value.slice(fromItem, toItem);
            });
            $.each(data.yaxis, function (key, value) {
                var groupBox = {
                    x: x,
                    y: value.slice(fromItem, toItem),
                    name: key,
                    type: passGraphType,
                    hoverinfo: 'skip' 
                };
                globalBox.push(groupBox);
                loadingdata = true;
            });
            var layout = {
                //title: graphType.toUpperCase(),
                showlegend: true
            };
            break;
    }
    if (loadingdata === true) {
        Plotly.newPlot('datagraph');
        Plotly.newPlot('datagraph', globalBox, layout, {scrollZoom: true});
    } else {
        alert("selezionare i dati");
    }

}


function showGraph(graphType) {


    $('#checkbox-filter').prop("checked", false);
    $('#select-filter').addClass('invisible');
    $("#targetX tbody tr").each(function () {
        $('#sourceTable tr:last').after($(this));
    });
    $("#targetY tbody tr").each(function () {
        $('#sourceTable tr:last').after($(this));
    });
    $("#filter tbody tr").each(function () {
        $('#sourceTable tr:last').after($(this));
    });
    $('#targetX').addClass("invisible");
    $('#targety').addClass("invisible");
    $('#filter').addClass("invisible");
    $(".graph-title").text("Chart");
    $(".graph-action").removeClass("menu-selected");
    Plotly.purge("datagraph");
    switch (graphType) {
        case 'box':
            $('.yaxis').removeClass("invisible");
            $(".graph-title").text("Box Plot Chart");
            break;
        case 'scatter':
            $('.xaxis').removeClass("invisible");
            $('.yaxis').removeClass("invisible");
            $(".graph-title").text("Scatter Chart");
            break;
        case 'bar':
            $('.xaxis').removeClass("invisible");
            $('.yaxis').removeClass("invisible");
            $(".graph-title").text("Bar Chart");
            break;
    }
    $("#" + graphType).addClass("menu-selected");
}


function scatterLayout(){
        var layout = {
        //title: graphType.toUpperCase(),
        showlegend: true,

        xaxis: {
                title: {
                  text: xAxis[0],
                  font: {
                    family: 'Courier New, monospace',
                    size: 18,
                    color: '#7f7f7f'
                  }
                }
              },
              yaxis: {
                title: {
                  text: yAxis[0],
                  font: {
                    family: 'Courier New, monospace',
                    size: 18,
                    color: '#7f7f7f'
                  }
                }
              }

    };
    
    return layout;
}