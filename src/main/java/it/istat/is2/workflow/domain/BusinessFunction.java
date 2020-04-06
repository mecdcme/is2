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
import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import it.istat.is2.workflow.domain.common.AbstractDomainObject;

import java.util.List;

@Data
@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "IS2_BUSINESS_FUNCTION")
public class BusinessFunction extends AbstractDomainObject implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "LABEL")
	private String label;
	@Column(name = "ACTIVE")
	private Short active;

	@JsonBackReference
	@ManyToMany(cascade = { CascadeType.ALL })

	@JoinTable(name = "is2_link_function_process", joinColumns = {

			@JoinColumn(name = "BUSINESS_FUNCTION_ID", referencedColumnName = "ID", nullable = false) }, inverseJoinColumns = {

					@JoinColumn(name = "BUSINESS_PROCESS_ID", referencedColumnName = "ID", nullable = false) })
	private List<BusinessProcess> businessProcesses;

	@JsonManagedReference
	@ManyToMany(cascade = { CascadeType.ALL })
	@JoinTable(name = "is2_link_function_view_data_type", joinColumns = {
			@JoinColumn(name = "BUSINESS_FUNCTION_ID", referencedColumnName = "ID", nullable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "VIEW_DATA_TYPE_ID", referencedColumnName = "ID", nullable = false) })
	private List<ViewDataType> viewDataType;

	public BusinessFunction() {
	}

	public BusinessFunction(Long idfunction) {
		super();
		this.id = idfunction;
	}

}
