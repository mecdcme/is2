package it.istat.is2.business.design.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import it.istat.is2.app.domain.User;
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
    @Autowired
    private MessageSource messages;
   

    @GetMapping("/busservlist")
    public String serviceList(HttpSession session,Model model) {        

        List<BusinessService> listaBService = businessServiceService.findBusinessServices();  
        List<AppService> listaAppService = appServiceService.findAllAppService();
      
        model.addAttribute("listaBService", listaBService);
        model.addAttribute("listaAppService", listaAppService);

        return "businessdesign/home.html";

    }
    @RequestMapping(value = "/newbservice", method = RequestMethod.POST)
    public String createNewBService(HttpSession session, Model model, @AuthenticationPrincipal User user, 
    		@RequestParam("name") String name, @RequestParam("description") String description) {
        notificationService.removeAllMessages();

        BusinessService businessService = new BusinessService();
        businessService.setName(name);
        businessService.setDescr(description);
        // TODO: l'id di GsbpmProcess va gestito
        
        try {
        	businessServiceService.save(businessService);
        	notificationService.addInfoMessage(messages.getMessage("generic.successfull.saved.message", null, LocaleContextHolder.getLocale()));
        }catch(Exception e) {
        	notificationService.addErrorMessage(messages.getMessage("generic.saving.error.messager", null, LocaleContextHolder.getLocale()) +": " + e.getMessage());
        }       

        return "redirect:/busservlist";
    }
    
    @GetMapping(value = "/deletebservice/{idbservice}")
    public String deleteBService(HttpSession session, Model model, RedirectAttributes ra, @AuthenticationPrincipal User user, 
    		@PathVariable("idbservice") Integer idbservice) {
        notificationService.removeAllMessages();
        
        BusinessService businessService = businessServiceService.findBusinessServiceById(idbservice);
        try {
        	businessServiceService.deleteBusinessService(idbservice);
        	notificationService.addInfoMessage(messages.getMessage("bs.removed.success.message", new Object[]{businessService.getName()}, LocaleContextHolder.getLocale()));
        }catch(Exception e) {
        	notificationService.addErrorMessage(messages.getMessage("bs.remove.error.message", null, LocaleContextHolder.getLocale()));
        }        
        return "redirect:/busservlist";
    }
}