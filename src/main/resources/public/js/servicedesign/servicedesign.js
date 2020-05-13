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

$(document).ready(function() {

	$("#select-gsbpm-2").hide();
	
	$("#update-bservice-modal").keydown(function(event) {
		if (event.which == 13) {
			check_and_send_upd_bs_req();
		}
	});
	
	
	
	$("#update-step-instance-modal").keydown(function(event) {
		if (event.which == 13) {
			check_and_send_upd_si_req();
		}
	});
	$("#modalDeleteBS").keydown(function(event) {
		if (event.which == 13) {
			delete_bservice();
		}
	});
	$("#modalDeleteAS").keydown(function(event) {
		if (event.which == 13) {
			delete_appservice();
		}
	});
	$("#modalDeleteSI").keydown(function(event) {
		if (event.which == 13) {
			delete_stepinstance();
		}
	});
	
	$("#btn-submit-upd-bs").click(function() {
		check_and_send_upd_bs_req();
	});
	
	
	
	$("#btn-submit-upd-si").click(function() {
		check_and_send_upd_si_req();
	});
	$('#btn_delete_bs').click(function() {
		delete_bservice();
	});
	$('#btn_delete_as').click(function() {
		delete_appservice();
	});
	$('#btn_delete_si').click(function() {
		delete_stepinstance();
	});
	setTab(_selectedTab);

});

function setTab(selectedTab) {

	switch (selectedTab) {

	case "business":
		$("#business-tab").attr('class', 'nav-link active');
		$("#businessTab").attr('class', 'tab-pane fade show active');
		$("#application-tab").attr('class', 'nav-link');
		$("#applicationTab").attr('class', 'tab-pane fade');		
		$("#step-tab").attr('class', 'nav-link');
		$("#stepTab").attr('class', 'tab-pane fade');
		break;
	case "application":
		$("#business-tab").attr('class', 'nav-link');
		$("#businessTab").attr('class', 'tab-pane fade');
		$("#application-tab").attr('class', 'nav-link active');
		$("#applicationTab").attr('class', 'tab-pane fade show active');	
		$("#step-tab").attr('class', 'nav-link');
		$("#stepTab").attr('class', 'tab-pane fade');
		break
	case "step":
		$("#business-tab").attr('class', 'nav-link');
		$("#businessTab").attr('class', 'tab-pane fade');
		$("#application-tab").attr('class', 'nav-link');
		$("#applicationTab").attr('class', 'tab-pane fade');	
		$("#step-tab").attr('class', 'nav-link active');
		$("#stepTab").attr('class', 'tab-pane fade show active');	
		break;

	default:
		$("#business-tab").attr('class', 'nav-link active');
	$("#businessTab").attr('class', 'tab-pane fade show active');
	$("#application-tab").attr('class', 'nav-link');
	$("#applicationTab").attr('class', 'tab-pane fade');		
	$("#step-tab").attr('class', 'nav-link');
	$("#stepTab").attr('class', 'tab-pane fade');
		break;

	}

}


function openAppServiceEditPage(idappservice) {	
	window.location = _ctx + '/applicationedit/'+idappservice;
}
function openStepInstanceEditPage(stepid) {
	window.location = _ctx + '/stepinstanceedit/'+stepid;	
}
function updateBusinessService(id, name, description, gsbpmid) {
	$("#up-bs-name-error").text('');
	$("#up-bs-id").val(id);
	$("#up-bs-name").val(name);
	$("#up-bs-description").val(description);
	$("#up-bs-gsbpm").val(gsbpmid);
	$('#update-bservice-modal').modal('show');
}

function updateStepInstanceDialog(id, method, description, label, appserviceid) {
	$("#upd-si-method-error").text('');
	$("#id-upd-step-instance").val(id);
	$("#upd-si-method").val(method);
	$("#upd-si-description").val(description);
	$("#upd-si-label").val(label);
	$("#select-si-upd-appservice").val(appserviceid);
	$('#update-step-instance-modal').modal('show');
}
function open_business_edit(idservice) {
	window.location = _ctx + '/businessedit/'+idservice;	
}


function check_and_send_upd_bs_req() {
	var upbsname = $('#up-bs-name').val();
	if (upbsname.length < 1) {
		$("#up-bs-name-error").text(_mandatory_name_field);
	} else {
		$("#upd-bs-form").submit();
	}
}

function check_and_send_upd_si_req() {
	var method = $('#upd-si-method').val().length;
	if (method.length < 1) {
		$("#upd-si-method-error").text(_mandatory_method_field);
	} else {
		$("#upd-si-form").submit();
	}
}
function check_and_send_elab_req() {
	var nomeelab = $('#nome-elab').val();
	if (nomeelab.length < 1) {
		$("#nomesesserror").text(_mandatory_name_field);
	} else {
		$("#form").submit();
	}

}
function deleteBusinessService(id) {
	$('#id_bs_delete').val(id);
	$('#del_bs_msg').text(_remove_bs_msg_dialog);
	$('#modalDeleteBS').modal('show');
}
function deleteAppService(id) {
	$('#id_as_delete').val(id);
	$('#del_as_msg').text(_remove_as_msg_dialog);
	$('#modalDeleteAS').modal('show');
}
function deleteStepInstance(id) {
	$('#id_si_delete').val(id);
	$('#del_si_msg').text(_remove_si_msg_dialog);
	$('#modalDeleteSI').modal('show');
}
function delete_bservice() {
	var idbs = $('#id_bs_delete').val();
	window.location = _ctx + '/deletebservice/' + idbs;
}
function delete_appservice() {
	var idas = $('#id_as_delete').val();
	window.location = _ctx + '/deleteappservice/' + idas;
}
function delete_stepinstance() {
	var idsi = $('#id_si_delete').val();
	window.location = _ctx + '/deletestepinstance/' + idsi;
}
