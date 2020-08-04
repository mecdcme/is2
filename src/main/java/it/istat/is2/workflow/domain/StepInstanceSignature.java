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

import lombok.Data;

/**
 * The persistent class for the SX_STEP_PATTERN database table.
 *
 */
@Data
@Entity
@Table(name = "IS2_STEP_INSTANCE_SIGNATURE")
public class StepInstanceSignature implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "ID")
    private Long id;
    @Column(name = "REQUIRED")
    private Boolean isRequerid;

    @ManyToOne
    @JoinColumn(name = "APP_ROLE_ID")
    private AppRole appRole;

    @ManyToOne
    @JoinColumn(name = "STEP_INSTANCE_ID")
    private StepInstance stepInstance;

    @ManyToOne
    @JoinColumn(name = "CLS_TYPE_IO_ID")
    private TypeIO typeIO;

}
