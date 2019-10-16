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
 * @author Paolo Francescangeli <pafrance @ istat.it>
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
    $("#upload").hide();

    $("#delimiter_sel").change(function () {
        $("#delimiter").val($("#delimiter_sel").val());
    });

    $("#file").change(function () { // bCheck is a input type button
        filename = $("input.file-caption-name").attr("title");
        $("#delimiter").val($("#delimiter_sel").val());
        preview();
        if (filename) { // returns true if the string is not empty
            $("#nomeF").val(filename);
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
    $('#btn_delete_ruleset').click(function () {
        var rulesetid = $('#idRuleset').val();
        var sessioneid = $('#idSessione_del').val();
        window.location = _ctx + '/rule/deleteRuleset/' + sessioneid + "/" + rulesetid;
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

function eliminaRuleset(idRuleset, nomeFile, idSessione) {
    $("#idRuleset").val(idRuleset);
    $("#idSessione_del").val(idSessione);
    $('#msg_elim_ruleset').text("Eliminare il set di regole " + nomeFile + "?");
    $('#modalCancellaRuleset').modal('show');
}
function eliminaElaborazione(ide, ids) {
    $('#id_elaborazione_del').val(ide);
    $('#id_sessione_del').val(ids);
    $('#msg_elaboraz').text("Eliminare l'elaborazione con id " + ide + "?");
    $('#modalCancellaElaborazione').modal('show');
}

function creaContenuto(data, delimiter) {
    // La lista dei tipi dovrà essere dinamica
    var list = [{
            "value": 0,
            "text": 'Skip'
        }, {
            "value": 1,
            "text": 'Identificativo'
        }, {
            "value": 2,
            "text": 'Correlata'
        }, {
            "value": 3,
            "text": 'Covariata'
        }, {
            "value": 4,
            "text": 'Pred'
        }];
    var content = "<b>(Seleziona i campi da inviare a SeleMix)</b>&nbsp;<br><br/>";
    content += '<div style="overflow: auto; padding: 5px;"><table>';
    content += '<tr>';
    for (var i = 0; i < data.length; i++) {
        content += '<td class="text-center">';
        content += '<label class="form-group">' + data[i] + "</label><br>";
        content += '<select  name="sel_' + i + '" >';
        for (var j = 0; j < list.length; j++) {
            content += '<option class="form-control" value="' + j + '">'
                    + list[j].text + '</option>';
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

function browseFiles() {
    $("#file").click();
}

function openNewRulesetDialog() {
    var action = /* [[@{/rule/newRuleset}]] */_ctx + '/rule/newRuleset';
    $("#inputNewRulesetForm").attr("action", action);
    $("#newrulesetdialog").modal('show');
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

function inviaFormRulesetFile() {
    var fileName = document.getElementById('file').files[0];
    if (fileName) { // returns true if the string is not empty
        $("#desc").val($("div.file-caption-name").attr("title"));// set
        // filename
        $("#labelFile").val($("#label_file").val());
        $("#desc").val($("#desc_file").val());
        $("#delimiter").val($("#delimiter_sel").val());
        $("#classificazione").val($("#tipo_regola").val());
        $("#labelCodeRule").val($("#label-code-rule").val());
        var radioValue = $("input[name='skip_line']:checked").val();
        $("#skipFisrtLine").val(radioValue);
        $("#inputFileRulesetForm").submit();
    } else { // no file was selected
        $("#errorUplodFile").modal('toggle');
        return false;
    }
}
function inviaFormNewRuleset() {
    $("#rulesetName").val($("#ruleset_name").val());
    $("#dataset").val($("#dataset_file").val());
    $("#rulesetDesc").val($("#ruleset_desc").val());
    $("#inputNewRulesetForm").submit();
}
function apriModificaRulesetDialog(id, nome, desc, dataset) {
    $("#rulesetId").val(id);
    var action = /* [[@{/rule/modificaRuleset}]] */_ctx
            + '/rule/modificaRuleset';
    $("#inputNewRulesetForm").attr("action", action);
    if (nome != 'null') {
        $('#ruleset_name_upd').val(nome);
    } else {
        $('#ruleset_name_upd').val('');
    }
    if (desc != 'null') {
        $('#ruleset_desc_upd').val(desc);
    } else {
        $('#ruleset_desc_upd').val('');
    }
    if (dataset != 'null') {
        $('#dataset_file_upd').val(dataset);
    } else {
        $('#dataset_file_upd').val(-1);
    }
    $('#updaterulesetdialog').modal('show');
}
function modificaRuleset() {
    $("#rulesetName").val($("#ruleset_name_upd").val());
    $("#rulesetDesc").val($("#ruleset_desc_upd").val());
    $("#dataset").val($("#dataset_file_upd").val());
    $("#inputNewRulesetForm").submit();
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
        results += decoder.decode(fr.result, {
            stream: true
        });
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