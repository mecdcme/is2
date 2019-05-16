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
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
 
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import it.istat.rservice.app.domain.SessioneLavoro;
import it.istat.rservice.workflow.domain.SxTipoDato;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(exclude = "sessioneLavoro")
@Entity
@Table(name = "SX_DATASET_FILE")
public class DatasetFile implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "ID")
    private Long id;
    @Column(name = "ID_UTENTE")
    private Integer idUtente;
    @Column(name = "NUMERO_RIGHE")
    private Integer numerorighe;
    @Column(name = "FORMATOFILE")
    private String formatoFile;
    @Column(name = "LABEL_FILE")
    private String labelFile;
    @Column(name = "SEPARATORE")
    private String separatore;
    @Column(name = "NOMEFILE")
    private String nomeFile;
    @Column(name = "DATACARICAMENTO")
    private Date dataCaricamento;
    @Column(name = "NOTE")
    private String note;
    
    @ManyToOne(optional = true, fetch = FetchType.LAZY)
    @JoinColumn(name = "TIPODATO", nullable = true)
    private SxTipoDato tipoDato;
    

    @OneToOne
    @JoinColumn(name = "sessione_lavoro")
    private SessioneLavoro sessioneLavoro;
    
    @OneToMany(fetch = FetchType.LAZY, cascade = {CascadeType.ALL}, mappedBy = "datasetFile", orphanRemoval = true)
    @JsonManagedReference
    @OrderBy(value = "ordine ASC")
    private List<DatasetColonna> colonne;

    public DatasetFile(Long id) {
        super();
        this.id = id;
    }

    public DatasetFile() {
        super();

    }

	public Short getNumCol() {
		// TODO Auto-generated method stub
		return  (short) colonne.size();
	}
}
