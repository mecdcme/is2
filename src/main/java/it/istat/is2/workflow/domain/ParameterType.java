/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.istat.is2.workflow.domain;

import java.io.Serializable;

import javax.persistence.Entity;

import javax.persistence.Table;

import it.istat.is2.workflow.domain.common.AbstractDomainObject;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Entity
@Table(name = "IS2_PARAMTER_TYPE")
public class ParameterType extends AbstractDomainObject implements Serializable {

    private static final long serialVersionUID = 1L;

}
