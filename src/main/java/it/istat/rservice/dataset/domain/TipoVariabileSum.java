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
package it.istat.rservice.dataset.domain;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Data;

/**
 * The persistent class for the TIPO_VARIABILE_SUM database table.
 * 
 */
@Data
@Entity
@Table(name = "SX_TIPO_VARIABILE_SUM")
public class TipoVariabileSum implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "TIPO_VARIABILE")
	private Integer tipoVariabile;

	@Column(name = "NOME_TIPO_VARIABILE_ENG")
	private String nomeTipoVariabileEng;

	@Column(name = "NOME_TIPO_VARIABILE_ITA")
	private String nomeTipoVariabileIta;

	@Column(name = "ORDINE")
	private Short ordine;

	@Column(name = "TITOLO")
	private String titolo;

	public TipoVariabileSum() {
		super();
	}

	public TipoVariabileSum(Integer tipoVariabile) {
		super();
		this.tipoVariabile = tipoVariabile;
	}
}