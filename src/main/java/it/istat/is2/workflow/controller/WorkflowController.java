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

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import it.istat.is2.dataset.domain.DatasetColumn;
import it.istat.is2.app.bean.MappingVarsFormBean;
import it.istat.is2.app.bean.BusinessProcessParentBean;
import it.istat.is2.app.bean.AssociazioneVarRoleBean;
import it.istat.is2.app.bean.BusinessProcessBean;
import it.istat.is2.app.bean.ProcessStepBean;
import it.istat.is2.app.bean.SessionBean;
import it.istat.is2.app.domain.Log;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.service.DataProcessingService;
import it.istat.is2.app.service.LogService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.dataset.service.DatasetService;
import it.istat.is2.rule.domain.Ruleset;
import it.istat.is2.rule.service.RuleService;
import it.istat.is2.workflow.domain.DataProcessing;
import it.istat.is2.workflow.domain.DataTypeCls;
import it.istat.is2.workflow.domain.BusinessFunction;
import it.istat.is2.workflow.domain.BusinessProcess;
import it.istat.is2.workflow.domain.ProcessStep;
import it.istat.is2.workflow.domain.StepInstanceSignature;
import it.istat.is2.workflow.domain.AppRole;
import it.istat.is2.workflow.domain.ViewDataType;
import it.istat.is2.workflow.domain.StepRuntime;
import it.istat.is2.workflow.domain.TypeIO;
import it.istat.is2.workflow.domain.Workset;
import it.istat.is2.workflow.service.AppRoleService;
import it.istat.is2.workflow.service.StepRuntimeService;
import it.istat.is2.workflow.service.WorkflowService;
import it.istat.is2.worksession.domain.WorkSession;
import it.istat.is2.worksession.service.WorkSessionService;

@RequestMapping("/ws")
@Controller
public class WorkflowController {

	@Autowired
	private AppRoleService  appRoleService;
	@Autowired
	private WorkflowService workflowService;
	@Autowired
	private NotificationService notificationService;
	@Autowired
	private MessageSource messages;
	@Autowired
	private WorkSessionService workSessionService;
	@Autowired
	private DataProcessingService dataProcessingService;
	@Autowired
	private DatasetService datasetService;
	@Autowired
	private StepRuntimeService stepRuntimeservice;
	@Autowired
	private RuleService ruleService;
	@Autowired
	private LogService logService;

	@GetMapping(value = "/home/{id}")
	public String homeWS(HttpSession session, Model model, @PathVariable("id") Long id) {
		notificationService.removeAllMessages();

		DataProcessing dataProcessing = workflowService.findDataProcessing(id);
		List<BusinessProcess> listaBp = dataProcessing.getBusinessProcess().getBusinessSubProcesses();
		List<BusinessProcessBean> businessProcessBeans = new ArrayList<BusinessProcessBean>();
		List<StepRuntime> stepRList = workflowService.getStepRuntimesNoValues(dataProcessing.getId(),
				new DataTypeCls(IS2Const.DATA_TYPE_VARIABLE));
		model.addAttribute("stepRList", stepRList);

		// Create session DTO
		SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
		sessionBean.setDataProcessingId(dataProcessing.getId());
		sessionBean.setDataProcessingName(dataProcessing.getName());
		BusinessProcessParentBean BusinessProcessParent = new BusinessProcessParentBean();
		BusinessProcessParent.setId(dataProcessing.getBusinessProcess().getId());
		BusinessProcessParent.setName(dataProcessing.getBusinessProcess().getName());
		for (BusinessProcess sbp : listaBp) {
			BusinessProcessBean businessProcessBean = new BusinessProcessBean();
			businessProcessBean.setId(sbp.getId());
			businessProcessBean.setName(sbp.getName());
			List<ProcessStepBean> processStepBeans = new ArrayList<ProcessStepBean>();
			for (ProcessStep bpStep : sbp.getBusinessSteps()) {
				processStepBeans.add(new ProcessStepBean(bpStep.getId(), bpStep.getName()));
			}
			businessProcessBean.setSteps(processStepBeans);
			businessProcessBeans.add(businessProcessBean);
		}
		BusinessProcessParent.setProcesses(businessProcessBeans);
		sessionBean.setBusinessProcess(BusinessProcessParent);
		session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);

