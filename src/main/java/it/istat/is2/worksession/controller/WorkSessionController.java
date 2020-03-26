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
package it.istat.is2.worksession.controller;

import it.istat.is2.app.bean.BusinessFunctionBean;
import java.util.Date;
import java.util.List;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import it.istat.is2.app.bean.ElaborazioneFormBean;
import it.istat.is2.app.bean.NotificationMessage;
import it.istat.is2.app.bean.SessionBean;
import it.istat.is2.app.domain.Log;
import it.istat.is2.app.service.DataProcessingService;
import it.istat.is2.app.service.LogService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.rule.domain.Ruleset;
import it.istat.is2.workflow.domain.DataProcessing;
import it.istat.is2.workflow.domain.ViewDataType;
import it.istat.is2.workflow.domain.BusinessFunction;
import it.istat.is2.workflow.domain.BusinessProcess;
import it.istat.is2.workflow.service.BusinessFunctionService;
import it.istat.is2.workflow.service.BusinessProcessService;
import it.istat.is2.worksession.domain.WorkSession;
import it.istat.is2.worksession.service.WorkSessionService;

import java.security.Principal;
import java.util.ArrayList;

@Controller
public class WorkSessionController {

	@Autowired
	private WorkSessionService workSessionService;
	@Autowired
	private NotificationService notificationService;
	@Autowired
	private DataProcessingService dataProcessingService;
	@Autowired
	private BusinessProcessService businessProcessService;
	@Autowired
	private BusinessFunctionService businessFunctionService;
	@Autowired
	private LogService logService;
	@Autowired
	private MessageSource messages;

	@GetMapping(value = "/sessione/mostraSessioni/{idBusinessFunction}")
	public String mostraSessioni(HttpSession session, Model model, @AuthenticationPrincipal Principal user,
			@PathVariable("idBusinessFunction") Long idBusinessFunction,
			@ModelAttribute("message") NotificationMessage messsage) {
		notificationService.removeAllMessages();
		notificationService.addMessage(messsage);

		SessionBean sessionBean = new SessionBean();
		BusinessFunction businessFunction = businessFunctionService.findBFunctionById(idBusinessFunction);
		BusinessFunctionBean businessFunctionBean = new BusinessFunctionBean(businessFunction.getId(),
				businessFunction.getName());
		sessionBean.setBusinessFunction(businessFunctionBean);
		session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);

		List<WorkSession> listasessioni = workSessionService.getSessioneList(user.getName(), idBusinessFunction);
		model.addAttribute("listasessioni", listasessioni);

