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
import it.istat.is2.workflow.dao.SxRuleDao;
import it.istat.is2.workflow.dao.SxRuleTypeDao;
import it.istat.is2.workflow.dao.SxRulesetDao;
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

	// private EngineValidate engine;

	@Autowired
	private WorkSessionService sessioneLavoroService;
	@Autowired
	private SxRuleDao sxRuleDao;
	@Autowired
	private SxRuleTypeDao sxRuleTypeDao;
	@Autowired
	private SxRulesetDao sxRulesetDao;

	public List<SxRule> findAll() {
		return (List<SxRule>) this.sxRuleDao.findAll();
	}

	public List<SxRuleType> findAllRuleType() {
		return (List<SxRuleType>) sxRuleTypeDao.findAll();
	}

	public void runValidate(Integer idRuleset) {
		// List<SxRule> rules = sxRuleDao.findBySxRuleset(idRuleset);

		try {
			// engine.init();
			// engine.loadRules(null);
			// engine.processOutput();

		} catch (Exception e) {
			Logger.getRootLogger().debug(e.getMessage());
		} finally {
			// engine.destroy();
		}

	}

	/**
	 * @param fileRules
	 * @param idsessione
	 * @param idclassificazione
	 * @param descrizione2
	 * @param separatore
	 * @return
	 */
	public int loadRules(File fileRules, String idsessione, String descrizione, String idclassificazione,
			String separatore) {
		// TODO Auto-generated method stub
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

		String riga = null;
		String formula = null;

		Iterator<CSVRecord> itr = records.iterator();
		while (itr.hasNext()) {
			CSVRecord rec = itr.next();
			formula = rec.get(0);
			SxRule regola = new SxRule();
			regola.setActive((short) 1);
			regola.setRule(formula);
			regola.setRuleType(new SxRuleType(new Short(idclassificazione)));
			regola.setSxRuleset(ruleset);
			ruleset.getSxRules().add(regola);

		}

		ruleset.setDescr(descrizione);
		ruleset.setSessioneLavoro(sessionelv);

		ruleset = sxRulesetDao.save(ruleset);

		return ruleset.getSxRules().size();
	}

	/**
	 * @param idfile
	 * @return
	 */
	public SxRuleset findRuleSet(Integer idfile) {
		// TODO Auto-generated method stub
		return sxRulesetDao.findById(idfile).orElse(null);
	}
}
