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
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(name = "IS2_BUSINESS_PROCESS")
@JsonIgnoreProperties(ignoreUnknown=true)
public class BusinessProcess implements Serializable {

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
    @Column(name="ORDER_CODE")
    private Short order;
   

    
    @ManyToMany(mappedBy = "businessProcesses")
    private List<BusinessFunction> businessFunctions;

    @JsonManagedReference
    @ManyToOne(cascade = {CascadeType.ALL})
    @JoinColumn(name = "PARENT")
    private BusinessProcess businessProcessParent;

    @JsonBackReference
    @ManyToMany(cascade = {CascadeType.ALL})
    @JoinTable(name = "is2_link_process_step", joinColumns = @JoinColumn(name = "BUSINESS_PROCESS_ID"), inverseJoinColumns = @JoinColumn(name = "PROCESS_STEP_ID"))
    private List<ProcessStep> businessSteps;
    @JsonBackReference
    @OneToMany(mappedBy = "businessProcessParent")
    private List<BusinessProcess> businessSubProcesses = new ArrayList<>();
    
    

    
    public BusinessProcess() {
    }

    public BusinessProcess(Long idFunction) {
        super();
        this.id = idFunction;
    }

}



