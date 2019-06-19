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


function getDensityPlot() {

}

function getBoxPlot() {
    $.ajax({
        url: _ctx + "/rest/graph/getColumns/" + getColumnIds(),
        type: "GET",
        success: function (data) {
            boxPlot(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });
}
function getScatterPlot() {

    $.ajax({
        url: _ctx + "/rest/graph/getPoints/" + getColumnIds(),
        type: "GET",
        success: function (data) {
            scatterPlot(data);
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
function boxPlot(data) {
    // set the dimensions and margins of the graph
    var margin = {top: 10, right: 30, bottom: 30, left: 40},
    width = 400 - margin.left - margin.right,
            height = 400 - margin.top - margin.bottom;

// append the svg object to the body of the page
    var svg = d3.select("#datagraph")
            .append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

// create dummy data
//var data = [12, 19, 11, 13, 12, 22, 13, 4, 15, 16, 18, 19, 20, 12, 11, 9]

// Compute summary statistics used for the box:
    var data_sorted = data[0].datiColonna.sort(d3.ascending);
    var q1 = d3.quantile(data_sorted, .25);
    var median = d3.quantile(data_sorted, .5);
    var q3 = d3.quantile(data_sorted, .75);
    var interQuantileRange = q3 - q1;
    var min = q1 - 1.5 * interQuantileRange;
    var max = q1 + 1.5 * interQuantileRange;

// Show the Y scale
    var y = d3.scaleLinear()
            .domain([0, 24])
            .range([height, 0]);

    svg.call(d3.axisLeft(y));

// a few features for the box
    var center = 200;
    var width = 100;

// Show the main vertical line
    svg
            .append("line")
            .attr("x1", center)
            .attr("x2", center)
            .attr("y1", y(min))
            .attr("y2", y(max))
            .attr("stroke", "black");

// Show the box
    svg
            .append("rect")
            .attr("x", center - width / 2)
            .attr("y", y(q3))
            .attr("height", (y(q1) - y(q3)))
            .attr("width", width)
            .attr("stroke", "black")
            .style("fill", "#69b3a2");

// show median, min and max horizontal lines
    svg
            .selectAll("toto")
            .data([min, median, max])
            .enter()
            .append("line")
            .attr("x1", center - width / 2)
            .attr("x2", center + width / 2)
            .attr("y1", function (d) {
                return(y(d))
            })
            .attr("y2", function (d) {
                return(y(d))
            })
            .attr("stroke", "black")
}

function scatterPlot(data) {
// set the dimensions and margins of the graph
    var margin = {top: 10, right: 40, bottom: 30, left: 30},
    width = 450 - margin.left - margin.right,
            height = 400 - margin.top - margin.bottom;

// append the svg object to the body of the page
    var svg = d3.select("#datagraph")
            .append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

// Create data
//var data = [ {x:10, y:20}, {x:40, y:90}, {x:80, y:50} ]

// X scale and Axis
    var x = d3.scaleLinear()
            .domain([0, 10])         // This is the min and the max of the data: 0 to 100 if percentages
            .range([0, width]);       // This is the corresponding value I want in Pixel
    svg
            .append('g')
            .attr("transform", "translate(0," + height + ")")
            .call(d3.axisBottom(x));

// X scale and Axis
    var y = d3.scaleLinear()
            .domain([0, 10])         // This is the min and the max of the data: 0 to 100 if percentages
            .range([height, 0]);       // This is the corresponding value I want in Pixel
    svg
            .append('g')
            .call(d3.axisLeft(y));

// Add 3 dots for 0, 50 and 100%
    svg
            .selectAll("whatever")
            .data(data)
            .enter()
            .append("circle")
            .attr("cx", function (d) {
                return x(d.x);
            })
            .attr("cy", function (d) {
                return y(d.y);
            })
            .attr("r", 7)
            .style("fill", "#69b3a2");


}

