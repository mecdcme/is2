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
import it.istat.is2.app.domain.Log;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.service.LogService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.FileHandler;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.dataset.domain.DatasetColonna;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.dataset.service.DatasetService;
import it.istat.is2.rule.service.RuleService;
import it.istat.is2.workflow.domain.SxRule;
import it.istat.is2.workflow.domain.SxRuleType;
import it.istat.is2.workflow.domain.SxRuleset;
import it.istat.is2.worksession.domain.WorkSession;
import it.istat.is2.worksession.service.WorkSessionService;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
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
	private DatasetService datasetService;
	@Autowired
	ServletContext context;
	@Autowired
	private NotificationService notificationService;
	@Autowired
	private MessageSource messages;
	@Autowired
	private WorkSessionService sessioneLavoroService;
	@Autowired
	private RuleService ruleService;
	@Autowired
	private LogService logService;
 

	@RequestMapping(value = "/loadRulesFile", method = RequestMethod.POST)
	public String loadInputRulesData(HttpSession session, HttpServletRequest request, Model model,
			@AuthenticationPrincipal User user, @ModelAttribute("inputFormBean") InputFormBean form)
			throws IOException {

		notificationService.removeAllMessages();

		String descrizione = form.getDescrizione();
		String idclassificazione = form.getClassificazione();
		String separatore = form.getDelimiter();
		String idsessione = form.getIdsessione();

		File fileRules = FileHandler.convertMultipartFileToFile(form.getFileName());

		int rules = ruleService.loadRules(fileRules, idsessione, descrizione, idclassificazione, separatore);
        logService.save("Caricate " + rules + " regole");
        

		return "redirect:/rule/viewRuleset/" + idsessione;
	}

	@GetMapping(value = "/viewRuleset/{id}")
	public String mostraroleset(HttpSession session, Model model, @PathVariable("id") Long id) {

		List<Log> logs = logService.findByIdSessione(id);

		WorkSession sessionelv = sessioneLavoroService.getSessione(id);
		if (sessionelv.getDatasetFiles() != null) {
			session.setAttribute(IS2Const.SESSION_DATASET, true);
		}

		List<SxRuleset> listaRuleSet = sessionelv.getRuleSets();

		List<SxRuleType> listaRuleType = ruleService.findAllRuleType();

		session.setAttribute(IS2Const.SESSION_LV, sessionelv);

		model.addAttribute("listaRuleSet", listaRuleSet);
		model.addAttribute("listaRuleType", listaRuleType);
		model.addAttribute("logs", logs);

		return "ruleset/list";
	}

	@RequestMapping("/viewRules/{idfile}")
	public String caricafile(HttpSession session, Model model, @PathVariable("idfile") Integer  idfile) {

		notificationService.removeAllMessages();
		SxRuleset ruleset=ruleService.findRuleSet(idfile);
 
		model.addAttribute("ruleset", ruleset);
	 
		return "ruleset/preview";
	}
}
