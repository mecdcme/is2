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
public interface EngineService {

    public static final String ENGINE_RSERVE = "RSERVE";
    public static final String ENGINE_RENJIN = "RENJIN";
    public static final String ENGINE_JAVA = "JAVA";
    public static final String ENGINE_SQL = "SQL";

    public static final String ENGINE_R_LIGHT = "R-LIGHT";


    // GENERIC BRIDGE
    public static final String WORKSET = "workset";
    public static final String PARAMETERS = "ws_params";
    public static final String ROLES = "roles";
    public static final String OUT = "out";

    // GENERIC INPUT
    public static final String WORKSET_IN = "workset_in";
    public static final String PARAMETERS_IN = "params_in";
    public static final String ROLES_IN = "roles_in";

    // GENERIC OUTPUT
    public static final String WORKSET_OUT = "workset_out"; // Output container
    public static final String PARAMETERS_OUT = "params_out";
    public static final String REPORT_OUT = "report_out";
    public static final String ROLES_OUT = "roles_out";
    public static final String ROLES_GROUP_OUT = "rolesgroup_out";
    public static final String RESULTSET = "resultset";

    // RULESET
    public static final String RULESET = "ruleset";

    // DEFAULT VALUES
    public static final String ROLE_DEFAULT = "N";
    public static final String DEFAULT_NA = "NA"; //

    public void init(DataProcessing dataProcessing, StepInstance stepInstance) throws Exception;

    public void init() throws Exception;

    public void doAction() throws Exception;

    public void processOutput() throws Exception;

    public void destroy();

}
