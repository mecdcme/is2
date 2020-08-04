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

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "IS2_STEP_RUNTIME")
public class StepRuntime implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Integer id;
    @Column(name = "ORDER_CODE")
    private Short orderCode;

    @ManyToOne
    @JoinColumn(name = "CLS_TYPE_IO_ID")
    private TypeIO typeIO;

    @ManyToOne
    @JoinColumn(name = "APP_ROLE_ID")
    private AppRole appRole;

    @ManyToOne
    @JoinColumn(name = "ROLE_GROUP")
    private AppRole roleGroup;

    @ManyToOne
    @JoinColumn(name = "CLS_DATA_TYPE_ID")
    private DataTypeCls dataType;

    @ManyToOne
    @JoinColumn(name = "DATA_PROCESSING_ID")
    private DataProcessing dataProcessing;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "WORKSET_ID")
    private Workset workset;

    @OneToOne
    @JoinColumn(name = "STEP_INSTANCE_SIGNATURE_ID")
    private StepInstanceSignature stepInstanceSignature;

    public StepRuntime() {
    }

    public StepRuntime(Integer id) {
        super();
        this.id = id;
    }

    public StepRuntime(Integer id, AppRole appRole, DataProcessing dataProcessing, TypeIO typeIO, Short order,
                       Long idw, Long idDsCol, String nomeW, Integer valoriSizeW, String paramValue) {
        super();
        this.id = id;
        this.appRole = appRole;
        this.dataProcessing = dataProcessing;
        this.typeIO = typeIO;
        this.orderCode = order;


        Workset ws = new Workset();
        ws.setId(idw);
        ws.setName(nomeW);

        ws.setContentSize(valoriSizeW);
        ws.setContents(new ArrayList<>());
        ws.setParamValue(paramValue);
        ws.setDatasetColumnId(idDsCol);
        this.workset = ws;

    }

}
