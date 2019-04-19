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
package it.istat.rservice.workflow.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import org.rosuda.REngine.REngineException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import it.istat.rservice.app.bean.AssociazioneVarFormBean;
import it.istat.rservice.app.bean.SessionBean;
import it.istat.rservice.app.domain.Elaborazione;
import it.istat.rservice.app.domain.SessioneLavoro;
import it.istat.rservice.app.domain.User;
import it.istat.rservice.app.service.ElaborazioneService;
import it.istat.rservice.app.service.NotificationService;
import it.istat.rservice.app.service.SessioneLavoroService;
import it.istat.rservice.app.util.IS2Const;
import it.istat.rservice.app.util.Utility;
import it.istat.rservice.dataset.domain.DatasetColonna;
import it.istat.rservice.dataset.domain.DatasetFile;
import it.istat.rservice.dataset.service.DatasetService;
import it.istat.rservice.workflow.domain.SXTipoCampo;
import it.istat.rservice.workflow.domain.SxBusinessFunction;
import it.istat.rservice.workflow.domain.SxBusinessProcess;
import it.istat.rservice.workflow.domain.SxParPattern;
import it.istat.rservice.workflow.domain.SxRuoli;
import it.istat.rservice.workflow.domain.SxStepVariable;
import it.istat.rservice.workflow.domain.SxTipoVar;
import it.istat.rservice.workflow.domain.SxWorkset;
import it.istat.rservice.workflow.service.BusinessFunctionService;
import it.istat.rservice.workflow.service.StepVariableService;
import it.istat.rservice.workflow.service.WorkflowService;

@RequestMapping("/ws")
@Controller
public class WorkflowController {

    @Autowired
    private WorkflowService workflowService;
    @Autowired
    private NotificationService notificationService;
    @Autowired
    private MessageSource messages;
    @Autowired
    private SessioneLavoroService sessioneLavoroService;
    @Autowired
    private ElaborazioneService elaborazioneService;
    @Autowired
    private BusinessFunctionService businessFunctionService;
    @Autowired
    private DatasetService datasetService;
    @Autowired
    private StepVariableService stepVariableService;