		model.addAttribute("dataProcessing", dataProcessing);
		model.addAttribute(IS2Const.LIST_BUSINESS_PROCESS, listaBp);

		List<Log> logs = logService.findByIdSessione(sessionBean.getId());
		model.addAttribute("logs", logs);

		HashMap<Long, List<String>> paramsMissing = workflowService
				.findMissingAppRoleySubProcessAndTipoVar(dataProcessing, new DataTypeCls(IS2Const.DATA_TYPE_PARAMETER));
		HashMap<Long, List<String>> variablesMissing = workflowService
				.findMissingAppRoleySubProcessAndTipoVar(dataProcessing, new DataTypeCls(IS2Const.DATA_TYPE_VARIABLE));
		
		HashMap<Long, List<String>> rulesetMissing = workflowService
				.findMissingAppRoleySubProcessAndTipoVar(dataProcessing, new DataTypeCls(IS2Const.DATA_TYPE_RULESET));

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

	@GetMapping(value = "/eliminaAssociazione/{dataProcessingId}/{idvar}")
	public String eliminaAssociazioneVar(HttpSession session, Model model,
			@PathVariable("dataProcessingId") Long dataProcessingId, @PathVariable("idvar") Integer idvar) {
		notificationService.removeAllMessages();

		StepRuntime stepRuntime = stepRuntimeservice.findById(idvar).get();
		List<StepRuntime> listaVars = stepRuntime.getWorkset().getStepRuntimes();

		if (listaVars.size() == 1) {
			Workset workset = (Workset) listaVars.get(0).getWorkset();
			workflowService.deleteWorkset(workset);
		} else {
			stepRuntimeservice.removeStepRuntimeById(idvar);
		}

		
		notificationService.addInfoMessage("La variabile è stata rimossa");

		return "redirect:/ws/editworkingset/" + dataProcessingId;
	}

	@GetMapping(value = "/cleanallworkset/{dataProcessingId}/{flagIO}")
	public String cleanAllWorkset(HttpSession session, Model model, RedirectAttributes ra,
			@PathVariable("dataProcessingId") Long dataProcessingId,@PathVariable("flagIO")Short flagIO) {
		notificationService.removeAllMessages();

		try {
			workflowService.cleanAllWorkset(dataProcessingId,flagIO);
			notificationService.addInfoMessage(messages.getMessage("workset.clean.ok", null, LocaleContextHolder.getLocale()));
		} catch (Exception e) {
			notificationService.addErrorMessage(messages.getMessage("workset.clean.error", null, LocaleContextHolder.getLocale()));
		}
		return "redirect:/ws/home/" + dataProcessingId;
	}

	@GetMapping(value = "/eliminaParametro/{dataProcessingId}/{idparametro}")
	public String eliminaParametro(HttpSession session, Model model, RedirectAttributes ra,
			@PathVariable("dataProcessingId") Long dataProcessingId, @PathVariable("idparametro") Integer idparametro) {
		notificationService.removeAllMessages();

		StepRuntime stepRuntime = stepRuntimeservice.findById(idparametro).get();
		List<StepRuntime> listaVars = stepRuntime.getWorkset().getStepRuntimes();

		if (listaVars.size() == 1) {
			Workset workset = (Workset) listaVars.get(0).getWorkset();
			workflowService.deleteWorkset(workset);
		} else {
			// do nothing
		}

		stepRuntimeservice.removeStepRuntimeById(idparametro);
		notificationService.addInfoMessage("Il parametro è stato eliminato");
		ra.addFlashAttribute("showTabParam", true);
		return "redirect:/ws/editworkingset/" + dataProcessingId;
	}

