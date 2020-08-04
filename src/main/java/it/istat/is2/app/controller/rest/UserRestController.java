/**
 * Copyright 2017 ISTAT
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
 * @author Stefano Macone <stefano.macone @ istat.it>
 * @author Andrea Pagano <andrea.pagano @ istat.it>
 * @author Paolo Pizzo <papizzo @ istat.it>
 * @version 1.0
 */
package it.istat.is2.app.controller.rest;

import java.security.Principal;
import java.util.List;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import it.istat.is2.app.bean.NotificationMessage;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.forms.UserCreateForm;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.service.UserService;


@RestController
public class UserRestController {

    @Autowired
    private UserService userService;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    MessageSource messages;

    @GetMapping("/users")
    public List<User> userslist(Model model) {

        List<User> users = userService.findAll();
        return users;
    }

    @GetMapping("/users/{id}")
    public User getUser(@PathVariable("id") Long id) {

        User user = userService.findOne(id);
        return user;
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/users")
    public List<NotificationMessage> newUser(@Valid @ModelAttribute("userCreateForm") UserCreateForm form,
                                             BindingResult bindingResult) {

        notificationService.removeAllMessages();
        if (!bindingResult.hasErrors()) {
            try {
                userService.create(form);
                notificationService.addInfoMessage(messages.getMessage("user.created", null, LocaleContextHolder.getLocale()));
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

    @PreAuthorize("hasRole('ADMIN')")
    @PutMapping("/users")
    public List<NotificationMessage> updateUser(@Valid @ModelAttribute("userCreateForm") UserCreateForm form,
                                                BindingResult bindingResult) {

        notificationService.removeAllMessages();
        if (!bindingResult.hasErrors()) {

            try {
                userService.update(form);
                notificationService.addInfoMessage(messages.getMessage("user.updated", null, LocaleContextHolder.getLocale()));
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

    @PreAuthorize("hasRole('ADMIN')")
    @DeleteMapping("/users/{id}")
    public List<NotificationMessage> deleteUser(@PathVariable("id") Long id) {

        notificationService.removeAllMessages();
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (id.compareTo(user.getId()) == 0) {
            notificationService.addErrorMessage(messages.getMessage("user.error.delete", null, LocaleContextHolder.getLocale()));
        } else {
            try {
                userService.delete(id);
                notificationService.addInfoMessage(messages.getMessage("user.deleted", null, LocaleContextHolder.getLocale()));

            } catch (Exception e) {
                notificationService.addErrorMessage("Error: " + e.getMessage());
            }
        }
        return notificationService.getNotificationMessages();
    }

    @PostMapping(value = "/users/reset_password")
    public List<NotificationMessage> updateMyPassword(@RequestParam("passw") String password, Principal principal) {

        String email = principal.getName(); // get logged in username
        notificationService.removeAllMessages();
        try {
            userService.updatePasswordByEmail(email, password);
            notificationService.addInfoMessage(messages.getMessage("user.password.updated", null, LocaleContextHolder.getLocale()));
        } catch (Exception e) {
            notificationService.addErrorMessage("Error: " + e.getMessage());
        }
        return notificationService.getNotificationMessages();
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping(value = "/users/reset_password/{id}")
    public List<NotificationMessage> updatePassword(@RequestParam("passw") String password, @PathVariable("id") String id) {

        notificationService.removeAllMessages();
        try {
            userService.updatePasswordById(Long.parseLong(id), password);
            notificationService.addInfoMessage(messages.getMessage("user.password.updated", null, LocaleContextHolder.getLocale()));
        } catch (Exception e) {
            notificationService.addErrorMessage("Error: " + e.getMessage());
        }
        return notificationService.getNotificationMessages();
    }

}
