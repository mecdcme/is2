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
package it.istat.is2.app.forms;

import javax.validation.constraints.NotNull;

import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class UserCreateForm {

    private Long id;

    @NotNull
    @Size(min = 2, max = 100)
    private String email;

    @NotNull
    @Size(min = 2, max = 50)
    private String password;

    @NotNull
    @Size(min = 2, max = 30)
    private String name;

    @NotNull
    @Size(min = 2, max = 30)
    private String surname;

    @NotNull
    private Short role;

       
    public String toString() {
        return "Person(Email: " + this.email + ", Nome: " + this.name + ", Surname: " + this.surname + ")";
    }
}
