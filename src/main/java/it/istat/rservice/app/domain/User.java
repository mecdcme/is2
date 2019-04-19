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
package it.istat.rservice.app.domain;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.validator.constraints.Email;


import lombok.Data;

@Data
@Entity
@Table(name = "sx_users")
@DynamicUpdate
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "userid")
    private Long userid;

    @Column(name = "password", length = 100)
    private String password;

    @Email
    @Column(name = "email", unique = true, nullable = false)
    private String email;

    @Column(name = "name", length = 100)
    private String name;

    @Column(name = "surname", length = 100)
    private String surname;

 
    @OneToOne
    @JoinColumn(name = "roleid")
    private UserRole role;

    public User() {

    }

    public User(String email, String fullname) {
        this.email = email;
    }

    public User(Long userid, String email, String fullname) {
        this.userid = userid;
        this.email = email;
    }

    public User(User user) {
        this.userid = user.userid;
        this.name = user.name;
        this.surname = user.surname;
        this.email = user.email;
        this.password = user.password;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + userid + ", email='" + email + '\'' + ", passwordHash='" + password + '\'' + '}';
    }
}
