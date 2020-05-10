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

	$("#select-gsbpm-1-div").change(function() {
		var sel_process = $("#select-gsbpm-1 :selected").val();
		loadSubGsbpmProcess();
	});
	$("#btn-submit-bs").click(function() {
		check_and_send_req();
	});
	$("#btn-submit-bs").keydown(function(event) {
		if (event.which == 13) {
			check_and_send_req();
		}
	});
});

function check_and_send_req() {		
	var bsname = $('#bs-name').val();
	if (bsname.length < 1) {
		$("#bs-name-error").text(_mandatory_name_field);
	} else {
		$("#bs-form").submit();
	}
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