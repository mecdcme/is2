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
var filename;
var previewdata;
var previewString;
var delimiterValue;
var dialog;

$(document).ready(function () {
    delimiterValue = $("#delimiter").find('option:selected').text();
    $("#errorUplodFile").hide();
    $("#mostraDati").hide();
    $("#scegliHeader").hide();
    $("#lnk_opzioni_avanzate").hide();
    $("#upload_file").hide();

    $("#delimiter_sel").change(function () {
        $("#delimiter").val($("#delimiter_sel").val());
    });

    $("#file").fileinput({showCaption: false, dropZoneEnabled: false});

    $("#file").change(function () { // bCheck is a input type button
        filename = $("input.file-caption-name").attr("title");
        $("#delimiter").val($("#delimiter_sel").val());
        preview();
        if (filename) { // returns true if the string is not empty
            $("#desc").val(filename);
            $("#previewModal").modal('show');
            return true;
        } else { // no file was selected        	
            alert("Nessun file caricato!");
            return false;
        }
        ;
    });
    controllaInputText();
    $('#label_file').on("keyup", function (e) {
        controllaInputText();
    });
    $('#btn_delete_dataset').click(function () {
        var datasetid = $('#idDataset').val();
        window.location = _ctx + '/deleteDataset/' + datasetid;
    });


    $("#sel-tables").on('change', function () {
        var datasetid = $('#sel-db').val();
        var table = $('#sel-tables').val();
        $('#check-list-fields').html('');
        commonAjaxCall("GET", _ctx + "/rest/dataset/fields/" + datasetid + '/' + table, '', loadFieldsList);
    });

});

function controllaInputText() {
    if ($("#label_file").val().length > 0 && $("#label_file").val() != '') {
        $("#btn-invia-file").removeClass('disabled');
        $("#btn-invia-file").removeAttr('disabled');
    } else {
        $("#btn-invia-file").addClass('disabled');
        $("#btn-invia-file").attr("disabled", "disabled");
    }
}
function browseFiles() {
    $("#file").click();
}

function eliminaDataset(idDataset, nomeFile) {
    $("#idDataset").val(idDataset);
    $('#msg_elim_dataset').text("Eliminare il dataset " + nomeFile + "?");
    $('#modalCancellaDataset').modal('show');
}
function eliminaElaborazione(ide, ids) {
    $('#id_elaborazione_del').val(ide);
    $('#id_sessione_del').val(ids);
    $('#msg_elaboraz').text("Eliminare l'elaborazione con id " + ide + "?");
    $('#modalCancellaElaborazione').modal('show');
}

function creaContenuto(data, delimiter) {
    // La lista dei tipi dovrà essere dinamica
    var list = [
        {"value": 0, "text": 'Skip'},
        {"value": 1, "text": 'Identificativo'},
        {"value": 2, "text": 'Correlata'},
        {"value": 3, "text": 'Covariata'},
        {"value": 4, "text": 'Pred'}
    ];
    var content = "<b>(Seleziona i campi da inviare a SeleMix)</b>&nbsp;<br><br/>";
    content += '<div style="overflow: auto; padding: 5px;"><table>';
    content += '<tr>';
    for (var i = 0; i < data.length; i++) {
        content += '<td class="text-center">';
        content += '<label class="form-group">' + data[i] + "</label><br>";
        content += '<select  name="sel_' + i + '" >';
        for (var j = 0; j < list.length; j++) {
            content += '<option class="form-control" value="' + j + '">' + list[j].text + '</option>';
        }
        content += '</select></td><td class="text-center">&nbsp;&nbsp;&nbsp;</td>';
    }
    content += '</tr></table></div>';
    $("#intestazioneFile").html(content);
    $("#intestazioneFile").show();
    $("#upload").hide();
    $("#tastoUpload").hide();
    $("#tastiForm").show();
    $("#numeroCampi").val(data.length);
    $("#separator").val(delimiter);
    $("#titolo").html("Intestazione file:");
}