		return "worksession/list";
	}

	@PostMapping(value = "/sessione/nuovasessione")
	public String nuovaSessione(HttpSession session, RedirectAttributes ra, Model model,
			@AuthenticationPrincipal Principal user, @RequestParam("descrizione") String descrizione,
			@RequestParam("nome") String nome, @RequestParam("idBusinessFunction") Long idBusinessFunction) {
		notificationService.removeAllMessages();
		NotificationMessage message;
		try {
			WorkSession workSession = workSessionService.newWorkSession(user.getName(), descrizione, nome,
					idBusinessFunction);
			message = new NotificationMessage(NotificationMessage.TYPE_SUCCESS,
					messages.getMessage("session.created.success", new Object[] { workSession.getName() },
							LocaleContextHolder.getLocale()));

		} catch (Exception e) {
			message = new NotificationMessage(NotificationMessage.TYPE_ERROR,
					messages.getMessage("session.created.error", null, LocaleContextHolder.getLocale()),
					e.getMessage());
		}
		ra.addFlashAttribute("message", message);
		return "redirect:/sessione/mostraSessioni/" + idBusinessFunction;
	}

	@GetMapping(value = "/sessione/apriseselab/{idSessione}/{idElaborazione}")
	public String apriSesElab(HttpSession session, Model model, @AuthenticationPrincipal Principal user,
			@PathVariable("idSessione") Long idSessione, @PathVariable("idElaborazione") Long idElaborazione) {

		WorkSession workSession = workSessionService.getSessione(idSessione);
		if (workSession.getDatasetFiles() != null) {
			session.setAttribute(IS2Const.SESSION_DATASET, true);
		}
		session.setAttribute(IS2Const.SESSION_BEAN, new SessionBean(idSessione, workSession.getName()));

		return "redirect:/ws/home/" + idElaborazione;
	}

	@GetMapping(value = "/sessione/apri/{id}")
	public String apriSessione(HttpSession session, Model model, @PathVariable("id") Long id) {

		// notificationService.removeAllMessages();

		List<Log> logs = logService.findByIdSessione(id);

		WorkSession workSession = workSessionService.getSessione(id);
		SessionBean sessionBean;

		List<DataProcessing> listaElaborazioni = dataProcessingService.getDataProcessingList(workSession);
		List<BusinessProcess> processesList = businessProcessService
				.findBProcessByIdFunction(workSession.getBusinessFunction().getId());

		sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
		sessionBean.setId(id);
		sessionBean.setName(workSession.getName());

		List<String> files;
		List<String> rulesets;

		if (workSession.getBusinessFunction().getViewDataType()
				.contains(new ViewDataType(IS2Const.VIEW_DATATYPE_DATASET))) {
			files = new ArrayList<String>();
			if (workSession.getDatasetFiles() != null) {
				session.setAttribute(IS2Const.SESSION_DATASET, true);
				for (DatasetFile datasetFile : workSession.getDatasetFiles()) {
					files.add(datasetFile.getFileName());
				}
			}
			sessionBean.setFile(files);
		}
		if (workSession.getBusinessFunction().getViewDataType()
				.contains(new ViewDataType(IS2Const.VIEW_DATATYPE_RULESET))) {
			rulesets = new ArrayList<String>();
			if (workSession.getRuleSets() != null) {
				for (Ruleset ruleset : workSession.getRuleSets()) {
					rulesets.add(ruleset.getFileName());
				}
			}
			sessionBean.setRuleset(rulesets);
		}

		session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);

		model.addAttribute("processesList", processesList);
		model.addAttribute("listaElaborazioni", listaElaborazioni);
		model.addAttribute("logs", logs);

		return "worksession/home";
	}

	@PostMapping(value = "/sessione/nuovoworkingset")
	public String nuovoWorkingSet(HttpSession session, RedirectAttributes ra, Model model,
			@AuthenticationPrincipal Principal user,
			@ModelAttribute("elaborazioneFormBean") ElaborazioneFormBean form) {
		notificationService.removeAllMessages();

		session.setAttribute(IS2Const.WORKINGSET, "workingset");
		WorkSession workSession = workSessionService.getSessione(form.getIdsessione());
		try {
			DataProcessing elaborazione = new DataProcessing();
			elaborazione.setWorkSession(workSession);
			elaborazione.setDescr(form.getDescrizione());
			elaborazione.setName(form.getNome());
			elaborazione.setLastUpdate(new Date());
			elaborazione.setBusinessProcess(businessProcessService.findBProcessById(form.getIdfunzione()));

			dataProcessingService.saveDataProcessing(elaborazione);

			notificationService.addInfoMessage(
					messages.getMessage("creation.process.success", null, LocaleContextHolder.getLocale()));

			logService.save("Elaborazione " + elaborazione.getName() + " creata con successo");

		} catch (Exception e) {

			notificationService.addErrorMessage(
					messages.getMessage("process.create.error", null, LocaleContextHolder.getLocale()), e.getMessage());
		}

		return "redirect:/sessione/apri/" + workSession.getId();
	}

	@GetMapping(value = "/sessione/workingset/{id}")
	public String workingSet(HttpSession session, Model model, @PathVariable("id") Long id) {
		session.setAttribute(IS2Const.WORKINGSET, "workingset");
		return "elaborazione/nuovo_ws";
	}

	@GetMapping(value = "/sessione/chiudisessione/{idBusinessFunction}")
	public String chiudiSessione(HttpSession session, @PathVariable("idBusinessFunction") Long idBusinessFunction) {
		session.removeAttribute(IS2Const.SESSION_BEAN);
		session.removeAttribute(IS2Const.SESSION_DATASET);
		session.removeAttribute(IS2Const.SESSION_DATAPROCESSING);
		return "redirect:/sessione/mostraSessioni/" + idBusinessFunction;
	}

	@GetMapping(value = "/sessione/elimina/{idsessione}")
	public String eliminaWS(HttpSession session, Model model, RedirectAttributes ra,
			@PathVariable("idsessione") Long idsessione) {
		notificationService.removeAllMessages();
		NotificationMessage message;
		WorkSession workSession = workSessionService.getSessione(idsessione);
		if (workSessionService.deleteWorkSession(idsessione)) {
			message = new NotificationMessage(NotificationMessage.TYPE_SUCCESS,
					messages.getMessage("session.removed.success", new Object[] { workSession.getName() },
							LocaleContextHolder.getLocale()));
		} else {
			message = new NotificationMessage(NotificationMessage.TYPE_ERROR,
					messages.getMessage("session.removed.success", null, LocaleContextHolder.getLocale()));
		}
		SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
		session.removeAttribute(IS2Const.SESSION_DATAPROCESSING);
		ra.addFlashAttribute("message", message);
		return "redirect:/sessione/mostraSessioni/" + sessionBean.getBusinessFunction().getId();
	}
}
