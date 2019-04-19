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
package it.istat.rservice.workflow.engine;

import java.util.ArrayList;
import java.util.HashMap;


import org.springframework.stereotype.Service;
 

/**
 * @author framato
 *
 */
@Service
public class EngineJava implements EngineService {

	/* (non-Javadoc)
	 * @see it.istat.rservice.workflow.engine.EngineService#createConnection()
	 */
	@Override
	public void createConnection() throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see it.istat.rservice.workflow.engine.EngineService#bindInputParams(java.util.HashMap)
	 */
	@Override
	public void bindInputParams(HashMap<String, ArrayList<String>> parametriMap) throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see it.istat.rservice.workflow.engine.EngineService#eseguiStringaIstruzione(java.lang.String, java.util.HashMap)
	 */
	@Override
	public void eseguiStringaIstruzione(String fname, HashMap<String, ArrayList<String>> ruoliVariabileNome)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see it.istat.rservice.workflow.engine.EngineService#bindInputColumns(java.util.HashMap, java.lang.String)
	 */
	@Override
	public void bindInputColumns(HashMap<String, ArrayList<String>> worksetVariabili, String workset) {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see it.istat.rservice.workflow.engine.EngineService#getGenericoOutput(java.util.HashMap, java.lang.String, java.lang.String)
	 */
	@Override
	public void getGenericoOutput(HashMap<String, ArrayList<String>> worksetOut, String resultset,
			String resultOutput) {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see it.istat.rservice.workflow.engine.EngineService#setRuoli(java.util.HashMap)
	 */
	@Override
	public void setRuoli(HashMap<String, ArrayList<String>> ruoliVariabileNome) throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see it.istat.rservice.workflow.engine.EngineService#bindOutputColumns(java.util.HashMap, java.lang.String)
	 */
	@Override
	public void bindOutputColumns(HashMap<String, ArrayList<String>> workset, String varR) throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see it.istat.rservice.workflow.engine.EngineService#getRuoli(java.util.HashMap, java.lang.String)
	 */
	@Override
	public void getRuoli(HashMap<String, ArrayList<String>> ruoliOutputStep, String varR) throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see it.istat.rservice.workflow.engine.EngineService#closeConnection()
	 */
	@Override
	public void closeConnection() {
		// TODO Auto-generated method stub
		
	}

     
}
