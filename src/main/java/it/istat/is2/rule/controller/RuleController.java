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
package it.istat.is2.rule.controller;

import it.istat.is2.app.bean.InputFormBean;
import it.istat.is2.app.bean.NewRuleFormBean;
import it.istat.is2.app.bean.NewRulesetFormBean;
import it.istat.is2.app.bean.SessionBean;
import it.istat.is2.app.domain.Log;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.service.LogService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.FileHandler;
import it.istat.is2.app.util.IS2Const;
import static it.istat.is2.app.util.IS2Const.OUTPUT_R;

import it.istat.is2.dataset.domain.DatasetColonna;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.dataset.service.DatasetService;
import it.istat.is2.rule.service.RuleService;
import it.istat.is2.workflow.domain.SxClassification;
import it.istat.is2.workflow.domain.SxRule;
import it.istat.is2.workflow.domain.SxRuleset;
import it.istat.is2.worksession.domain.WorkSession;
import it.istat.is2.worksession.service.WorkSessionService;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/rule")
@Controller
public class RuleController {

	@Autowired
	ServletContext context;
	@Autowired
	private MessageSource messages;
	@Autowired
	private NotificationService notificationService;
	@Autowired
	private WorkSessionService sessioneLavoroService;
	@Autowired
	private RuleService ruleService;
	@Autowired
	private LogService logService;
	@Autowired
	private DatasetService datasetService;

	@RequestMapping(value = "/loadRulesFile", method = RequestMethod.POST)
	public String loadInputRulesData(HttpSession httpSession, HttpServletRequest request, Model model,
			@AuthenticationPrincipal User user, @ModelAttribute("inputFormBean") InputFormBean form)
			throws IOException {

		notificationService.removeAllMessages();

		String nomeFile = form.getName();
		String descrizione = form.getDescrizione();
		String etichetta = form.getLabelFile();
		String idclassificazione = form.getClassificazione();
		String separatore = form.getDelimiter();
		String idsessione = form.getIdsessione();
		Integer skipFirstLine = form.getSkipFirstLine();

		File fileRules = FileHandler.convertMultipartFileToFile(form.getFileName());	
		

		int rules = ruleService.loadRules(fileRules, idsessione, etichetta, idclassificazione, separatore, nomeFile, descrizione,
				skipFirstLine);
		logService.save("Caricate " + rules + " regole");

		SessionBean sessionBean = (SessionBean) httpSession.getAttribute(IS2Const.SESSION_BEAN);
		sessionBean.getRuleset().add(nomeFile);
		httpSession.setAttribute(IS2Const.SESSION_BEAN, sessionBean);

		return "redirect:/rule/viewRuleset/" + idsessione;
	}

	@RequestMapping(value = "/newRuleset", method = RequestMethod.POST)
	public String newRulesetData(HttpSession session, HttpServletRequest request, Model model,
			@AuthenticationPrincipal User user, @ModelAttribute("inputFormBean") NewRulesetFormBean form)
			throws IOException {

		notificationService.removeAllMessages();
		List<Log> logs = logService.findByIdSessione(Long.parseLong(form.getIdsessione()));
		List<Log> rlogs = logService.findByIdSessioneAndTipo(Long.parseLong(form.getIdsessione()), OUTPUT_R);

		List<SxClassification> listaClassificazioni1 = new ArrayList<SxClassification>();
		SxClassification nullClass = new SxClassification();
		nullClass.setId((short) -1);
		nullClass.setNome("--");
		listaClassificazioni1.add(nullClass);

		List<SxClassification> listaClassificazioni2 = ruleService.findAllClassifications();
		listaClassificazioni1.addAll(listaClassificazioni2);

		List<SxClassification> listaClassificazioni3 = new ArrayList<SxClassification>();
		SxClassification onlyDominio = new SxClassification();
		onlyDominio.setId((short) 1);
		onlyDominio.setNome("Dominio");
		listaClassificazioni3.add(onlyDominio);

		String nomeRuleset = form.getRulesetName();

		String descrRuleset = form.getRulesetDesc();
		Long dataset = form.getDataset();
		DatasetFile dfile = null;
		List<DatasetColonna> colonne = null;
		SxRuleset ruleset = new SxRuleset();

		if (dataset != -1) {
			dfile = datasetService.findDataSetFile(dataset);
			colonne = datasetService.findAllNomeColonne(dataset);
			ruleset.setDatasetFile(dfile);
			model.addAttribute("listaClassificazioni", listaClassificazioni3);
		} else {
			model.addAttribute("listaClassificazioni", listaClassificazioni1);
		}

		WorkSession sessionelv = sessioneLavoroService.getSessione(new Long(form.getIdsessione()));

		ruleset.setLabelFile(nomeRuleset);
		ruleset.setDescr(descrRuleset);
		ruleset.setSessioneLavoro(sessionelv);

		model.addAttribute("colonne", colonne);
		SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);

