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
package it.istat.is2.app.bean;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class SessionBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String nome;
        private List<String> file;
        private List<String> ruleset;
        private Long idElaborazione;
        private String nomeElaborazione;
        private BusinessProcessParentBean businessProcess;
        private BusinessFunctionBean businessFunction;
        private Long tipoRuleset;
        private Long dataset;
        
        public SessionBean(Long id, String nome) {
		this.id = id;
		this.nome = nome;
	}
        
        public SessionBean() {
            
	}
}
