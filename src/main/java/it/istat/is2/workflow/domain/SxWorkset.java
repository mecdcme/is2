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


import it.istat.is2.app.domain.converter.ListToStringConverter;
import lombok.Data;
import lombok.Getter;
import lombok.AccessLevel;

import java.util.List;

/**
 * The persistent class for the SX_WORKSET database table.
 *
 */
@Data
@Entity
@Table(name = "SX_WORKSET")
@NamedQuery(name = "SxWorkset.findAll", query = "SELECT s FROM SxWorkset s")
public class SxWorkset implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    private String nome;

    @Column(name = "valori_size")
    private Integer valoriSize;

    @Column(name = "valori")
    @Convert(converter = ListToStringConverter.class)
    private List<String> valori;
    
    @Column(name = "param_value")
    private String paramValue;
    
    @Transient
    @Getter(AccessLevel.NONE)
    private String valoriStr;
    // bi-directional many-to-one association to SxTipoVar
    @ManyToOne
    @JoinColumn(name = "TIPO_VAR")
    private SxTipoVar sxTipoVar;

    // bi-directional many-to-one association to SxVarPattern
    @OneToMany(mappedBy = "sxWorkset")
    private List<SxStepVariable> sxStepVariables;

    public String getValoriStr() {
        String ret = "";
        for (int i = 0; i < valori.size(); i++) {
            ret += valori.get(i) + " ";
        }
        String ret2 = ret.trim();
        return ret2;
    }
}
