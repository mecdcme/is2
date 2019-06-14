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

import it.istat.is2.app.util.IS2Const;
import it.istat.is2.workflow.dao.SxRuleDao;
import it.istat.is2.workflow.dao.SxRuleTypeDao;
import it.istat.is2.workflow.domain.SxRule;
import it.istat.is2.workflow.domain.SxRuleType;
import it.istat.is2.workflow.engine.EngineFactory;

import java.util.List;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import it.istat.is2.workflow.engine.EngineValidate;

@Service
public class RuleService {

    @Autowired
    private EngineValidate engine;

    @Autowired
    private SxRuleDao sxRuleDao;
    @Autowired
    private SxRuleTypeDao sxRuleTypeDao;

    public List<SxRule> findAll() {
        return (List<SxRule>) this.sxRuleDao.findAll();
    }

    public List<SxRuleType> findAllRuleType() {
        return (List<SxRuleType>) sxRuleTypeDao.findAll();
    }

    public void runValidate(Integer idRuleset) {
       //List<SxRule> rules = sxRuleDao.findBySxRuleset(idRuleset);

        try {
            engine.init();
            engine.loadRules(null);
            engine.processOutput();

        } catch (Exception e) {
            Logger.getRootLogger().debug(e.getMessage());
        } finally {
            engine.destroy();
        }

    }
}
