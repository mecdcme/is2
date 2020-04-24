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

function updateFunctionDialog(id, nome, descrizione, etichetta, idPadre,
		idBusinessFunction, funzione) {
	var titolo;
	$('.form-control').removeAttr("readonly", "readonly");
	$('#id').attr("readonly", "readonly");
	$('#fatherProcess').hide();
	$('#fatherLabel').hide();
	$('#businessProcess').hide();
	$('#processLabel').hide();

	switch (funzione) {

	case "functions":
		titolo = _updatefun;
		$('#currentTab').val("function");
		$('#action').val("uf");
		$('#id').val(id);
		$('#name').val(nome);
		$('#description').val(descrizione);
		$('#label').val(etichetta);
//		$('#label').show();
//		$('#lab').show();
		break;
	case "processes":
		titolo = _updateproc;
		$('#currentTab').val("process");
		$('#action').val("up");
		$('#id').val(id);
		$('#name').val(nome);
		$('#description').val(descrizione);
		$('#label').val(etichetta);
		$('#label').show();
		$('#lab').show();
		break
	case "subprocesses":
		titolo = _updatesubproc;
		$('#currentTab').val("subprocess");
		$('#action').val("usp");
		$('#fatherProcess').show();
		$('#fatherLabel').show();
		$('#fatherProcess').val(idPadre);
		$('#id').val(id);
		$('#name').val(nome);
		$('#description').val(descrizione);
		$('#label').val(etichetta);
//		$('#label').show();
//		$('#lab').show();
		break;
	case "steps":
		titolo = _updatestep;
		$('#currentTab').val("step");
		$('#action').val("us");
		$('#id').val(id);
		$('#name').val(nome);
		$('#description').val(descrizione);
		$('#label').val(etichetta);
		$('#businessProcess').val(idBusinessFunction);
		$('#businessProcess').show();
		$('#processLabel').show();
//		$('#label').hide();
//		$('#lab').hide();

		break;

	default:
		titolo = "";
		break;
	}

	$("#modTitle").text(titolo);

	$('#Update-Dialog').modal('show');

}

function newFunctionDialog(funzione) {
	var titolo;
	$('.form-control').removeAttr("readonly", "readonly");
	$('#id').hide();
	$('#idlab').hide();
	$('#fatherProcess').hide();
	$('#fatherLabel').hide();
	$('#businessProcess').hide();
	$('#processLabel').hide();
	switch (funzione) {

	case "functions":
		titolo = _newfun;
		$('#currentTab').val("function");
		$('#action').val("nf");
		$('#name').val("");
		$('#description').val("");
		$('#label').val("");
//		$('#label').show();
//		$('#lab').show();
		break;
	case "processes":
		titolo = _newproc;
		$('#currentTab').val("process");
		$('#action').val("np");
		$('#name').val("");
		$('#description').val("");
		$('#label').val("");
//		$('#label').show();
//		$('#lab').show();
		break
	case "subprocesses":
		titolo = _newsubproc;
		$('#currentTab').val("subprocess");
		$('#action').val("nsp");
		$('#fatherProcess').val("0");
		$('#fatherProcess').show();
		$('#fatherLabel').show();
		$('#name').val("");
		$('#description').val("");
		$('#label').val("");
//		$('#label').show();
//		$('#lab').show();
		break;
	case "steps":
		titolo = _newstep;
		$('#currentTab').val("step");
		$('#action').val("ns");
		$('#businessProcess').val("0");
		$('#name').val("");
		$('#description').val("");
		$('#businessProcess').show();
		$('#processLabel').show();
//		$('#label').hide();
//		$('#lab').hide();

		break;

	default:
		titolo = "";
		break;
	}

	$("#modTitle").text(titolo);

	$('#Update-Dialog').modal('show');

}

