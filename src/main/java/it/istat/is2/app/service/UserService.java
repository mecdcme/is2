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
package it.istat.is2.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.istat.is2.app.dao.UserDao;
import it.istat.is2.app.dao.UserRolesDao;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.domain.UserRole;
import it.istat.is2.app.forms.UserCreateForm;
import it.istat.is2.app.util.IS2Const;

@Service
@Transactional
public class UserService {

	@Autowired
	private UserDao userDao;
	@Autowired
	private UserRolesDao userRolesDao;

	public List<User> findAll() {
		return (List<User>) this.userDao.findAll();
	}

	public List<UserRole> findAllRoles() {
		return (List<UserRole>) this.userRolesDao.findAll();
	}

	public User findOne(Long id) {
		return this.userDao.findById(id).orElse(null);
	}

	public User findByEmail(String email) {
		return this.userDao.findByEmail(email);
	}

	public User create(UserCreateForm uf) {
		User user = new User();
		user.setEmail(uf.getEmail());
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		user.setPassword(passwordEncoder.encode(uf.getPassword()));
		user.setName(uf.getName());
		user.setSurname(uf.getSurname());
		UserRole ur = new UserRole(uf.getRole());
		user.setRole(ur);
		userDao.save(user);
		return user;
	}

	public User update(UserCreateForm uf, String principal) throws Exception {
		User user = userDao.findById(uf.getId()).orElse(null);
		if (user == null) {
			throw new Exception("User not found");
		}
		user.setEmail(uf.getEmail());
		user.setName(uf.getName());
		user.setSurname(uf.getSurname());

		User userPrincipal = userDao.findByEmail(principal);
		if (userPrincipal == null) {
			throw new Exception("User not found");
		}
		if (userPrincipal.getRole().getId().equals(IS2Const.USER_ROLE_ADMIN)) {

			UserRole ur = new UserRole(uf.getRole());
			user.setRole(ur);
		}
		userDao.save(user);

		return user;
	}
	public User update(UserCreateForm uf) throws Exception {
		User user = userDao.findById(uf.getId()).orElse(null);
		if (user == null) {
			throw new Exception("User not found");
		}
		user.setEmail(uf.getEmail());
		user.setName(uf.getName());
		user.setSurname(uf.getSurname());

	 	UserRole ur = new UserRole(uf.getRole());
			user.setRole(ur);
		 
		userDao.save(user);

		return user;
	}

	public User updatePasswordByEmail(String email, String password) throws Exception {
		User user = userDao.findByEmail(email);
		if (user == null) {
			throw new Exception("User not found");
		}

		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		user.setPassword(passwordEncoder.encode(password));
		userDao.save(user);
		return user;
	}

	public User updatePasswordById(Long id, String password) throws Exception {
		User user = userDao.findById(id).orElse(null);
		if (user == null) {
			throw new Exception("User not found");
		}

		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		user.setPassword(passwordEncoder.encode(password));
		userDao.save(user);
		return user;
	}

	public void delete(Long id) {
		userDao.deleteById(id);
	}
}
