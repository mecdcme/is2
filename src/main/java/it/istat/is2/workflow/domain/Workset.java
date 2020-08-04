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
import javax.persistence.*;

import it.istat.is2.app.domain.converter.ListToStringConverter;
import lombok.Data;

import java.util.List;

@Data
@Entity
@Table(name = "IS2_WORKSET")
public class Workset implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Long id;
    @Column(name = "NAME")
    private String name;

    @Column(name = "ORDER_CODE")
    private Short orderCode;
    @Column(name = "CONTENT")
    @Convert(converter = ListToStringConverter.class)
    private List<String> contents;

    @Column(name = "CONTENT_SIZE")
    private Integer contentSize;

    @Column(name = "VALUE_PARAMETER")
    private String paramValue;

    @ManyToOne
    @JoinColumn(name = "CLS_DATA_TYPE_ID")
    private DataTypeCls dataType;

    @OneToMany(mappedBy = "workset", cascade = CascadeType.ALL)
    private List<StepRuntime> stepRuntimes;

    @Column(name = "DATASET_COLUMN")
    private Long datasetColumnId;

    public String getValoriStr() {
        String ret = "";
        for (int i = 0; i < contents.size(); i++) {
            ret += contents.get(i) + " ";
        }
        String ret2 = ret.trim();
        return ret2;
    }
}
