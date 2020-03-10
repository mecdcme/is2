package it.istat.is2.business.design.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.workflow.domain.AppService;
import it.istat.is2.workflow.domain.BusinessService;
import it.istat.is2.workflow.service.AppServiceService;
import it.istat.is2.workflow.service.BusinessServiceService;

@Controller
public class BusinessDesignController {
	@Autowired
    private NotificationService notificationService;
    @Autowired
    private BusinessServiceService businessServiceService;
    @Autowired
    private AppServiceService appServiceService;
   

    @GetMapping("/busservlist")
    public String serviceList(HttpSession session,Model model) {
        notificationService.removeAllMessages();

        List<BusinessService> listaBService = businessServiceService.findBusinessServices();  
        List<AppService> listaAppService = appServiceService.findAllAppService();
      
        model.addAttribute("listaBService", listaBService);
        model.addAttribute("listaAppService", listaAppService);

        return "businessdesign/home.html";

    }
}