function parsingStep(results, parser) {
    console.log("Row data:", results.data);
    previewString += results.data.toString() + "\n";
    $("#PreviewTextarea").val(previewString);
}

function preview() {
    var file = document.getElementById('file').files[0];
    var lineno = 1;
    previewString = "";
    readSomeLines(file, 15, function (line) {
        if (lineno == 1) {
            if (line.split(",").length > 1) {
                $("#delimiter_sel").val(',');
                $("#delimiter").val(',');
            }
            if (line.split(";").length > 1) {
                $("#delimiter_sel").val(';');
                $("#delimiter").val(';');
            }
            if (line.split("\t").length > 1) {
                $("#delimiter_sel").val('0');
                $("#delimiter").val('0');
            }
        }
        previewString += line;
        console.log("Line: " + (lineno++) + line);

    }, function onComplete() {
        console.log('Read all lines');
        $("#PreviewTextarea").val(previewString);
    });
}

function inviaFormFile() {
    var fileName = document.getElementById('file').files[0];
    if (fileName) { // returns true if the string is not empty
        var a = $("#label_f").val($("#label_file").val());
        var b = $("#tipo_dat").val($("#tipo_dato").val());
        $("#inputFileForm").submit();
    } else { // no file was selected        	
        $("#errorUplodFile").modal('toggle');
        return false;
    }
}

function readSomeLines(file, maxlines, forEachLine, onComplete) {
    var CHUNK_SIZE = 50000; // 50kb, arbitrarily chosen.
    var decoder = new TextDecoder();
    var offset = 0;
    var linecount = 0;
    var linenumber = 0;
    var results = '';
    var fr = new FileReader();
    fr.onload = function () {
        // Use stream:true in case we cut the file
        // in the middle of a multi-byte character
        results += decoder.decode(fr.result, {stream: true});
        var lines = results.split('\n');
        results = lines.pop(); // In case the line did not end yet.
        linecount += lines.length;

        if (linecount > maxlines) {
            // Read too many lines? Truncate the results.
            lines.length -= linecount - maxlines;
            linecount = maxlines;
        }

        for (var i = 0; i < lines.length; ++i) {
            forEachLine(lines[i] + '\n');
        }
        offset += CHUNK_SIZE;
        seek();
    };
    fr.onerror = function () {
        onComplete(fr.error);
    };
    seek();

    function seek() {
        if (linecount === maxlines) {
            // We found enough lines.
            onComplete(); // Done.
            return;
        }
        if (offset !== 0 && offset >= file.size) {
            // We did not find all lines, but there are no more lines.
            forEachLine(results); // This is from lines.pop(), before.
            onComplete(); // Done
            return;
        }
        var slice = file.slice(offset, offset + CHUNK_SIZE);
        fr.readAsArrayBuffer(slice);
    }
}



function openDlgLoadTable() {
    var datasetid = $('#sel-db').val();
    commonAjaxCall("GET", _ctx + "/rest/dataset/tables/" + datasetid, '', loadTableList);
    $('#load-table-db').modal('show');
}


function loadTableList(data) {
    $.each(data, function (i, value) {
        $('<option></option>', {text: value}).attr('value', value).appendTo('#sel-tables');
    });
}
function loadFieldsList(data) {
    $.each(data, function (i, value) {
        var li = '<li class="list-group-item"><div class="custom-control custom-checkbox">'
                + '<input type="checkbox" class="custom-control-input" name="fields" value="' + value + '" id="check' + i + '" checked="checked">'
                + '<label class="custom-control-label" for="check' + i + '">' + value + '</label></div></li>';
        $(li).appendTo('#check-list-fields');
    });
}

function inviaFormTable() {
    $('#db-schema').val($('#sel-db').val());
    $('#table-name').val($('#sel-tables').val());
    $("#dataset-fields-table").submit();

}

// Method to initiate AJAX request
function commonAjaxCall(type, url, data, callback) {
    $.ajax({
        type: type,
        url: url,
        data: data,
        success: function (data) {
            callback(data);
        }
    });
}
