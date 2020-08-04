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
package it.istat.is2.workflow.domain;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.Data;

import java.util.List;

@Data
@Entity
@Table(name = "IS2_STEP_INSTANCE")
@NamedQuery(name = "StepInstance.findAll", query = "SELECT s FROM StepInstance s")
public class StepInstance implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;
    @Column(name = "METHOD")
    private String method;
    @Column(name = "DESCR")
    private String descr;
    @Column(name = "LABEL")
    private String label;

    @ManyToMany(mappedBy = "stepInstances", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonBackReference
    private List<ProcessStep> processSteps;

    @ManyToOne
    @JoinColumn(name = "APP_SERVICE_ID")
    @JsonBackReference
    private AppService appService;

    // bi-directional many-to-one association to StepInstanceSignature
    @OneToMany(mappedBy = "stepInstance", fetch = FetchType.EAGER)
    @JsonBackReference
    private List<StepInstanceSignature> stepInstanceSignatures;

    public StepInstance() {
    }

    public StepInstance(Long id) {
        this.id = id;
    }

}
