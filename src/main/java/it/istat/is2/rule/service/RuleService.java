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
package it.istat.is2.rule.service;

import it.istat.is2.app.util.FileHandler;
import it.istat.is2.rule.engine.EngineValidate;
import static it.istat.is2.rule.engine.EngineValidate.INPUT_NAMES_PREFIX;
import it.istat.is2.rule.forms.RuleCreateForm;
import it.istat.is2.workflow.dao.SxClassificationDao;
import it.istat.is2.workflow.dao.SxRuleDao;
import it.istat.is2.workflow.dao.SxRuleTypeDao;
import it.istat.is2.workflow.dao.SxRulesetDao;
import it.istat.is2.workflow.domain.SxClassification;
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
import java.util.Iterator;
import java.util.List;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RuleService {

    @Autowired
    private WorkSessionService sessioneLavoroService;
    @Autowired
    private SxRuleDao sxRuleDao;
    @Autowired
    private SxRuleTypeDao sxRuleTypeDao;
    @Autowired
    private SxRulesetDao sxRulesetDao;
    @Autowired
    private SxClassificationDao sxClassificationDao;
    @Autowired
    private EngineValidate engine;

    private String[] input;
    private String[] inputNames;
    private String[] out;

    public List<SxRule> findAll() {
        return (List<SxRule>) this.sxRuleDao.findAll();
    }

    public List<SxRuleType> findAllRuleType() {
        return (List<SxRuleType>) sxRuleTypeDao.findAll();
    }
    public List<SxClassification> findAllClassifications() {
        return (List<SxClassification>) sxClassificationDao.findAll();
    }
    public SxRuleType findRuleTypeById(short idrule) {
        return sxRuleTypeDao.findById(idrule);
    }
    public SxClassification findClassificationById(short idclassification) {
        return sxClassificationDao.findById(idclassification);
    }

    public void runValidate(SxRuleset ruleset) {
        SxRule rule;
        Integer ruleId;
        List<SxRule> rules = sxRuleDao.findBySxRuleset(ruleset);
        
        //Reset error status of rules
        for (int i = 0; i < rules.size(); i++) {
            rules.get(i).setErrcode(0);
        }
        sxRuleDao.saveAll(rules);
        
        //Create array of rules for R
        input = new String[rules.size()];
        for (int i = 0; i < rules.size(); i++) {
            input[i] = rules.get(i).getRule().toUpperCase();
        }

        //Create array of names for R
        inputNames = new String[rules.size()];
        for (int i = 0; i < rules.size(); i++) {
            inputNames[i] = INPUT_NAMES_PREFIX + rules.get(i).getId();
        }

        try {
            engine.connect();

            out = engine.detectInfeasibleRules(input, inputNames);
            //Save error codes of infeasible rules 
            for (int i = 0; i < out.length; i++) {
                ruleId = Integer.valueOf(out[i].replace(INPUT_NAMES_PREFIX, ""));
                rule = sxRuleDao.findById(ruleId).orElse(null);
                if (rule != null) {
                    rule.setErrcode(1);
                    sxRuleDao.save(rule);
                }
            }
        } catch (Exception e) {
            Logger.getRootLogger().error(e.getMessage());
        } finally {
            engine.destroy();
        }

    }

    public int loadRules(File fileRules, String idsessione, String etichetta, String idclassificazione, String separatore, String nomeFile, Integer skipFirstLine) {
        String pathTmpFile = fileRules.getAbsolutePath().replace("\\", "/");
        WorkSession sessionelv = sessioneLavoroService.getSessione(Long.parseLong(idsessione));
        SxRuleset ruleset = new SxRuleset();

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
        } catch (IOException e) {
            Logger.getRootLogger().error("Errore: ", e);
        }

        String formula = null;
        SxClassification classificazione = new SxClassification();
        classificazione.setId(Short.parseShort(idclassificazione));
        Iterator<CSVRecord> itr = records.iterator();
        // If skipFirstLine equals 1 skips first line
        if(skipFirstLine==1) {
        	itr.next();
        }        
        while (itr.hasNext()) {
            CSVRecord rec = itr.next();
            formula = rec.get(0);
            SxRule regola = new SxRule();
            regola.setActive((short) 1);
            regola.setRule(formula);          
            regola.setSxClassification(classificazione);
            regola.setSxRuleset(ruleset);
            ruleset.getSxRules().add(regola);

        }

        ruleset.setNomeFile(nomeFile);
        ruleset.setLabelFile(etichetta);
        ruleset.setNumeroRighe(ruleset.getSxRules().size());
        ruleset.setSessioneLavoro(sessionelv);

        ruleset = sxRulesetDao.save(ruleset);

        return ruleset.getSxRules().size();
    }

    public void saveRuleSet(SxRuleset sxRuleset) {

        sxRulesetDao.save(sxRuleset);
    }
public void deleteRuleset(Integer rulesetId) {       
        sxRulesetDao.deleteById(rulesetId);        
    }

    public SxRuleset findRuleSet(Integer idfile) {        
        return sxRulesetDao.findById(idfile).orElse(null);
    }

    public List<SxRule> findRules(SxRuleset ruleset) {
        return sxRuleDao.findBySxRuleset(ruleset);
    }

    public SxRule findRuleByid(Integer ruleId) {
        return sxRuleDao.findById(ruleId).orElse(null);
    }

    public void save(RuleCreateForm ruleForm) {

        SxRule rule = new SxRule();

        SxRuleset ruleSet = sxRulesetDao.findById(ruleForm.getRuleSetId()).orElse(null);

        rule.setId(ruleForm.getRuleId());
        rule.setSxRuleset(ruleSet);
        rule.setRule(ruleForm.getRule());

        sxRuleDao.save(rule);

    }

    public void update(RuleCreateForm ruleForm) {

        SxRule rule = sxRuleDao.findById(ruleForm.getRuleId()).orElse(null);

        if (rule != null) {
            rule.setRule(ruleForm.getRule());
            sxRuleDao.save(rule);
        }

    }

    public void delete(Integer ruleId) {
        
        SxRule rule =  sxRuleDao.findById(ruleId).orElse(null);
        SxRuleset ruleSet;
        Integer numberOfRules;
        //decrease the number of rules of the ruleset
        if(rule != null){
            ruleSet = rule.getSxRuleset();
            numberOfRules = sxRuleDao.countBySxRuleset(ruleSet);
            ruleSet.setNumeroRighe(numberOfRules - 1);
            sxRulesetDao.save(ruleSet);
        }
        
        sxRuleDao.deleteById(ruleId);
        
    }

}
