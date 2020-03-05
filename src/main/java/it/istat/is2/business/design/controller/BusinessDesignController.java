package it.istat.is2.business.design.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.workflow.domain.BusinessService;
import it.istat.is2.workflow.service.BusinessServiceService;

@Controller
public class BusinessDesignController {
	@Autowired
    private NotificationService notificationService;
    @Autowired
    private BusinessServiceService businessServiceService;
   

    @RequestMapping("/busservlist")
    public String serviceList(Model model) {
        notificationService.removeAllMessages();

        List<BusinessService> listaBService = businessServiceService.findBusinessServices();  
      
        model.addAttribute("listaBService", listaBService);

        return "businessdesign/home.html";

    }
}