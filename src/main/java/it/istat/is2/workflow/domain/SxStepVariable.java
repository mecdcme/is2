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
import java.util.ArrayList;

import javax.persistence.*;

import lombok.Data;

/**
 * The persistent class for the SX_VAR_PATTERN database table.
 *
 */
@Data
@Entity
@Table(name = "SX_STEP_VARIABLE")
@NamedQuery(name = "SxStepVariable.findAll", query = "SELECT s FROM SxStepVariable s")
public class SxStepVariable implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "flag_ricerca")
    private Short flagRicerca;
    // bi-directional many-to-one association to SxRuoli
    @ManyToOne
    @JoinColumn(name = "RUOLO")
    private SxRuoli sxRuoli;
    
    @ManyToOne
    @JoinColumn(name = "ROLE_GROUP")
    private SxRuoli sxRuoloGruppo;

    @ManyToOne
    @JoinColumn(name = "TIPO_CAMPO")
    private SXTipoCampo tipoCampo;

    // bi-directional many-to-one association to sxElaborazione
    @ManyToOne
    @JoinColumn(name = "ELABORAZIONE")
    private Elaborazione elaborazione;

    private Short ordine;
    // bi-directional many-to-one association to SxWorkset

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "VAR")
    private SxWorkset sxWorkset;

    public SxStepVariable() {
    }

    public SxStepVariable(Integer id) {
        super();
        this.id = id;
    }

    public SxStepVariable(Integer id, SxRuoli sxRuoli, Elaborazione elaborazione, SXTipoCampo tipoCampo, Short ordineW, Short flagRicerca,
            Long idw, String nomeW, Integer valoriSizeW) {
        super();
        this.id = id;
        this.sxRuoli = sxRuoli;
        this.elaborazione = elaborazione;
        this.tipoCampo = tipoCampo;
        this.ordine = ordineW;
        this.flagRicerca = flagRicerca;

        SxWorkset sxWorkset = new SxWorkset();
        sxWorkset.setId(idw);
        sxWorkset.setNome(nomeW);

        sxWorkset.setValoriSize(valoriSizeW);
        sxWorkset.setValori(new ArrayList<>());
        this.sxWorkset = sxWorkset;

    }

}
