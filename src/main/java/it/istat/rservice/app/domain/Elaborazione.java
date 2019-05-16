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
package it.istat.rservice.app.domain;

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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import javax.persistence.OrderBy;
import javax.persistence.Table;
import com.fasterxml.jackson.annotation.JsonIgnore;

import it.istat.rservice.workflow.domain.SxBusinessFunction;
import it.istat.rservice.workflow.domain.SxStepVariable;
import lombok.Data;

@Data
@Entity
@Table(name = "SX_ELABORAZIONE")
public class Elaborazione implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "DATAELABORAZIONE")
    private Date dataElaborazione;
    @Column(name = "DESCRIZIONE")
    private String descrizione;
    @Column(name = "PARAMETRI")
    private String parametri;
    @Column(name = "nome")
    private String nome;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "ses_elaborazione", nullable = false)
    @JsonIgnore
    private SessioneLavoro sessioneLavoro;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "BFUNCTION", nullable = false)
    private SxBusinessFunction sxBusinessFunction;

    @OneToMany(mappedBy = "elaborazione", cascade = CascadeType.ALL)
    @OrderBy(value = "ordine ASC")
    private List<SxStepVariable> sxStepVariables;

    public Elaborazione(Long id) {
        super();
        this.id = id;
    }

    public Elaborazione() {
        super();

    }
}
