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
package it.istat.is2.app.util;

public interface IS2Const {

    public static final String SESSION_BEAN = "sessioneBean";
    public static final String SESSION_LV = "sessionelv";
    public static final String SESSION_ELABORAZIONE = "elaborazione";
    public static final String WORKINGSET = "workingset";
    public static final int WORKSET_TIPO_VARIABILE = 1;
    public static final int WORKSET_TIPO_PARAMETRO = 2;
    public static final int WORKSET_TIPO_MODELLO = 3;
    public static final int CODICE_APP_SERVICE_R = 100;
    public static final int VARIABILE_TIPO_INPUT = 1;
    public static final int VARIABILE_TIPO_OUTPUT = 2;
    public static final String LISTA_BUSINESS_PROCESS = "listaBP";
    public static final String SESSION_DATASET = "sessionelavdataset";
    public static final int TIPO_CAMPO_INPUT = 1;
    public static final int TIPO_CAMPO_ELABORATO = 2;
    
    public static final String ENGINE_R = "R";
    public static final String ENGINE_JAVA = "JAVA";
    public static final String ENGINE_SQL = "SQL";
    public static final String ENGINE_R_LIGHT = "R-LIGHT";
	public static final String WORKSET_FREQUENCY = "FREQUENCY";
	public static final String WF_OUTPUT_ROLES = "roles.output";
	public static final String WF_OUTPUT_WORKSET = "worset.output";
    
    public static final String OUTPUT_DEFAULT = "OUT";
    public static final String OUTPUT_R = "R";

    
}
