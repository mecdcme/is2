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
package it.istat.is2.worksession.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import it.istat.is2.app.domain.User;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.SxRuleset;

import javax.persistence.Temporal;
import lombok.Data;

@Data
@Entity
@Table(name = "SX_SESSIONE_LAVORO")
public class WorkSession implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @OneToOne
    @JoinColumn(name = "id_utente")
    private User user;

    @Column(name = "data_creazione")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date dataCreazione;
    @Column(name = "descrizione")
    private String descrizione;
    @Column(name = "nome")
    private String nome;

    @OneToMany(mappedBy = "sessioneLavoro", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Elaborazione> listaElaborazioni;

    @OneToMany(mappedBy = "sessioneLavoro", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<DatasetFile> datasetFiles;

    @OneToMany(mappedBy = "sessioneLavoro", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<SxRuleset> ruleSets;

    public WorkSession(Long id) {
        super();
        this.id = id;
    }

    public WorkSession() {
        super();
    }
}
