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

import it.istat.is2.app.domain.Elaborazione;
import it.istat.is2.workflow.domain.SxStepInstance;
@Service
public interface EngineService {
	public static final String RESULTSET = "sel_out";
	public static final String WORKSET = "workset";
	public static final String RUOLI_VAR = "role_var";
	public static final String RUOLI_VAR_OUTPUT = "role_var_out";
	public static final String RUOLI_INPUT = "role_in";
	public static final String RUOLI_OUTPUT = "ruol_out";
	public static final String PARAMETRI = "params";
	public static final String MODELLO = "model";
	public static final String RUOLO_SKIP_N = "N";
	public static final String RESULT_RUOLI = "roles";
	public static final String RESULT_OUTPUT = "out";
	public static final String RESULT_PARAM = "mod";
	public static final String RESULT_REPORT = "report"; // aggiunto componente dei parametri di uscita


	public void init(Elaborazione elaborazione, SxStepInstance stepInstance) throws Exception;
	public void doAction()throws Exception;
	public void processOutput() throws Exception;
	public void destroy();
 

}