		sessionBean.setDataset(dataset);
		session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);
		session.setAttribute("dfile", dfile);
		model.addAttribute("ruleset", ruleset);
		model.addAttribute("logs", logs);
		model.addAttribute("rlogs", rlogs);

		ruleService.saveRuleSet(ruleset);
		return "redirect:/rule/viewRuleset/" + sessionelv.getId();

	}

	@RequestMapping(value = "/modificaRuleset", method = RequestMethod.POST)
	public String modificaRuleset(HttpSession session, HttpServletRequest request, Model model,
			@AuthenticationPrincipal User user, @ModelAttribute("inputFormBean") NewRulesetFormBean form)
			throws IOException {

		SxRuleset ruleset = ruleService.findRulesetById(Integer.parseInt(form.getRulesetId()));

		String nomeRuleset = form.getRulesetName();
		String descrRuleset = form.getRulesetDesc();
		Long datasetid = form.getDataset();
		DatasetFile ds = datasetService.findDataSetFile(datasetid);

		ruleset.setLabelFile(nomeRuleset);
		ruleset.setDescr(descrRuleset);
		ruleset.setDatasetFile(ds);

		WorkSession sessionelv = sessioneLavoroService.getSessione(new Long(form.getIdsessione()));

		ruleService.saveRuleSet(ruleset);
		return "redirect:/rule/viewRuleset/" + sessionelv.getId();

	}

	@RequestMapping(value = "/newRule", method = RequestMethod.POST)
	public String newRule(HttpSession session, HttpServletRequest request, Model model,
			@AuthenticationPrincipal User user, @ModelAttribute("inputFormBean") NewRuleFormBean form)
			throws IOException {

		notificationService.removeAllMessages();

		String nomeRule = form.getRuleName();

		// short tipoRule = form.getRuleType();
		String descrRule = form.getRuleDesc();
		Integer idRuleset = form.getIdruleset();
		String textRule = form.getRuleText();
		short idclassification = form.getClassification();
		Integer idVar = form.getIdcol();

		SxRuleset ruleset = ruleService.findRulesetById(idRuleset);
		SxRule sxrule = new SxRule();

		// SxRuleType ruletype = ruleService.findRuleTypeById(tipoRule);
		SxClassification classification = ruleService.findClassificationById(idclassification);

		sxrule.setNome(nomeRule);
		sxrule.setDescr(descrRule);
		sxrule.setActive((short) 1);
		// sxrule.setRuleType(ruletype);
		sxrule.setRule(textRule);
		sxrule.setSxRuleset(ruleset);
		sxrule.setSxClassification(classification);
		sxrule.setVariabile(idVar);

		List<SxRule> rules = ruleset.getSxRules();
		rules.add(sxrule);

		try {
			ruleService.saveRuleSet(ruleset);
		} catch (Exception e) {
			notificationService.addErrorMessage(
					messages.getMessage("rules.save.error", null, LocaleContextHolder.getLocale()), e.getMessage());

		}

		notificationService.addInfoMessage("Salvataggio avvenuto con successo.");
		WorkSession sessionelv = sessioneLavoroService.getSessione(new Long(form.getIdsessione()));

		ruleset.setSessioneLavoro(sessionelv);

		SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);

		session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);
		model.addAttribute("ruleset", ruleset);

		ruleService.saveRuleSet(ruleset);
		return "redirect:/rule/viewRules/" + ruleset.getId();

	}

	@GetMapping(value = "/viewRuleset/{id}")
	public String mostraroleset(HttpSession session, Model model, @PathVariable("id") Long id) {

		List<Log> logs = logService.findByIdSessione(id);
		List<Log> rlogs = logService.findByIdSessioneAndTipo(id, OUTPUT_R);

		WorkSession sessionelv = sessioneLavoroService.getSessione(id);
		List<DatasetFile> listaDSFile = new ArrayList<DatasetFile>();

		DatasetFile fakeFile = new DatasetFile();
		fakeFile.setId(new Long(-1));
		fakeFile.setNomeFile("--");
		listaDSFile.add(fakeFile);

		List<DatasetFile> listaDatasetFile = datasetService.findDatasetFilesByIdSessioneLavoro(id);

		listaDSFile.addAll(listaDatasetFile);

		List<SxRuleset> listaRuleSet = sessionelv.getRuleSets();
		String etichetta = null;
		if (listaRuleSet != null && listaRuleSet.size() > 0) {
			etichetta = "RS_" + Integer.toString(listaRuleSet.size() + 1);
		} else {
			etichetta = "RS_1";
		}
		SxRuleset rs;
		for (int i = 0; i < listaRuleSet.size(); i++) {
			rs = listaRuleSet.get(i);
			if (rs.getDatasetFile() == null) {
				rs.setNumeroRighe(rs.getSxRules().size());
			}
		}

		List<SxClassification> listaClassificazioni3 = new ArrayList<SxClassification>();
		SxClassification onlyDominio = new SxClassification();
		onlyDominio.setId((short) 1);
		onlyDominio.setNome("Dominio");
		listaClassificazioni3.add(onlyDominio);

		List<SxClassification> listaClassificazioni = ruleService.findAllClassifications();

		session.setAttribute(IS2Const.SESSION_LV, sessionelv);

		model.addAttribute("listaDatasetFile", listaDSFile);
		model.addAttribute("listaRuleSet", listaRuleSet);
		model.addAttribute("listaClassificazioni", listaClassificazioni);
		model.addAttribute("etichetta", etichetta);
		model.addAttribute("logs", logs);
		model.addAttribute("rlogs", rlogs);

		return "ruleset/list";
	}

	@RequestMapping("/viewRules/{idfile}")
	public String caricafile(HttpSession session, Model model, @PathVariable("idfile") Integer idfile) {

		session.removeAttribute("dfile");
		notificationService.removeAllMessages();
		List<Log> logs = logService.findByIdSessione();
		List<Log> rlogs = logService.findByIdSessioneAndTipo(OUTPUT_R);
		// TODO: Controllare findRulesetById
		SxRuleset ruleset = ruleService.findRulesetById(idfile);
		List<SxRule> rules = ruleService.findRules(ruleset);

		DatasetFile dfile = ruleset.getDatasetFile();

		/*
		 * List<SxClassification> listaClassificazioni1 = new
		 * ArrayList<SxClassification>(); SxClassification nullClass = new
		 * SxClassification(); nullClass.setId((short)-1); nullClass.setNome("--");
		 * listaClassificazioni1.add(nullClass);
		 */

		List<SxClassification> listaClassificazioni3 = new ArrayList<SxClassification>();
		SxClassification onlyDominio = new SxClassification();
		onlyDominio.setId((short) 1);
		onlyDominio.setNome("Dominio");
		listaClassificazioni3.add(onlyDominio);

		List<SxClassification> listaClassificazioni = ruleService.findAllClassifications();
		// listaClassificazioni1.addAll(listaClassificazioni2);

		model.addAttribute("ruleset", ruleset);
		model.addAttribute("rules", rules);
		if (dfile != null) {
			model.addAttribute("listaClassificazioni", listaClassificazioni3);
		} else {
			model.addAttribute("listaClassificazioni", listaClassificazioni);
		}
		session.setAttribute("dfile", dfile);
		model.addAttribute("logs", logs);
		model.addAttribute("rlogs", rlogs);

		return "ruleset/preview";
	}

	@GetMapping(value = "/deleteRuleset/{idSessione}/{idRuleset}")
	public String eliminaRuleset(HttpSession session, Model model, @PathVariable("idSessione") Long idSessione,
			@PathVariable("idRuleset") Integer idRuleset) {

		notificationService.removeAllMessages();

		ruleService.deleteRuleset(idRuleset);

		logService.save("Set di regole con id " + idRuleset + " eliminato con successo");
		notificationService.addInfoMessage("Eliminazione avvenuta con successo");

		SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
		sessionBean.getRuleset().remove(0);
		session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);

		return "redirect:/rule/viewRuleset/" + idSessione;
	}
}
