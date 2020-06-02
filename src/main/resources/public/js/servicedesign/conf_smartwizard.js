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

	
	showWizard();
	  
	  
	  
	  
	  // Carica le combo gsbpm
	/*loadParentGsbpmProcess();
	$("#preparing-select-js-parent").change(function() {
		var sel_process = $("#select-gsbpm-1 :selected").val();
		loadSubGsbpmProcess();
	});*/
	
	
	
	
	
	
	
	
});
function showWizard(){
	
	var current_fs, next_fs, previous_fs; //fieldsets
	var opacity;

	$(".next").click(function(){

	current_fs = $(this).parent();
	next_fs = $(this).parent().next();

	//Add Class Active
	$("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

	//show the next fieldset
	next_fs.show();
	//hide the current fieldset with style
	current_fs.animate({opacity: 0}, {
	step: function(now) {
	// for making fielset appear animation
	opacity = 1 - now;

	current_fs.css({
	'display': 'none',
	'position': 'relative'
	});
	next_fs.css({'opacity': opacity});
	},
	duration: 600
	});
	});

	$(".previous").click(function(){

	current_fs = $(this).parent();
	previous_fs = $(this).parent().prev();

	//Remove class active
	$("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

	//show the previous fieldset
	previous_fs.show();

	//hide the current fieldset with style
	current_fs.animate({opacity: 0}, {
	step: function(now) {
	// for making fielset appear animation
	opacity = 1 - now;

	current_fs.css({
	'display': 'none',
	'position': 'relative'
	});
	previous_fs.css({'opacity': opacity});
	},
	duration: 600
	});
	});

	$('.radio-group .radio').click(function(){
	$(this).parent().find('.radio').removeClass('selected');
	$(this).addClass('selected');
	});

	$(".submit").click(function(){
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
							+ "<select name='gsbpmid' id='select-gsbpm-1' title='Processo gsbpm' class='form-control'>";

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
function execute_switch(stepIndex){
	switch (stepIndex) {
		case 1:
			
			alert("tab 1");
		
		break;
		case 2:
			
			alert("tab 2");
		
		break;
		case 3:
			
			alert("tab 3");
		
		break;
	}
}

