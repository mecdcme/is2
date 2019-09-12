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
import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import java.util.List;

/**
 * The persistent class for the SX_BUSINESS_STEP database table.
 *
 */
@Data
@Entity
@EqualsAndHashCode(exclude = "stepInstances")
@Table(name = "SX_BUSINESS_STEP")
@NamedQuery(name = "BusinessStep.findAll", query = "SELECT s FROM BusinessStep s")
public class BusinessStep implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    private Long id;

    private String descr;

    private String nome;

    @ManyToMany
    @JoinTable(name = "SX_STEP_STEPINSTANCE", joinColumns = {
        @JoinColumn(name = "STEP")}, inverseJoinColumns = {
        @JoinColumn(name = "ISTANZA")})
    @JsonManagedReference
    private List<StepInstance> stepInstances;

    @ManyToMany(mappedBy = "businessSteps")
    @JsonBackReference
    private List<BusinessProcess> businessProcesses;

    @ManyToOne
    @JoinColumn(name = "REGOLE")
    @JsonBackReference
    private Ruleset ruleset;
  
    public BusinessStep() {
    }

    public BusinessStep(Long id) {
        super();
        this.id = id;
    }

}
