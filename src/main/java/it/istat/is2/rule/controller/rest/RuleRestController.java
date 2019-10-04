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
package it.istat.is2.rule.controller.rest;

import it.istat.is2.app.service.LogService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.rule.forms.RuleCreateForm;
import it.istat.is2.rule.service.RuleService;
import it.istat.is2.workflow.domain.Rule;
import it.istat.is2.workflow.domain.Ruleset;
import java.util.List;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RuleRestController {

    @Autowired
    private LogService logService;

    @Autowired
    private RuleService ruleService;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    MessageSource messages;

    @GetMapping("/rules")
    public List<Rule> ruleslist(Model model) {

        List<Rule> rules = ruleService.findAll();
        return rules;
    }

    @GetMapping("/rules/runvalidate/{idRuleset}")
    public void runValidate(@PathVariable("idRuleset") Integer idRuleset) {

        Ruleset ruleSet = ruleService.findRulesetById(idRuleset);
        ruleService.runValidate(ruleSet);
    }

    @PostMapping("/rules")
    public List<NotificationService.NotificationMessage> newRule(@Valid @ModelAttribute("ruleCreateForm") RuleCreateForm form,
            BindingResult bindingResult) {

        notificationService.removeAllMessages();
        if (!bindingResult.hasErrors()) {
            try {
                ruleService.save(form);
                notificationService.addInfoMessage(messages.getMessage("rule.created", null, LocaleContextHolder.getLocale()));
            } catch (Exception e) {
                notificationService.addErrorMessage("Error: " + e.getMessage());
            }
        } else {
            List<FieldError> errors = bindingResult.getFieldErrors();
            for (FieldError error : errors) {
                notificationService.addErrorMessage(error.getField() + " - " + error.getDefaultMessage());
            }
        }
        return notificationService.getNotificationMessages();
    }

    @PutMapping("/rules")
    public List<NotificationService.NotificationMessage> updateRule(@Valid @ModelAttribute("ruleCreateForm") RuleCreateForm form,
            BindingResult bindingResult) {

        notificationService.removeAllMessages();
        if (!bindingResult.hasErrors()) {

            try {
                ruleService.update(form);
                notificationService.addInfoMessage(messages.getMessage("rule.updated", null, LocaleContextHolder.getLocale()));
            } catch (Exception e) {
                notificationService.addErrorMessage("Error: " + e.getMessage());
            }
        } else {
            List<FieldError> errors = bindingResult.getFieldErrors();
            for (FieldError error : errors) {
                notificationService.addErrorMessage(error.getField() + " - " + error.getDefaultMessage());
            }
        }
        return notificationService.getNotificationMessages();
    }

    @DeleteMapping("/rules/{id}")
    public List<NotificationService.NotificationMessage> deleteRule(@PathVariable("id") Integer id) {

        notificationService.removeAllMessages();
       
        try {
            ruleService.delete(id);
            notificationService.addInfoMessage(messages.getMessage("user.deleted", null, LocaleContextHolder.getLocale()));

        } catch (Exception e) {
            notificationService.addErrorMessage("Error: " + e.getMessage());
        }

        return notificationService.getNotificationMessages();
    }

}
