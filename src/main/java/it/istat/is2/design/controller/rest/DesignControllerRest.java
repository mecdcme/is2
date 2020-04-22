package it.istat.is2.design.controller.rest;



import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import it.istat.is2.app.bean.WizardData;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.workflow.domain.BusinessFunction;
import it.istat.is2.workflow.domain.BusinessProcess;
import it.istat.is2.workflow.domain.ProcessStep;
import it.istat.is2.workflow.service.BusinessFunctionService;
import it.istat.is2.workflow.service.BusinessProcessService;
import it.istat.is2.workflow.service.ProcessStepService;


@RestController
public class DesignControllerRest {

		 
	 	@Autowired
	 	private BusinessFunctionService businessFunctionService;
		@Autowired
		 private BusinessProcessService businessProcessService;
		 @Autowired
		 private ProcessStepService processStepService;
		 @Autowired
		 private NotificationService notificationService;
		 @Autowired
		private MessageSource messages;
		 
		@PostMapping(value = "/rest/design/savewizard")
	 	    public  ProcessStep saveWizard(HttpServletRequest request, @RequestParam("wizardData")  WizardData wizardData) {
		    	notificationService.removeAllMessages();
		    	//ProcessStep step = null;
		    	ProcessStep step = new ProcessStep();
		    	step.setId(Long.parseLong("10"));
		    	
		    	step.setName("pippo");
		    	step.setDescr("pluto");
		    	
		    	try {
		    		messages.getMessage("design.update.success", null, LocaleContextHolder.getLocale());
		    		
					
				} catch (Exception e) {
					// TODO: handle exception
					notificationService.addErrorMessage(messages.getMessage("design.error", null, LocaleContextHolder.getLocale()) +": " + e.getMessage());
					
					
				}
		    	return step;
		    }
		 
		 
		@GetMapping(value = "/rest/design/getProcess/{id}")
 	    public  ResponseEntity<BusinessProcess>  getProcess(HttpServletRequest request, @PathVariable("id") Integer id) {
	    	notificationService.removeAllMessages();
	    	BusinessProcess processo = null;
	    	try {
	    		processo = businessProcessService.findBProcessById(id);
        		
			} catch (Exception e) {
				// TODO: handle exception
				notificationService.addErrorMessage(messages.getMessage("design.error", null, LocaleContextHolder.getLocale()) +": " + e.getMessage());
				
				
			}
	    	return ResponseEntity.ok(processo);
	    }
		
		@GetMapping(value = "/rest/design/getFunction/{id}")
 	    public  ResponseEntity<BusinessFunction>  getFunction(HttpServletRequest request, @PathVariable("id") Integer id) {
	    	notificationService.removeAllMessages();
	    	BusinessFunction function = null;
	    	try {
	    		function = businessFunctionService.findBFunctionById(id);
        		
			} catch (Exception e) {
				// TODO: handle exception
				notificationService.addErrorMessage(messages.getMessage("design.error", null, LocaleContextHolder.getLocale()) +": " + e.getMessage());
				
				
			}
	    	return ResponseEntity.ok(function);
	    }
	    
	   
	    
	    
		@GetMapping(value = "/rest/design/getStep/{id}")
	    public ProcessStep getStep(HttpServletRequest request, @PathVariable("id") Long id) {
	    	notificationService.removeAllMessages();
	    	ProcessStep step = null;
	    	try {
	    		step = processStepService.findProcessStepById(id);
        		
			} catch (Exception e) {
				// TODO: handle exception
				notificationService.addErrorMessage(messages.getMessage("design.error", null, LocaleContextHolder.getLocale()) +": " + e.getMessage());
				
				
			}
	    	return step;
	    }
		@GetMapping(value = "/rest/design/getProcessByName/{name}")
	    public BusinessProcess getSubprocessByName(HttpServletRequest request, @PathVariable("name") String name) {
	    	notificationService.removeAllMessages();
	    	BusinessProcess proc = null;
	    	try {
	    		proc = businessProcessService.findBProcessByName(name);
        		
			} catch (Exception e) {
				// TODO: handle exception
				notificationService.addErrorMessage(messages.getMessage("design.error", null, LocaleContextHolder.getLocale()) +": " + e.getMessage());
				
				
			}
	    	return proc;
	    }
		
		
		@GetMapping(value = "/rest/design/getFunctionByName/{name}")
 	    public  BusinessFunction  getFunctionByName(HttpServletRequest request, @PathVariable("name") String name) {
	    	notificationService.removeAllMessages();
	    	BusinessFunction function = null;
	    	try {
	    		function = businessFunctionService.findBFunctionByName(name);
        		
			} catch (Exception e) {
				// TODO: handle exception
				notificationService.addErrorMessage(messages.getMessage("design.error", null, LocaleContextHolder.getLocale()) +": " + e.getMessage());
				
				
			}
	    	return function;
	    }
	
}
