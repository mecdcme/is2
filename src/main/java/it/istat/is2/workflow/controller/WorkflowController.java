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
package it.istat.is2.workflow.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import it.istat.is2.app.bean.AssociazioneVarFormBean;
import it.istat.is2.app.bean.BusinessProcessParentBean;
import it.istat.is2.app.bean.NotificationMessage;
import it.istat.is2.app.bean.BusinessProcessBean;
import it.istat.is2.app.bean.ProcessStepBean;
import it.istat.is2.app.bean.SessionBean;
import it.istat.is2.app.domain.Log;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.service.ElaborazioneService;
import it.istat.is2.app.service.LogService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.app.util.Utility;
import it.istat.is2.dataset.domain.DatasetColonna;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.dataset.service.DatasetService;
import it.istat.is2.rule.domain.Ruleset;
import it.istat.is2.rule.service.RuleService;
import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.TipoCampo;
import it.istat.is2.workflow.domain.BusinessFunction;
import it.istat.is2.workflow.domain.BusinessProcess;
import it.istat.is2.workflow.domain.BusinessStep;
import it.istat.is2.workflow.domain.StepInstanceParameter;
import it.istat.is2.workflow.domain.AppRole;
import it.istat.is2.workflow.domain.ArtifactBFunction;
import it.istat.is2.workflow.domain.StepVariable;
import it.istat.is2.workflow.domain.SxTipoVar;
import it.istat.is2.workflow.domain.Workset;
import it.istat.is2.workflow.service.StepVariableService;
import it.istat.is2.workflow.service.WorkflowService;
import it.istat.is2.worksession.domain.WorkSession;
import it.istat.is2.worksession.service.WorkSessionService;

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
	private WorkSessionService sessioneLavoroService;
	@Autowired
	private ElaborazioneService elaborazioneService;
	@Autowired
	private DatasetService datasetService;
	@Autowired
	private StepVariableService stepVariableService;
	@Autowired
	private RuleService ruleService;
	@Autowired
	private LogService logService;

	@GetMapping(value = "/home/{id}")
	public String homeWS(HttpSession session, Model model, @PathVariable("id") Long id) {
		notificationService.removeAllMessages();

		Elaborazione elaborazione = workflowService.findElaborazione(id);
		List<BusinessProcess> listaBp = elaborazione.getBusinessProcess().getBusinessSubProcesses();
		List<BusinessProcessBean> businessProcessBeans = new ArrayList<BusinessProcessBean>();
		List<StepVariable> listaSV = workflowService.getStepVariablesNoValori(elaborazione.getId(),
				new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
		model.addAttribute("stepVList", listaSV);

		// Create session DTO
		SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
		sessionBean.setIdElaborazione(elaborazione.getId());
		sessionBean.setNomeElaborazione(elaborazione.getNome());
		BusinessProcessParentBean BusinessProcessParent = new BusinessProcessParentBean();
		BusinessProcessParent.setId(elaborazione.getBusinessProcess().getId());
		BusinessProcessParent.setName(elaborazione.getBusinessProcess().getNome());
		for (BusinessProcess sbp : listaBp) {
			BusinessProcessBean businessProcessBean = new BusinessProcessBean();
			businessProcessBean.setId(sbp.getId());
			businessProcessBean.setName(sbp.getNome());
			List<ProcessStepBean> processStepBeans = new ArrayList<ProcessStepBean>();
			for (BusinessStep bpStep : sbp.getBusinessSteps()) {
				processStepBeans.add(new ProcessStepBean(bpStep.getId(), bpStep.getNome()));
			}
			businessProcessBean.setSteps(processStepBeans);
			businessProcessBeans.add(businessProcessBean);
		}
		BusinessProcessParent.setProcesses(businessProcessBeans);
		sessionBean.setBusinessProcess(BusinessProcessParent);
		session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);

		model.addAttribute("elaborazione", elaborazione);
		model.addAttribute(IS2Const.LISTA_BUSINESS_PROCESS, listaBp);

		List<Log> logs = logService.findByIdSessione(sessionBean.getId());
		model.addAttribute("logs", logs);

		HashMap<Long, List<String>> paramsMissing = workflowService
				.findMissingAppRoleySubProcessAndTipoVar(elaborazione, new SxTipoVar(IS2Const.WORKSET_TIPO_PARAMETRO));
		HashMap<Long, List<String>> variablesMissing = workflowService
				.findMissingAppRoleySubProcessAndTipoVar(elaborazione, new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
		
		HashMap<Long, List<String>> rulesetMissing = workflowService
				.findMissingAppRoleySubProcessAndTipoVar(elaborazione, new SxTipoVar(IS2Const.WORKSET_TIPO_RULESET));

		//all in paramterers
		for (Map.Entry<Long, List<String>> entry : variablesMissing.entrySet()) {
			Long key = entry.getKey();
			List<String> value = entry.getValue();
			List<String> list=paramsMissing.get(key);
			if(list==null) list=new ArrayList<>();
			list.addAll(value);
			paramsMissing.put(key, list);
	   }
		for (Map.Entry<Long, List<String>> entry : rulesetMissing.entrySet()) {
			Long key = entry.getKey();
			List<String> value = entry.getValue();
			List<String> list=paramsMissing.get(key);
			if(list==null) list=new ArrayList<>();
			list.addAll(value);
			paramsMissing.put(key, list);
	   }
		
		model.addAttribute("paramsMissing", paramsMissing);
		model.addAttribute("variablesMissing", new HashMap<>());
		model.addAttribute("rulesetMissing", new HashMap<>());

		return "workflow/home";
	}

	@GetMapping(value = "/eliminaAssociazione/{idelaborazione}/{idvar}")
	public String eliminaAssociazioneVar(HttpSession session, Model model,
			@PathVariable("idelaborazione") Long idelaborazione, @PathVariable("idvar") Integer idvar) {
		notificationService.removeAllMessages();

		StepVariable stepVar = stepVariableService.findById(idvar).get();
		List<StepVariable> listaVars = stepVar.getWorkset().getStepVariables();

		if (listaVars.size() == 1) {
			Workset workset = (Workset) listaVars.get(0).getWorkset();
			workflowService.deleteWorkset(workset);
		} else {
			// do nothing
		}

		stepVariableService.removeStepVarById(idvar);
		notificationService.addInfoMessage("La variabile è stata rimossa");

		return "redirect:/ws/editworkingset/" + idelaborazione;
	}

	@GetMapping(value = "/cleanallworkset/{idelaborazione}/{flagIO}")
	public String cleanAllWorkset(HttpSession session, Model model, RedirectAttributes ra,
			@PathVariable("idelaborazione") Long idelaborazione,@PathVariable("flagIO")Integer flagIO) {
		notificationService.removeAllMessages();

		try {
			workflowService.cleanAllWorkset(idelaborazione,flagIO);
			notificationService.addInfoMessage(messages.getMessage("workset.clean.ok", null, LocaleContextHolder.getLocale()));
		} catch (Exception e) {
			notificationService.addErrorMessage(messages.getMessage("workset.clean.error", null, LocaleContextHolder.getLocale()));
		}
		return "redirect:/ws/home/" + idelaborazione;
	}

	@GetMapping(value = "/eliminaParametro/{idelaborazione}/{idparametro}")
	public String eliminaParametro(HttpSession session, Model model, RedirectAttributes ra,
			@PathVariable("idelaborazione") Long idelaborazione, @PathVariable("idparametro") Integer idparametro) {
		notificationService.removeAllMessages();

		StepVariable stepVar = stepVariableService.findById(idparametro).get();
		List<StepVariable> listaVars = stepVar.getWorkset().getStepVariables();

		if (listaVars.size() == 1) {
			Workset workset = (Workset) listaVars.get(0).getWorkset();
			workflowService.deleteWorkset(workset);
		} else {
			// do nothing
		}

		stepVariableService.removeStepVarById(idparametro);
		notificationService.addInfoMessage("Il parametro è stato eliminato");
		ra.addFlashAttribute("showTabParam", true);
		return "redirect:/ws/editworkingset/" + idelaborazione;
	}

	@GetMapping(value = "/editworkingset/{idelaborazione}")
	public String editWorkingSet(HttpSession session, Model model, @ModelAttribute("showTabParam") String showTabParam,
			@PathVariable("idelaborazione") Long idElaborazione) {

		session.setAttribute(IS2Const.WORKINGSET, "workingset");

		Elaborazione elaborazione = elaborazioneService.findElaborazione(idElaborazione);

		SessionBean elaSession = new SessionBean(elaborazione.getId(), elaborazione.getNome());
		session.setAttribute(IS2Const.SESSION_ELABORAZIONE, elaSession);
		
		List<String> matchedVariables = new ArrayList<>();
		

		List<DatasetFile> datasetfiles = datasetService
				.findDatasetFilesByIdSessioneLavoro(elaborazione.getSessioneLavoro().getId());

		datasetfiles.forEach(datasetfile -> {
			// retrieve DatasetColonna without data
			List<DatasetColonna> colonne = datasetService.findAllNomeColonne(datasetfile);
			datasetfile.setColonne(colonne);

		});

		List<StepVariable> listaSV = workflowService.getStepVariablesNoValori(idElaborazione, new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
		if(listaSV != null && listaSV.size() > 0) {
			for(StepVariable stepVariable : listaSV) {
				matchedVariables.add(stepVariable.getWorkset().getNome());
			}
		}
		
		BusinessProcess businessProcessParent = elaborazione.getBusinessProcess();

		BusinessFunction businessFunction = elaborazione.getSessioneLavoro().getBusinessFunction();

		// Carica i Ruoli di input
		List<AppRole> listaRuoliInput = workflowService.findRuoliByProcess(businessProcessParent, 0, new SxTipoVar (IS2Const.WORKSET_TIPO_VARIABILE));
		// Carica i Ruoli di input e output
		List<AppRole> listaRuoliInOut = workflowService.findRuoliByProcess(businessProcessParent, 1,new SxTipoVar (IS2Const.WORKSET_TIPO_VARIABILE));

		List<StepInstanceParameter> paramsNotAssignedList = new ArrayList<>();
		List<StepVariable> sVParamsAssignedList = workflowService.getStepVariablesParametri(idElaborazione);
		Map<String, StepVariable> stepParamMap=new HashMap<>();
	 	ArrayList<String> paramAssigned = new ArrayList<>();
		sVParamsAssignedList.forEach(sxstepVaraible -> {
			paramAssigned.add(sxstepVaraible.getWorkset().getNome());
			stepParamMap.put(sxstepVaraible.getWorkset().getNome(), sxstepVaraible);
		});

		Map<Long, List<StepInstanceParameter>> paramsAllBPPMap = workflowService
				.findParametriAndSubProcessesByProcess(businessProcessParent);
		List<StepInstanceParameter> paramsAllBPPList = new ArrayList<>();

		for (Map.Entry<Long, List<StepInstanceParameter>> entry : paramsAllBPPMap.entrySet()) {
			
			List<StepInstanceParameter> listparams = entry.getValue();
			
			paramsAllBPPList.addAll(listparams);
			for (StepInstanceParameter sxParPattern : listparams) {
				if (!paramAssigned.contains(sxParPattern.getNome())) {
					paramsNotAssignedList.add(sxParPattern);
				
				}

			}
		}
     	List<BusinessProcess> listaBp = elaborazione.getBusinessProcess().getBusinessSubProcesses();

     	if( businessFunction.getSxArtifacts().contains(new ArtifactBFunction(IS2Const.ARTIFACT_RULESET))) {
     		List<StepVariable> stepVariablesRuleset = workflowService.getStepVariablesRuleset(idElaborazione);
     		Map<String, StepVariable> stepVariablesRulesetMap=new HashMap<>();
     		stepVariablesRuleset.forEach(sxstepVariable -> {
    		 	stepVariablesRulesetMap.put(sxstepVariable.getAppRole().getNome(), sxstepVariable);
    		});
    	   	List<Ruleset> rulesetList=ruleService.findRulesetBySessioneLavoro(elaborazione.getSessioneLavoro());
    		// Load Ruleset Role
    		List<AppRole> rulesetRoleList = workflowService.findRuoliByProcess(businessProcessParent, 0, new SxTipoVar (IS2Const.WORKSET_TIPO_RULESET));

    	   	model.addAttribute("stepVariablesRulesetMap", stepVariablesRulesetMap);
    	   	model.addAttribute("rulesetList", rulesetList);
    	  	model.addAttribute("rulesetRoleList", rulesetRoleList);
     	}
     	
     	
     	
     	
		model.addAttribute("bProcess", listaBp);
		model.addAttribute(IS2Const.LISTA_BUSINESS_PROCESS, listaBp);
		model.addAttribute("stepVList", listaSV);

		model.addAttribute("stepParamList", sVParamsAssignedList);
		model.addAttribute("stepParamMap", stepParamMap);

		model.addAttribute("listaRuoliInput", listaRuoliInput);
		model.addAttribute("listaRuoliInOut", listaRuoliInOut);
		model.addAttribute("listaParametri", paramsNotAssignedList);
		model.addAttribute("listaParametriAll", paramsAllBPPList);
		model.addAttribute("datasetfiles", datasetfiles);
		model.addAttribute("elaborazione", elaborazione);
		model.addAttribute("businessProcessParent", businessProcessParent);
		model.addAttribute("businessFunction", businessFunction);
		model.addAttribute("showTabParam", showTabParam);
		model.addAttribute("matchedVariables", matchedVariables);
		return "workflow/edit";

	}

	@GetMapping(value = "/dataview/{idelab}/{tipoCampo}")
	public String viewDataProc(HttpSession session, Model model, @PathVariable("idelab") Long idelaborazione,
			@PathVariable("tipoCampo") Integer tipoCampo) {
		notificationService.removeAllMessages();
		List<StepVariable> listaSV = new ArrayList<>();
		List<BusinessProcess> listaBp = new ArrayList<>();
		AppRole currentGroup = new AppRole();
		Elaborazione elaborazione = workflowService.findElaborazione(idelaborazione);
		TipoCampo sxTipoCampo = workflowService.getTipoCampoById(tipoCampo);

		List<AppRole> outputObjects = workflowService.getOutputRoleGroupsStepVariables(idelaborazione,
				new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE), sxTipoCampo);
		if (!outputObjects.isEmpty()) {
			currentGroup = outputObjects.get(0);
			listaSV = workflowService.getStepVariablesTipoCampoNoValori(idelaborazione,
					new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE), sxTipoCampo, currentGroup);
		}

		listaBp = elaborazione.getBusinessProcess().getBusinessSubProcesses();
		model.addAttribute("outputObjects", outputObjects);
		model.addAttribute("currentGroup", currentGroup);
		model.addAttribute("stepVList", listaSV);
		model.addAttribute("elaborazione", elaborazione);
		model.addAttribute("tipoCampo", sxTipoCampo);
		model.addAttribute("bProcess", listaBp);
		model.addAttribute(IS2Const.LISTA_BUSINESS_PROCESS, listaBp);

		return "workflow/view_data";

	}

	@GetMapping(value = "/dataview/{idelab}/{tipoCampo}/{outRole}")
	public String viewDataOut(HttpSession session, Model model, @PathVariable("idelab") Long idelaborazione,
			@PathVariable("tipoCampo") Integer tipoCampo, @PathVariable("outRole") Integer outRole) {
		notificationService.removeAllMessages();

		List<StepVariable> listaSV = new ArrayList<>();
		List<BusinessProcess> listaBp = new ArrayList<>();
		Elaborazione elaborazione = workflowService.findElaborazione(idelaborazione);
		TipoCampo sxTipoCampo = workflowService.getTipoCampoById(tipoCampo);

		List<AppRole> outputObjects = workflowService.getOutputRoleGroupsStepVariables(idelaborazione,
				new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE), sxTipoCampo);

		AppRole currentGroup = new AppRole(outRole);
		listaSV = workflowService.getStepVariablesTipoCampoNoValori(idelaborazione,
				new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE), sxTipoCampo, currentGroup);

		listaBp = elaborazione.getBusinessProcess().getBusinessSubProcesses();
		model.addAttribute("outputObjects", outputObjects);
		model.addAttribute("currentGroup", currentGroup);
		model.addAttribute("stepVList", listaSV);
		model.addAttribute("elaborazione", elaborazione);
		model.addAttribute("tipoCampo", sxTipoCampo);
		model.addAttribute("bProcess", listaBp);
		model.addAttribute(IS2Const.LISTA_BUSINESS_PROCESS, listaBp);

		return "workflow/view_data";

	}

	@GetMapping(value = "/chiudiElab/{id}")
	public String chiudiWS(HttpSession session, Model model, @PathVariable("id") Long id) {
		notificationService.removeAllMessages();

		Elaborazione elaborazione = workflowService.findElaborazione(id);
		session.removeAttribute(IS2Const.SESSION_ELABORAZIONE);

		// Create session DTO
		SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
		sessionBean.setBusinessProcess(null);
		sessionBean.setIdElaborazione(Long.valueOf("-1"));
		session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);

		return "redirect:/sessione/apri/" + elaborazione.getSessioneLavoro().getId();
	}

	@GetMapping(value = "/elimina/{idelaborazione}/{idsessione}")
	public String eliminaWS(HttpSession session, Model model, @AuthenticationPrincipal User user,
			@PathVariable("idelaborazione") Long idelaborazione, @PathVariable("idsessione") Long idsessione) {
		notificationService.removeAllMessages();
		
		
		
		
		try {
			workflowService.eliminaElaborazione(idelaborazione);
			notificationService.addInfoMessage(
	                messages.getMessage("process.removed.message", null, LocaleContextHolder.getLocale()));	
		}catch(Exception e) {
			notificationService.addErrorMessage(
                    messages.getMessage("process.removing.error", null, LocaleContextHolder.getLocale()), e.getMessage());
		}
		
		List<WorkSession> listasessioni = sessioneLavoroService.getSessioneList(user);
		model.addAttribute("listasessioni", listasessioni);

		logService.save("Elaborazione " + idelaborazione + " Eliminata con successo");

		return "redirect:/sessione/apri/" + idsessione;
	}

	/*
	@GetMapping(value = "/dobproc/{idelaborazione}/{idBProc}")
	public String dobproc(HttpSession session, Model model, @PathVariable("idelaborazione") Long idelaborazione,
			@PathVariable("idBProc") Long idBProc) throws REngineException {
		notificationService.removeAllMessages();

		Elaborazione elaborazione = workflowService.findElaborazione(idelaborazione);
		try {
			elaborazione = workflowService.doBusinessProc(elaborazione, idBProc);
			notificationService.addInfoMessage(messages.getMessage("run.ok", null, LocaleContextHolder.getLocale()));
		} catch (Exception e) {
			notificationService.addErrorMessage("Error: " + e.getMessage());
		}

		List<StepVariable> listaSV = workflowService.getStepVariablesTipoCampoNoValori(idelaborazione,
				new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE), new TipoCampo(IS2Const.TIPO_CAMPO_ELABORATO), null);
		List<BusinessProcess> listaBp = elaborazione.getBusinessProcess().getBusinessSubProcesses();

		BusinessProcess bProcess = Utility.getBusinessProcess(listaBp, idBProc);
		model.addAttribute("stepVList", listaSV);
		model.addAttribute("elaborazione", elaborazione);
		model.addAttribute("bProcess", bProcess);
		model.addAttribute(IS2Const.LISTA_BUSINESS_PROCESS, listaBp);

		SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
		List<Log> logs = logService.findByIdSessione(sessionBean.getId());
		model.addAttribute("logs", logs);

		return "workflow/home";
	}
*/
	@RequestMapping(value = "/associavariabile", method = RequestMethod.POST)
	public String associavariabileWS(HttpSession session, Model model,
			@ModelAttribute("associazioneVarFormBean") AssociazioneVarFormBean form) {
		Elaborazione elaborazione = workflowService.findElaborazione(Long.parseLong(form.getElaborazione()[0]));
		workflowService.creaAssociazioni(form, elaborazione);
		model.addAttribute("elaborazione", elaborazione);
		notificationService.addInfoMessage("L'associazione è stata aggiunta");

		return "redirect:/ws/editworkingset/" + elaborazione.getId();
	}

	@RequestMapping(value = "/associavariabileSum/{idvar}/{idvarsum}", method = RequestMethod.POST)
	public String associavariabileSum(HttpSession session, Model model, @RequestParam("idvar") Long idVar,
			@RequestParam("idvarsum") Long idVarSum,
			@ModelAttribute("associazioneVarFormBean") AssociazioneVarFormBean form) {
		Elaborazione elaborazione = workflowService.findElaborazione(Long.parseLong(form.getElaborazione()[0]));
		workflowService.creaAssociazioni(form, elaborazione);
		model.addAttribute("elaborazione", elaborazione);
		notificationService.addInfoMessage("L'associazione è stata aggiunta");

		return "redirect:/ws/editworkingset/" + idVar + "/" + idVarSum;
	}

	@RequestMapping(value = "/updateassociavariabile", method = RequestMethod.POST)
	public String updateAssociavariabileWS(HttpSession session, Model model,
			@ModelAttribute("associazioneVarFormBean") AssociazioneVarFormBean form) {
		Elaborazione elaborazione = workflowService.findElaborazione(Long.parseLong(form.getElaborazione()[0]));
		workflowService.updateAssociazione(form, elaborazione);
		model.addAttribute("elaborazione", elaborazione);
		notificationService.addInfoMessage("L'associazione è stata modificata");

		return "redirect:/ws/editworkingset/" + elaborazione.getId();
	}

	@RequestMapping(value = "/assegnaparametri", method = RequestMethod.POST)
	public String assegnaparametriWS(HttpSession session, Model model, RedirectAttributes ra,
			@RequestParam("idelaborazione") Long idelaborazione, @RequestParam("parametri") String parametri,
			@RequestParam("valoreParam") String valoreParam) {

		AssociazioneVarFormBean form2 = new AssociazioneVarFormBean();
		String[] idelaborazioneList = { idelaborazione + "" };
		form2.setElaborazione(idelaborazioneList);
		String[] params = { parametri };
		form2.setParametri(params);
		String[] valori = { valoreParam };
		form2.setValore(valori);
		Elaborazione elaborazione = workflowService.findElaborazione(idelaborazione);
		workflowService.associaParametri(form2, elaborazione);
		notificationService.addInfoMessage("Parametro inserito correttamente");

		model.addAttribute("elaborazione", elaborazione);
		ra.addFlashAttribute("showTabParam", true);
		return "redirect:/ws/editworkingset/" + elaborazione.getId();
	}

	@RequestMapping(value = "modificaparametro", method = RequestMethod.POST)
	public String modificaparametro(HttpSession session, Model model, RedirectAttributes ra,
			@RequestParam("idelaborazione") Long idelaborazione, @RequestParam("parametri") String parametri,
			@RequestParam("valoreParam") String valoreParam, @RequestParam("idStepvarMod") String idStepvarMod) {

		AssociazioneVarFormBean form2 = new AssociazioneVarFormBean();
		String[] idelaborazioneList = { idelaborazione + "" };
		form2.setElaborazione(idelaborazioneList);
		String[] params = { parametri };
		form2.setParametri(params);
		form2.setIdStepVar(idStepvarMod);
		String[] valori = { valoreParam };
		form2.setValore(valori);

		Elaborazione elaborazione = workflowService.findElaborazione(idelaborazione);

		workflowService.updateParametri(form2, elaborazione);
		notificationService.addInfoMessage("Parametro modificato");

		model.addAttribute("elaborazione", elaborazione);
		ra.addFlashAttribute("showTabParam", "parametri");
		return "redirect:/ws/editworkingset/" + elaborazione.getId();
	}
	
	@RequestMapping(value = "/setruleset", method = RequestMethod.POST)
	public String setRuleset(HttpSession session, Model model, RedirectAttributes ra,
			@RequestParam("idelaborazione") Long idelaborazione, @RequestParam("idRole") Integer idRole,
			@RequestParam("idRuleset") Integer idRuleset) {
		
		Elaborazione elaborazione = workflowService.findElaborazione(idelaborazione);
		try {
			workflowService.setRuleset(elaborazione, idRole,idRuleset);
			notificationService.addInfoMessage(messages.getMessage("process.setresulset.ok", null, LocaleContextHolder.getLocale()));
		} catch (Exception e) {
			notificationService.addErrorMessage("Error: " + e.getMessage());
		}
	 
		model.addAttribute("elaborazione", elaborazione);
		ra.addFlashAttribute("showTab", "resultset");
		return "redirect:/ws/editworkingset/" + elaborazione.getId();
	}
}
