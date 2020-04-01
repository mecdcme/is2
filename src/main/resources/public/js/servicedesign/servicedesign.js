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

	$("#new-bservice-modal").keydown(function(event) {
		if (event.which == 13) {
			check_and_send_req();
		}
	});
	$("#update-bservice-modal").keydown(function(event) {
		if (event.which == 13) {
			check_and_send_upd_bs_req();
		}
	});
	$("#new-app-service-modal").keydown(function(event) {
		if (event.which == 13) {
			check_and_send_as_req();
		}
	});
	$("#update-app-service-modal").keydown(function(event) {
		if (event.which == 13) {
			check_and_send_upd_as_req();
		}
	});
	$("#new-step-instance-modal").keydown(function(event) {
		if (event.which == 13) {
			check_and_send_si_req();
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
	$("#btn-submit-bs").click(function() {
		check_and_send_req();
	});
	$("#btn-submit-upd-bs").click(function() {
		check_and_send_upd_bs_req();
	});
	$("#btn-submit-as").click(function() {
		check_and_send_as_req();
	});
	$("#btn-submit-as-upd").click(function() {
		check_and_send_upd_as_req();
	});
	$("#btn-submit-si").click(function() {
		check_and_send_si_req();
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

});

function openNewBServiceDialog() {
	$("#bs-name-error").text('');
	$('#new-bservice-modal').modal('show');
}
function openNewAppServiceDialog() {
	$("#as-name-error").text('');
	$('#new-app-service-modal').modal('show');
}
function openNewStepInstanceDialog() {
	$("#si-name-error").text('');
	$('#new-step-instance-modal').modal('show');
}
function updateBusinessService(id, name, description, gsbpmid) {	
	$("#up-bs-name-error").text('');
	$("#up-bs-id").val(id);
	$("#up-bs-name").val(name);
	$("#up-bs-description").val(description);	
	$("#up-bs-gsbpm").val(gsbpmid);	
	$('#update-bservice-modal').modal('show');
}
function updateAppServiceDialog(identifier) {	
	$("#upd-as-name-error").text("");
	$("#upd-as-id").val($(identifier).data('id-app-service'));	
	
	$("#upd-as-name").val($(identifier).data('name'));
	$("#upd-as-description").val($(identifier).data('descr'));
	
	$("#upd-as-language").val($(identifier).data('language'));
	$("#upd-as-engine").val($(identifier).data('engine'));
	$("#upd-as-sourcepath").val($(identifier).data('source-path'));
	$("#upd-as-sourcecode").val($(identifier).data('source-code'));
	
	$("#upd-as-author").val($(identifier).data('author'));
	$("#upd-as-licence").val($(identifier).data('licence'));
	$("#upd-as-contact").val($(identifier).data('contact'));
	$("#upd-as-select").val($(identifier).data('bservice-id'));
	$('#update-app-service-modal').modal('show');
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
function check_and_send_req() {
	var bsname = $('#bs-name').val();
	if (bsname.length < 1) {
		$("#bs-name-error").text(_mandatory_name_field);
	} else {
		$("#bs-form").submit();
	}
}
function check_and_send_as_req() {
	var asname = $('#as-name').val();
	if (asname.length < 1) {
		$("#as-name-error").text(_mandatory_name_field);
	} else {
		$("#as-form").submit();
	}
}
function check_and_send_upd_bs_req() {
	var upbsname = $('#up-bs-name').val();
	if (upbsname.length < 1) {
		$("#up-bs-name-error").text(_mandatory_name_field);
	} else {
		$("#upd-bs-form").submit();
	}
}
function check_and_send_upd_as_req() {
	var updasname = $('#upd-as-name').val().length;	
	if (updasname.length < 1) {
		$("#upd-as-method-error").text(_mandatory_name_field);
	} else {
		$("#upd-as-form").submit();
	}
}
function check_and_send_si_req() {
	var method = $('#si-method').val().length;	
	if (method.length < 1) {
		$("#si-method-error").text(_mandatory_method_field);
	} else {
		$("#si-form").submit();
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
