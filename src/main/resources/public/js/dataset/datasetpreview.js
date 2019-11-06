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
var selVar;
var mergeField = "";
var commandField = "";
var charOrString = "_";
var upperLower = "_";
var newField = "";
var idColonna = "";
var idColonnaToParse = "";
var filename;

function eliminaDataset() {
    $('#modalCancellaDataset').modal('show');
}

function openStandardizationModal() {
    $('#modalStandardization').modal('show');
}

function openMergeModal() {
    $('#modalMerge').modal('show');
}

function openParseModal() {
    $('#modalParse').modal('show');
}

function openRepairModal() {
    $('#modalRepair').modal('show');
}

function openDeleteModal() {

    $('#modalDelete').modal('show');
}

$(document).ready(function () {

    mergeField = "";
    commandField = "";
    charOrString = "_";
    upperLower = "_";
    newField = "";
    idColonna = "";
    idColonnaToParse = "";

    $("#csvFileId").attr("disabled", true);
    selVar = $("#selectedVar").val();
    selVarName = $("#selectedVar option:selected").text();


    $('#id_Dataset').val(_idfile);
    $('#id_Colonna').val($('#selectedVariableToFix').val());
    $('#num_Colonne').val(_variabili);
    $('#num_Righe').val(_righe);

    if ($('#upperCase').is(':checked')) {
        $('#upperRadio').show();
    } else {
        $('#upperRadio').hide();
    }

    if ($("input[name='tipoSeparatore']:checked")[0].id == 'sepRadio') {
        $('#lenField').hide();
        $('#sepField').show();

    } else {
        $('#lenField').show();
        $('#sepField').hide();
    }

    if ($('#removeChar').is(':checked')) {
        $('#charValue').show();
    } else {
        $('#charValue').hide();
    }

    $('#upperCase').on('click', function () {
        $('#upperRadio').hide();
        if (this.checked) {
            $('#upperRadio').show();
        }
    });

    $('#selectedVariable').on('change', function () {
        selVarName = $(this).children("option:selected").text();
        selVar = $(this).val();
    });

    $('#sselectedVariableToFix').on('change', function () {
        $('#id_Colonna').val($(this).val());
        selVar = $(this).val();
    });

    $('#id_Colonna').val($('#selectedVariableToFix').val());

    $('#newfieldMerge').on('keyup', function () {
        if ($('#textArea').val() != "") {
            $("#btn_Merge_field").attr("disabled", false);
            if ($(this).val() == "") {
                $("#btn_Merge_field").attr("disabled", true);
            }
        } else {
            $("#btn_Merge_field").attr("disabled", true);
        }
    });

    $("#csvFileId").on('change', function () { // bCheck is a input type button
        filename = $("#csvFileId").val().substr($("#csvFileId").val().lastIndexOf("\\") + 1, $("#csvFileId").val().length);

        preview();
        if (filename) { // returns true if the string is not empty
            $("#desc").val(filename);
            $("#previewModalFixField").modal('show');
            return true;
        } else { // no file was selected        	
            alert("Nessun file caricato!");
            return false;
        }
    });

    $('#newfieldMerge').on('keypress', function (event) {
        if (event.key === ".") {
            return (false);
        }
        if (event.key === "\\") {
            return (false);
        }
        if (event.key === "\/") {
            return (false);
        }
        if (event.key === "\'") {
            return (false);
        }
        if (event.key === "\"") {
            return (false);
        }
    });

    $('#lenField').on('keypress', function (event) {
        var regular = new RegExp("[0-9]");
        return (regular.test(event.key));
    });

    $('#lenField').on('keyup', function (event) {
        if ($(this).val() !== "" && $('#newParseField1').val() !== "" && $('#newParseField2').val() !== "") {
            $("#btn_Parse_field").attr("disabled", false);
        } else {
            $("#btn_Parse_field").attr("disabled", true);
        }
    });

    $('#newRepairedField').on('keyup', function (event) {
        if ($(this).val() !== "") {
            $("#csvFileId").attr("disabled", false);
        } else {
            $("#csvFileId").attr("disabled", true);
        }
    });


    $('#sepField').on('keyup', function (event) {
        if ($(this).val() !== "" && $('#newParseField1').val() !== "" && $('#newParseField2').val() !== "") {
            $("#btn_Parse_field").attr("disabled", false);
        } else {
            $("#btn_Parse_field").attr("disabled", true);
        }
    });
    
    $('#newParseField1').on('keyup', function (event) {
        if ($(this).val() !== "" && $('#newParseField2').val() !== "") {
            if (($("input[name='tipoSeparatore']:checked")[0].id === 'sepRadio' && $('#sepField').val() !== "") || ($("input[name='tipoSeparatore']:checked")[0].id == 'lenRadio' && $('#lenField').val() !== "")) {
                $("#btn_Parse_field").attr("disabled", false);
            } else {
                $("#btn_Parse_field").attr("disabled", true);
            }
        } else {
            $("#btn_Parse_field").attr("disabled", true);
        }
    });
    
    $('#newParseField2').on('keyup', function (event) {
        if ($(this).val() !== "" && $('#newParseField1').val() !== "") {
            if ($("input[name='tipoSeparatore']:checked")[0].id === 'sepRadio' && $('#sepField').val() != "" || ($("input[name='tipoSeparatore']:checked")[0].id == 'lenRadio' && $('#lenField').val() != "")) {
                $("#btn_Parse_field").attr("disabled", false);
            } else {
                $("#btn_Parse_field").attr("disabled", true);
            }
        } else {
            $("#btn_Parse_field").attr("disabled", true);
        }
    });

    $('input:radio[name=tipoSeparatore]').on('change', function () {
        if ($("input[name='tipoSeparatore']:checked")[0].id === 'sepRadio') {
            $('#lenField').hide();
            $('#sepField').show();
            if ($('#sepField').val() !== "" && $('#newParseField1').val() !== "" && $('#newParseField2').val() !== "") {
                $("#btn_Parse_field").attr("disabled", false);
            } else {
                $("#btn_Parse_field").attr("disabled", true);
            }
        }
        if ($("input[name='tipoSeparatore']:checked")[0].id === 'lenRadio') {
            $('#sepField').hide();
            $('#lenField').show();
            if ($('#lenField').val() !== "" && $('#newParseField1').val() !== "" && $('#newParseField2').val() != "") {
                $("#btn_Parse_field").attr("disabled", false);
            } else {
                $("#btn_Parse_field").attr("disabled", true);
            }
        }
    });

    $('#removeChar').on('click', function () {
        $('#charValue').hide();
        if (this.checked) {
            $('#charValue').show();
        }
    });

    $('#btn_delete_dataset').click(function () {
        window.location = _ctx + '/deleteDataset/' + _idfile;
    });

    $('#addVariable').click(function () {
        $('#textArea').text($('#textArea').text() + selVarName)
        mergeField = mergeField + "{...(id)" + selVar + "...}";
        if ($('#newfieldMerge').val() != "") {
            $("#btn_Merge_field").attr("disabled", false);
        }
    });

    $('#addSeparator').click(function () {
        if ($('#sepValue').val() !== "") {
            $('#textArea').text($('#textArea').text() + $('#sepValue').val());
            mergeField = mergeField + "{...(se)" + $('#sepValue').val() + "...}";
            $('#sepValue').val("");
        } else {
            alert("Insert valid Separator!");
        }

        if ($('#newfieldMerge').val() !== "") {
            $("#btn_Merge_field").attr("disabled", false);
        }
    });

    $('#clearTextArea').click(function () {
        //alert(mergeField);
        $('#textArea').text("");
        mergeField = "";
        $("#btn_Merge_field").attr("disabled", true);
    });

    $('#btn_Standardization_field').click(function () {
        idColonna = $('#selectedVar').val();
        if ($("#removeSpace").is(':checked')) {
            commandField = commandField + "1";
        } else {
            commandField = commandField + "0";
        }

        if ($('#removeSpecial').is(':checked')) {
            commandField = commandField + "1";
        } else {
            commandField = commandField + "0";
        }
        
        if ($('#newField').val() !== "") {
            newField = $('#newField').val();
        } else {
            alert("Inserire il nome della nuova variabile");
            return;
        }

        if ($('#removeChar').is(':checked')) {
            commandField = commandField + "1";
            if ($('#charValue').val() != "") {
                charOrString = $('#charValue').val();
            } else {
                alert("inserire la stringa o il carattere da rimuovere");
                return;
            }
        } else {
            commandField = commandField + "0";
        }
        
        if ($('#upperCase').is(':checked')) {
            commandField = commandField + "1";
            upperLower = $('input:radio[name=gruppo3]:checked')[0].id;

        } else {
            commandField = commandField + "0";
        }

        $("btn_Standardization_field").addClass("towait");
        window.location = _ctx + '/createField/' + _idfile + "/" + idColonna + "/" + commandField + "/" + charOrString + "/" + upperLower + "/" + newField + "/" + _variabili + "/" + _righe;
    });

    $('#btn_Merge_field').click(function () {
        $("btn_Merge_field").addClass("towait");
        window.location = _ctx + '/createMergedField/' + _idfile + "/" + _variabili + "/" + _righe + "/" + mergeField + "/" + $('#newfieldMerge').val();
    });

    $('#btn_Delete_field').click(function () {
        $("btn_Delete_field").addClass("towait");
        window.location = _ctx + '/deleteField/' + _idfile + "/" + $('#selectedVariableToDelete').val() + "/" + _variabili + "/" + _righe;
    });

    $('#btn_Parse_field').click(function () {
        var executeCommand = "";
        var commandValue = "";
        var startTo = "";
        idColonnaToParse = $('#selectedVariableToParse').val();

        if ($("input[name='tipoSeparatore']:checked")[0].id === 'sepRadio') {
            executeCommand = "separatore";
            commandValue = "{..." + $('#sepField').val() + "...}";
        } else {
            executeCommand = "lunghezza";
            commandValue = $('#lenField').val();
        }
        if ($("input[name='posizionePartenza']:checked")[0].id === 'startRadio') {
            startTo = "start";
        } else {
            startTo = "end";
        }

        $("btn_Parse_field").addClass("towait");
        window.location = _ctx + '/createParsedFields/' + _idfile + "/" + idColonnaToParse + "/" + _variabili + "/" + _righe + "/" + executeCommand + "/" + commandValue + "/" + startTo + "/" + $('#newParseField1').val() + "/" + $('#newParseField2').val();
    });

    table = $("#dataview").DataTable({

        drawCallback: function () {
            $(".loading").hide();
        },
        dom: "<'row'<'col-sm-5'B>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        //autoWidth: false,
        scrollX: true,
        //responsive: false,
        ordering: true,
        "order": [],
        searching: false,
        lengthChange: true,
        lengthMenu: [[10, 15, 25, 50], [10, 15, 25, 50]],
        pageLength: 20,
        processing: true,
        serverSide: true,
        ajax: {url: _ctx + "/rest/datasetvalori/" + ID + "/" + getParams(),
            type: "POST"
        },
        columns: eval(getHeaders('dataview')),
        buttons: [{
                extend: 'csvHtml5',
                filename: 'download',
                title: 'download',
                className: 'btn-light',
                action: function (e, dt, node, config) {
                    scaricaDataset(e, 'csv', ID);
                }
            }]
    });

    $("#datapreview").DataTable({
        responsive: true,
        ordering: false,
        searching: false
    });

    if ($(".param-filter").length == 0) {
        $("#bottoneRicerca").hide();
        $("#no_filters_msg").text(_no_search_filters);
    }
});

