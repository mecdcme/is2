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


function updateFunctionDialog(id, nome, descrizione, etichetta, idPadre, funzione) {
   var titolo;
   $('.form-control').removeAttr("readonly","readonly");
   $('#id').attr("readonly","readonly");
   $('#fatherProcess').hide();
   $('#fatherLabel').hide();
   
   
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
//			$('#id').val(id);
			 $('#name').val("");
			 $('#description').val("");
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




function deleteFunctionDialog(id, nome, descrizione, etichetta, idPadre, funzione) {
	var titolo;
	 $('.form-control').attr("readonly","readonly");
	 $('#fatherProcess').hide();
	 $('#fatherLabel').hide();
	 
	switch (funzione) {
	case "functions":
		titolo=_deletefun;
		 $('#action').val("df");
		 $('#id').val(id);
		 $('#name').val(nome);
		 $('#description').val(descrizione);
		 $('#label').val(etichetta);
		 $('#label').show();
		 $('#lab').show();
		 
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
		 $('#label').show();
		 $('#lab').show();
		
		break
	case "subprocesses":
		titolo=_deletesubproc;
		 $('#action').val("dsp");
		 $('#fatherProcess').show();
		 $('#fatherLabel').show();
		$('#id').val(id);
		 $('#name').val(nome);
		 $('#description').val(descrizione);
		 $('#label').val(etichetta);
		 $('#label').show();
		 $('#lab').show();
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
	
	
	$("#modTitle").text(titolo);
    $('#Update-Dialog').modal('show');
}

function playAction(){
    
   $("#dialog").submit();
   
}

$(document).ready(function () {
   

});






