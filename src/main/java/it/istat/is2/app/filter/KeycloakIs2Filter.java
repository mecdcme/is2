package it.istat.is2.app.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.keycloak.KeycloakSecurityContext;
import org.keycloak.representations.AccessToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;

import it.istat.is2.app.domain.User;
import it.istat.is2.app.forms.UserCreateForm;
import it.istat.is2.app.service.UserService;

@ConditionalOnProperty("keycloak.realm")
@Component
public class KeycloakIs2Filter implements Filter {

    @Autowired
    private UserService userService;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
            throws IOException, ServletException {
        KeycloakSecurityContext keycloakContext = 
            (KeycloakSecurityContext) request.getAttribute(
                KeycloakSecurityContext.class.getName());
        AccessToken token = keycloakContext.getToken();
        String email = token.getEmail();
        User user = userService.findByEmail(email);
        if (user == null){
            UserCreateForm userForm = new UserCreateForm();
            userForm.setName(token.getGivenName());
            userForm.setSurname(token.getFamilyName());
            userForm.setEmail(email);
            userForm.setPassword("password");
            userForm.setRole((short)2); //TODO : avoid hard-coding role
            userService.create(userForm);
        }
        filterChain.doFilter(request, response);
    }
    
}
