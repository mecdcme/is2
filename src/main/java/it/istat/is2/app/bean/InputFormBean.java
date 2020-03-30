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
package it.istat.is2.app.bean;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class InputFormBean implements Serializable {

	private static final long serialVersionUID = 1L;

	private MultipartFile fileName;
	private String name;
	private String descrizione;
	private String tipo;
	private String labelFile;
	private String labelCodeRule;
	private Long fileType;
	private String covariate;
	private String predizioni;
	private int numeroCampi;
	private String delimiter;
	private String identificativo;
	private String target;
	private String covariata;
	private String outlier;
	private String idsessione;
	private String classificazione;
	private Integer skipFirstLine;
}
