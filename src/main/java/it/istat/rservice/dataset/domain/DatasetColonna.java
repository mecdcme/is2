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
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Convert;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;

import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import com.fasterxml.jackson.annotation.JsonBackReference;

import it.istat.rservice.app.domain.converter.ListToStringConverter;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(exclude = {"datasetFile"})
@Entity
@Table(name = "SX_DATASET_COLONNA")
public class DatasetColonna implements Serializable {

    private static final long serialVersionUID = 3059519218117628717L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "IDCOL")
    private Long id;
    @Column(name = "NOME")
    private String nome;
    @Column(name = "ORDINE")
    private Short ordine;
    @Column(name = "FILTRO")
    private Short filtro;

    @Column(name = "VALORI_SIZE")
    private Integer valoriSize;

    @Basic(fetch = FetchType.LAZY)
    @Column(name = "DATICOLONNA")
    @Convert(converter = ListToStringConverter.class)
    private List<String> datiColonna;

    @ManyToOne
    @JoinColumn(name = "dataset_file")
    @JsonBackReference
    private DatasetFile datasetFile;

    @ManyToOne(optional = true, fetch = FetchType.LAZY)
    @JoinColumn(name = "TIPO_VARIABILE", nullable = true)
    private TipoVariabileSum tipoVariabile;

    public DatasetColonna() {
        super();
    }

    public DatasetColonna(Long id) {
        super();
        this.id = id;
    }

    public DatasetColonna(Long id, String nome, Short ordine, Short filtro, DatasetFile datasetFile, TipoVariabileSum tipoVariabile) {
        super();
        this.id = id;
        this.nome = nome;
        this.ordine = ordine;
        this.filtro = filtro;
        this.datasetFile = datasetFile;
        this.tipoVariabile = tipoVariabile;
        this.datiColonna = new ArrayList<>();
    }

    public DatasetColonna(Long id, String nome, Short ordine, DatasetFile datasetFile, Integer In) {
        super();
        this.id = id;
        this.nome = nome;
        this.ordine = ordine;
        this.datasetFile = datasetFile;
        this.tipoVariabile = null;
        this.datiColonna = new ArrayList<>();
    }

    public DatasetColonna(Long id, String nome, Short ordine) {
        super();
        this.id = id;
        this.nome = nome;
        this.ordine = ordine;
        this.datasetFile = null;
        this.tipoVariabile = null;
        ;
        this.datiColonna = new ArrayList<>();
    }

    public DatasetColonna(Long id, String nome, Short ordine, DatasetFile datasetFile) {
        super();
        this.id = id;
        this.nome = nome;
        this.ordine = ordine;
        this.datasetFile = datasetFile;
        this.tipoVariabile = null;
        this.datiColonna = new ArrayList<>();
    }
}
