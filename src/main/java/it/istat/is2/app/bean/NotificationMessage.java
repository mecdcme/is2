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
 * @version 0.1.1
 */
/**
 *
 */
package it.istat.is2.app.bean;

import java.io.Serializable;

import lombok.Data;

@Data
public class NotificationMessage implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 1L;
    public static final String TYPE_SUCCESS = "SUCCESS";
    public static final String TYPE_ERROR = "ERROR";
    public static final String TYPE_INFO = "INFO";

    String type;
    String text;
    String details;

    public NotificationMessage() {
    }

    public NotificationMessage(String type, String text) {
        this.type = type;
        this.text = text;
        this.details = "";
    }

    public NotificationMessage(String type, String text, String details) {
        this.type = type;
        this.text = text;
        this.details = details;

    }

}
