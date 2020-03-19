package it.istat.is2.design.controller.rest;



import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import it.istat.is2.app.service.NotificationService;
import it.istat.is2.workflow.domain.BusinessProcess;
import it.istat.is2.workflow.domain.ProcessStep;
import it.istat.is2.workflow.service.BusinessProcessService;
import it.istat.is2.workflow.service.ProcessStepService;


@RestController
public class DesignControllerRest {

		 @Autowired
		 private BusinessProcessService businessProcessService;
		 @Autowired
		 private ProcessStepService processStepService;
		 @Autowired
		 private NotificationService notificationService;
		 @Autowired
		private MessageSource messages;
		 
		 
		@GetMapping("/rest/design/getProcess/{id}")
		@ResponseBody    
//		@RequestMapping(value = "/rest/design/getProcess/{id}", method = RequestMethod.GET)
	    public  ResponseEntity<?>  getProcess(HttpServletRequest request, @PathVariable("id") Integer id) {
	    	notificationService.removeAllMessages();
	    	BusinessProcess processo = null;
	    	try {
	    		processo = businessProcessService.findBProcessById(id);
        		
			} catch (Exception e) {
				// TODO: handle exception
				notificationService.addErrorMessage(messages.getMessage("design.update.error", null, LocaleContextHolder.getLocale()) +": " + e.getMessage());
				
				
			}
	    	return ResponseEntity.ok(processo);
	    }
	    
	    @RequestMapping(value = "/rest/design/getStep/{id}", method = RequestMethod.GET)
	    public ProcessStep getColumns(HttpServletRequest request, @PathVariable("id") Long id) {
	    	notificationService.removeAllMessages();
	    	ProcessStep step = null;
	    	try {
	    		step = processStepService.findProcessStepById(id);
        		
			} catch (Exception e) {
				// TODO: handle exception
				notificationService.addErrorMessage(messages.getMessage("design.update.error", null, LocaleContextHolder.getLocale()) +": " + e.getMessage());
				
				
			}
	    	return step;
	    }

	
}
