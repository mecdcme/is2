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
package it.istat.is2.workflow.engine;

import org.springframework.stereotype.Service;

import it.istat.is2.workflow.domain.DataProcessing;
import it.istat.is2.workflow.domain.StepInstance;

@Service
public class EngineSQL implements EngineService {

    @Override
    public void init(DataProcessing elaborazione, StepInstance stepInstance) throws Exception {
        // TODO	
    }

    @Override
    public void init() throws Exception {
        // TO DO
    }

    @Override
    public void doAction() throws Exception {
        // TODO
    }

    @Override
    public void processOutput() throws Exception {
        // TODO
    }

    @Override
    public void destroy() {
        // TODO 
    }

}
