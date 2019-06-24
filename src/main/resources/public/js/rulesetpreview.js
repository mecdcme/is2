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

    $("#dataview").DataTable({

        drawCallback: function () {
            $(".loading").hide();
        },
        dom: "<'row'<'col-sm-5'B><'col-sm-7'<'pull-right'f>>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        autoWidth: false,
        responsive: true,
        ordering: false,
        searching: true,
        lengthChange: true,
        pageLength: 20,
        buttons: [{
                extend: 'csvHtml5',
                filename: 'download',
                title: 'download',
                className: 'btn-light',
                action: function (e, dt, node, config) {
                    scaricaDataset(e, 'csv', ID);
                }
            }],
        language: {
            paginate: {
                "previous": "Prev"
            }
        }
    });


    $('#btnDelete').click(function () {
        var ruleId = $('#ruleId').val();
        $.ajax({
            url: _ctx + "/rules/" + ruleId,
            type: "DELETE",
            success: function (data) {
                location.reload();
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert('Error loading data');
            }
        });
    });


    $('#btnEdit').click(function () {
        
        $.ajax({
            url: _ctx + "/rules/",
            type: "PUT",
            data: $('#editForm').serialize(),
            dataType: "JSON",
            success: function (data) {
                location.reload();
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert('Error loading data');
            }
        });
    });

});

function scaricaDataset(e, param, idDFile) {
    e.preventDefault();
    window.location = _ctx + '/rest/download/dataset/' + param + '/' + idDFile;
}

function newRule() {
    alert("Add a new rule");
}

function editRule(id, rule) {
    $('#editRuleId').val(id);
    $('#editRuleText').val(rule);
    $('#modalEditRule').modal('show');
}

function deleteRule(id, rule) {
    $('#ruleId').val(id);
    $('#modalDeleteRule .modal-body span').text(rule);
    $('#modalDeleteRule').modal('show');

}

function runValidate(idRuleset) {
    $('#loading').modal('show');
    $.ajax({
        url: _ctx + "/rules/runvalidate/" + idRuleset,
        type: "GET",
        success: function (data) {
            $('#loading').modal('hide');
            location.reload();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });

}