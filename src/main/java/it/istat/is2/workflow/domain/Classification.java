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
@NamedQuery(name = "Classification.findAll", query = "SELECT s FROM Classification s")
public class Classification implements Serializable {

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
   

    public Classification() {
        super();
    }

    public Classification(Short id) {
        super();
        this.id = id;
    }
}