function deleteFunctionDialog(id, nome, descrizione, etichetta, idPadre,
		idBusinessFunction, funzione) {
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
		titolo = _deletefun;
		$('#currentTab').val("function");
		$('#action').val("df");
		$('#id').val(id);
		$('#name').val(nome);
		$('#description').val(descrizione);
		$('#label').val(etichetta);

		break;
	case "processes":
		titolo = _deleteproc;
		$('#currentTab').val("process");
		$('#action').val("dp");
		$('#id').val(id);
		$('#name').val(nome);
		$('#description').val(descrizione);
		$('#label').val(etichetta);

		break
	case "subprocesses":
		titolo = _deletesubproc;
		$('#currentTab').val("subprocess");
		$('#action').val("dsp");
		$('#id').val(id);
		$('#name').val(nome);
		$('#description').val(descrizione);
		$('#label').val(etichetta);

		break;
	case "steps":
		titolo = _deletestep;
		$('#currentTab').val("step");
		$('#action').val("ds");
		$('#id').val(id);
		$('#name').val(nome);
		$('#description').val(descrizione);
		$('#label').hide();
		$('#lab').hide();

		break;

	default:
		titolo = "";
		break;
	}

	$('.form-control').attr("readonly", "readonly");
	$("#modTitle").text(titolo);
	$('#Update-Dialog').modal('show');
}

function setTab(selectedTab) {

	switch (selectedTab) {

	case "function":
		$("#function-tab").attr('class', 'nav-link active');
		$("#functionTab").attr('class', 'tab-pane fade show active');
		$("#process-tab").attr('class', 'nav-link');
		$("#procTab").attr('class', 'tab-pane fade');
		$("#subprocess-tab").attr('class', 'nav-link');
		$("#subprocTab").attr('class', 'tab-pane fade');
		$("#step-tab").attr('class', 'nav-link');
		$("#stepTab").attr('class', 'tab-pane fade');

		break;
	case "process":
		$("#function-tab").attr('class', 'nav-link');
		$("#functionTab").attr('class', 'tab-pane fade');
		$("#process-tab").attr('class', 'nav-link active');
		$("#procTab").attr('class', 'tab-pane fade show active');
		$("#subprocess-tab").attr('class', 'nav-link');
		$("#subprocTab").attr('class', 'tab-pane fade');
		$("#step-tab").attr('class', 'nav-link');
		$("#stepTab").attr('class', 'tab-pane fade');
		break
	case "subprocess":
		$("#function-tab").attr('class', 'nav-link');
		$("#functionTab").attr('class', 'tab-pane fade');
		$("#process-tab").attr('class', 'nav-link');
		$("#procTab").attr('class', 'tab-pane fade');
		$("#subprocess-tab").attr('class', 'nav-link active');
		$("#subprocTab").attr('class', 'tab-pane fade show active');
		$("#step-tab").attr('class', 'nav-link');
		$("#stepTab").attr('class', 'tab-pane fade');
		break;
	case "step":
		$("#function-tab").attr('class', 'nav-link');
		$("#functionTab").attr('class', 'tab-pane fade');
		$("#process-tab").attr('class', 'nav-link');
		$("#procTab").attr('class', 'tab-pane fade');
		$("#subprocess-tab").attr('class', 'nav-link');
		$("#subprocTab").attr('class', 'tab-pane fade');
		$("#step-tab").attr('class', 'nav-link active');
		$("#stepTab").attr('class', 'tab-pane fade show active');

		break;
	default:
		$("#function-tab").attr('class', 'nav-link active');
		$("#functionTab").attr('class', 'tab-pane fade show active');
		$("#process-tab").attr('class', 'nav-link');
		$("#procTab").attr('class', 'tab-pane fade');
		$("#subprocess-tab").attr('class', 'nav-link');
		$("#subprocTab").attr('class', 'tab-pane fade');
		$("#step-tab").attr('class', 'nav-link');
		$("#stepTab").attr('class', 'tab-pane fade');
		break;

	}

}

function checkSelected(value) {

	$("#functionsList > option").each(function() {
		if (this.value == value.id) {

			$(this).prop("selected", true);
			$('.demo').bootstrapDualListbox('refresh')
		}
		;
	});

}
function checkSelectedSteps(value) {

	$("#processesList > option").each(function() {
		if (this.value == value.id) {

			$(this).prop("selected", true);
			$('.demo1').bootstrapDualListbox('refresh')
		}
		;
	});

}

