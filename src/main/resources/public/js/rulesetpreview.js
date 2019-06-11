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
var ID = _idfile;
var table;

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
        pageLength: 15,
        processing: true,
        serverSide: true,
        ajax: {url: _ctx + "/rest/datasetvalori/" + ID + "/" + getParams(),
            type: "POST"
        },
        columns: [
            {data: 'EDIT'},
            {
                render: function (data, type, row) {
                    var txt = '<a href="javascript:void(0)" title="Edit" onclick="javascript:editRule(\''
                            + row.EDIT
                            + '\');"><i class="fa fa-pencil"></i></a>'
                            + '&nbsp;&nbsp; <a   href="javascript:void(0)" title="Delete" onclick="javascript:deleteRule(\''
                            + row.EDIT
                            + '\');"><i class="fa fa-trash-o"></i></a>';

                    return txt;
                },
                orderable: false
            }
        ],
        buttons: [{
            extend: 'csvHtml5',
            filename: 'download',
            title: 'download',
            className: 'btn-light',
            action: function (e, dt, node, config) {
                scaricaDataset(e, 'csv', ID);
            }
        }],
        language:{
            paginate:{
                "previous": "Prev"
            }
        }
    });
});

function getParams() {
    var params = "";
    var inputs = $(".input-sm");
    var y = 0;
    var z = 0;
    for (var i = 0; i < inputs.length; i++) {
        var valore = inputs[i].value;
        if (valore != "") {
            // Controlla e non aggiunge l'& dopo l'ultimo elemento
            if (y > z) {
                z++;
                params += "&";

            }
            params += inputs[i].id + "=" + inputs[i].value;//this is not working
            y++;
        }
    }

    if (params == "") {
        params = "noparams";
    }

    return params;
}

function scaricaDataset(e, param, idDFile) {
    e.preventDefault();
    window.location = _ctx + '/rest/download/dataset/' + param + '/' + idDFile;
}

function newRule(){
    alert("Add a new rule");
}

function editRule(idRule){
    alert("Edit rule \'" + idRule + "\'");
}

function deleteRule(idRule){
    alert("Delete rule \'" + idRule + "\'");
}