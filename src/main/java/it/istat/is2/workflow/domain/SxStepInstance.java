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

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.Data;

import java.util.List;

/**
 * The persistent class for the SX_STEP_INSTANCE database table.
 *
 */
@Data
@Entity
@Table(name = "SX_STEP_INSTANCE")
@NamedQuery(name = "SxStepInstance.findAll", query = "SELECT s FROM SxStepInstance s")
public class SxStepInstance implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    private Long id;

    private String descr;

    private String etichetta;

    private String fname;
    

    // bi-directional many-to-one association to SxAppInstance
    @ManyToMany(mappedBy = "sxStepInstances", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonBackReference
    private List<SxBusinessStep> sxBusinessSteps;

    // bi-directional many-to-one association to SxAppService
    @ManyToOne
    @JoinColumn(name = "SERVIZIO")
    @JsonBackReference
    private SxAppService sxAppService;

    // bi-directional many-to-one association to SxStepPattern
    @OneToMany(mappedBy = "sxStepInstance")
    @JsonBackReference
    private List<SxStepPattern> sxStepPatterns;

    // bi-directional many-to-one association to SxParPattern
    @OneToMany(mappedBy = "sxStepInstance")
    @JsonBackReference
    private List<SxParPattern> sxParPatterns;

    public SxStepInstance() {
    }

}
