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

	// Carica le combo
	loadParentGsbpmProcess();
	loadBusinessServices();
	loadAppServices();
	$("#preparing-select-js-parent").change(function() {
		var sel_process = $("#select-gsbpm-1 :selected").val();
		loadSubGsbpmProcess();
	});

	$(".next").click(function() {
		// selservice = 0: bservice, = 1: appservice, = 2: stepinstance, = 3:
		// end
		next_fs = $(this).parent().next();
		var x = false;
		var ajaxError = false;
		$("#selservice").val($("fieldset").index(next_fs));
		// onclick
		execute_switch($("#selservice").val());

	});
	// onload

	showWizard();
	$("#msform").submit(function(e) {
		e.preventDefault(); // avoid to execute the actual submit of the form.

		var form = $(this);
		var url = form.attr('action');		

		$.ajax({
			type : "POST",
			url : url,
			data : form.serialize(), // serializes the form's elements.
			success : function(data) {
				// customize success message
			},
			error : function(jqXHR, textStatus, errorThrown) {
				// customize failure message
			}
		});
	});

});

function showWizard() {

	var current_fs, next_fs, previous_fs; // fieldsets
	var opacity;

	$(".next").click(
			function() {

				current_fs = $(this).parent();
				next_fs = $(this).parent().next();

				// check input errrors before proceed
				var inputError = $("#inputerror").val();
				if (inputError != "1") {
					// alert(inputError);
					// Add Class Active
					$("#progressbar li").eq($("fieldset").index(next_fs))
							.addClass("active");
					// show the next fieldset
					next_fs.show();
					// hide the current fieldset with style
					current_fs.animate({
						opacity : 0
					}, {
						step : function(now) {
							// for making fielset appear animation
							opacity = 1 - now;

							current_fs.css({
								'display' : 'none',
								'position' : 'relative'
							});
							next_fs.css({
								'opacity' : opacity
							});
						},
						duration : 600
					});

				} else {
					// alert(inputError);
				}
			});

	$(".previous").click(
			function() {

				current_fs = $(this).parent();
				previous_fs = $(this).parent().prev();

				// Remove class active
				$("#progressbar li").eq($("fieldset").index(current_fs))
						.removeClass("active");

				// show the previous fieldset
				previous_fs.show();

				// hide the current fieldset with style
				current_fs.animate({
					opacity : 0
				}, {
					step : function(now) {
						// for making fielset appear animation
						opacity = 1 - now;

						current_fs.css({
							'display' : 'none',
							'position' : 'relative'
						});
						previous_fs.css({
							'opacity' : opacity
						});
					},
					duration : 600
				});
			});

	$('.radio-group .radio').click(function() {
		$(this).parent().find('.radio').removeClass('selected');
		$(this).addClass('selected');
	});

	$(".submit").click(function() {
		return false;
	})
}
function loadParentGsbpmProcess() {
	$
			.ajax({
				url : _ctx + "/loadGsbpmParentProcess",
				type : "GET",
				dataType : "JSON",
				success : function(data) {
					var content = "<div class='form-group' id='select-gsbpm-1-div'>"
							+ "<label class='control-label'>Processo gsbpm</label> "
							+ "<select name='gsbpmidparent' id='select-gsbpm-1' title='Processo gsbpm' class='form-control'>";

					"<div class='col-lg-4'><label class='control-label'>"
							+ "<span id='step'>Business Steps:</span></label></div><div class='col-lg-8'>"
							+ "<select id='sel_step' name='step' class='form-control'>";

					$(jQuery.parseJSON(JSON.stringify(data))).each(
							function() {

								var id = this.id;
								var name = this.name;
								content += "<option value='" + id + "'>" + name
										+ "</option>";
							});

					content += "</select><span class='help-block'></span></div>";
					$("#preparing-select-js-parent").html(content);
					loadSubGsbpmProcess();

				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert('Error loading data');
				}
			});
}
function loadSubGsbpmProcess() {
	var id_process = $("#select-gsbpm-1 :selected").val();
	$
			.ajax({
				url : _ctx + "/loadGsbpmSubProcess/" + id_process,
				type : "GET",
				dataType : "JSON",
				success : function(data) {
					var content = "<div class='form-group' id='select-gsbpm-2-div'>"
							+ "<label class='control-label'>Processo gsbpm</label> "
							+ "<select name='gsbpmid' id='select-gsbpm-2' title='Processo gsbpm' class='form-control'>";

					"<div class='col-lg-4'><label class='control-label'>"
							+ "<span id='step'>Business Steps:</span></label></div><div class='col-lg-8'>"
							+ "<select id='sel_step' name='step' class='form-control'>";

					$(jQuery.parseJSON(JSON.stringify(data))).each(
							function() {

								var id = this.id;
								var name = this.name;
								content += "<option value='" + id + "'>" + name
										+ "</option>";
							});

					content += "</select><span class='help-block'></span></div>";
					$("#preparing-select-js").html(content);

				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert('Error loading data');
				}
			});
}
function loadBusinessServices() {
	$
			.ajax({
				url : _ctx + "/loadbusinessservices",
				type : "GET",
				dataType : "JSON",
				success : function(data) {
					var content = "<div class='form-group' id='select-bservice-div'>"
							+ "<label class='control-label'>Associa Business Service</label> "
							+ "<select name='bsid' id='select-bserv' title='Business service' class='form-control'>";

					"<div class='col-lg-4'><label class='control-label'>"
							+ "<span id='bserv'>Business Service:</span></label></div><div class='col-lg-8'>"
							+ "<select id='sel_bserv' name='bserv' class='form-control'>";

					$(jQuery.parseJSON(JSON.stringify(data))).each(
							function() {

								var id = this.id;
								var name = this.name;
								content += "<option value='" + id + "'>" + name
										+ "</option>";
							});

					content += "</select><span class='help-block'></span></div>";
					$("#select-bservice-div").html(content);

				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert('Error loading data');
				}
			});
}
function loadAppServices() {
	$
			.ajax({
				url : _ctx + "/loadapplicationservices",
				type : "GET",
				dataType : "JSON",
				success : function(data) {
					var content = "<div class='form-group' id='select-appservice-div'>"
							+ "<label class='control-label'>Associa Application Service</label> "
							+ "<select name='appid' id='select-appserv' title='Application service' class='form-control'>";

					"<div class='col-lg-4'><label class='control-label'>"
							+ "<span id='bserv'>Application Service:</span></label></div><div class='col-lg-8'>"
							+ "<select id='sel_appserv' name='appserv' class='form-control'>";

					$(jQuery.parseJSON(JSON.stringify(data))).each(
							function() {

								var id = this.id;
								var name = this.name;
								content += "<option value='" + id + "'>" + name
										+ "</option>";
							});

					content += "</select><span class='help-block'></span></div>";
					$("#select-appservice-div").html(content);

				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert('Error loading data');
				}
			});
}
function saveAllData() {
	
}

