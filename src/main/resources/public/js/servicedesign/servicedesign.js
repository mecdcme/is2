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
    
    $( "#new-bservice-modal" ).keydown(function( event ) { 
    	  if ( event.which == 13 ) {check_and_send_req();}
    });
    
});


function openNewBServiceDialog() {
    $("#nomesesserror").text('');
    $('#new-bservice-modal').modal('show');
}
function openNewAppServiceDialog() {
    $("#nomesesserror").text('');
    $('#new-app-service-modal').modal('show');
}

function check_and_send_req(){
    var nomesess = $('#nome-sessione').val();
    if (nomesess.length < 1) {           
        $("#nomesesserror").text(_mandatory_field);
    } else {
        $("#form").submit();
    }
}
function check_and_send_elab_req(){
    var nomeelab = $('#nome-elab').val();
    if (nomeelab.length < 1) {            
        $("#nomesesserror").text(_mandatory_field);
    } else {
        $("#form").submit();
    }
}
