/**
 * Copyright 2019 ISTAT
 * <p>
 * Licensed under the EUPL, Version 1.1 or – as soon they will be approved by
 * the European Commission - subsequent versions of the EUPL (the "Licence");
 * You may not use this work except in compliance with the Licence. You may
 * obtain a copy of the Licence at:
 * <p>
 * http://ec.europa.eu/idabc/eupl5
 * <p>
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
package it.istat.is2.rule.service;

import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.FileHandler;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.rule.domain.Rule;
import it.istat.is2.rule.domain.RuleCls;
import it.istat.is2.rule.domain.Ruleset;
import it.istat.is2.rule.engine.EngineValidate;
import it.istat.is2.rule.forms.RuleCreateForm;
import it.istat.is2.workflow.dao.RuleDao;
import it.istat.is2.workflow.dao.RuleTypeDao;
import it.istat.is2.workflow.dao.RulesetDao;
import it.istat.is2.worksession.domain.WorkSession;
import it.istat.is2.worksession.service.WorkSessionService;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;
import org.apache.log4j.Logger;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;

@Service
public class RuleService {

    @Autowired
    private WorkSessionService sessioneLavoroService;
    @Autowired
    private RuleDao ruleDao;
    @Autowired
    private RuleTypeDao ruleTypeDao;
    @Autowired
    private RulesetDao rulesetDao;
    @Autowired
    private EngineValidate engine;
    @Autowired
    private NotificationService notificationService;
    @Autowired
    private MessageSource messages;

    private String[] input;
    private String[] inputNames;

    public List<Rule> findAll() {
        return (List<Rule>) this.ruleDao.findAll();
    }

    public List<RuleCls> findAllRuleType() {
        return (List<RuleCls>) ruleTypeDao.findAll();
    }

    public RuleCls findRuleTypeById(short idrule) {
        return ruleTypeDao.findById(idrule);
    }

    public Map<String, List<String>> runValidate(Ruleset ruleset) throws Exception {

        Map<String, List<String>> ret = new HashMap<String, List<String>>();
        List<Rule> rules = ruleDao.findByRulesetOrderByIdAsc(ruleset);

        // Create array of rules for R
        input = new String[rules.size()];
        for (int i = 0; i < rules.size(); i++) {
            input[i] = rules.get(i).getRule();
        }

        // Create array of names for R
        inputNames = new String[rules.size()];
        for (int i = 0; i < rules.size(); i++) {
            inputNames[i] = rules.get(i).getName();
        }

        try {
            engine.connect();
            ret = engine.detectInfeasibleRules(input, inputNames);
        } catch (RserveException e) {
            Logger.getRootLogger().error(e.getMessage());
            notificationService.addErrorMessage(
                    messages.getMessage("r.connectiom.error", null, LocaleContextHolder.getLocale()), e.getMessage());
            throw e;
        } catch (Exception e) {
            notificationService.addErrorMessage("Error: " + e.getMessage());
            Logger.getRootLogger().error(e.getMessage());
            throw e;
        } finally {
            engine.destroy();
        }
        return ret;
    }

    public int loadRules(File fileRules, String idsessione, String etichetta, String labelCodeRule,
                         String idclassificazione, String separatore, String nomeFile, String descrizione, Integer skipFirstLine) {
        String pathTmpFile = fileRules.getAbsolutePath().replace("\\", "/");
        WorkSession sessionelv = sessioneLavoroService.getSessione(Long.parseLong(idsessione));
        Ruleset ruleset = new Ruleset();
        int counter = 1;
        Reader in = null;
        char delimiter = 9;
        try {
            in = new FileReader(pathTmpFile);
            delimiter = FileHandler.checkDelimiter(separatore.toCharArray()[0]);
        } catch (FileNotFoundException e) {
            Logger.getRootLogger().error("Errore: ", e);
        }
        Iterable<CSVRecord> records = null;
        try {
            records = CSVFormat.RFC4180.withDelimiter(delimiter).parse(in);
            if (records != null) {
                String formula = null;
                RuleCls classificazione = new RuleCls();
                classificazione.setId(Short.parseShort(idclassificazione));
                Iterator<CSVRecord> itr = records.iterator();
                // If skipFirstLine equals 1 skips first line
                if (skipFirstLine == 1) {
                    itr.next();
                }
                while (itr.hasNext()) {
                    CSVRecord rec = itr.next();
                    formula = rec.get(0);
                    Rule regola = new Rule();
                    regola.setActive((short) 1);
                    regola.setRule(formula);
                    regola.setRuleType(classificazione);
                    regola.setRuleset(ruleset);
                    regola.setCode(labelCodeRule + (counter++));
                    ruleset.getRules().add(regola);

                }
            }

        } catch (IOException e) {
            Logger.getRootLogger().error("Errore: ", e);
        }

        ruleset.setFileName(nomeFile);
        ruleset.setDescr(descrizione);
        ruleset.setFileLabel(etichetta);
        ruleset.setRulesTotal(ruleset.getRules().size());
        ruleset.setWorkSession(sessionelv);

        ruleset = rulesetDao.save(ruleset);

        return ruleset.getRules().size();
    }

    public void saveRuleSet(Ruleset ruleset) {

        rulesetDao.save(ruleset);
    }

    public void deleteRuleset(Integer rulesetId) {
        rulesetDao.deleteById(rulesetId);
    }

    public Ruleset findRulesetByDatasetFile(DatasetFile ds) {
        return rulesetDao.findByDatasetFile(ds).orElse(null);
    }

    public List<Ruleset> findAllRuleset() {
        return rulesetDao.findAll();
    }

    public List<Ruleset> findRulesetBySessioneLavoro(WorkSession sessionlv) {
        return rulesetDao.findByWorkSession(sessionlv);
    }

    public Ruleset findRulesetById(Integer id) {
        return rulesetDao.findById(id).orElse(null);
    }

    public List<Rule> findRules(Ruleset ruleset) {
        return ruleDao.findByRulesetOrderByIdAsc(ruleset);
    }

    public Rule findRuleByid(Integer ruleId) {
        return ruleDao.findById(ruleId).orElse(null);
    }

    public void save(RuleCreateForm ruleForm) {

        Rule rule = new Rule();

        Ruleset ruleSet = rulesetDao.findById(ruleForm.getRuleSetId()).orElse(null);

        rule.setId(ruleForm.getRuleId());
        rule.setRuleset(ruleSet);
        rule.setRule(ruleForm.getRule());

        ruleDao.save(rule);

    }

    public void update(RuleCreateForm ruleForm) {

        Rule rule = ruleDao.findById(ruleForm.getRuleId()).orElse(null);

        RuleCls classif = findRuleTypeById(ruleForm.getClassificazione());
        if (rule != null) {
            rule.setRule(ruleForm.getRule());
            rule.setDescr(ruleForm.getDescrizione());
            rule.setCode(ruleForm.getCodeRule());
            rule.setRuleType(classif);
            ruleDao.save(rule);
        }

    }

    public void delete(Integer ruleId) {

        Rule rule = ruleDao.findById(ruleId).orElse(null);
        Ruleset ruleSet;
        Integer numberOfRules;
        // decrease the number of rules of the ruleset
        if (rule != null) {
            ruleSet = rule.getRuleset();
            numberOfRules = ruleDao.countByRuleset(ruleSet);
            ruleSet.setRulesTotal(numberOfRules - 1);
            rulesetDao.save(ruleSet);
        }

        ruleDao.deleteById(ruleId);

    }

    /**
     * @param ruleset
     * @param function
     * @return
     */
    public Map<String, ?> runValidateR(Integer rulesetId, String function) throws Exception {
        // TODO Auto-generated method stub

        Map<String, Object> ret = new HashMap<String, Object>();
        List<Rule> rules = ruleDao.findByRulesetOrderByIdAsc(new Ruleset(rulesetId));

        // Create array of rules for R
        input = new String[rules.size()];
        for (int i = 0; i < rules.size(); i++) {
            input[i] = rules.get(i).getRule();
        }

        // Create array of names for R
        inputNames = new String[rules.size()];
        for (int i = 0; i < rules.size(); i++) {
            inputNames[i] = rules.get(i).getCode();
        }

        try {
            engine.connect();
            ret = engine.runFunction(function, input, inputNames);
        } catch (RserveException e) {
            Logger.getRootLogger().error(e.getMessage());
            notificationService.addErrorMessage(
                    messages.getMessage("r.connectiom.error", null, LocaleContextHolder.getLocale()), e.getMessage());
            throw e;
        } catch (Exception e) {
            notificationService.addErrorMessage("Error: " + e.getMessage());
            Logger.getRootLogger().error(e.getMessage());
            throw e;
        } finally {
            engine.destroy();
        }
        return ret;
    }

}
