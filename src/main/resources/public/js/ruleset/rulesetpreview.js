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

var table;
$(document).ready(function () {
    
	table=  $("#dataview").DataTable({
        drawCallback: function () {
            $(".loading").hide();
        },
        dom: "<'row'<'col-sm-5'B><'col-sm-7'<'pull-right'f>>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        autoWidth: false,
        responsive: true,
        ordering: true,
        searching: true,
        lengthChange: true,
        pageLength: 20,
        order: [[ 2, "asc" ]],
        columnDefs: [ {
            "targets": [ 0,1 ],
            "visible": false,
            "searchable": false
        },{
          targets: 'no-sort',
          orderable: false
        }],
         buttons: [{
                text: _new_role,
                title: 'New rule',
                className: 'btn-light mr-1',
                action: function (e, dt, node, config) {
                    newRule();
                }
            },
            {
                extend: 'csvHtml5',
                filename: 'download',
                title: 'download',
                className: 'btn-light mr-1'
            }],
        language: {
            paginate: {
                "previous": "Prev"
            }
        }
    });
    
    if ($('#dataset_div').length > 0) {
        $("#dataview").DataTable().button().add(1, {
            title: 'Show variables',
            className: 'btn-light',
            action: function (e, dt, node, config) {
                mostraVariabili();
            },
            text: 'Mostra variabili'
        });
    }

    $("#dataset_div").hide();

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
    
    
    $("#inputNewRuleForm").validate({
         rules : {          
        	ruleCode : {
             required : true
            },
            ruleText : {
                required : true,
             } 
        },
          messages: {
        	ruleCode: "*Field required",
            ruleText: "*Field required"
        },
        submitHandler: function(form) {
        	$('#loading').modal('show');
        	$('#newruledialog').modal('hide');
            form.submit();
        }
    });
    $("#editForm").validate({
        rules : {          
        	rule : {
            required : true
           } 
       },
         messages: {
        	 rule: "*Field required" 
       },
       submitHandler: function(form) {
       	$('#loading').modal('show');
       	$('#modalEditRule').modal('hide');
           form.submit();
       }
   });
    
});


function chiudiDivVariabili() {
    $("#dataset_div").hide();
}

function inviaFormNewRule() {
    $("#inputNewRuleForm").submit();
}
function inviaFormEditRule() {
    $("#editForm").submit();
}

function inviaFormNewVarRule() {
    $("#ruleText").val($("#rule_text_v").val());
    $("#ruleDesc").val($("#rule_desc_v").val());
    $("#classification").val($("#classification_v").val());
    $("#inputNewRuleForm").submit();
}



function modificaRegola() {
    $("#ruleText").val($("#rule_text_v").val());
    $("#ruleDesc").val($("#rule_desc_v").val());
    $("#classification").val($("#classification_v").val());
    $("#inputNewRuleForm").submit();
}

function newRule() {
    $('#newruledialog').modal('show');
}

function mostraVariabili() {
    $("#dataset_div").show();
}

function addRule(id_variable, nome_variabile) {
    $('#nome_var').text(nome_variabile);
    $('#idcol').val(id_variable);
    $('#addrulevariable').modal('show');
}

function editRule(identifier){
	var idRole = $(identifier).data('rule-id');
	var codeRole = $(identifier).data('rule-code');
	var rule = $(identifier).data('rule-rule');
	var descr = $(identifier).data('rule-descr');
	var classif = $(identifier).data('rule-class-id');
  	$('#editRuleId').val(idRole);
    $('#rule').val(rule);
    $('#editCodeRule').val(codeRole);
    if (descr == 'null') {
        $('#descrizione_edit').val('');
    } else {
        $('#descrizione_edit').val(descr);
    }
    $("#classification_edit").val(classif);
    $('#modalEditRule').modal('show');
}

function deleteRule(id, rule) {
    $('#ruleId').val(id);
    
    var str_msg = "DELETE";
    if(_delete_msg.toUpperCase().includes(str_msg)){
    	var msg = _delete_msg.replace("*", rule) + "?";
    }else{    	
        var msg = _delete_msg + " " + rule + "?";
    }    
    $('#modalDeleteRule .modal-body span').text(msg);
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


function runValidateR(rfunction,idRuleset,col) {
    $('#loading').modal('show');
    $.ajax({
        url: _ctx + "/rest/runvalidater/" + idRuleset+'/'+rfunction,
        type: "GET",
        success: function (data) {
        	var respTrue='<i class="fa fa-check" style="color:#4dbd74"></i><span style="display: none">2</span>';
        	var respFalse='<i class="fa fa-times" style="color:#f86c6b"></i><span style="display: none">1</span>';
        	table.column( col ).visible( true );
            var ris=data[rfunction];
        	$.each( ris.key, function( index, value ){
        		  $('#'+rfunction+'_'+value).html(ris.value[index].toLowerCase() == 'true'?respTrue:respFalse) ;
      		  });
        	  $('#loading').modal('hide');
           
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });

}


function runIsContradicted(idRule) {
    $('#loading').modal('show');
    $.ajax({
        url: _ctx + "/rules/IsContradicted/" + idRule,
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