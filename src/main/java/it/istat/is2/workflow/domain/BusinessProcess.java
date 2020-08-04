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
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import it.istat.is2.workflow.domain.common.AbstractDomainObject;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "IS2_BUSINESS_PROCESS")
@JsonIgnoreProperties(ignoreUnknown = true)
public class BusinessProcess extends AbstractDomainObject implements Serializable {

    private static final long serialVersionUID = 1L;


    @Column(name = "LABEL")
    private String label;
    @Column(name = "ORDER_CODE")
    private Short order;

    @ManyToMany(mappedBy = "businessProcesses")
    private List<BusinessFunction> businessFunctions;

    @JsonManagedReference
    @ManyToOne(cascade = {CascadeType.ALL})
    @JoinColumn(name = "PARENT")
    private BusinessProcess businessProcessParent;

    @JsonBackReference
    @ManyToMany(cascade = {CascadeType.ALL}, fetch = FetchType.EAGER)
    @JoinTable(name = "is2_link_process_step", joinColumns = @JoinColumn(name = "BUSINESS_PROCESS_ID"), inverseJoinColumns = @JoinColumn(name = "PROCESS_STEP_ID"))
    @OrderBy(value = "id")
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



