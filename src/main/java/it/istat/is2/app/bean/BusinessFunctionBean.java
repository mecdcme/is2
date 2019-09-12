/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.istat.is2.app.bean;

import java.io.Serializable;
import java.util.List;
import lombok.Data;

/**
 *
 * @author mbruno
 */
@Data
public class BusinessFunctionBean implements Serializable {

    private static final long serialVersionUID = 11292613;

    private Long id;
    private String name;
    private String description;
    boolean hasRuleSet;
    
    public BusinessFunctionBean(Long id, String name){
        this.id = id;
        this.name = name;
    }
}
