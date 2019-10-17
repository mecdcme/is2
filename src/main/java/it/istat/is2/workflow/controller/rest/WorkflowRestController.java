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
package it.istat.is2.workflow.controller.rest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import it.istat.is2.app.bean.AssociazioneVarRoleBean;
import it.istat.is2.app.bean.Ruolo;
import it.istat.is2.app.bean.Variable;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.Utility;
import it.istat.is2.workflow.domain.BusinessProcess;
import it.istat.is2.workflow.domain.BusinessStep;
import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.StepVariable;
import it.istat.is2.workflow.service.BusinessProcessService;
import it.istat.is2.workflow.service.BusinessStepService;
import it.istat.is2.workflow.service.StepVariableService;
import it.istat.is2.workflow.service.WorkflowService;

@RequestMapping("/rest/ws")
@RestController
public class WorkflowRestController {

    @Autowired
    private WorkflowService workflowService;
    @Autowired
    private BusinessProcessService businessProcessService;
    @Autowired
    private BusinessStepService businessStepService;
    @Autowired
    StepVariableService stepVariableService;
    @Autowired
	private NotificationService notificationService;

    @RequestMapping(value = "/worksetvalori/{idelaborazione}/{tipoCampo}/{groupRole}/{paramsFilter:.+}", method = RequestMethod.GET)
    public String loadDatasetValoriWorkset(HttpServletRequest request, Model model,
            @PathVariable("idelaborazione") Long idelaborazione, @PathVariable("tipoCampo") Integer tipoCampo,@PathVariable("groupRole") Integer groupRole,
            @PathVariable("paramsFilter") String paramsFilter, @RequestParam("length") Integer length,
            @RequestParam("start") Integer start, @RequestParam("draw") Integer draw) throws IOException, JSONException {

        HashMap<String, String> parameters = null;
        String noparams = "noparams";
        if (!noparams.equals(paramsFilter)) {
            StringTokenizer st = new StringTokenizer(paramsFilter, "&");
            StringTokenizer st2 = null;
            parameters = new HashMap<String, String>();
            ArrayList<String> nomeValore = null;
            while (st.hasMoreTokens()) {
                st2 = new StringTokenizer(st.nextToken(), "=");
                nomeValore = new ArrayList<String>();
                while (st2.hasMoreTokens()) {
                    nomeValore.add(st2.nextToken());
                }
                parameters.put(nomeValore.get(0), nomeValore.get(1));
            }
        }
        String dtb = workflowService.loadWorkSetValoriByElaborazione(idelaborazione, tipoCampo,groupRole, length, start, draw, parameters);

        return dtb;
    }

    @RequestMapping(value = "/loadBProcess/{idfunction}", method = RequestMethod.GET)
    public List<BusinessProcess> loadComboBProcess(HttpServletRequest request, Model model,
            @PathVariable("idfunction") Long idfunction) throws IOException {

        List<BusinessProcess> listaProcess = businessProcessService.findBProcessByIdFunction(idfunction);

        return listaProcess;
    }

    @RequestMapping(value = "/loadBSteps/{idprocess}", method = RequestMethod.GET)
    public List<BusinessStep> loadComboBSteps(HttpServletRequest request, Model model,
            @PathVariable("idprocess") Long idprocess) throws IOException {

        List<BusinessStep> listaBStep = businessStepService.findBStepByIdProcess(idprocess);

        return listaBStep;
    }

    @RequestMapping(value = "/loadVarsByStep/{idelab}/{idstep}", method = RequestMethod.GET)
    public List<StepVariable> loadVarsByStep(HttpServletRequest request, Model model,
            @PathVariable("idelab") Long idelab, @PathVariable("idstep") Integer idstep) throws IOException {

        List<StepVariable> listaVarAssociate = stepVariableService.findBStepByIdProcess(idelab, idstep);

        return listaVarAssociate;
    }

    @RequestMapping(value = "/download/workset/{tipoFile}/{idelab}/{groupRole}", method = RequestMethod.GET)
    public void downloadWorkset(HttpServletRequest request, HttpServletResponse response,
            @PathVariable("tipoFile") String tipoFile, @PathVariable("idelab") Long idelab,@PathVariable("groupRole") Integer groupRole) throws Exception {

        String fileName = "";
        String contentType = "";
        switch (tipoFile) {
            case "csv":
                fileName = "workset.csv";
                contentType = "text/csv";
                break;
            case "pdf":
                fileName = "workset.pdf";
                contentType = "application/pdf";
                break;
            case "excel":
                fileName = "workset.xlsx";
                contentType = "application/vnd.ms-excel";
                break;
        }

        response.setHeader("charset", "utf-8");
        response.setHeader("Content-Type", contentType);
        response.setHeader("Content-disposition", "attachment; filename=" + fileName);
        Map<String, List<String>> dataMap = workflowService.loadWorkSetValoriByElaborazioneRoleGroupMap(idelab,groupRole);
        Utility.writeObjectToCSV(response.getWriter(), dataMap);
    }

    @RequestMapping(value = "/updaterowlist", method = RequestMethod.POST)
    public String updateOrdineRighe(HttpServletRequest request, Model model,
            @RequestParam("ordineIds") String ordineIds) throws IOException {

        StringTokenizer stringTokenizerElements = new StringTokenizer(ordineIds, "|");
        String element = null;
        String ordine = null;
        String idstepvar = null;
        StepVariable stepVariable = new StepVariable();
        while (stringTokenizerElements.hasMoreElements()) {
            element = stringTokenizerElements.nextElement().toString();
            StringTokenizer stringTokenizerValues = new StringTokenizer(element, "=");
            while (stringTokenizerValues.hasMoreElements()) {
                ordine = stringTokenizerValues.nextElement().toString();
                idstepvar = stringTokenizerValues.nextElement().toString();
            }
            Integer idstep =Integer.parseInt(idstepvar);
            Short ordineS = Short.parseShort(ordine);
            stepVariable = stepVariableService.findById(idstep).get();
            stepVariable.setOrdine(ordineS);
            stepVariableService.updateStepVar(stepVariable);
        }

        return "success";
    }

    @PostMapping(value = "/associaVariabiliRuolo")
    public void associaVariabiliRuolo(HttpServletResponse response, Model model, @RequestBody AssociazioneVarRoleBean[] associazioneVarRoleBean) throws IOException {
   		Elaborazione elaborazione = workflowService.findElaborazione(associazioneVarRoleBean[0].getIdElaborazione());
   		workflowService.creaAssociazionVarRole(elaborazione,associazioneVarRoleBean);	
   		notificationService.addInfoMessage("Associazione variabile-ruolo completata");
   	}

}
