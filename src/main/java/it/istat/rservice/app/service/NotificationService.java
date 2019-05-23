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

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NotificationService {

    public static final String NOTIFY_MSG_SESSION_KEY = "siteNotificationMessages";

    @Autowired
    private HttpSession httpSession;

    public void addInfoMessage(String msg) {
        addNotificationMessage(NotificationMessageType.SUCCESS, msg, "");
    }

    public void addInfoMessage(String msg, String details) {
        addNotificationMessage(NotificationMessageType.SUCCESS, msg, details);
    }

    public void addErrorMessage(String msg) {
        addNotificationMessage(NotificationMessageType.DANGER, msg, "");
    }

    public void addErrorMessage(String msg, String details) {
        addNotificationMessage(NotificationMessageType.DANGER, msg, details);
    }

    public void removeAllMessages() {
        if (httpSession != null) {
            httpSession.removeAttribute(NOTIFY_MSG_SESSION_KEY);
        }
    }

    @SuppressWarnings("unchecked")
    private void addNotificationMessage(NotificationMessageType type, String msg, String details) {
        List<NotificationMessage> notifyMessages = (List<NotificationMessage>) httpSession.getAttribute(NOTIFY_MSG_SESSION_KEY);
        if (notifyMessages == null) {
            notifyMessages = new ArrayList<NotificationMessage>();
        }
        notifyMessages.add(new NotificationMessage(type, msg, details));
        httpSession.setAttribute(NOTIFY_MSG_SESSION_KEY, notifyMessages);
    }

    @SuppressWarnings("unchecked")
    public List<NotificationMessage> getNotificationMessages() {
        List<NotificationMessage> notifyMessages = (List<NotificationMessage>) httpSession.getAttribute(NOTIFY_MSG_SESSION_KEY);
        if (notifyMessages == null) {
            notifyMessages = new ArrayList<NotificationMessage>();
        }
        return notifyMessages;
    }

    public enum NotificationMessageType {
        SUCCESS, DANGER
    }

    public class NotificationMessage {
        
        NotificationMessageType type;
        String text;
        String details;

        public NotificationMessage(NotificationMessageType type, String text) {
            this.type = type;
            this.text = text;
            this.details = "";
        }

        public NotificationMessage(NotificationMessageType type, String text, String details) {
            this.type = type;
            this.text = text;
            this.details = details;

        }

        public NotificationMessageType getType() {
            return type;
        }

        public String getText() {
            return text;
        }

        public String getDetails() {
            return details;
        }
    }
}
