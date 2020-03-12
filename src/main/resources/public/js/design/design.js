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




function bindingFunctionDialog(id, nome, descrizione, etichetta, idPadre, idBusinessFunction, funzione) {
	var titolo;
	 
	$('.form-controlbinding').removeAttr("readonly","readonly");
	 
	$('#idb').val(id);
	$('#nameb').val(nome);
	$('#descriptionb').val(descrizione);
	switch (funzione) {
	
	case "processes":
		titolo=_bindingprocess;
		 $('#action').val("bp");
		
		
		break
	
	case "steps":
		titolo=_bindingstep;
		 $('#action').val("bs")
		
		
		break;

	default:
		titolo="";
		break;
	}
	
	$('.form-control').attr("readonly","readonly");
	$("#bindingTitle").text(titolo);
 $('#binding-Dialog').modal('show');
}


function playAction(){
	
	switch ($('#action').val()) {
	case "nsp":
		
			
		 $("#dialog").submit();
		break;
	case "ns":
		
		 $("#dialog").submit();
		break
	

	default:
		 $("#dialog").submit();
		break;
	}
    
  
   
}

$(document).ready(function () {
   

});






