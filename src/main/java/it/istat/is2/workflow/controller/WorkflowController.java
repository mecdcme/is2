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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import it.istat.is2.app.bean.AssociazioneVarFormBean;
import it.istat.is2.app.bean.AssociazioneVarRoleBean;
import it.istat.is2.app.bean.BusinessFunctionBean;
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
import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.SXTipoCampo;
import it.istat.is2.workflow.domain.SxBusinessFunction;
import it.istat.is2.workflow.domain.SxBusinessProcess;
import it.istat.is2.workflow.domain.SxBusinessStep;
import it.istat.is2.workflow.domain.SxParPattern;
import it.istat.is2.workflow.domain.SxRuoli;
import it.istat.is2.workflow.domain.SxStepVariable;
import it.istat.is2.workflow.domain.SxTipoVar;
import it.istat.is2.workflow.domain.SxWorkset;
import it.istat.is2.workflow.service.BusinessFunctionService;
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
	private BusinessFunctionService businessFunctionService;
	@Autowired
	private DatasetService datasetService;
	@Autowired
	private StepVariableService stepVariableService;
	@Autowired
	private LogService logService;

	@GetMapping(value = "/home/{id}")
	public String homeWS(HttpSession session, Model model, @PathVariable("id") Long id) {
		notificationService.removeAllMessages();

		Elaborazione elaborazione = workflowService.findElaborazione(id);
		List<SxBusinessProcess> listaBp = elaborazione.getSxBusinessFunction().getSxBusinessProcesses();
		List<BusinessProcessBean> businessProcessBeans = new ArrayList<BusinessProcessBean>();
		List<SxStepVariable> listaSV = workflowService.getSxStepVariablesNoValori(elaborazione.getId(),
				new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
		model.addAttribute("stepVList", listaSV);

		// Create session DTO
		SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
		sessionBean.setIdElaborazione(elaborazione.getId());
		sessionBean.setNomeElaborazione(elaborazione.getNome());
		BusinessFunctionBean businessFunction = new BusinessFunctionBean();
		businessFunction.setId(elaborazione.getSxBusinessFunction().getId());
		businessFunction.setName(elaborazione.getSxBusinessFunction().getNome());
		for (SxBusinessProcess sbp : listaBp) {
			BusinessProcessBean businessProcessBean = new BusinessProcessBean();
			businessProcessBean.setId(sbp.getId());
			businessProcessBean.setName(sbp.getNome());
			List<ProcessStepBean> processStepBeans = new ArrayList<ProcessStepBean>();
			for (SxBusinessStep bpStep : sbp.getSxBusinessSteps()) {
				processStepBeans.add(new ProcessStepBean(bpStep.getId(), bpStep.getNome()));
			}
			businessProcessBean.setSteps(processStepBeans);
			businessProcessBeans.add(businessProcessBean);
		}
		businessFunction.setProcesses(businessProcessBeans);
		sessionBean.setBusinessFunction(businessFunction);
		session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);

		model.addAttribute("elaborazione", elaborazione);
		model.addAttribute(IS2Const.LISTA_BUSINESS_PROCESS, listaBp);

		List<Log> logs = logService.findByIdSessione(sessionBean.getId());
		model.addAttribute("logs", logs);

		return "workflow/home";
	}

	@GetMapping(value = "/eliminaAssociazione/{idelaborazione}/{idvar}")
	public String eliminaAssociazioneVar(HttpSession session, Model model,
			@PathVariable("idelaborazione") Long idelaborazione, @PathVariable("idvar") Integer idvar) {
		notificationService.removeAllMessages();

		SxStepVariable stepVar = stepVariableService.findById(idvar).get();
		List<SxStepVariable> listaVars = stepVar.getSxWorkset().getSxStepVariables();

		if (listaVars.size() == 1) {
			SxWorkset workset = (SxWorkset) listaVars.get(0).getSxWorkset();
			workflowService.deleteWorkset(workset);
		} else {
			// do nothing
		}

		stepVariableService.removeStepVarById(idvar);
		notificationService.addInfoMessage("La variabile è stata rimossa");

		return "redirect:/ws/editworkingset/" + idelaborazione;
	}

	@GetMapping(value = "/eliminaParametro/{idelaborazione}/{idparametro}")
	public String eliminaParametro(HttpSession session, Model model,
			@PathVariable("idelaborazione") Long idelaborazione, @PathVariable("idparametro") Integer idparametro) {
		notificationService.removeAllMessages();

		SxStepVariable stepVar = stepVariableService.findById(idparametro).get();
		List<SxStepVariable> listaVars = stepVar.getSxWorkset().getSxStepVariables();

		if (listaVars.size() == 1) {
			SxWorkset workset = (SxWorkset) listaVars.get(0).getSxWorkset();
			workflowService.deleteWorkset(workset);
		} else {
			// do nothing
		}

		stepVariableService.removeStepVarById(idparametro);
		notificationService.addInfoMessage("Il parametro è stato eliminato");

		return "redirect:/ws/editworkingset/" + idelaborazione;
	}

	@GetMapping(value = "/editworkingset/{idelaborazione}")
	public String editWorkingSet(HttpSession session, Model model,
			@PathVariable("idelaborazione") Long idElaborazione) {

		session.setAttribute(IS2Const.WORKINGSET, "workingset");

		Elaborazione elaborazione = elaborazioneService.findElaborazione(idElaborazione);

		SessionBean elaSession = new SessionBean(elaborazione.getId(), elaborazione.getNome());
		session.setAttribute(IS2Const.SESSION_ELABORAZIONE, elaSession);

		List<DatasetFile> datasetfiles = datasetService
				.findDatasetFilesByIdSessioneLavoro(elaborazione.getSessioneLavoro().getId());

		datasetfiles.forEach(datasetfile -> {
			// retrieve DatasetColonna without data
			List<DatasetColonna> colonne = datasetService.findAllNomeColonne(datasetfile);
			datasetfile.setColonne(colonne);

		});

		List<SxStepVariable> listaSV = workflowService.getSxStepVariablesNoValori(idElaborazione,
				new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
	
		
		
		List<SxBusinessFunction> listaFunzioni = businessFunctionService.findBFunctions();

		SxBusinessFunction businessFunction = elaborazione.getSxBusinessFunction();

		// Carica i Ruoli di input
		List<SxRuoli> listaRuoliInput = workflowService.findRuoliByFunction(businessFunction, 0);
		// Carica i Ruoli di input e output
		List<SxRuoli> listaRuoliInOut = workflowService.findRuoliByFunction(businessFunction, 1);
		
		List<SxStepVariable> listaSP = workflowService.getSxStepVariablesParametri(idElaborazione);
		List<SxParPattern> listaParametriAll = workflowService.findParametriByFunction(businessFunction);
		//remove assigned paramters
		ArrayList<String> paramAssigned=new ArrayList<>();
		List<SxParPattern> listaParametri=new ArrayList<>();
		listaSP.forEach(sxstepVaraible -> { paramAssigned.add(sxstepVaraible.getSxWorkset().getNome());});
		listaParametriAll.forEach(sxParPattern -> {
				if( !paramAssigned.contains(sxParPattern.getNome())) 
					listaParametri.add(sxParPattern) ;
				});
		
		
		
		List<SxBusinessProcess> listaBp = elaborazione.getSxBusinessFunction().getSxBusinessProcesses();

		model.addAttribute("bProcess", listaBp);
		model.addAttribute(IS2Const.LISTA_BUSINESS_PROCESS, listaBp);
		model.addAttribute("stepVList", listaSV);

		model.addAttribute("stepParamList", listaSP);

		model.addAttribute("listaRuoliInput", listaRuoliInput);
		model.addAttribute("listaRuoliInOut", listaRuoliInOut);
		model.addAttribute("listaParametri", listaParametri);
		model.addAttribute("listaParametriAll", listaParametriAll);
		model.addAttribute("listaFunzioni", listaFunzioni);
		model.addAttribute("datasetfiles", datasetfiles);
		model.addAttribute("elaborazione", elaborazione);
		model.addAttribute("businessFunction", businessFunction);

		return "workflow/edit";

	}

	@GetMapping(value = "/dataview/{idelab}/{tipoCampo}")
	public String viewDataProc(HttpSession session, Model model, @PathVariable("idelab") Long idelaborazione,
			@PathVariable("tipoCampo") Integer tipoCampo) {
		notificationService.removeAllMessages();
		List<SxStepVariable> listaSV = new ArrayList<>();
		List<SxBusinessProcess> listaBp = new ArrayList<>();
		SxRuoli currentGroup =new SxRuoli();
		Elaborazione elaborazione = workflowService.findElaborazione(idelaborazione);
		SXTipoCampo sxTipoCampo = workflowService.getTipoCampoById(tipoCampo);

		List<SxRuoli> outputObjects = workflowService.getOutputRoleGroupsStepVariables(idelaborazione,
				new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE), sxTipoCampo);
		if (!outputObjects.isEmpty()) {
			  currentGroup = outputObjects.get(0);
			listaSV = workflowService.getSxStepVariablesTipoCampoNoValori(idelaborazione,
					new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE), sxTipoCampo, currentGroup);
		}

		listaBp = elaborazione.getSxBusinessFunction().getSxBusinessProcesses();
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

		List<SxStepVariable> listaSV = new ArrayList<>();
		List<SxBusinessProcess> listaBp = new ArrayList<>();
		Elaborazione elaborazione = workflowService.findElaborazione(idelaborazione);
		SXTipoCampo sxTipoCampo = workflowService.getTipoCampoById(tipoCampo);

		List<SxRuoli> outputObjects = workflowService.getOutputRoleGroupsStepVariables(idelaborazione,
				new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE), sxTipoCampo);

		SxRuoli currentGroup = new SxRuoli(outRole);
		listaSV = workflowService.getSxStepVariablesTipoCampoNoValori(idelaborazione,
				new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE), sxTipoCampo, currentGroup);

		listaBp = elaborazione.getSxBusinessFunction().getSxBusinessProcesses();
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
		sessionBean.setBusinessFunction(null);
		sessionBean.setIdElaborazione(Long.valueOf("-1"));
		session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);

		return "redirect:/sessione/apri/" + elaborazione.getSessioneLavoro().getId();
	}

	@GetMapping(value = "/elimina/{idelaborazione}/{idsessione}")
	public String eliminaWS(HttpSession session, Model model, @AuthenticationPrincipal User user,
			@PathVariable("idelaborazione") Long idelaborazione, @PathVariable("idsessione") Long idsessione) {
		notificationService.removeAllMessages();
		notificationService.addInfoMessage("L'elaborazione è stata rimossa.");
		workflowService.eliminaElaborazione(idelaborazione);
		List<WorkSession> listasessioni = sessioneLavoroService.getSessioneList(user);
		model.addAttribute("listasessioni", listasessioni);

		logService.save("Elaborazione " + idelaborazione + " Eliminata con successo");

		// Create session DTO
		SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
		sessionBean.setBusinessFunction(null);
		session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);

		return "redirect:/sessione/apri/" + idsessione;
	}

	@GetMapping(value = "/dobproc/{idelaborazione}/{idBProc}")
	public String dobproc(HttpSession session,Model model, @PathVariable("idelaborazione") Long idelaborazione,
			@PathVariable("idBProc") Long idBProc) throws REngineException {
		notificationService.removeAllMessages();

		Elaborazione elaborazione = workflowService.findElaborazione(idelaborazione);
		try {
			elaborazione = workflowService.doBusinessProc(elaborazione, idBProc);
			notificationService.addInfoMessage(messages.getMessage("run.ok", null, LocaleContextHolder.getLocale()));
		} catch (Exception e) {
			notificationService.addErrorMessage("Error: " + e.getMessage());
		}

	

		List<SxStepVariable> listaSV = workflowService.getSxStepVariablesTipoCampoNoValori(idelaborazione,
				new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE), new SXTipoCampo(IS2Const.TIPO_CAMPO_ELABORATO), null);
		List<SxBusinessProcess> listaBp = elaborazione.getSxBusinessFunction().getSxBusinessProcesses();

		SxBusinessProcess bProcess = Utility.getSxBusinessProcess(listaBp, idBProc);
		model.addAttribute("stepVList", listaSV);
		model.addAttribute("elaborazione", elaborazione);
		model.addAttribute("bProcess", bProcess);
		model.addAttribute(IS2Const.LISTA_BUSINESS_PROCESS, listaBp);
	 
		SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
		List<Log> logs = logService.findByIdSessione(sessionBean.getId());
		model.addAttribute("logs", logs);
		

		return "workflow/home";
	}

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
	public String assegnaparametriWS(HttpSession session, Model model,
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

		return "redirect:/ws/editworkingset/" + elaborazione.getId();
	}

	@RequestMapping(value = "modificaparametro", method = RequestMethod.POST)
	public String modificaparametro(HttpSession session, Model model,
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

		return "redirect:/ws/editworkingset/" + elaborazione.getId();
	}

}
