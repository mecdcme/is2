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

@Data
@Entity
@EqualsAndHashCode(exclude = "stepInstances")
@Table(name = "IS2_PROCESS_STEP")
public class ProcessStep implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="ID")
    private Long id;
    @Column(name="NAME")
    private String name;
    @Column(name="DESCR")
    private String descr;
    @Column(name="LABEL")
    private String label;
    
    @ManyToOne
    @JoinColumn(name = "BUSINESS_SERVICE_ID")
    private BusinessService businessService;
   
    @ManyToMany
    @JoinTable(name = "is2_link_step_instance", joinColumns = {
        @JoinColumn(name = "PROCESS_STEP_ID")}, inverseJoinColumns = {
        @JoinColumn(name = "PROCESS_STEP_INSTANCE_ID")})
    @JsonManagedReference
    private List<StepInstance> stepInstances;

    @ManyToMany(mappedBy = "businessSteps")
    @JsonBackReference
    private List<BusinessProcess> businessProcesses;

    public ProcessStep() {
    }

    public ProcessStep(Long id) {
        super();
        this.id = id;
    }
    
    
    
    
  


}
