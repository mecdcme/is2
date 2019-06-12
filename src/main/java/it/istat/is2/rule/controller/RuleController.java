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
import it.istat.is2.app.bean.SessionBean;
import it.istat.is2.app.domain.Log;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.service.LogService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.FileHandler;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.dataset.domain.DatasetColonna;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.dataset.service.DatasetService;
import it.istat.is2.workflow.domain.SxRuleset;
import it.istat.is2.workflow.domain.SxTipoDato;
import it.istat.is2.workflow.service.TipoDatoService;
import it.istat.is2.worksession.domain.WorkSession;
import it.istat.is2.worksession.service.WorkSessionService;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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
    private TipoDatoService tipoDatoService;
    @Autowired
    private LogService logService;

    @RequestMapping(value = "/loadRulesFile", method = RequestMethod.POST)
	public String loadInputData(HttpSession session, HttpServletRequest request, Model model,
			@AuthenticationPrincipal User user, @ModelAttribute("inputFormBean") InputFormBean form)
			throws IOException {

		notificationService.removeAllMessages();

		String labelFile = form.getLabelFile();
		Integer tipoDato = form.getTipoDato();
		String separatore = form.getDelimiter();
		String idsessione = form.getIdsessione();

		File f = FileHandler.convertMultipartFileToFile(form.getFileName());
		String pathTmpFile = f.getAbsolutePath().replace("\\", "/");

		HashMap<Integer, String> valoriHeaderNum = null;
		try {
			valoriHeaderNum = FileHandler.getCampiHeaderNumIndex(pathTmpFile, separatore.toCharArray()[0]);
		} catch (Exception e) {
			notificationService.addErrorMessage(
					messages.getMessage("file.read.error", null, LocaleContextHolder.getLocale()), e.getMessage());
			return "redirect:/sessione/mostradataset/" + idsessione;
		}

		HashMap<String, ArrayList<String>> campiL = null;
		try {
			campiL = FileHandler.getArrayListFromCsv2(pathTmpFile, form.getNumeroCampi(), separatore.toCharArray()[0],
					valoriHeaderNum);
		} catch (Exception e) {
			notificationService.addErrorMessage(
					messages.getMessage("file.read.error", null, LocaleContextHolder.getLocale()), e.getMessage());
		}

		try {
			datasetService.salva(campiL, valoriHeaderNum, labelFile, tipoDato, separatore, form.getDescrizione(),
					idsessione);
			logService.save("File " + labelFile + " salvato con successo", user.getUserid(),
					Long.parseLong(idsessione));
			notificationService.addInfoMessage("Salvataggio avvenuto con successo.");

			SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
			sessionBean.getFile().add(form.getDescrizione());
			session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);
		} catch (Exception e) {
			notificationService.addErrorMessage("Errore nel salvataggio del file.");
			return "redirect:/sessione/mostradataset/" + idsessione;
		}

		return "redirect:/sessione/mostradataset/" + idsessione;
	}
    @GetMapping(value = "/roles/viewRoleset/{id}")
	public String mostradataset(HttpSession session, Model model, @PathVariable("id") Long id) {

		List<Log> logs = logService.findByIdSessione(id);

		WorkSession sessionelv = sessioneLavoroService.getSessione(id);
		if (sessionelv.getDatasetFiles() != null) {
			session.setAttribute(IS2Const.SESSION_DATASET, true);
		}

		List<SxRuleset> listaRuleSet = sessionelv.getRuleSets();
		List<DatasetFile> listaDataset = sessionelv.getDatasetFiles();
		//List<SxTipoDato> listaTipoDato = tipoDatoService.findListTipoDato();

		Long etichetta = new Long(0);

		if (listaDataset != null && !listaDataset.isEmpty()) {
			DatasetFile lastDS = listaDataset.get(listaDataset.size() - 1);

			etichetta = lastDS.getId() + 1;

		}

		session.setAttribute(IS2Const.SESSION_LV, sessionelv);

		//model.addAttribute("listaTipoDato", listaTipoDato);
		model.addAttribute("listaRuleSet", listaRuleSet);
		model.addAttribute("logs", logs);
		model.addAttribute("etichetta", etichetta);
		return "ruleset/list";
	}
    @RequestMapping("/viewRuleset/{idfile}")
    public String caricafile(HttpSession session, Model model, @PathVariable("idfile") Long idfile) {

        notificationService.removeAllMessages();

        DatasetFile dfile = datasetService.findDataSetFile(idfile);

        List<DatasetColonna> colonne = datasetService.findAllNomeColonne(idfile);

        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idfile);
        model.addAttribute("dfile", dfile);

        return "ruleset/preview";
    }
}
