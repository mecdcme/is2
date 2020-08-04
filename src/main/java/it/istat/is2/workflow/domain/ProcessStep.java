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

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import it.istat.is2.workflow.domain.common.AbstractDomainObject;

import java.util.List;

@Getter
@Setter
@Entity
@EqualsAndHashCode(callSuper = false, exclude = "stepInstances")
@Table(name = "IS2_PROCESS_STEP")
public class ProcessStep extends AbstractDomainObject implements Serializable {

    private static final long serialVersionUID = 1L;

    @Column(name = "LABEL")
    private String label;
    @JsonManagedReference
    @ManyToOne
    @JoinColumn(name = "BUSINESS_SERVICE_ID")
    private BusinessService businessService;
    @JsonBackReference
    @ManyToMany(cascade = {CascadeType.ALL}, fetch = FetchType.EAGER)
    @JoinTable(name = "is2_link_step_instance", joinColumns = {
            @JoinColumn(name = "PROCESS_STEP_ID")}, inverseJoinColumns = {
            @JoinColumn(name = "PROCESS_STEP_INSTANCE_ID")})

    private List<StepInstance> stepInstances;


    @ManyToMany(mappedBy = "businessSteps")
    private List<BusinessProcess> businessProcesses;

    public ProcessStep() {
    }

    public ProcessStep(Long id) {
        super();
        this.id = id;
    }


}
