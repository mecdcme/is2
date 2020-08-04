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
package it.istat.is2.app.controller;

import it.istat.is2.app.bean.BusinessFunctionBean;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;

import it.istat.is2.app.service.AdministrationService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.workflow.domain.AppService;
import it.istat.is2.workflow.domain.ViewDataType;
import it.istat.is2.workflow.domain.BusinessFunction;
import it.istat.is2.workflow.domain.BusinessService;
import it.istat.is2.workflow.domain.GsbpmProcess;
import it.istat.is2.workflow.domain.StepInstance;
import it.istat.is2.workflow.service.BusinessFunctionService;
import it.istat.is2.workflow.service.BusinessServiceService;
import it.istat.is2.workflow.service.GsbpmProcessService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class HomeController {

    @Autowired
    private BusinessFunctionService businessFunctionService;
    @Autowired
    private BusinessServiceService businessServiceService;
    @Autowired
    private GsbpmProcessService gsbpmProcessService;
    @Autowired
    private AdministrationService administrationService;
    @Autowired
    private MessageSource messages;
    @Autowired
    private NotificationService notificationService;

    @GetMapping("/")
    public String home(HttpSession session, Model model) {
        notificationService.removeAllMessages();

        List<BusinessService> businessServiceList = businessServiceService.findBusinessServices();
        List<BusinessFunction> businessFunctionList = businessFunctionService.findBFunctions();

        List<BusinessFunctionBean> businessFunctionBeanList = new ArrayList<BusinessFunctionBean>();
        for (BusinessFunction bf : businessFunctionList) {
            if (bf.getViewDataType().contains(new ViewDataType(IS2Const.VIEW_DATATYPE_RULESET))) {
                businessFunctionBeanList.add(new BusinessFunctionBean(bf.getId(), bf.getName(), bf.getDescr(), true));
            } else {
                businessFunctionBeanList.add(new BusinessFunctionBean(bf.getId(), bf.getName(), bf.getDescr(), false));
            }
        }

        session.setAttribute(IS2Const.SESSION_BUSINESS_FUNCTIONS, businessFunctionBeanList);
        session.setAttribute(IS2Const.SESSION_BUSINESS_SERVICES, businessServiceList);

        return "index";
    }

    @GetMapping("/gsbpm")
    public String services(HttpSession session, Model model) {
        notificationService.removeAllMessages();

        HashMap<String, GsbpmProcess> gsbpmMatrix = gsbpmProcessService.getGsbpmMatrix();
        Integer rows = gsbpmProcessService.getGsbpmRows();
        Integer columns = gsbpmProcessService.getGsbpmColumns();

        model.addAttribute("gsbpmMatrix", gsbpmMatrix);
        model.addAttribute("rows", rows);
        model.addAttribute("columns", columns);

        return "service/gsbpm";
    }

    @GetMapping("/gsbpm/{idGsbpm}")
    public String getServiceByGsbpm(HttpSession session, Model model, @PathVariable("idGsbpm") Long idGsbpm) {
        notificationService.removeAllMessages();
        List<BusinessService> businessServices = businessServiceService.findBusinessServiceByIdGsbpm(idGsbpm);
        GsbpmProcess gsbpmProcess = gsbpmProcessService.findById(idGsbpm);

        model.addAttribute("businessServices", businessServices);
        model.addAttribute("gsbpmProcess", gsbpmProcess);

        return "service/list";
    }

    @GetMapping(value = "/service/{idService}")
    public String getService(HttpSession session, Model model, @PathVariable("idService") Long idBusinessService) {
        notificationService.removeAllMessages();
        BusinessService businessService = businessServiceService.findBusinessServiceById(idBusinessService);
        List<AppService> appServices = businessServiceService.findAppServices(idBusinessService);
        List<StepInstance> stepInstances = businessServiceService.findStepInstances(idBusinessService);

        model.addAttribute("businessService", businessService);
        model.addAttribute("appServices", appServices);
        model.addAttribute("appService", appServices.get(0)); // DEBUG
        model.addAttribute("stepInstances", stepInstances);
        return "service/home";
    }

    @GetMapping("/code")
    public String getSourceCode(HttpSession session, Model model) {
        notificationService.removeAllMessages();
        return "service/code";
    }

    @GetMapping("/functions")
    public String functions(HttpSession session, Model model) {
        notificationService.removeAllMessages();
        return "function/list";
    }

    @GetMapping("/team")
    public String team(HttpSession session, Model model) {
        notificationService.removeAllMessages();
        return "team";
    }

    @GetMapping("/admin")
    public String admin(HttpSession session, Model model) {
        notificationService.removeAllMessages();
        return "admin/home";
    }

    @PostMapping("/startr")
    public String startR(HttpSession session, Model model) {
        notificationService.removeAllMessages();

        try {
            administrationService.startR();
            notificationService
                    .addInfoMessage(messages.getMessage("generic.success", null, LocaleContextHolder.getLocale()));
        } catch (Exception e) {
            notificationService.addErrorMessage(
                    messages.getMessage("generic.error", null, LocaleContextHolder.getLocale()), e.getMessage());
        }

        return "admin/home";
    }
}
