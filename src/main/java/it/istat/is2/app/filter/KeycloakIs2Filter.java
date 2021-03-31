package it.istat.is2.app.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpStatus;
import org.keycloak.KeycloakSecurityContext;
import org.keycloak.representations.AccessToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;

import it.istat.is2.app.domain.User;
import it.istat.is2.app.service.UserService;

@ConditionalOnProperty("keycloak.realm")
@Component
public class KeycloakIs2Filter implements Filter {

    @Autowired
    private UserService userService;

    /** 
     * Redirects to /registerKeycloakUser if the user is authentified with Keycloak
     * but not registered in IS2.
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        KeycloakSecurityContext keycloakContext = 
                (KeycloakSecurityContext) request.getAttribute(
                    KeycloakSecurityContext.class.getName());
        AccessToken token = keycloakContext.getToken();
        String email = token.getEmail();
        User user = userService.findByEmail(email);
        if (user == null){
            HttpServletRequest httpRequest = (HttpServletRequest) request;
            HttpServletResponse httpResponse = (HttpServletResponse) response;

            String encodedRedirectURL = httpResponse.encodeRedirectURL(
                httpRequest.getContextPath() + "/registerKeycloakUser");
            httpResponse.setStatus(HttpStatus.SC_TEMPORARY_REDIRECT);
            httpResponse.setHeader("Location", encodedRedirectURL);
        }
        chain.doFilter(request, response);
        
    }
}
