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

import com.fasterxml.jackson.annotation.JsonManagedReference;

import it.istat.is2.workflow.domain.common.AbstractDomainObject;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "IS2_GSBPM_PROCESS")
public class GsbpmProcess extends AbstractDomainObject implements Serializable {

    private static final long serialVersionUID = 1L;


    @Column(name = "ACTIVE")
    private Boolean active;
    @Column(name = "ORDER_CODE")
    private Short orderCode;

    @JsonManagedReference
    @ManyToOne(cascade = {CascadeType.ALL})
    @JoinColumn(name = "PARENT")
    private GsbpmProcess gsbpmProcessParent;

    @OneToMany(mappedBy = "gsbpmProcessParent")
    private List<GsbpmProcess> gsbpmSubProcesses = new ArrayList<>();

    @OneToMany(mappedBy = "gsbpmProcess")
    private List<BusinessService> businessServices;

    public GsbpmProcess() {
    }

    public GsbpmProcess(Long idFunction) {
        super();
        this.id = idFunction;
    }

}



