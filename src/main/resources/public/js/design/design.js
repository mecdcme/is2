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





function updateFunctionDialog(id, nome, descrizione, etichetta, idPadre, idBusinessFunction, funzione) {
   var titolo;
   $('.form-control').removeAttr("readonly","readonly");
   $('#id').attr("readonly","readonly");
   $('#fatherProcess').hide();
   $('#fatherLabel').hide();
   $('#businessProcess').hide();
   $('#processLabel').hide();
   
   
	switch (funzione) {
	
	case "functions":
		titolo=_updatefun;
		 $('#action').val("uf");
		 $('#id').val(id);
		 $('#name').val(nome);
		 $('#description').val(descrizione);
		 $('#label').val(etichetta);
		 $('#label').show();
		 $('#lab').show();
		break;
	case "processes":
		titolo=_updateproc;
		$('#action').val("up");
		$('#id').val(id);
		 $('#name').val(nome);
		 $('#description').val(descrizione);
		 $('#label').val(etichetta);
		 $('#label').show();
		 $('#lab').show();
		break
	case "subprocesses":
		titolo=_updatesubproc;
		$('#action').val("usp");
		$('#fatherProcess').show();
		 $('#fatherLabel').show();
		$('#fatherProcess').val(idPadre);
		$('#id').val(id);
		 $('#name').val(nome);
		 $('#description').val(descrizione);
		 $('#label').val(etichetta);
		 $('#label').show();
		 $('#lab').show();
		break;
	case "steps":
		titolo=_updatestep;
		$('#action').val("us");
		$('#id').val(id);
		 $('#name').val(nome);
		 $('#description').val(descrizione);
		 $('#businessProcess').val(idBusinessFunction);
		 $('#businessProcess').show();
		 $('#processLabel').show();
		 $('#label').hide();
		 $('#lab').hide();
		
		break;

	default:
		titolo="";
		break;
	}
	
	
	$("#modTitle").text(titolo);

    $('#Update-Dialog').modal('show');
  
    
}


function newFunctionDialog(funzione) {
	   var titolo;
	   $('.form-control').removeAttr("readonly","readonly");
	   $('#id').hide();
	   $('#idlab').hide();
	   $('#fatherProcess').hide();
	   $('#fatherLabel').hide();
	   $('#businessProcess').hide();
	   $('#processLabel').hide();
		switch (funzione) {
		
		case "functions":
			titolo=_newfun;
			 $('#action').val("nf");
//			 $('#id').val(id);
			 $('#name').val("");
			 $('#description').val("");
			 $('#label').val("");
			 $('#label').show();
			 $('#lab').show();
			break;
		case "processes":
			titolo=_newproc;
			 $('#action').val("np");
//			$('#id').val(id);
			 $('#name').val("");
			 $('#description').val("");
			 $('#label').val("");
			 $('#label').show();
			 $('#lab').show();
			break
		case "subprocesses":
			titolo=_newsubproc;
			 $('#action').val("nsp");
//			$('#id').val(id);
			 $('#fatherProcess').val("0");
			 $('#fatherProcess').show();
			 $('#fatherLabel').show();
			 $('#name').val("");
			 $('#description').val("");
			 $('#label').val("");
			 $('#label').show();
			 $('#lab').show();
			break;
		case "steps":
			titolo=_newstep;
			 $('#action').val("ns");
			 $('#businessProcess').val("0");
			
//			$('#id').val(id);
			 $('#name').val("");
			 $('#description').val("");
			 $('#businessProcess').show();
			 $('#processLabel').show();
			 $('#label').hide();
			 $('#lab').hide();
			
			break;

		default:
			titolo="";
			break;
		}
		
		
		$("#modTitle").text(titolo);

	    $('#Update-Dialog').modal('show');
	  
	    
	}




function deleteFunctionDialog(id, nome, descrizione, etichetta, idPadre, idBusinessFunction, funzione) {
	var titolo;
	 
	 
	 $('#id').show();
	 $('#idlab').show();
	 $('#label').show();
	 $('#lab').show();
	 $('#fatherProcess').hide();
	 $('#fatherLabel').hide();
	 $('#businessProcess').hide();
	 $('#processLabel').hide();
	switch (funzione) {
	case "functions":
		titolo=_deletefun;
		 $('#action').val("df");
		 $('#id').val(id);
		 $('#name').val(nome);
		 $('#description').val(descrizione);
		 $('#label').val(etichetta);
		
		 
//		 $(':input').readOnly(true);
//		 $('[name="id"]').prop("readOnly", false);  

			
		
		break;
	case "processes":
		titolo=_deleteproc;
		 $('#action').val("dp");
		$('#id').val(id);
		 $('#name').val(nome);
		 $('#description').val(descrizione);
		 $('#label').val(etichetta);
		
		break
	case "subprocesses":
		titolo=_deletesubproc;
		 $('#action').val("dsp");
//		 $('#fatherProcess').show();
//		 $('#fatherLabel').show();
		$('#id').val(id);
		 $('#name').val(nome);
		 $('#description').val(descrizione);
		 $('#label').val(etichetta);
		
		break;
	case "steps":
		titolo=_deletestep;
		 $('#action').val("ds");
		$('#id').val(id);
		 $('#name').val(nome);
		 $('#description').val(descrizione);
		 $('#label').hide();
		 $('#lab').hide();
		
		break;

	default:
		titolo="";
		break;
	}
	
	$('.form-control').attr("readonly","readonly");
	$("#modTitle").text(titolo);
    $('#Update-Dialog').modal('show');
}