function bindingFunctionDialog(id, nome, descrizione, etichetta, idPadre,
		idBusinessFunction, funzione) {
	var titolo;

	$('.bindingProcessesForm').removeAttr("readonly", "readonly");

	$('#idf').val(id);
	$('#namef').val(nome);
	$('#descriptionf').val(descrizione);
	$('#labelf').val(etichetta);
	$('#currentTabFunctionBinding').val("process");

	$.ajax({
		type : "GET",
		contentType : "application/json",
		url : _ctx + "/rest/design/getProcess/" + id,
		dataType : 'json',
		cache : true,
		success : function(data) {

			$("#functionsList > option").each(function() {
				$(this).prop("selected", false)
			});
			$('.demo').bootstrapDualListbox('refresh');
			data.businessFunctions.forEach(checkSelected);

			$('.form-control').attr("readonly", "readonly");
			$('.filter').removeAttr("readonly", "readonly");

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

function bindingProcessDialog(id, nome, descrizione, etichetta, idPadre,
		idBusinessFunction, funzione) {
	var titolo;

	$('.bindingFunctionsForm').removeAttr("readonly", "readonly");

	$('#idp').val(id);
	$('#namep').val(nome);
	$('#descriptionp').val(descrizione);
	$('#labelp').val(etichetta);
	$('#currentTabProcessBinding').val("step");

	$.ajax({
		type : "GET",
		contentType : "application/json",
		url : _ctx + "/rest/design/getStep/" + id,
		dataType : 'json',
		cache : true,
		success : function(data) {

			$("#processesList > option").each(function() {
				$(this).prop("selected", false)
			});
			$('.demo1').bootstrapDualListbox('refresh');
			data.businessProcesses.forEach(checkSelectedSteps);

			$('.form-control').attr("readonly", "readonly");
			$('.filter').removeAttr("readonly", "readonly");

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

function playAction() {

	switch ($('#action').val()) {

	case "nsp":
		if ($('#fatherProcess').val() != "0") {
			$("#dialog").submit();
		} else {
			alert(_alertSelFatherProcess);

		}

		break;
	case "ns":
		if ($('#businessProcess').val() != "0") {
			$("#dialog").submit();
		} else {
			alert(_alertSelBusinessProcess);

		}
		break;
	default:
		$("#dialog").submit();
		break;
	}

}

function playBindingProcesses() {

	$("#bindingProcessesForm").submit();

}

function playBindingFunctions() {

	$("#bindingFunctionsForm").submit();
}

$(document).ready(function() {
	var demo = $('select[name="duallistbox_demo[]"]').bootstrapDualListbox({
		nonSelectedListLabel : 'Non-selected',
		selectedListLabel : 'Selected',
		preserveSelectionOnMove : 'moved',
		moveOnSelect : false,
		nonSelectedFilter : ''

	});
	var demo1 = $('select[name="duallistbox_demo1[]"]').bootstrapDualListbox({
		nonSelectedListLabel : 'Non-selected',
		selectedListLabel : 'Selected',
		preserveSelectionOnMove : 'moved',
		moveOnSelect : false,
		nonSelectedFilter : ''

	});

	$('.treeview-animated').mdbTreeview();

	$("#function-tab").click(function(e) {
		$('#currentTab').val("function");
		$('#currentTabFunctionBinding').val("function");
		$('#currentTabProcessBinding').val("function");
	});
	$("#process-tab").click(function(e) {
		$('#currentTab').val("process");
		$('#currentTabFunctionBinding').val("process");
		$('#currentTabProcessBinding').val("process");
	});
	$("#subprocess-tab").click(function(e) {
		$('#currentTab').val("subprocess");
		$('#currentTabFunctionBinding').val("subprocess");
		$('#currentTabProcessBinding').val("subprocess");

	});
	$("#step-tab").click(function(e) {
		$('#currentTab').val("step");
		$('#currentTabFunctionBinding').val("step");
		$('#currentTabProcessBinding').val("step");
	});

	setTab(_selectedTab);

});
