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
package it.istat.is2.rule.domain;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;

import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.workflow.domain.BusinessStep;
import it.istat.is2.worksession.domain.WorkSession;
import lombok.Data;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * The persistent class for the SX_RULESET database table.
 *
 */
@Data
@Entity
@Table(name = "SX_RULESET")
@NamedQuery(name = "Ruleset.findAll", query = "SELECT s FROM Ruleset s")
public class Ruleset implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;
    @Column(name = "DESCR")
    private String descr;
    @Column(name = "NUMERO_RIGHE")
    private Integer numeroRighe;
    @Column(name = "NOME_FILE")
    private String nomeFile;
    @Column(name = "LABEL_FILE")
    private String labelFile;
    @Column(name = "DATA_CARICAMENTO")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date dataCaricamento;
    @OneToOne
    @JoinColumn(name = "SESSIONE_LAVORO")
    private WorkSession sessioneLavoro;

    @OneToMany(mappedBy = "ruleset")
    @JsonBackReference
    private List<BusinessStep> businessSteps;

    @OneToMany(mappedBy = "ruleset", cascade = CascadeType.ALL)
    @JsonBackReference
    private List<Rule> rules;   
    
    @OneToOne
    @JoinColumn(name = "DATASET")
    private DatasetFile datasetFile;

    public Ruleset() {
        this.rules = new ArrayList<Rule>();
    }

    public Ruleset(Integer id) {
    	this.id=id;
        this.rules = new ArrayList<Rule>();
    }
}
