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
	
	
	$("#btn-submit-as").keydown(function(event) {
		if (event.which == 13) {
			check_and_send_as_req();
		}
	});
	$("#btn-submit-as").click(function() {
		check_and_send_as_req();
	});
	
	$("#btn-submit-as-upd").click(function() {
		check_and_send_upd_as_req();
	});
});

function check_and_send_as_req() {	
	var asname = $('#as-name').val();
	if (asname.length < 1) {
		$("#as-name-error").text(_mandatory_name_field);
	} else {
		$("#as-form").submit();
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