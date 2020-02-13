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
        var params = "noparams";
        function toFixed(num, fixed) {
        var ret = num;
                try {
                var re = new RegExp('^-?\\d+(?:\.\\d{0,' + (fixed || - 1) + '})?');
                        ret = num.toString().match(re)[0];
                } catch (err) {
        }
        return ret;
                }
var table = null;
        
$(document).ready(function () {

    setMenuActive("elaborazione");
    table = $("#worksetTab").DataTable({
        "aoColumnDefs": [{
            "aTargets": ['_all'],
            "mRender": function (data, type, full) {
                return '<span role="button" title="' + data + '">' +data  + '</span>';
            //    return '<span role="button" title="' + data + '">' + toFixed(data,10) + '</span>';
            }
        }],
        drawCallback: function () {
            $(".loading").hide();
        },
        dom: "<'row'<'col-sm-5'B>>" +
             "<'row'<'col-sm-12'tr>>" +
             "<'row'<'col-sm-5'i><'col-sm-7'p>>",
        autoWidth: false,
        responsive: true,
        ordering: false,
        searching: false,
        pageLength: 20,
        processing: true,
        serverSide: true,
        ajax: _ctx + "/rest/ws/worksetvalori/" + _idElaborazione + "/" + _tipoCampo + "/" + _roleGroup + "/"+ getParams(),
        columns: eval(getHeaders('worksetTab')),
        buttons: [{
            extend: 'colvis',
            text: 'Seleziona colonne',
            className: 'btn-light'
        },
        {
            extend: 'csvHtml5',
            filename: 'download',
            title: 'download',
            className: 'btn-light',
            action: function (e, dt, node, config) {
                scaricaWorkSet(e, 'csv', _idElaborazione);
            }
        }]
    });
    if ($(".param-filter").length == 0) {
        $("#btn_filtri_cerca").hide();
        $("#no_filters_msg").text("Non ci sono filtri di ricerca impostati.");
    }
 
    
});
        
function getParams() {

    var params = "";
    var inputs = $(".param-filter");
    var y = 0;
    var z = 0;
    for (var i = 0; i < inputs.length; i++) {
        var valore = inputs[i].value;
        if (valore != "") {
            // Controlla e non aggiunge l'& dopo l'ultimo elemento
            if (y > z) {
                z++;
                params += "&";
            }
        params += inputs[i].id + "=" + inputs[i].value;
        y++;
        }
    }

    if (params == "") {
        params = "noparams";
    }

    return params;
}

function ricercaByParams() {
    //table.ajax.reload();
    table.ajax.url(_ctx + "/rest/ws/worksetvalori/" + _idElaborazione + "/"+ _tipoCampo + "/"+ _roleGroup + "/" + getParams()).load();
        return false;
}

function getHeaders(tab) {
    var text = '[';
    $("#" + tab + " tr:first th").map(function () {
        text += '{"data": "' + $(this).text() + '"},';
    });
    if (text.length > 1) text = text.substring(0, text.length - 1);
    text += ']';
    return text;
}

function getHeadersComplex(tab) {
    var text = '[';
    $("#" + tab + " th").map(function () {
        text += '{"data": "' + $(this).text() + '"},';
    });
    if (text.length > 1) text = text.substring(0, text.length - 1);
    text += ']';
    return text;
}

function scaricaWorkSet(e, param, idelab) {
    e.preventDefault();
    window.location = _ctx + '/rest/ws/download/workset/' + param + '/' + idelab+'/'+_roleGroup;
}

function getDynamicSchema(data) {
	var text = "{\"properties\":{ ";
	Object.keys(data).forEach(function(key) {
		text += "\"" + key + "\": {\"title\":\"" + key + "\"},";
	});
	text = text.substring(0, text.length - 1);
	text += "}}";
    return  JSON.parse(text);
}


function viewParamsAlpacaTemplate(identifier) {
	var indexParam = $(identifier).data('index-param');
	var nameParameter = $(identifier).data('name-workset');
	$('#param-text-edit').text(nameParameter);
	var jsontemplate = $(identifier).data('param-template');
	var data = $(identifier).data('value-param');
	if (!data)
		data = "";
	var schema = "";
	var options = "{\"type\" : \"object\"}";
	if (jsontemplate != undefined) {
		schema = jsontemplate["schema"];
		options = JSON.stringify(jsontemplate["options"]);
	} else {
		schema=getDynamicSchema(data);
	}
	 console.log(schema);
	var schemaJson=JSON.stringify(schema);
	
	var dataContent = "{\"data\":" + JSON.stringify(data) + ",\"schema\":"
			+ schemaJson + ",\"options\":" + options
  		+ ",\"view\":\"bootstrap-display\"}";


	var jsonObj = JSON.parse(dataContent);

	$('#view-param-'+indexParam).empty();
 	$('#view-param-'+indexParam).alpaca(jsonObj);
}

