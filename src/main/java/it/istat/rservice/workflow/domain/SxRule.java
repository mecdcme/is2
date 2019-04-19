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
package it.istat.rservice.workflow.domain;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Data;

import java.math.BigDecimal;

/**
 * The persistent class for the SX_RULE database table.
 *
 */
@Data
@Entity
@Table(name = "SX_RULE")
@NamedQuery(name = "SxRule.findAll", query = "SELECT s FROM SxRule s")
public class SxRule implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    private long id;

    @Column(name = "ACTION")
    private String action;

    private BigDecimal active;

    private BigDecimal blockrule;

    private String descr;

    private String eccezione;

    private BigDecimal errcode;

    private String nome;

    private String regola;

    private BigDecimal rtype;

    //bi-directional many-to-one association to SxRuleset
    @ManyToOne
    @JoinColumn(name = "RULESET")
    private SxRuleset sxRuleset;

    public SxRule() {
    }
}