function validate_bs_and_send_req() {
	var bsname = $('#bs-name').val();
	if (bsname.length < 1) {
		$("#bs-name-error").text(_mandatory_name_field);
		$("#inputerror").val(1);
	} else {
		$("#inputerror").val(0);
		// $("#bs-form").submit();
	}
}
function validate_as_and_send_req() {
	var asname = $('#as-name').val();
	if (asname.length < 1) {
		$("#as-name-error").text(_mandatory_name_field);
		$("#inputerror").val(1);
	} else {
		// $("#as-form").submit();
		$("#inputerror").val(0);
	}
}
function validate_si_and_send_req() {
	var method = $('#si-method').val();
	if (method.length < 1) {
		$("#si-method-error").text(_mandatory_method_field);
		$("#inputerror").val(1);
	} else {
		$("#msform").submit();
		$("#inputerror").val(0);	
	}
}
function execute_switch(stepIndex) {
	switch (stepIndex * 1) {

	case 0:

		// alert("tab 1");

		break;
	case 1:
		// alert($("#selservice").val());
		// velidate fields bservice
		validate_bs_and_send_req();
		// alert("tab 2");

		break;
	case 2:
		// alert($("#selservice").val());
		validate_as_and_send_req();
		// alert("tab 3");

		break;
	case 3:
		// alert($("#selservice").val());
		validate_si_and_send_req();

		break;
	}
}