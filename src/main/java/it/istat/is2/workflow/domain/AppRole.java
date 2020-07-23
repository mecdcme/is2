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

import com.fasterxml.jackson.annotation.JsonBackReference;

import it.istat.is2.workflow.domain.common.AbstractDomainObject;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
 
@Getter
@Setter
@Entity
@Table(name = "IS2_APP_ROLE")
@NamedQuery(name = "AppRole.findAll", query = "SELECT s FROM AppRole s")
public class AppRole  extends AbstractDomainObject  {

    private static final long serialVersionUID = 1L;

  
    @Column(name = "CODE")
    private String code;
    @Column(name = "ORDER_CODE")
    private Short order;
    
    @ManyToOne
    @JoinColumn(name = "CLS_DATA_TYPE_ID")
    private DataTypeCls dataType;
 
    @JsonBackReference
    @ManyToMany(mappedBy = "appRoles")
    private List<BusinessService> businessServices;
    
    @JsonBackReference
    @OneToMany(mappedBy = "appRole")
    private  List<StepInstanceSignature> stepInstanceSignatures;
    
    @ManyToOne
    @JoinColumn(name = "PARAMETER_ID")
    private Parameter parameter;

    public AppRole() {
    }

    public AppRole(Long id) {
        this.id = id;
    }

	 
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AppRole other = (AppRole) obj;
		if (businessServices == null) {
			if (other.businessServices != null)
				return false;
		} else if (!businessServices.equals(other.businessServices))
			return false;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		return true;
	}

	 
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((businessServices == null) ? 0 : businessServices.hashCode());
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		return result;
	}
	
	@Override
    public int compareTo(AbstractDomainObject abstractDomainObject) {
       
        return this.order.intValue() -((AppRole)abstractDomainObject).getOrder().intValue();
 
    }
}
