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
package it.istat.is2.rule.controller.rest;

import it.istat.is2.app.domain.Log;
import it.istat.is2.app.service.LogService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.rule.domain.Rule;
import it.istat.is2.rule.forms.RuleCreateForm;
import it.istat.is2.rule.service.RuleService;

import static it.istat.is2.app.util.IS2Const.OUTPUT_R;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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
    private MessageSource messages;

    @GetMapping("/rules")
    public List<Rule> ruleslist(Model model) {

        List<Rule> rules = ruleService.findAll();
        return rules;
    }

    @SuppressWarnings("unchecked")
    @GetMapping("/rest/runvalidater/{idRuleset}/{rfunction}")
    public ResponseEntity<?> runValidateR(HttpSession session, Model model, @PathVariable("idRuleset") Integer idRuleset, @PathVariable("rfunction") String rfunction) {
        notificationService.removeAllMessages();

        Map<String, Object> resulVal = new HashMap<String, Object>();
        try {
            resulVal = (Map<String, Object>) ruleService.runValidateR(idRuleset, rfunction);
            for (Entry<String, Object> me : resulVal.entrySet()) {
                model.addAttribute(me.getKey().toString(), me.getValue());
            }
        } catch (Exception e) {
            //notificationService.addErrorMessage("Error: " + e.getMessage());
        }

        List<Log> rlogs = logService.findByIdSessioneAndTipo(OUTPUT_R);
        resulVal.put("rlogs", rlogs);
        resulVal.put("rfunction", rfunction);

        return ResponseEntity.ok(resulVal);

    }


    @PostMapping("/rules")
    public ResponseEntity<?> newRule(@Valid @ModelAttribute("ruleCreateForm") RuleCreateForm form,
                                     BindingResult bindingResult) {

        notificationService.removeAllMessages();
        if (!bindingResult.hasErrors()) {
            try {
                ruleService.save(form);
                notificationService
                        .addInfoMessage(messages.getMessage("rule.created", null, LocaleContextHolder.getLocale()));
            } catch (Exception e) {
                notificationService.addErrorMessage("Error: " + e.getMessage());
            }
        } else {
            List<FieldError> errors = bindingResult.getFieldErrors();
            for (FieldError error : errors) {
                notificationService.addErrorMessage(error.getField() + " - " + error.getDefaultMessage());
            }
        }
        return ResponseEntity.ok(notificationService.getNotificationMessages());
    }


    @DeleteMapping("/rules/{id}")
    public ResponseEntity<?> deleteRule(@PathVariable("id") Integer id) {

        notificationService.removeAllMessages();

        try {
            ruleService.delete(id);
            notificationService
                    .addInfoMessage(messages.getMessage("rule.deleted", null, LocaleContextHolder.getLocale()));

        } catch (Exception e) {
            notificationService.addErrorMessage("Error: " + e.getMessage());
        }

        return ResponseEntity.ok(notificationService.getNotificationMessages());
    }

}