function newFunctionDialog(funzione) {
	   var titolo;
	   $('.form-control').removeAttr("readonly","readonly");
	   $('#id').hide();
	   $('#idlab').hide();
	   $('#fatherProcess').hide();
	   $('#fatherLabel').hide();
	   $('#businessProcess').hide();
	   $('#processLabel').hide();
		switch (funzione) {
		
		case "functions":
			titolo=_newfun;
			 $('#action').val("nf");
//			 $('#id').val(id);
			 $('#name').val("");
			 $('#description').val("");
			 $('#label').val("");
			 $('#label').show();
			 $('#lab').show();
			break;
		case "processes":
			titolo=_newproc;
			 $('#action').val("np");
//			$('#id').val(id);
			 $('#name').val("");
			 $('#description').val("");
			 $('#label').val("");
			 $('#label').show();
			 $('#lab').show();
			break
		case "subprocesses":
			titolo=_newsubproc;
			 $('#action').val("nsp");
//			$('#id').val(id);
			 $('#fatherProcess').val("0");
			 $('#fatherProcess').show();
			 $('#fatherLabel').show();
			 $('#name').val("");
			 $('#description').val("");
			 $('#label').val("");
			 $('#label').show();
			 $('#lab').show();
			break;
		case "steps":
			titolo=_newstep;
			 $('#action').val("ns");
			 $('#businessProcess').val("0");
			
//			$('#id').val(id);
			 $('#name').val("");
			 $('#description').val("");
			 $('#businessProcess').show();
			 $('#processLabel').show();
			 $('#label').hide();
			 $('#lab').hide();
			
			break;

		default:
			titolo="";
			break;
		}
		
		
		$("#modTitle").text(titolo);

	    $('#Update-Dialog').modal('show');
	  
	    
	}


function checkSelected(value) {
	  
	
//	alert(value.id);
	$("#functionsList > option").each(function() {
		  if (this.value==value.id) {
			  
			  $(this).prop("selected", true);
			  $('.demo').bootstrapDualListbox('refresh')
		};
	});


}
function checkSelectedSteps(value) {
	  
	
//	alert(value.id);
	$("#processesList > option").each(function() {
		  if (this.value==value.id) {
			  
			  $(this).prop("selected", true);
			  $('.demo1').bootstrapDualListbox('refresh')
		};
	});


}


function bindingFunctionDialog(id, nome, descrizione, etichetta, idPadre, idBusinessFunction, funzione) {
	var titolo;
	 
	$('.bindingProcessesForm').removeAttr("readonly","readonly");
	
	 
	$('#idf').val(id);
	$('#namef').val(nome);
	$('#descriptionf').val(descrizione);
	

	$.ajax({
		type : "GET",
		contentType : "application/json",
		url : _ctx + "/rest/design/getProcess/" + id,
		dataType : 'json',
		cache : true,
		success : function(data) {
			
			$("#functionsList > option").each(function() { $(this).prop("selected", false)});
			$('.demo').bootstrapDualListbox('refresh');
			data.businessFunctions.forEach(checkSelected);
			
			$('.form-control').attr("readonly","readonly");
			$('.filter').removeAttr("readonly","readonly");
			
			$("#bindingTitleFunctions").text(titolo);
			$('#binding-Functions').modal('show');
		},
		error : function(e) {
			
			console.log("ERROR : ", e);
		},
		complete : function() {
			
		}
	});
	
	
}



function bindingProcessDialog(id, nome, descrizione, etichetta, idPadre, idBusinessFunction, funzione) {
	var titolo;
	 
	$('.bindingFunctionsForm').removeAttr("readonly","readonly");
	
	 
	$('#idp').val(id);
	$('#namep').val(nome);
	$('#descriptionp').val(descrizione);
	
	$.ajax({
		type : "GET",
		contentType : "application/json",
		url : _ctx + "/rest/design/getStep/" + id,
		dataType : 'json',
		cache : true,
		success : function(data) {
			
			$("#processesList > option").each(function() { $(this).prop("selected", false)});
			$('.demo1').bootstrapDualListbox('refresh');
			data.businessProcesses.forEach(checkSelectedSteps);
			
			$('.form-control').attr("readonly","readonly");
			$('.filter').removeAttr("readonly","readonly");
			
			$("#bindingTitleSteps").text(titolo);
			$('#binding-Processes').modal('show');
		},
		error : function(e) {
			
			console.log("ERROR : ", e);
		},
		complete : function() {
			
		}
	});
	
	
	
}



function playAction(){
	
	switch ($('#action').val()) {
	
	case "nf":
		$("#dialog").submit();
	break;
	
	case "np":
		$("#dialog").submit();
	break;

	case "nsp":
		if($('#fatherProcess').val()!=0) {
			$("#dialog").submit();
		}else {
			alert("select the father process");
		}
		
		 
		break;
	case "ns":
		if($('#fbusinessProcess').val()!=0) {
			$("#dialog").submit();
		}else {
			alert("select the business process");
		}
		
		
		break
	
	default:
		
		break;
	}
    
  
   
}

function playBindingProcesses(){

	
	$("#bindingProcessesForm").submit();
	
}


function playBindingFunctions(){

	
	$("#bindingFunctionsForm").submit();
}

$(document).ready(function () {
	var demo = $('select[name="duallistbox_demo[]"]').bootstrapDualListbox({
		  nonSelectedListLabel: 'Non-selected',
		  selectedListLabel: 'Selected',
		  preserveSelectionOnMove: 'moved',
		  moveOnSelect: false,
		  nonSelectedFilter: ''
			  
		});
	var demo1 = $('select[name="duallistbox_demo1[]"]').bootstrapDualListbox({
		  nonSelectedListLabel: 'Non-selected',
		  selectedListLabel: 'Selected',
		  preserveSelectionOnMove: 'moved',
		  moveOnSelect: false,
		  nonSelectedFilter: ''
			  
		});
	
	$('.treeview-animated').mdbTreeview();
		
	
});






