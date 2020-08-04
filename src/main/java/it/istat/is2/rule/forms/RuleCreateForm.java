/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.istat.is2.rule.forms;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class RuleCreateForm {

    @NotNull
    private Integer ruleId;
    @NotNull
    private Integer ruleSetId;
    @NotNull
    @Size(max = 500)
    private String rule;
    private String codeRule;
    private String descrizione;
    @NotNull
    private Short classificazione;


}
