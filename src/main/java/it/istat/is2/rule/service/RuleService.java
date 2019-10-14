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
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.rule.domain.Rule;
import it.istat.is2.rule.domain.RuleType;
import it.istat.is2.rule.domain.Ruleset;
import it.istat.is2.rule.engine.EngineValidate;
import static it.istat.is2.rule.engine.EngineValidate.INPUT_NAMES_PREFIX;
import it.istat.is2.rule.forms.RuleCreateForm;
import it.istat.is2.workflow.dao.ClassificationDao;
import it.istat.is2.workflow.dao.RuleDao;
import it.istat.is2.workflow.dao.RuleTypeDao;
import it.istat.is2.workflow.dao.RulesetDao;
import it.istat.is2.workflow.domain.Classification;
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
    private RuleDao ruleDao;
    @Autowired
    private RuleTypeDao ruleTypeDao;
    @Autowired
    private RulesetDao rulesetDao;
    @Autowired
    private ClassificationDao sxClassificationDao;
    @Autowired
    private EngineValidate engine;

    private String[] input;
    private String[] inputNames;
    private String[] out;

    public List<Rule> findAll() {
        return (List<Rule>) this.ruleDao.findAll();
    }

    public List<RuleType> findAllRuleType() {
        return (List<RuleType>) ruleTypeDao.findAll();
    }
    public List<Classification> findAllClassifications() {
        return (List<Classification>) sxClassificationDao.findAll();
    }
    public RuleType findRuleTypeById(short idrule) {
        return ruleTypeDao.findById(idrule);
    }
    public Classification findClassificationById(short idclassification) {
        return sxClassificationDao.findById(idclassification);
    }

    public void runValidate(Ruleset ruleset) {
        Rule rule;
        Integer ruleId;
        List<Rule> rules = ruleDao.findByRuleset(ruleset);
        
        //Reset error status of rules
        for (int i = 0; i < rules.size(); i++) {
            rules.get(i).setErrcode(0);
        }
        ruleDao.saveAll(rules);
        
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
                rule = ruleDao.findById(ruleId).orElse(null);
                if (rule != null) {
                    rule.setErrcode(1);
                    ruleDao.save(rule);
                }
            }
        } catch (Exception e) {
            Logger.getRootLogger().error(e.getMessage());
        } finally {
            engine.destroy();
        }

    }

    public int loadRules(File fileRules, String idsessione, String etichetta, String idclassificazione, String separatore, String nomeFile, String descrizione, Integer skipFirstLine) {
        String pathTmpFile = fileRules.getAbsolutePath().replace("\\", "/");
        WorkSession sessionelv = sessioneLavoroService.getSessione(Long.parseLong(idsessione));
        Ruleset ruleset = new Ruleset();

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
        Classification classificazione = new Classification();
        classificazione.setId(Short.parseShort(idclassificazione));
        Iterator<CSVRecord> itr = records.iterator();
        // If skipFirstLine equals 1 skips first line
        if(skipFirstLine==1) {
        	itr.next();
        }        
        while (itr.hasNext()) {
            CSVRecord rec = itr.next();
            formula = rec.get(0);
            Rule regola = new Rule();
            regola.setActive((short) 1);
            regola.setRule(formula);          
            regola.setSxClassification(classificazione);
            regola.setRuleset(ruleset);
            ruleset.getRules().add(regola);

        }

        ruleset.setNomeFile(nomeFile);
        ruleset.setDescr(descrizione);
        ruleset.setLabelFile(etichetta);
        ruleset.setNumeroRighe(ruleset.getRules().size());
        ruleset.setSessioneLavoro(sessionelv);

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
        return rulesetDao.findBySessioneLavoro(sessionlv);
    }
    public Ruleset findRulesetById(Integer id) {        
        return rulesetDao.findById(id).orElse(null);
    }

    public List<Rule> findRules(Ruleset ruleset) {
        return ruleDao.findByRuleset(ruleset);
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

        Classification classif = findClassificationById(ruleForm.getClassificazione());
        if (rule != null) {
            rule.setRule(ruleForm.getRule());
            rule.setDescr(ruleForm.getDescrizione());
            rule.setSxClassification(classif);
            ruleDao.save(rule);
        }

    }

    public void delete(Integer ruleId) {
        
        Rule rule =  ruleDao.findById(ruleId).orElse(null);
        Ruleset ruleSet;
        Integer numberOfRules;
        //decrease the number of rules of the ruleset
        if(rule != null){
            ruleSet = rule.getRuleset();
            numberOfRules = ruleDao.countByRuleset(ruleSet);
            ruleSet.setNumeroRighe(numberOfRules - 1);
            rulesetDao.save(ruleSet);
        }
        
        ruleDao.deleteById(ruleId);
        
    }

}