	@GetMapping(value = "/editworkingset/{dataProcessingId}")
	public String editWorkingSet(HttpSession session, Model model, @ModelAttribute("showTabParam") String showTabParam,
			@PathVariable("dataProcessingId") Long dataProcessingId) {

		session.setAttribute(IS2Const.WORKINGSET, "workingset");

		DataProcessing dataProcessing = dataProcessingService.findDataProcessing(dataProcessingId);

		SessionBean elaSession = new SessionBean(dataProcessing.getId(), dataProcessing.getName());
		session.setAttribute(IS2Const.SESSION_DATAPROCESSING, elaSession);
		
		List<String> matchedVariables = new ArrayList<>();
		

		List<DatasetFile> datasetfiles = datasetService
				.findDatasetFilesByIdWorkSession(dataProcessing.getWorkSession().getId());

		datasetfiles.forEach(datasetfile -> {
			// retrieve DatasetColonna without data
			List<DatasetColumn> colonne = datasetService.findAllNameColum(datasetfile);
			datasetfile.setColumns(colonne);

		});

		List<StepRuntime> stepRList = workflowService.getStepRuntimesNoValues(dataProcessingId, new DataTypeCls(IS2Const.DATA_TYPE_VARIABLE));
		if(stepRList != null && stepRList.size() > 0) {
			for(StepRuntime stepRuntime : stepRList) {
				matchedVariables.add(stepRuntime.getWorkset().getName());
			}
		}
		
		BusinessProcess businessProcessParent = dataProcessing.getBusinessProcess();

		BusinessFunction businessFunction = dataProcessing.getWorkSession().getBusinessFunction();

		// Carica i Ruoli di input
		List<AppRole> listaRuoliInput = workflowService.findAppRolesByProcess(businessProcessParent, 0, new DataTypeCls (IS2Const.DATA_TYPE_VARIABLE));
		// Carica i Ruoli di input e output
		List<AppRole> listaRuoliInOut = workflowService.findAppRolesByProcess(businessProcessParent, 1,new DataTypeCls (IS2Const.DATA_TYPE_VARIABLE));

		List<AppRole> paramsNotAssignedList = new ArrayList<>();
		List<StepRuntime> sVParamsAssignedList = workflowService.getStepRuntimeParameters(dataProcessingId);
		Map<String, StepRuntime> stepParamMap=new HashMap<>();
	 	ArrayList<String> paramAssigned = new ArrayList<>();
		sVParamsAssignedList.forEach(stepRuntime -> {
			paramAssigned.add(stepRuntime.getAppRole().getCode());
			stepParamMap.put(stepRuntime.getAppRole().getCode(), stepRuntime);
		});

		Map<Long, List<StepInstanceSignature>> paramsAllBPPMap = workflowService
				.findParametriAndSubProcessesByProcess(businessProcessParent);
		List<AppRole> paramsAllBPPList = new ArrayList<>();

		for (Map.Entry<Long, List<StepInstanceSignature>> entry : paramsAllBPPMap.entrySet()) {
			
			List<StepInstanceSignature> listparams = entry.getValue();
			
			for (StepInstanceSignature stepInstanceSignature : listparams) {
			if(!paramsAllBPPList.contains(stepInstanceSignature.getAppRole()))	paramsAllBPPList.add(stepInstanceSignature.getAppRole());	
				if (!paramAssigned.contains(stepInstanceSignature.getAppRole().getCode())) {
					paramsNotAssignedList.add(stepInstanceSignature.getAppRole());
				
				}

			}
		}
     	List<BusinessProcess> listaBp = dataProcessing.getBusinessProcess().getBusinessSubProcesses();

     	if( businessFunction.getViewDataType().contains(new ViewDataType(IS2Const.VIEW_DATATYPE_RULESET))) {
     		List<StepRuntime> stepRuntimesRuleset = workflowService.getStepRuntimesRuleset(dataProcessingId);
     		Map<String, StepRuntime> stepRuntimesRulesetMap=new HashMap<>();
     		stepRuntimesRuleset.forEach(sxstepRuntime -> {
    		 	stepRuntimesRulesetMap.put(sxstepRuntime.getAppRole().getCode(), sxstepRuntime);
    		});
    	   	List<Ruleset> rulesetList=ruleService.findRulesetBySessioneLavoro(dataProcessing.getWorkSession());
    		// Load Ruleset Role
    		List<AppRole> rulesetRoleList = workflowService.findAppRolesByProcess(businessProcessParent, 0, new DataTypeCls(IS2Const.DATA_TYPE_RULESET));

    	   	model.addAttribute("stepRuntimesRulesetMap", stepRuntimesRulesetMap);
    	   	model.addAttribute("rulesetList", rulesetList);
    	  	model.addAttribute("rulesetRoleList", rulesetRoleList);
     	}
     	
     	
     	
     	
		
		model.addAttribute(IS2Const.LIST_BUSINESS_PROCESS, listaBp);
		model.addAttribute("stepRList", stepRList);

		model.addAttribute("stepParamList", sVParamsAssignedList);
		model.addAttribute("stepParamMap", stepParamMap);

		model.addAttribute("listaRuoliInput", listaRuoliInput);
		model.addAttribute("listaRuoliInOut", listaRuoliInOut);
		//model.addAttribute("parameterList", paramsNotAssignedList);
		model.addAttribute("parameterListAll", paramsAllBPPList);
		model.addAttribute("datasetfiles", datasetfiles);
		model.addAttribute("dataProcessing", dataProcessing);
		model.addAttribute("businessProcessParent", businessProcessParent);
		model.addAttribute("businessFunction", businessFunction);
		model.addAttribute("showTabParam", showTabParam);
		model.addAttribute("matchedVariables", matchedVariables);
		return "workflow/edit";

	}

