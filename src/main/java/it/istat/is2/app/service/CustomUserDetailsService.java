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
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import it.istat.is2.app.dao.UserDao;
import it.istat.is2.app.dao.UserRolesDao;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.security.CustomUserDetails;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserDao userDao;
    private final UserRolesDao userRolesDao;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private AuthenticationManager am;

    @Autowired
    public CustomUserDetailsService(UserDao userDao, UserRolesDao userRolesDao) {
        this.userDao = userDao;
        this.userRolesDao = userRolesDao;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userDao.findByEmail(email);
        CustomUserDetails cud;
        if (null == user) {
            notificationService.addErrorMessage("Nessun user presente con  user: " + email);
            throw new UsernameNotFoundException("No user present with user: " + email);
        } else {
            List<String> userRoles = userRolesDao.findRoleByEmail(email);
            cud = new CustomUserDetails(user, userRoles);
            return cud;
        }
    }

    public void authenticate(String name, Object password) {
        Authentication request = new UsernamePasswordAuthenticationToken(name, password);
        Authentication result = am.authenticate(request);
        SecurityContextHolder.getContext().setAuthentication(result);
    }

}
