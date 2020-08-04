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
package it.istat.is2.app.bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class ColonnaJson implements Serializable {

    private static final long serialVersionUID = 1L;

    private List<DatoJson> valori;

    public List<DatoJson> getValori() {
        return valori;
    }

    public void setValori(List<DatoJson> valori) {
        this.valori = valori;
    }

    public ColonnaJson() {
        super();
        valori = new ArrayList<DatoJson>();
    }

    public void add(DatoJson j) {
        valori.add(j);

    }
}
