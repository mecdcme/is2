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
package it.istat.is2.workflow.domain;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

/**
 * The persistent class for the SX_PAR_PATTERN database table.
 *
 */
@Data
@Entity
@Table(name = "sx_stepinstance_parameter")
@NamedQuery(name = "StepInstanceParameter.findAll", query = "SELECT s FROM StepInstanceParameter s")
public class StepInstanceParameter implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    private Long id;

    private String deflt;

    private String descr;

    private String nome;
    
    @JoinColumn(name = "json_template")
    private String jsonTemplate;

    // bi-directional many-to-one association to StepInstance
    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "ISTANZA")
    private StepInstance stepInstance;

    // bi-directional many-to-one association to SxRuoli
    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "RUOLO")
    private AppRole appRole;

    public StepInstanceParameter() {
    }

}
