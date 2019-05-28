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
package it.istat.is2.workflow.engine;


import org.springframework.stereotype.Service;

import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.SxStepInstance;

@Service
public  class EngineSQL implements EngineService {

	/* (non-Javadoc)
	 * @see it.istat.is2.workflow.engine.EngineService#init(it.istat.is2.app.domain.Elaborazione, it.istat.is2.workflow.domain.SxStepInstance)
	 */
	@Override
	public void init(Elaborazione elaborazione, SxStepInstance stepInstance) throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see it.istat.is2.workflow.engine.EngineService#eseguiStringaIstruzione()
	 */
	@Override
	public void doAction() throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see it.istat.is2.workflow.engine.EngineService#processOutput()
	 */
	@Override
	public void processOutput() throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see it.istat.is2.workflow.engine.EngineService#destroy()
	 */
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
 
 
}
