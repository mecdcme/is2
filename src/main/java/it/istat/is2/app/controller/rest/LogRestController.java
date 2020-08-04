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
package it.istat.is2.app.controller.rest;

import it.istat.is2.app.bean.NotificationMessage;
import it.istat.is2.app.service.LogService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.IS2Const;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LogRestController {

    @Autowired
    private NotificationService notificationService;

    @Autowired
    MessageSource messages;

    @Autowired
    private LogService logService;

    @DeleteMapping("/logs/{sessionId}")
    public List<NotificationMessage> deleteLogs(@PathVariable("sessionId") Long sessionId) {

        notificationService.removeAllMessages();

        try {
            logService.deleteByIdSessione(sessionId);

        } catch (Exception e) {
            notificationService.addErrorMessage("Error: " + e.getMessage());
        }

        return notificationService.getNotificationMessages();
    }

    @DeleteMapping("/rlogs/{sessionId}")
    public List<NotificationMessage> deleteRLogs(@PathVariable("sessionId") Long sessionId) {

        notificationService.removeAllMessages();

        try {
            logService.deleteByIdSessioneAndTipo(sessionId, IS2Const.OUTPUT_R);

        } catch (Exception e) {
            notificationService.addErrorMessage("Error: " + e.getMessage());
        }

        return notificationService.getNotificationMessages();
    }

}
