package it.istat.is2.workflow.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import lombok.Data;

/**
 * The persistent class for the SX_CLASSIFICATION database table.
 *
 */
@Data
@Entity
@Table(name = "SX_CLASSIFICATION")
@NamedQuery(name = "SxClassification.findAll", query = "SELECT s FROM SxClassification s")
public class SxClassification implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id 
    @Column(name = "ID")
    private Short id;
    @Column(name = "NOME")
    private String nome;
    @Column(name = "DESCRIZIONE")
    private String descrizione;    
    @Column(name = "NOTE")
    private String note;
   

    public SxClassification() {
        super();
    }

    public SxClassification(Short id) {
        super();
        this.id = id;
    }
}