    @GetMapping(value = "/home/{id}")
    public String homeWS(HttpSession session, Model model, @PathVariable("id") Long id) {
        notificationService.removeAllMessages();

        Elaborazione elaborazione = workflowService.findElaborazione(id);
        List<SxBusinessProcess> listaBp = elaborazione.getSxBusinessFunction().getSxBusinessProcesses();
        SxBusinessProcess bProcess = listaBp.get(0);
        List<SxStepVariable> listaSV = workflowService.getSxStepVariablesNoValori(elaborazione.getId(),
                new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
        model.addAttribute("stepVList", listaSV);

        SessionBean elaSession = new SessionBean(elaborazione.getId().toString(), elaborazione.getNome());
        session.setAttribute(IS2Const.SESSION_ELABORAZIONE, elaSession);

        model.addAttribute("bProcess", bProcess);
        model.addAttribute("elaborazione", elaborazione);
        model.addAttribute(IS2Const.LISTA_BUSINESS_PROCESS, listaBp);

        return "elaborazione/homeelaborazione";
    }

    @GetMapping(value = "/eliminaAssociazione/{idelaborazione}/{idvar}")
    public String eliminaAssociazioneVar(HttpSession session, Model model, @PathVariable("idelaborazione") Long idelaborazione, @PathVariable("idvar") Long idvar) {
        notificationService.removeAllMessages();

        SxStepVariable stepVar = stepVariableService.findById(idvar);
        List<SxStepVariable> listaVars = stepVar.getSxWorkset().getSxStepVariables();

        if (listaVars.size() == 1) {
            SxWorkset workset = (SxWorkset) listaVars.get(0).getSxWorkset();
            workflowService.deleteWorkset(workset);
        } else {
            //do nothing
        }

        stepVariableService.removeStepVarById(idvar);
        notificationService.addInfoMessage("La variabile è stata rimossa");

        return "redirect:/ws/editworkingset/" + idelaborazione;
    }

    @GetMapping(value = "/eliminaParametro/{idelaborazione}/{idparametro}")
    public String eliminaParametro(HttpSession session, Model model, @PathVariable("idelaborazione") Long idelaborazione, @PathVariable("idparametro") Long idparametro) {
        notificationService.removeAllMessages();

        SxStepVariable stepVar = stepVariableService.findById(idparametro);
        List<SxStepVariable> listaVars = stepVar.getSxWorkset().getSxStepVariables();

        if (listaVars.size() == 1) {
            SxWorkset workset = (SxWorkset) listaVars.get(0).getSxWorkset();
            workflowService.deleteWorkset(workset);
        } else {
            //do nothing
        }

        stepVariableService.removeStepVarById(idparametro);
        notificationService.addInfoMessage("Il parametro è stato eliminato");

        return "redirect:/ws/editworkingset/" + idelaborazione;
    }

    @GetMapping(value = "/editworkingset/{idelaborazione}")
    public String editWorkingSet(HttpSession session, Model model, @PathVariable("idelaborazione") Long idElaborazione) {
        session.setAttribute(IS2Const.WORKINGSET, "workingset");

        Elaborazione elaborazione = elaborazioneService.findElaborazione(idElaborazione);

        SessionBean elaSession = new SessionBean(elaborazione.getId().toString(), elaborazione.getNome());
        session.setAttribute(IS2Const.SESSION_ELABORAZIONE, elaSession);

        List<DatasetFile> datasetfiles = datasetService.findDatasetFilesByIdSessioneLavoro(elaborazione.getSessioneLavoro().getId());
         DatasetFile datasetfile =datasetfiles.get(0);
        model.addAttribute("idfile", datasetfile.getId());

        List<DatasetColonna> colonne = datasetService.findAllNomeColonne(datasetfile);
        List<SxStepVariable> listaSV = workflowService.getSxStepVariablesNoValori(idElaborazione, new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
        List<SxStepVariable> listaSP = workflowService.getSxStepVariablesParametri(idElaborazione);
        List<SxBusinessFunction> listaFunzioni = businessFunctionService.findBFunctions();

        SxBusinessFunction businessFunction = elaborazione.getSxBusinessFunction();

        // Carica i Ruoli di input
        List<SxRuoli> listaRuoliInput = workflowService.findRuoliByFunction(businessFunction, 0);
        // Carica i Ruoli di input e output
        List<SxRuoli> listaRuoliInOut = workflowService.findRuoliByFunction(businessFunction, 1);
        List<SxParPattern> listaParametri = workflowService.findParametriByFunction(businessFunction);
        List<SxBusinessProcess> listaBp = elaborazione.getSxBusinessFunction().getSxBusinessProcesses();

        model.addAttribute("bProcess", listaBp);
        model.addAttribute(IS2Const.LISTA_BUSINESS_PROCESS, listaBp);
        model.addAttribute("stepVList", listaSV);

        ArrayList<String> listaNomiSV = new ArrayList<String>();
        for (int i = 0; i < listaSV.size(); i++) {
            String nomeStepVariable = listaSV.get(i).getSxWorkset().getNome();
            listaNomiSV.add(nomeStepVariable);
            for (int y = 0; y < colonne.size(); y++) {
                String nomeCol = colonne.get(y).getNome();
                if (listaNomiSV.contains(nomeCol)) {
                    colonne.remove(colonne.get(y));
                }
            }
        }

        model.addAttribute("stepParamList", listaSP);
        model.addAttribute("colonne", colonne);
        model.addAttribute("listaRuoliInput", listaRuoliInput);
        model.addAttribute("listaRuoliInOut", listaRuoliInOut);
        model.addAttribute("listaParametri", listaParametri);
        model.addAttribute("listaFunzioni", listaFunzioni);
        model.addAttribute("datasetfile", datasetfile);
        model.addAttribute("elaborazione", elaborazione);
        model.addAttribute("businessFunction", businessFunction);

        return "elaborazione/edit_ws";

    }
    @GetMapping(value = "/newworkingset/{idelaborazione}")
    public String createWorkingSet(HttpSession session, Model model, @PathVariable("idelaborazione") Long idElaborazione) {
        session.setAttribute(IS2Const.WORKINGSET, "workingset");

        Elaborazione elaborazione = elaborazioneService.findElaborazione(idElaborazione);

        SessionBean elaSession = new SessionBean(elaborazione.getId().toString(), elaborazione.getNome());
        session.setAttribute(IS2Const.SESSION_ELABORAZIONE, elaSession);

        List<DatasetFile> datasetfiles = datasetService.findDatasetFilesByIdSessioneLavoro(elaborazione.getSessioneLavoro().getId());
         
        
        datasetfiles.forEach(datasetfile->{
        	//retrieve DatasetColonna without data
        	List<DatasetColonna> colonne = datasetService.findAllNomeColonne(datasetfile);
        	datasetfile.setColonne(colonne);
        	
        });
        
    
        List<SxStepVariable> listaSV = workflowService.getSxStepVariablesNoValori(idElaborazione, new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
        List<SxStepVariable> listaSP = workflowService.getSxStepVariablesParametri(idElaborazione);
        List<SxBusinessFunction> listaFunzioni = businessFunctionService.findBFunctions();

        SxBusinessFunction businessFunction = elaborazione.getSxBusinessFunction();

        // Carica i Ruoli di input
        List<SxRuoli> listaRuoliInput = workflowService.findRuoliByFunction(businessFunction, 0);
        // Carica i Ruoli di input e output
        List<SxRuoli> listaRuoliInOut = workflowService.findRuoliByFunction(businessFunction, 1);
        List<SxParPattern> listaParametri = workflowService.findParametriByFunction(businessFunction);
        List<SxBusinessProcess> listaBp = elaborazione.getSxBusinessFunction().getSxBusinessProcesses();

        model.addAttribute("bProcess", listaBp);
        model.addAttribute(IS2Const.LISTA_BUSINESS_PROCESS, listaBp);
        model.addAttribute("stepVList", listaSV);

       

        model.addAttribute("stepParamList", listaSP);
     
        model.addAttribute("listaRuoliInput", listaRuoliInput);
        model.addAttribute("listaRuoliInOut", listaRuoliInOut);
        model.addAttribute("listaParametri", listaParametri);
        model.addAttribute("listaFunzioni", listaFunzioni);
        model.addAttribute("datasetfiles", datasetfiles);
        model.addAttribute("elaborazione", elaborazione);
        model.addAttribute("businessFunction", businessFunction);

        return "elaborazione/new_ws";

    }
    @GetMapping(value = "/dataview/{idelab}/{tipoCampo}")
    public String viewDataProc(HttpSession session, Model model, @PathVariable("idelab") Long idelaborazione, @PathVariable("tipoCampo") Integer tipoCampo) {
        notificationService.removeAllMessages();

        SXTipoCampo sxTipoCampo = new SXTipoCampo();
        sxTipoCampo.setId(tipoCampo);
        List<SxStepVariable> listaSV = workflowService.getSxStepVariablesTipoCampoNoValori(idelaborazione, new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE), sxTipoCampo);
        Elaborazione elaborazione = workflowService.findElaborazione(idelaborazione);
        List<SxBusinessProcess> listaBp = elaborazione.getSxBusinessFunction().getSxBusinessProcesses();

        model.addAttribute("stepVList", listaSV);
        model.addAttribute("elaborazione", elaborazione);
        model.addAttribute("bProcess", listaBp);
        model.addAttribute(IS2Const.LISTA_BUSINESS_PROCESS, listaBp);

        return "elaborazione/view_data";
    }

    @GetMapping(value = "/chiudiElab/{id}")
    public String chiudiWS(HttpSession session, Model model, @PathVariable("id") Long id) {
        notificationService.removeAllMessages();

        Elaborazione elaborazione = workflowService.findElaborazione(id);
        session.removeAttribute(IS2Const.SESSION_ELABORAZIONE);

        return "redirect:/sessione/apri/" + elaborazione.getSessioneLavoro().getId();
    }

    @GetMapping(value = "/elimina/{idelaborazione}/{idsessione}")
    public String eliminaWS(HttpSession session, Model model, @AuthenticationPrincipal User user, @PathVariable("idelaborazione") Long idelaborazione, @PathVariable("idsessione") Long idsessione) {
        notificationService.removeAllMessages();
        notificationService.addInfoMessage("L'elaborazione è stata rimossa.");
        workflowService.eliminaElaborazione(idelaborazione);
        List<SessioneLavoro> listasessioni = sessioneLavoroService.getSessioneList(user);
        model.addAttribute("listasessioni", listasessioni);

        return "redirect:/sessione/apri/" + idsessione;
    }

    @GetMapping(value = "/dobproc/{idelaborazione}/{idBProc}")
    public String dobproc(Model model, @PathVariable("idelaborazione") Long idelaborazione, @PathVariable("idBProc") Long idBProc) throws REngineException {
        notificationService.removeAllMessages();

        Elaborazione elaborazione = workflowService.findElaborazione(idelaborazione);
        try {
            elaborazione = workflowService.doBusinessProc(elaborazione, idBProc);
            notificationService.addInfoMessage(messages.getMessage("run.ok", null, LocaleContextHolder.getLocale()));
        } catch (Exception e) {
            notificationService.addErrorMessage("Error: " + e.getMessage());
        }

        List<SxStepVariable> listaSV = workflowService.getSxStepVariablesNoValori(idelaborazione, new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
        List<SxBusinessProcess> listaBp = elaborazione.getSxBusinessFunction().getSxBusinessProcesses();
        SxBusinessProcess bProcess = Utility.getSxBusinessProcess(listaBp, idBProc);
        model.addAttribute("stepVList", listaSV);
        model.addAttribute("elaborazione", elaborazione);
        model.addAttribute("bProcess", bProcess);
        model.addAttribute(IS2Const.LISTA_BUSINESS_PROCESS, listaBp);
        model.addAttribute("elaborazione", elaborazione);

        return "elaborazione/view_data";
    }

    @RequestMapping(value = "/associavariabile", method = RequestMethod.POST)
    public String associavariabileWS(HttpSession session, Model model, @ModelAttribute("associazioneVarFormBean") AssociazioneVarFormBean form) {
        Elaborazione elaborazione = workflowService.findElaborazione(Long.parseLong(form.getElaborazione()[0]));
        workflowService.creaAssociazioni(form, elaborazione);
        model.addAttribute("elaborazione", elaborazione);
        notificationService.addInfoMessage("L'associazione è stata aggiunta");

        return "redirect:/ws/editworkingset/" + elaborazione.getId();
    }

    @RequestMapping(value = "/associavariabileSum/{idvar}/{idvarsum}", method = RequestMethod.POST)
    public String associavariabileSum(HttpSession session, Model model, @RequestParam("idvar") Long idVar, @RequestParam("idvarsum") Long idVarSum, 
            @ModelAttribute("associazioneVarFormBean") AssociazioneVarFormBean form) {
        Elaborazione elaborazione = workflowService.findElaborazione(Long.parseLong(form.getElaborazione()[0]));
        workflowService.creaAssociazioni(form, elaborazione);
        model.addAttribute("elaborazione", elaborazione);
        notificationService.addInfoMessage("L'associazione è stata aggiunta");

        return "redirect:/ws/editworkingset/" + idVar + "/" + idVarSum;
    }

    @RequestMapping(value = "/updateassociavariabile", method = RequestMethod.POST)
    public String updateAssociavariabileWS(HttpSession session, Model model, @ModelAttribute("associazioneVarFormBean") AssociazioneVarFormBean form) {
        Elaborazione elaborazione = workflowService.findElaborazione(Long.parseLong(form.getElaborazione()[0]));
        workflowService.updateAssociazione(form, elaborazione);
        model.addAttribute("elaborazione", elaborazione);
        notificationService.addInfoMessage("L'associazione è stata modificata");

        return "redirect:/ws/editworkingset/" + elaborazione.getId();
    }

    @RequestMapping(value = "/assegnaparametri", method = RequestMethod.POST)
    public String assegnaparametriWS(HttpSession session, Model model, @RequestParam("idelaborazione") Long idelaborazione, @RequestParam("parametri") String parametri, 
            @RequestParam("valoreParam") String valoreParam) {

        AssociazioneVarFormBean form2 = new AssociazioneVarFormBean();
        String[] idelaborazioneList = {idelaborazione + ""};
        form2.setElaborazione(idelaborazioneList);
        String[] params = {parametri};
        form2.setParametri(params);
        String[] valori = {valoreParam};
        form2.setValore(valori);
        Elaborazione elaborazione = workflowService.findElaborazione(idelaborazione);
        workflowService.associaParametri(form2, elaborazione);
        notificationService.addInfoMessage("Parametro inserito correttamente");

        model.addAttribute("elaborazione", elaborazione);

        return "redirect:/ws/editworkingset/" + elaborazione.getId();
    }

    @RequestMapping(value = "modificaparametro", method = RequestMethod.POST)
    public String modificaparametro(HttpSession session, Model model, @RequestParam("idelaborazione") Long idelaborazione, @RequestParam("parametri") String parametri, 
            @RequestParam("valoreParam") String valoreParam, @RequestParam("idStepvarMod") String idStepvarMod) {

        AssociazioneVarFormBean form2 = new AssociazioneVarFormBean();
        String[] idelaborazioneList = {idelaborazione + ""};
        form2.setElaborazione(idelaborazioneList);
        String[] params = {parametri};
        form2.setParametri(params);
        form2.setIdStepVar(idStepvarMod);
        String[] valori = {valoreParam};
        form2.setValore(valori);

        Elaborazione elaborazione = workflowService.findElaborazione(idelaborazione);

        workflowService.updateParametri(form2, elaborazione);
        notificationService.addInfoMessage("Parametro modificato");

        model.addAttribute("elaborazione", elaborazione);

        return "redirect:/ws/editworkingset/" + elaborazione.getId();
    }

}
