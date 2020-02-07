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


function updateFunctionDialog(idDataset, nomeFile, pluto, paperino, zio) {
   var titolo;
	switch (zio) {
	case "functions":
		titolo=_updatefun;
		break;
	case "processes":
		titolo=_updateproc;
		break
	case "subprocesses":
		titolo=_updatesubproc;
		break;
	case "steps":
		titolo=_updatestep;
		break;

	default:
		titolo="";
		break;
	}
	
	
	$("#modTitle").text(titolo);

    $('#Update-Dialog').modal('show');
  
    
}
function deleteFunctionDialog(ide, ids, op, paperino, zio) {
	var titolo;
	switch (zio) {
	case "functions":
		titolo=_deletefun;
		break;
	case "processes":
		titolo=_deleteproc;
		break
	case "subprocesses":
		titolo=_deletesubproc;
		break;
	case "steps":
		titolo=_deletestep;
		break;

	default:
		titolo="";
		break;
	}
	
	
	$("#delTitle").text(titolo);
    $('#Delete-Dialog').modal('show');
}
$(document).ready(function () {
   

});






