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
package it.istat.rservice.app.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.istat.rservice.app.dao.UserDao;
import it.istat.rservice.app.dao.UserRolesDao;
import it.istat.rservice.app.domain.User;
import it.istat.rservice.app.domain.UserRole;
import it.istat.rservice.app.forms.UserCreateForm;

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

    public Optional<User> findOne(Long id) {
        return this.userDao.findById(id);
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

    public Optional<User> update(UserCreateForm uf) throws Exception {
        Optional<User> user = (Optional<User>) userDao.findById(uf.getUserid());
        if (user == null) {
            throw new Exception("User not found");
        }
        user.get().setEmail(uf.getEmail());
        user.get().setName(uf.getName());
        user.get().setSurname(uf.getSurname());  
        UserRole ur = new UserRole(uf.getRole());
        user.get().setRole(ur);
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

    public Optional<User> updatePasswordById(Long id, String password) throws Exception {
        Optional<User> user = userDao.findById(id);
        if (user == null) {
            throw new Exception("User not found");
        }

        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        user.get().setPassword(passwordEncoder.encode(password));
        userDao.save(user);
        return user;
    }

    public void delete(Long id) {
        userDao.deleteById(id);

    }
}
