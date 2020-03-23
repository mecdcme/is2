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
package it.istat.is2.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import it.istat.is2.app.domain.User;
import it.istat.is2.app.domain.UserRole;
import it.istat.is2.app.forms.LoginForm;
import it.istat.is2.app.forms.UserCreateForm;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.service.UserService;

import java.security.Principal;
import java.util.List;
import javax.validation.Valid;

@Controller
public class UserController {

	@Autowired
	private NotificationService notificationService;

	@Autowired
	private UserService userService;

	@Autowired
	private MessageSource messages;

	@GetMapping("/login")
	public String showLoginForm(LoginForm loginForm) {
		return "login";
	}

	@GetMapping(value = "/users/logout")
	public String logout() {
		notificationService.addInfoMessage(messages.getMessage("user.logout", null, LocaleContextHolder.getLocale()));
		return "redirect:/";
	}

	@GetMapping(value = "/users/newuser")
	public String getUserCreatePage(Model model, @ModelAttribute("userCreateForm") UserCreateForm form) {
		notificationService.removeAllMessages();
		List<UserRole> allRoles = userService.findAllRoles();
		model.addAttribute("allRoles", allRoles);
		return "users/newuser";
	}

	@GetMapping(value = "/users/edituser")
	public String getEditUser(Model model, Principal principal) {
		notificationService.removeAllMessages();
		String name = principal.getName();
		User user = userService.findByEmail(name);

		UserCreateForm userf = new UserCreateForm();
		userf.setSurname(user.getSurname());
		userf.setEmail(user.getEmail());
		userf.setName(user.getName());

		userf.setRole(user.getRole().getId());
		userf.setId(user.getId());
		model.addAttribute("userCreateForm", userf);

		List<UserRole> allRoles = userService.findAllRoles();
		model.addAttribute("allRoles", allRoles);

		return "users/edit";
	}

	@PostMapping(value = "/users/edituser")
	public String editUser(Model model, @Valid @ModelAttribute("userCreateForm") UserCreateForm form,
			BindingResult bindingResult) {
		notificationService.removeAllMessages();
		List<UserRole> allRoles = userService.findAllRoles();
		model.addAttribute("allRoles", allRoles);

		if (bindingResult.hasErrors()) {
			return "users/edit";
		}

		try {
			userService.update(form);
			notificationService
					.addInfoMessage(messages.getMessage("user.updated", null, LocaleContextHolder.getLocale()));
		} catch (Exception e) {
			notificationService.addErrorMessage("Error: " + e.getMessage());
			return "users/edit";
		}
		return "users/edit";
	}

	@PostMapping(value = "/users/newuser")
	public String handleUserCreateForm(Model model, @Valid @ModelAttribute("userCreateForm") UserCreateForm form,
			BindingResult bindingResult) {
		notificationService.removeAllMessages();
		List<UserRole> allRoles = userService.findAllRoles();
		model.addAttribute("allRoles", allRoles);

		if (bindingResult.hasErrors()) {
			return "users/newuser";
		}

		try {
			userService.create(form);
			notificationService
					.addInfoMessage(messages.getMessage("user.created", null, LocaleContextHolder.getLocale()));
		} catch (Exception e) {
			notificationService.addErrorMessage("Error: " + e.getMessage());
			return "users/newuser";
		}

		return "users/newuser";
	}

	@PreAuthorize("hasRole('ADMIN')")
	@GetMapping(value = "/users/userlist")
	public String userslist(Model model) {
		List<User> users = userService.findAll();
		model.addAttribute("users", users);
		List<UserRole> allRoles = userService.findAllRoles();
		model.addAttribute("allRoles", allRoles);

		return "users/list";
	}
}
