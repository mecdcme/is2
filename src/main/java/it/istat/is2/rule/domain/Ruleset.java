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
import it.istat.is2.worksession.domain.WorkSession;
import lombok.Data;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
@Entity
@Table(name = "IS2_RULESET")
public class Ruleset implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;
    @Column(name = "FILE_NAME")
    private String fileName;
    @Column(name = "FILE_LABEL")
    private String fileLabel;
    @Column(name = "DESCR")
    private String descr;
    @Column(name = "RULES_TOTAL")
    private Integer rulesTotal;
    @Column(name = "LAST_UPDATE")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date lastUpdate;

    @OneToOne
    @JoinColumn(name = "WORK_SESSION_ID")
    private WorkSession workSession;

    @OneToOne
    @JoinColumn(name = "DATASET_ID")
    private DatasetFile datasetFile;

    

    @OneToMany(mappedBy = "ruleset", cascade = CascadeType.ALL)
    @JsonBackReference
    private List<Rule> rules;

    public Ruleset() {
        this.rules = new ArrayList<>();
    }

    public Ruleset(Integer id) {
        this.id = id;
        this.rules = new ArrayList<>();
    }
}
