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

import org.springframework.stereotype.Component;
@Component
public interface EngineService {

	public void createConnection() throws Exception;

	public void bindInputParams(HashMap<String, ArrayList<String>> parametriMap) throws Exception;

	public void eseguiStringaIstruzione(String fname, HashMap<String, ArrayList<String>> ruoliVariabileNome)
			throws Exception;

	public void bindInputColumns(HashMap<String, ArrayList<String>> worksetVariabili, String workset) throws Exception;

	public void getGenericoOutput(HashMap<String, ArrayList<String>> worksetOut, String resultset, String resultOutput) throws Exception;

	public void setRuoli(HashMap<String, ArrayList<String>> ruoliVariabileNome) throws Exception;

	public void bindOutputColumns(HashMap<String, ArrayList<String>> workset, String varR) throws Exception;

	public void getRuoli(HashMap<String, ArrayList<String>> ruoliOutputStep, String varR) throws Exception;

	public void closeConnection();

}
