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


function eliminaDataset() {
    $('#modalCancellaDataset').modal('show');
};

function openStandardizationModal() {
    $('#modalStandardization').modal('show');
};

function openMergeModal() {
    $('#modalMerge').modal('show');
};

function openParseModal() {
    $('#modalParse').modal('show');
};
function openRepairModal() {
    $('#modalRepair').modal('show');
};



$(document).ready(function () {
	
	
	
	if($('#upperCase').is(':checked')){
	     $('#upperRadio').show();
  }else{
		$('#upperRadio').hide();
	};
	
  if($('#removeChar').is(':checked')){
	     $('#charValue').show();
	}else{
		$('#charValue').hide();
	};

  $('#upperCase').on('click',function(){
  	   $('#upperRadio').hide();
  	   if(this.checked){
  	     $('#upperRadio').show();
  	   }
  	});
 
  $('#removeChar').on('click',function(){
	   $('#charValue').hide();
	   if(this.checked){
	     $('#charValue').show();
	   }
	});
	
	$('#btn_delete_dataset').click(function () {
       window.location = _ctx + '/deleteDataset/' + _idfile;
   });
   
	
	
	
	
  $('#btn_Standardization_field').click(function () {
   	
   
	var commandField="";
  	var charOrString="_";
  	var upperLower="_";
  	var newField="";
  	var idColonna="";


   	idColonna= $('#selectedVar').val();
   	if($("#removeSpace").is(':checked')){
   		commandField= commandField + "1";
	      }else{
	    	  commandField= commandField + "0";
	   	};
   	
   	if($('#removeSpecial').is(':checked')){
   		commandField= commandField + "1";
	      }else{
	    	  commandField= commandField + "0";
	   	};
	   	
	   	if($('#newField').val()!=""){
		   		newField=$('#newField').val();
			}else{
				alert("Inserire il nome della nuova variabile");
				return;
			
		}
  	
   	if($('#removeChar').is(':checked')){
   		commandField= commandField +"1";
   		if($('#charValue').val()!=""){
   			charOrString=$('#charValue').val();
   		}else{
   			alert("inserire la stringa o il carattere da rimuovere");
   			return;
   			
   		}
	      }else{
	    	  commandField= commandField + "0";
	   	};
  	
	   	if($('#upperCase').is(':checked')){
	   		commandField= commandField + "1";
	   		upperLower=$('input:radio[name=gruppo3]:checked')[0].id;
	    
	   	}else{
	   		commandField= commandField + "0";
	   	};
	   	
	   	
   	
	   	$("btn_Standardization_field").addClass("towait");
       window.location = _ctx + '/createField/' + _idfile + "/" +  idColonna + "/" + commandField + "/" +  charOrString + "/" + upperLower + "/" + newField + "/" + _variabili ;
       
   	
   	

   });
   
      
    
   table=  $("#dataview").DataTable({

        drawCallback: function () {
            $(".loading").hide();
        },
        dom: "<'row'<'col-sm-12'<'pull-left'B>>>"
                + "<'row'<'col-sm-12'<'pull-left'l>>>"
                + "<'row'<'col-sm-12'tr>>"
                + "<'row'<'col-sm-12'<'pull-left'p>>>"
                + "<'row'<'col-sm-12'<'pull-left'i>>>",
        responsive: true,
        ordering: true,
        searching: false,
        lengthChange: true,
        lengthMenu: [[10, 15, 25, 50], [10, 15, 25, 50]],
        pageLength: 15,
        serverSide: true,
        ajax: {url: _ctx + "/rest/datasetvalori/" + ID + "/" + getParams(),
            type: "POST"
        },
        columns: eval(getHeaders('dataview')),
        processing: true,
        buttons: [{
            extend: 'colvis',
            text: 'Seleziona colonne'
        },
        {
            extend: 'csvHtml5',
            filename: 'download',
            title: 'download',
            action: function (e, dt, node, config) {
                scaricaDataset(e, 'csv', ID);
            }
        }]
    });

    $("#datapreview").DataTable({
        responsive: true,
        "ordering": false,
        searching: false
    });

    if ($(".param-filter").length == 0) {
        $("#bottoneRicerca").hide();
        $("#no_filters_msg").text("Non ci sono filtri di ricerca impostati.");
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

function scaricaDataset(e, param, idDFile) {
    e.preventDefault();
    window.location = _ctx + '/rest/download/dataset/' + param + '/' + idDFile;
}