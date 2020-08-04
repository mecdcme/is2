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
package it.istat.is2.dataset.domain;

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
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

import it.istat.is2.app.domain.converter.ListToStringConverter;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(exclude = {"datasetFile"})
@Entity
@Table(name = "IS2_DATASET_COLUMN")
public class DatasetColumn implements Serializable {

    private static final long serialVersionUID = 3059519218117628717L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;
    @Column(name = "NAME")
    private String name;
    @Column(name = "ORDER_CODE")
    private Short orderCode;
    @Column(name = "CONTENT_SIZE")
    private Integer contentSize;

    @Basic(fetch = FetchType.LAZY)
    @Column(name = "CONTENT")
    @Convert(converter = ListToStringConverter.class)
    private List<String> contents;

    @ManyToOne
    @JoinColumn(name = "DATASET_FILE_ID")
    @JsonBackReference
    private DatasetFile datasetFile;

    @ManyToOne(optional = true, fetch = FetchType.LAZY)
    @JoinColumn(name = "STATISTICAL_VARIABLE_ID", nullable = true)
    private StatisticalVariableCls variabileType;

    public DatasetColumn() {
        super();
    }

    public DatasetColumn(Long id) {
        super();
        this.id = id;
    }

    public DatasetColumn(Long id, String nome, Short order, DatasetFile datasetFile, StatisticalVariableCls tipoVariabile) {
        super();
        this.id = id;
        this.name = nome;
        this.orderCode = order;
        this.datasetFile = datasetFile;
        this.variabileType = tipoVariabile;
        this.contents = new ArrayList<>();
    }

    public DatasetColumn(Long id, String nome, Short order, DatasetFile datasetFile, Integer In) {
        super();
        this.id = id;
        this.name = nome;
        this.orderCode = order;
        this.datasetFile = datasetFile;
        this.variabileType = null;
        this.contents = new ArrayList<>();
    }

    public DatasetColumn(Long id, String nome, Short order) {
        super();
        this.id = id;
        this.name = nome;
        this.orderCode = order;
        this.datasetFile = null;
        this.variabileType = null;
        this.contents = new ArrayList<>();
    }

    public DatasetColumn(Long id, String nome, Short order, DatasetFile datasetFile) {
        super();
        this.id = id;
        this.name = nome;
        this.orderCode = order;
        this.datasetFile = datasetFile;
        this.variabileType = null;
        this.contents = new ArrayList<>();
    }
}