function getParams() {
    var params = "";
    var inputs = $(".param-filter");
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
            params += inputs[i].id + "=" + inputs[i].value;
            y++;
        }
    }

    if (params == "") {
        params = "noparams";
    }

    return params;
}
function ricercaByParams() {
    var parametri = getParams();
    table.ajax.url(_ctx + "/rest/datasetvalori/" + ID + "/" + parametri).load();
    return false;
}

function getHeaders(tab) {
    var text = '[';
    $("#" + tab + " tr:first th").map(function () {
        text += '{"data": "' + $(this).text() + '"},';

    });
    if (text.length > 1)
        text = text.substring(0, text.length - 1);
    text += ']';

    return text;
}

function inviaFormFileFixField() {
    var fileName = document.getElementById('csvFileId').files[0];
    if (fileName) { // returns true if the string is not empty
        $("#field_Name").val($("#newRepairedField").val());
        $("#delimiter").val($("#delimiter_sel").val());
        $("#id_Colonna").val($("#selectedVariableToFix").val());

        $("#repairFieldForm").submit();

    } else { // no file was selected        	
        $("#errorUplodFile").modal('toggle');
        return false;
    }
}

function scaricaDataset(e, param, idDFile) {
    e.preventDefault();
    window.location = _ctx + '/rest/download/dataset/' + param + '/' + idDFile;
}

function preview() {
    var file = document.getElementById('csvFileId').files[0];
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