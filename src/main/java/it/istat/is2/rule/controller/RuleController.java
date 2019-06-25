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
import it.istat.is2.app.bean.NewRulesetFormBean;
import it.istat.is2.app.bean.SessionBean;
import it.istat.is2.app.domain.Log;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.service.LogService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.FileHandler;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.dataset.service.DatasetService;
import it.istat.is2.rule.service.RuleService;
import it.istat.is2.workflow.domain.SxRule;
import it.istat.is2.workflow.domain.SxRuleType;
import it.istat.is2.workflow.domain.SxRuleset;
import it.istat.is2.worksession.domain.WorkSession;
import it.istat.is2.worksession.service.WorkSessionService;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
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

        String nomeFile = form.getDescrizione();
        String etichetta = form.getLabelFile();
        String idclassificazione = form.getClassificazione();
        String separatore = form.getDelimiter();
        String idsessione = form.getIdsessione();
        Integer skipFirstLine = form.getSkipFirstLine();

        File fileRules = FileHandler.convertMultipartFileToFile(form.getFileName());

        int rules = ruleService.loadRules(fileRules, idsessione, etichetta, idclassificazione, separatore, nomeFile, skipFirstLine);
        logService.save("Caricate " + rules + " regole");

        SessionBean sessionBean = (SessionBean) httpSession.getAttribute(IS2Const.SESSION_BEAN);
        sessionBean.getRuleset().add(nomeFile);
        httpSession.setAttribute(IS2Const.SESSION_BEAN, sessionBean);
        
        return "redirect:/rule/viewRuleset/" + idsessione;
    }
    
    @RequestMapping(value = "/newRuleset", method = RequestMethod.POST)
    public String newRulesetData(HttpSession httpSession, HttpServletRequest request, Model model,
            @AuthenticationPrincipal User user, @ModelAttribute("inputFormBean") NewRulesetFormBean form)
            throws IOException {

        notificationService.removeAllMessages();

        String nomeRuleset = form.getRulesetName();
        String etichettaRuleset = form.getRulesetLabel();
        Integer tipoRuleset = form.getRulesetType();
        String descrRuleset = form.getRulesetDesc();
        WorkSession sessionelv = sessioneLavoroService.getSessione(new Long(form.getIdsessione()));
       
        Integer dataset = form.getDataset();        

        SxRuleset ruleset = new SxRuleset();
        ruleset.setLabelFile(etichettaRuleset);
        ruleset.setNomeFile(nomeRuleset);
        ruleset.setSessioneLavoro(sessionelv);
        
        
        ruleService.saveRuleSet(ruleset);
        
        
        return "redirect:/rule/viewRuleset/" + form.getIdsessione();
    }

    @GetMapping(value = "/viewRuleset/{id}")
    public String mostraroleset(HttpSession session, Model model, @PathVariable("id") Long id) {

        List<Log> logs = logService.findByIdSessione(id);

        WorkSession sessionelv = sessioneLavoroService.getSessione(id);
        List<DatasetFile> listaDatasetFile = datasetService.findDatasetFilesByIdSessioneLavoro(id);

        List<SxRuleset> listaRuleSet = sessionelv.getRuleSets();
        String etichetta = null;
        if(listaRuleSet!=null && listaRuleSet.size()>0) {
        	etichetta = "RS_" + Integer.toString( listaRuleSet.size()+1 );
        }else {
        	etichetta = "RS_0";
        }
        
        
        List<SxRuleType> listaRuleType = ruleService.findAllRuleType();

        session.setAttribute(IS2Const.SESSION_LV, sessionelv);

        model.addAttribute("listaDatasetFile", listaDatasetFile);
        model.addAttribute("listaRuleSet", listaRuleSet);
        model.addAttribute("listaRuleType", listaRuleType);
        model.addAttribute("etichetta", etichetta);
        model.addAttribute("logs", logs);

        return "ruleset/list";
    }

    @RequestMapping("/viewRules/{idfile}")
    public String caricafile(HttpSession session, Model model, @PathVariable("idfile") Integer idfile) {

        notificationService.removeAllMessages();
       List<Log> logs = logService.findByIdSessione();
        SxRuleset ruleset = ruleService.findRuleSet(idfile);
        List<SxRule> rules = ruleService.findRules(ruleset);

        model.addAttribute("ruleset", ruleset);
        model.addAttribute("rules", rules);
        model.addAttribute("logs", logs);

        return "ruleset/preview";
    }
    @GetMapping(value = "/deleteRuleset/{idSessione}/{idRuleset}")
    public String eliminaRuleset(HttpSession session, Model model, @PathVariable("idSessione") Long idSessione,  @PathVariable("idRuleset") Integer idRuleset) {

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