	@PostMapping(value = "/associaVariabiliRuolo")
    public String associaVariabiliRuolo(HttpServletResponse response, Model model, @RequestBody AssociazioneVarRoleBean[] associazioneVarRoleBean) throws IOException {
   		DataProcessing elaborazione = workflowService.findDataProcessing(associazioneVarRoleBean[0].getIdElaborazione());
   		
   		try {
   			workflowService.creaAssociazionVarRole(elaborazione,associazioneVarRoleBean);
			notificationService.addInfoMessage(
	                messages.getMessage("generic.save.success", null, LocaleContextHolder.getLocale()));	
		}catch(Exception e) {
			notificationService.addErrorMessage(
                    messages.getMessage("process.removing.error", null, LocaleContextHolder.getLocale()), e.getMessage());
		}
   		return "redirect:/ws/editworkingset/" + elaborazione.getId();
   	}

	
	
	
	
	
	
	@GetMapping(value = "/dataview/{idelab}/{type}")
	public String viewDataProc(HttpSession session, Model model, @PathVariable("idelab") Long dataProcessingId,
			@PathVariable("type") Short type) {
		notificationService.removeAllMessages();
		List<StepRuntime> stepRList = new ArrayList<>();
		List<BusinessProcess> listaBp = new ArrayList<>();
		AppRole currentGroup = new AppRole();
		DataProcessing dataProcessing = workflowService.findDataProcessing(dataProcessingId);
		//TypeIO typeIO = workflowService.getTypeIOById(tipoIo);
		TypeIO typeIO  =new TypeIO(type);

		List<AppRole> outputObjects = workflowService.getOutputRoleGroupsStepRuntimes(dataProcessingId,typeIO,
				null);
		if (!outputObjects.isEmpty()) {
			currentGroup = outputObjects.get(0);
			stepRList = workflowService.getStepRuntimesDataTypeNoValues(dataProcessingId,null, typeIO,currentGroup);
		}

		listaBp = dataProcessing.getBusinessProcess().getBusinessSubProcesses();
		model.addAttribute("outputObjects", outputObjects);
		model.addAttribute("currentGroup", currentGroup);
		model.addAttribute("stepRList", stepRList);
		model.addAttribute("dataProcessing", dataProcessing);
		model.addAttribute("tipoCampo", typeIO);
		model.addAttribute("bProcess", listaBp);
		model.addAttribute(IS2Const.LIST_BUSINESS_PROCESS, listaBp);

		return "workflow/view_data";

	}

	@GetMapping(value = "/dataview/{idelab}/{tipoIO}/{outRole}")
	public String viewDataOut(HttpSession session, Model model, @PathVariable("idelab") Long dataProcessingId,
			@PathVariable("tipoIO") Short tipoIO, @PathVariable("outRole") Integer outRole) {
		notificationService.removeAllMessages();

		List<StepRuntime> stepRList = new ArrayList<>();
		List<BusinessProcess> listaBp = new ArrayList<>();
		DataProcessing dataProcessing = workflowService.findDataProcessing(dataProcessingId);
		TypeIO typeIO = new TypeIO(tipoIO);

		List<AppRole> outputObjects = workflowService.getOutputRoleGroupsStepRuntimes(dataProcessingId, typeIO,null);

		AppRole currentGroup =appRoleService.findRuolo(outRole);
		stepRList = workflowService.getStepRuntimesDataTypeNoValues(dataProcessingId,null, typeIO, currentGroup);

		listaBp = dataProcessing.getBusinessProcess().getBusinessSubProcesses();
		model.addAttribute("outputObjects", outputObjects);
		model.addAttribute("currentGroup", currentGroup);
		model.addAttribute("stepRList", stepRList);
		model.addAttribute("dataProcessing", dataProcessing);
		model.addAttribute("tipoCampo", typeIO);
		model.addAttribute("bProcess", listaBp);
		model.addAttribute(IS2Const.LIST_BUSINESS_PROCESS, listaBp);

		return "workflow/view_data";

	}

