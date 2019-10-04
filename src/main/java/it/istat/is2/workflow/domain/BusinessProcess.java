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
import com.fasterxml.jackson.annotation.JsonManagedReference;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * The persistent class for the SX_BUSINESS_PROCESS database table.
 *
 */
@Data
@Entity
@Table(name = "SX_BUSINESS_PROCESS")
@NamedQuery(name = "BusinessProcess.findAll", query = "SELECT s FROM BusinessProcess s")
public class BusinessProcess implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    private Long id;

    private String descr;

    private String etichetta;

    private String nome;

    @JsonBackReference
    @ManyToMany(mappedBy = "businessProcesses")
    private List<BusinessFunction> businessFunctions;

    // bi-directional many-to-one association to Ruleset
    @ManyToOne
    @JoinColumn(name = "REGOLE")
    @JsonManagedReference
    private Ruleset sxRuleset;

    @JsonManagedReference
    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(name = "SX_BPROCESS_BSTEP", joinColumns = @JoinColumn(name = "BPROCESS"), inverseJoinColumns = @JoinColumn(name = "BSTEP"))
    private List<BusinessStep> businessSteps;

    @OneToMany(mappedBy = "sxBProcessParent")
    private List<BusinessProcess> businessSubProcesses = new ArrayList<>();

    @JsonManagedReference
    @ManyToOne(cascade = {CascadeType.ALL})
    @JoinColumn(name = "parent")
    private BusinessProcess sxBProcessParent;

    public BusinessProcess() {
    }

    public BusinessProcess(Long idFunction) {
        super();
        this.id = idFunction;
    }

}
