/**
 * Copyright 2020 ISTAT
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

$(document).ready(function() {

	$("body").on("change", $("#REDUCTION-METHOD"), function(event) {
		selectMethod($("#REDUCTION-METHOD :selected").text());
	});

	
});

var addRow = {
	"title" : "Add Row",
	"click" : function() {
		var value = this.getValue();
		value.push({});
		this.setValue(value);
	}
};

var removeRow = {
	"title" : "Remove Row",
	"click" : function() {
		var value = this.getValue();
		if (value.length > 0) {
			value.pop();
			this.setValue(value);
		}
	}
};

function selectMethod(value) {

	$("div[data-alpaca-container-item-name='REDUCTION-METHOD']").siblings().hide();

	$("div[data-alpaca-container-item-name='" + value + "']").show();
	$("div[data-alpaca-field-name='" + value + "']").show();
}

function reduction() {

//var method=	 $("#"+paramDialog+"-parametri-workset-modal").alpaca().getValue()["REDUCTION-METHOD"];
//if(method) $("#REDUCTION-METHOD").val(method);
$("#REDUCTION-METHOD").change();
}