	@GetMapping(value = "/chiudiElab/{id}")
	public String chiudiWS(HttpSession session, Model model, @PathVariable("id") Long id) {
		notificationService.removeAllMessages();

		DataProcessing dataProcessing = workflowService.findDataProcessing(id);
		session.removeAttribute(IS2Const.SESSION_DATAPROCESSING);

		// Create session DTO
		SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
		sessionBean.setBusinessProcess(null);
		sessionBean.setDataProcessingId(Long.valueOf("-1"));
		session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);

		return "redirect:/sessione/apri/" + dataProcessing.getWorkSession().getId();
	}

	@GetMapping(value = "/elimina/{dataProcessingId}/{idsessione}")
	public String eliminaWS(HttpSession session, Model model, @AuthenticationPrincipal User user,
			@PathVariable("dataProcessingId") Long dataProcessingId, @PathVariable("idsessione") Long idsessione) {
		notificationService.removeAllMessages();
		
		try {
			workflowService.eliminaDataProcessing(dataProcessingId);
			notificationService.addInfoMessage(
	                messages.getMessage("process.removed.message", null, LocaleContextHolder.getLocale()));	
		}catch(Exception e) {
			notificationService.addErrorMessage(
                    messages.getMessage("process.removing.error", null, LocaleContextHolder.getLocale()), e.getMessage());
		}
		
		List<WorkSession> listasessioni = workSessionService.getSessioneList(user);
		model.addAttribute("listasessioni", listasessioni);

		logService.save("Elaborazione " + dataProcessingId + " Eliminata con successo");

		return "redirect:/sessione/apri/" + idsessione;
	}

	/*
	@GetMapping(value = "/dobproc/{dataProcessingId}/{idBProc}")
	public String dobproc(HttpSession session, Model model, @PathVariable("dataProcessingId") Long dataProcessingId,
			@PathVariable("idBProc") Long idBProc) throws REngineException {
		notificationService.removeAllMessages();

		Elaborazione dataProcessing = workflowService.findElaborazione(dataProcessingId);
		try {
			dataProcessing = workflowService.doBusinessProc(dataProcessing, idBProc);
			notificationService.addInfoMessage(messages.getMessage("run.ok", null, LocaleContextHolder.getLocale()));
		} catch (Exception e) {
			notificationService.addErrorMessage("Error: " + e.getMessage());
		}

		List<stepRuntime> stepRList = workflowService.getstepRuntimesTipoCampoNoValori(dataProcessingId,
				new DataTypeCls(IS2Const.WORKSET_TIPO_VARIABILE), new TipoCampo(IS2Const.TIPO_CAMPO_ELABORATO), null);
		List<BusinessProcess> listaBp = dataProcessing.getBusinessProcess().getBusinessSubProcesses();

		BusinessProcess bProcess = Utility.getBusinessProcess(listaBp, idBProc);
		model.addAttribute("stepRList", stepRList);
		model.addAttribute("dataProcessing", dataProcessing);
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
			@ModelAttribute("associazioneVarFormBean") MappingVarsFormBean form) {
		DataProcessing dataProcessing = workflowService.findDataProcessing(Long.parseLong(form.getDataProcessing()[0]));
		workflowService.creaAssociazioni(form, dataProcessing);
		model.addAttribute("dataProcessing", dataProcessing);
		notificationService.addInfoMessage("L'associazione è stata aggiunta");

		return "redirect:/ws/editworkingset/" + dataProcessing.getId();
	}

	@RequestMapping(value = "/associavariabileSum/{idvar}/{idvarsum}", method = RequestMethod.POST)
	public String associavariabileSum(HttpSession session, Model model, @RequestParam("idvar") Long idVar,
			@RequestParam("idvarsum") Long idVarSum,
			@ModelAttribute("associazioneVarFormBean") MappingVarsFormBean form) {
		DataProcessing dataProcessing = workflowService.findDataProcessing(Long.parseLong(form.getDataProcessing()[0]));
		workflowService.creaAssociazioni(form, dataProcessing);
		model.addAttribute("dataProcessing", dataProcessing);
		notificationService.addInfoMessage("L'associazione è stata aggiunta");

		return "redirect:/ws/editworkingset/" + idVar + "/" + idVarSum;
	}

	@RequestMapping(value = "/updateassociavariabile", method = RequestMethod.POST)
	public String updateAssociavariabileWS(HttpSession session, Model model,
			@ModelAttribute("associazioneVarFormBean") MappingVarsFormBean form) {
		DataProcessing dataProcessing = workflowService.findDataProcessing(Long.parseLong(form.getDataProcessing()[0]));
		workflowService.updateAssociazione(form, dataProcessing);
		model.addAttribute("dataProcessing", dataProcessing);
		notificationService.addInfoMessage("L'associazione è stata modificata");

		return "redirect:/ws/editworkingset/" + dataProcessing.getId();
	}

	@RequestMapping(value = "/assegnaparametri", method = RequestMethod.POST)
	public String assegnaparametriWS(HttpSession session, Model model, RedirectAttributes ra,
			@RequestParam("dataProcessingId") Long dataProcessingId, @RequestParam("parametri") String parametri,
			@RequestParam("valoreParam") String valoreParam) {

		MappingVarsFormBean form2 = new MappingVarsFormBean();
		String[] dataProcessingIdList = { dataProcessingId + "" };
		form2.setDataProcessing(dataProcessingIdList);
		String[] params = { parametri };
		form2.setParameters(params);
		String[] valori = { valoreParam };
		form2.setValue(valori);
		DataProcessing dataProcessing = workflowService.findDataProcessing(dataProcessingId);
		workflowService.associaParametri(form2, dataProcessing);
		notificationService.addInfoMessage("Parametro inserito correttamente");

		model.addAttribute("dataProcessing", dataProcessing);
		ra.addFlashAttribute("showTabParam", true);
		return "redirect:/ws/editworkingset/" + dataProcessing.getId();
	}

	@RequestMapping(value = "modificaparametro", method = RequestMethod.POST)
	public String modificaparametro(HttpSession session, Model model, RedirectAttributes ra,
			@RequestParam("dataProcessingId") Long dataProcessingId, @RequestParam("parametri") String parametri,
			@RequestParam("valoreParam") String valoreParam, @RequestParam("idStepRunMod") String idStepRunMod) {

		MappingVarsFormBean form2 = new MappingVarsFormBean();
		String[] dataProcessingIdList = { dataProcessingId + "" };
		form2.setDataProcessing(dataProcessingIdList);
		String[] params = { parametri };
		form2.setParameters(params);
		form2.setIdStepRuntime(idStepRunMod);
		String[] valori = { valoreParam };
		form2.setValue(valori);

		DataProcessing dataProcessing = workflowService.findDataProcessing(dataProcessingId);

		workflowService.updateParametri(form2, dataProcessing);
		notificationService.addInfoMessage("Parametro modificato");

		model.addAttribute("dataProcessing", dataProcessing);
		ra.addFlashAttribute("showTabParam", "parametri");
		return "redirect:/ws/editworkingset/" + dataProcessing.getId();
	}
	
	@RequestMapping(value = "/setruleset", method = RequestMethod.POST)
	public String setRuleset(HttpSession session, Model model, RedirectAttributes ra,
			@RequestParam("dataProcessingId") Long dataProcessingId, 		
			@RequestParam("idRuleset") Integer idRuleset) {
		
		DataProcessing dataProcessing = workflowService.findDataProcessing(dataProcessingId);
		try {
			workflowService.setRuleset(dataProcessing,idRuleset);
			notificationService.addInfoMessage(messages.getMessage("process.setresulset.ok", null, LocaleContextHolder.getLocale()));
		} catch (Exception e) {
			notificationService.addErrorMessage("Error: " + e.getMessage());
		}
	 
		model.addAttribute("dataProcessing", dataProcessing);
		ra.addFlashAttribute("showTab", "resultset");
		return "redirect:/ws/editworkingset/" + dataProcessing.getId();
	}
}
