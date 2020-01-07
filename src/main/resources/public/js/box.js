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
var smallWindow = 560;
var load = true;

/* Toastr options */
toastr.options = {
  "closeButton": false,
  "debug": false,
  "newestOnTop": false,
  "progressBar": false,
  "positionClass": "toast-top-center",
  "preventDuplicates": false,
  "onclick": null,
  "showDuration": "200",
  "hideDuration": "1000",
  "timeOut": "2000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
};

/* Toastr usage
 * 
 * toastr["info"]("Session saved!", "Success")
 * 
 * */
function displayMessages(){
    $("#messages li").each(function(index, element) {
        var msg_type = $(element).find("span:first").text().toLowerCase();
        var msg_text = $(element).find("span:last").text();
        
        toastr[msg_type](msg_text);
    });
}

$(document).ajaxError(function (e, request, errorThrown, exception) {
    if (request.status === "302") {
        window.location = request.getResponseHeader('location');
    }
});

$(function () {
    $('.towait').click(function () {
        $('#loading').modal('show');
    });

    setTimeout(function () {
        $("#messages-container").fadeOut();
    }, 4000);

    $('.modal').modal({show: false, backdrop: 'static', keyboard: false});
    
    displayMessages();
    
});

//Set menu active
function setMenuActive(id, target) {
    if (id !== 0) { //home
        $("#" + target + id).addClass("c-active");
        $("#bf" + id).addClass("c-show");
    }     
}

function format(n) {
    return ("" + n).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function formatPercentage(a, b) {
    return Math.round(1000. * a / b) / 10 + "%";
}

//write REST response user
function writeMsgs(data, iddiv_msgs) {
    $.each(data, function (index, msg) {
        var classs = 'alert alert-info';
        if (msg.type == 'INFO')
            classs = 'alert alert-success';
        else if (msg.type == 'ERROR')
            classs = 'alert alert-danger';
        var div = $('<div class="' + classs + '"><strong>' + msg.type
                + '</strong>: ' + msg.text + ' </div>"');
        $("#" + iddiv_msgs).append(div);

    });
}

//write REST response user
function writeMsgsError(msg, iddiv_msgs) {
    var classs = 'alert alert-danger';
    var div = $('<div class="' + classs + '">' + msg + ' </div>"');
    $("#" + iddiv_msgs).append(div);

}

//function to render table
function renderTable(id, defBtns, defCols, arrLabelData) {
    $("#" + id).DataTable({
        bDestroy: true,
        dom: "<'row'<'col-sm-6'B><'col-sm-6'f>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        autoWidth: false,
        responsive: true,
        ordering: false,
        pageLength: 20,
        bPaginate: false,
        buttons: defBtns,
        columns: defCols,
        data: arrLabelData
    });
//table.buttons().container().appendTo('#religionlist_wrapper .col-sm-6:eq(0)');
}

function callBackHide() {
    setTimeout(function () {
        $("#center").fadeOut();
    }, 1000);
}

function callBackShow() {
    setTimeout(function () {
        $("#center").fadeIn();
    }, 1000);
}

function showLog(){
    $("#modalRLog").modal("show");
}

function clearLog(idSessione) {
    $.ajax({
        url: _ctx + "/logs/" + idSessione,
        type: "DELETE",
        dataType: "JSON",
        success: function () {
            $(".logbox").text("No message available");
        },
        error: function (jqXHR, textStatus, errorThrown) {
            writeMsgsError('Error deleting data', 'msgs');
        }
    });
}

function clearRLog(idSessione) {
    $.ajax({
        url: _ctx + "/rlogs/" + idSessione,
        type: "DELETE",
        dataType: "JSON",
        success: function () {
            $("#rbox").text("No message available");
        },
        error: function (jqXHR, textStatus, errorThrown) {
            writeMsgsError('Error deleting data', 'msgs');
        }
    });
}
