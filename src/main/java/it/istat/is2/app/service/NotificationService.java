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

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.app.bean.NotificationMessage;

@Service
public class NotificationService {

    public static final String NOTIFY_MSG_SESSION_KEY = "siteNotificationMessages";

    @Autowired
    private HttpSession httpSession;

    public void addInfoMessage(String msg) {
        addNotificationMessage(NotificationMessage.TYPE_SUCCESS, msg, "");
    }

    public void addInfoMessage(String msg, String details) {
        addNotificationMessage(NotificationMessage.TYPE_SUCCESS, msg, details);
    }

    public void addErrorMessage(String msg) {
        addNotificationMessage(NotificationMessage.TYPE_ERROR, msg, "");
    }

    public void addErrorMessage(String msg, String details) {
        addNotificationMessage(NotificationMessage.TYPE_ERROR, msg, details);
    }

    public void removeAllMessages() {
        if (httpSession != null) {
            httpSession.removeAttribute(NOTIFY_MSG_SESSION_KEY);
        }
    }

    @SuppressWarnings("unchecked")
    private void addNotificationMessage(String type, String msg, String details) {
        List<NotificationMessage> notifyMessages = (List<NotificationMessage>) httpSession
                .getAttribute(NOTIFY_MSG_SESSION_KEY);
        if (notifyMessages == null) {
            notifyMessages = new ArrayList<NotificationMessage>();
        }
        notifyMessages.add(new NotificationMessage(type, msg, details));
        httpSession.setAttribute(NOTIFY_MSG_SESSION_KEY, notifyMessages);
    }

    @SuppressWarnings("unchecked")
    public List<NotificationMessage> getNotificationMessages() {
        List<NotificationMessage> notifyMessages = (List<NotificationMessage>) httpSession
                .getAttribute(NOTIFY_MSG_SESSION_KEY);
        if (notifyMessages == null) {
            notifyMessages = new ArrayList<NotificationMessage>();
        }
        return notifyMessages;
    }

    public void addMessage(NotificationMessage messsage) {
        if (messsage.getText() != null) {

            @SuppressWarnings("unchecked")
            List<NotificationMessage> notifyMessages = (List<NotificationMessage>) httpSession
                    .getAttribute(NOTIFY_MSG_SESSION_KEY);
            if (notifyMessages == null) {
                notifyMessages = new ArrayList<NotificationMessage>();
            }
            notifyMessages.add(messsage);
            httpSession.setAttribute(NOTIFY_MSG_SESSION_KEY, notifyMessages);
        }
    }

}
