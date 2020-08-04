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
package it.istat.is2.app.util;

public interface IS2Const {

    public static final String SESSION_BEAN = "sessionBean";
    public static final String SESSION_WORKSESSION = "session_ws";
    public static final String SESSION_DATAPROCESSING = "dataProcessing";
    public static final String SESSION_BUSINESS_FUNCTIONS = "businessFunctionList";
    public static final String SESSION_BUSINESS_SERVICES = "businessServiceList";

    public static final String WORKINGSET = "workingset";

    public static final String LIST_BUSINESS_PROCESS = "listBP";
    public static final String SESSION_DATASET = "sessionWSdataset";


    public static final String OUTPUT_DEFAULT = "OUT";
    public static final String OUTPUT_R = "R";


    public static final String TEXT_RULE = "RULE";

    public static final long DATA_TYPE_VARIABLE = 1;
    public static final long DATA_TYPE_PARAMETER = 2;
    public static final long DATA_TYPE_DATASET = 3;
    public static final long DATA_TYPE_RULESET = 4;
    public static final int DATA_TYPE_RULE = 5;
    public static final int DATA_TYPE_MODEL = 6;

    public static final short TYPE_IO_INPUT = 1;
    public static final short TYPE_IO_OUTPUT = 2;
    public static final short TYPE_IO_INPUT_OUTPUT = 3;

    public static final String VIEW_DATATYPE_DATASET = "DATASET";
    public static final String VIEW_DATATYPE_RULESET = "RULESET";

    public static final String ROLE_NAME_RULESET = "RULESET";
    public static final String SORT_ASC = "ASC";

}
