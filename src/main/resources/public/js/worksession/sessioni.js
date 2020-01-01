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
    
    $("#funzioni").change(function () {
        var id = $("#funzioni :selected").val();
        $('.els').addClass('hide');
        $('.el_' + id).removeClass('hide');
    });

    $("#funzioni").change();
    $('#btn_delete').click(function () {
    	delete_session();
    });
    $('#btn_delete_elab').click(function () {
    	delete_process();
    });
    $("#btn-submit-ns").click(function () {
    	check_and_send_req();
    });
    $("#btn-submit-ne").click(function () {
    	check_and_send_elab_req();
    });
    
    $( "#nuova-sessione-modal" ).keydown(function( event ) { 
    	  if ( event.which == 13 ) {check_and_send_req();}
    });
    $( "#modalCancellaSessione" ).keydown(function( event ) {
    	  if ( event.which == 13 ) {delete_session();}
    });
    $( "#nuova-elaborazione-modal" ).keydown(function( event ) { 
  	  if ( event.which == 13 ) {check_and_send_elab_req();}
    });
    $( "#modalCancellaElaborazione" ).keydown(function( event ) { 
    	  if ( event.which == 13 ) {delete_process();}
      });
});

function delete_session(){
    var ids = $('#id_sessione_del').val();
    window.location = _ctx + '/sessione/elimina/' + ids;
}

function delete_process(){
    var ids = $('#id_sessione_del').val();
    var ide = $('#id_elaborazione_del').val();
    window.location = _ctx + '/ws/elimina/' + ide + "/" + ids;
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

function openNuovaSessioneWF() {
    $("#nomesesserror").text('');
    $('#nuova-sessione-modal').modal('show');
}

function nuovoWorkingSet() {
    $('#nuova-elaborazione-modal').modal('show');
}

function openNuovaElaborazione() {
    $('#nuova-elaborazione-modal').modal('show');
}

function eliminaSessioneLavoro(id) {
    $('#id_sessione_del').val(id);
    $('#del_msg').text(_remove_msg_dialog);
    $('#modalCancellaSessione').modal('show');
}

function eliminaElaborazione(ide, ids, p_name) {
    $('#id_elaborazione_del').val(ide);
    $('#id_sessione_del').val(ids);
    $('#msg_process').text(_remove_process_msg + " " + p_name + "?");    
    $('#modalCancellaElaborazione').modal('show');
}