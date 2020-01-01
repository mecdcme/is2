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
package it.istat.is2.app.controller;

import it.istat.is2.app.bean.BusinessFunctionBean;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import it.istat.is2.app.service.AdministrationService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.workflow.domain.ViewDataType;
import it.istat.is2.workflow.domain.BusinessFunction;
import it.istat.is2.workflow.service.BusinessFunctionService;
import java.util.ArrayList;
import java.util.List;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

    @Autowired
    private BusinessFunctionService businessFunctionService;
    @Autowired
    private AdministrationService administrationService;
    @Autowired
    private MessageSource messages;
    @Autowired
    private NotificationService notificationService;

    @RequestMapping("/")
    public String home(HttpSession session, Model model) {
        notificationService.removeAllMessages();

        List<BusinessFunction> businessFunctionList = businessFunctionService.findBFunctions();

        List<BusinessFunctionBean> businessFunctionBeanList = new ArrayList();
        for (BusinessFunction bf : businessFunctionList) {
            if (bf.getViewDataType().contains(new ViewDataType(IS2Const.VIEW_DATATYPE_RULESET))) {
                businessFunctionBeanList.add(new BusinessFunctionBean(bf.getId(), bf.getName(), bf.getDescr(), true));
            } else {
                businessFunctionBeanList.add(new BusinessFunctionBean(bf.getId(), bf.getName(), bf.getDescr(), false));
            }
        }

        session.setAttribute(IS2Const.SESSION_BUSINESS_FUNCTIONS, businessFunctionBeanList);

        return "index";
    }

    @RequestMapping("/team")
    public String team(HttpSession session, Model model) {
        notificationService.removeAllMessages();
        return "team";
    }

    @RequestMapping("/admin")
    public String admin(HttpSession session, Model model) {
        notificationService.removeAllMessages();
        return "admin/home";
    }

    @RequestMapping(value = "/startr", method = RequestMethod.POST)
    public String startR(HttpSession session, Model model) {
        notificationService.removeAllMessages();

        try {
            administrationService.startR();
            notificationService.addInfoMessage(
                    messages.getMessage("generic.success", null, LocaleContextHolder.getLocale()));
        } catch (Exception e) {
            notificationService.addErrorMessage(
                    messages.getMessage("generic.error", null, LocaleContextHolder.getLocale()), e.getMessage());
        }

        return "admin/home";
    }
}
