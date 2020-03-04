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
package it.istat.is2.design.controller;

import java.util.ArrayList;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.TreeNode;
import it.istat.is2.workflow.domain.BusinessFunction;
import it.istat.is2.workflow.domain.BusinessProcess;
import it.istat.is2.workflow.domain.BusinessService;
import it.istat.is2.workflow.domain.ProcessStep;
import it.istat.is2.workflow.service.BusinessFunctionService;
import it.istat.is2.workflow.service.ProcessStepService;
import it.istat.is2.workflow.service.BusinessProcessService;
import it.istat.is2.workflow.service.BusinessStepService;

@Controller
public class DesignController {

    @Autowired
    private NotificationService notificationService;
    @Autowired
    private BusinessFunctionService businessFunctionService;
    @Autowired
    private BusinessProcessService businessProcessService;
    @Autowired
    private ProcessStepService processStepService;
   

    @RequestMapping("/settings")
    public String viewSettings(Model model) {
        notificationService.removeAllMessages();

        List<BusinessFunction> listaFunzioni = businessFunctionService.findBFunctions();
        List<BusinessProcess> listaBp = businessProcessService.findAll();
        List<ProcessStep> listaBs = processStepService.findAll();
        List<BusinessProcess> listaAllBp = businessProcessService.findAllProcesses();
        List<BusinessProcess> listaAllSubBp = businessProcessService.findAllSubProcesses();

        List<TreeNode> albero = new ArrayList<>();

        listaFunzioni.forEach((n) -> {
            albero.add(new TreeNode<>(n.getName()));
            n.getBusinessProcesses().forEach((m) -> {
                if (m.getBusinessProcessParent() == null) {
                    albero.get(albero.size() - 1).addChild(m.getName());
                    listaBp.forEach((s) -> {
                        if (s.getBusinessProcessParent() != null && s.getBusinessProcessParent().getId() == m.getId()) {
                            TreeNode tempNode = ((TreeNode) albero.get(albero.size() - 1).getChildren().get(albero.get(albero.size() - 1).getChildren().size() - 1)).addChild(s.getName());
                            listaBs.forEach((p) -> {
                                p.getBusinessProcesses().forEach((k) -> {
                                    if (k.getId().equals(s.getId())) {
                                        tempNode.addChild(p.getName());
                                    };
                                });
                            });
                        };
                    });
                }
            });
        });
      
        model.addAttribute("albero", albero);
        model.addAttribute("listaBp", listaBp);
        model.addAttribute("listaAllBp", listaAllBp);
        model.addAttribute("listaAllSubBp", listaAllSubBp);
        model.addAttribute("listaFunzioni", listaFunzioni);
        model.addAttribute("listaBusinessStep", listaBs);

        return "design/home.html";

    }
   
    @RequestMapping(value = "/playaction", method = RequestMethod.POST)
    public String action(Model model, @RequestParam("fieldId") Long fieldId, @RequestParam("fieldName") String fieldName, @RequestParam("fieldDescription") String fieldDescr, 
    		@RequestParam("fieldLabel") String fieldLabel, @RequestParam("fieldFatherId") String fieldFatherId, @RequestParam("fieldAction") String fieldAction ) {
        notificationService.removeAllMessages();

        switch (fieldAction) {
    	
    	case "uf":
    		try {
    			BusinessFunction funzione = businessFunctionService.findBFunctionById(fieldId);
        		funzione.setName(fieldName);
        		funzione.setDescr(fieldDescr);
        		funzione.setLabel(fieldLabel);
        		BusinessFunction bf=  businessFunctionService.updateBFunction(funzione);
        		
			} catch (Exception e) {
				// TODO: handle exception
				
			}
    		
    		
    		break;
    	case "up":
    		try {
    			BusinessProcess process = businessProcessService.findBProcessById(fieldId);
        		process.setName(fieldName);
        		process.setDescr(fieldDescr);
        		process.setLabel(fieldLabel);
        		BusinessProcess bp=  businessProcessService.updateBProcess(process);
			} catch (Exception e) {
				// TODO: handle exception
			}
    		
    		break;
    	case "usp":
    		try {
    			BusinessProcess process = businessProcessService.findBProcessById(fieldId);
    			BusinessProcess newprocessParent = businessProcessService.findBProcessById(Long.parseLong(fieldFatherId));
    			process.setName(fieldName);
        		process.setDescr(fieldDescr);
        		process.setLabel(fieldLabel);
        		process.setBusinessProcessParent(newprocessParent);
        		BusinessProcess bp=  businessProcessService.updateBProcess(process);
				
			} catch (Exception e) {
				// TODO: handle exception
			}
    		
    		break;
    	case "us":
    		try {
				
    			ProcessStep step = processStepService.findProcessStep(fieldId);
    			step.setName(fieldName);
        		step.setDescr(fieldDescr);
        		step.setLabel(fieldLabel);
        		ProcessStep ps= processStepService.save(step);
    			
    			
			} catch (Exception e) {
				// TODO: handle exception
			}
    		
    		break;
    	case "df":
    		try {
    			
			} catch (Exception e) {
				// TODO: handle exception
			}
    		
    		break;
    	case "dp":
    		try {
				
			} catch (Exception e) {
				// TODO: handle exception
			}
    		
    		break;
    	case "dsp":
    		try {
				
			} catch (Exception e) {
				// TODO: handle exception
			}
    		
    		break;
    	case "ds":
    		try {
				
			} catch (Exception e) {
				// TODO: handle exception
			}
    		
    		break;
    	case "nf":
    		try {
    			BusinessFunction funzione = new BusinessFunction();
        		funzione.setName(fieldName);
        		funzione.setDescr(fieldDescr);
        		funzione.setLabel(fieldLabel);
        		BusinessFunction bf=  businessFunctionService.updateBFunction(funzione);
				
			} catch (Exception e) {
				// TODO: handle exception
			}
    		
    		break;
    	case "np":
    		try {
    			BusinessProcess process = new BusinessProcess();
        		process.setName(fieldName);
        		process.setDescr(fieldDescr);
        		process.setLabel(fieldLabel);
        		BusinessProcess bp=  businessProcessService.updateBProcess(process);
			} catch (Exception e) {
				// TODO: handle exception
			}
    		
    		break;
    	case "nsp":
    		try {
    			BusinessProcess process = new BusinessProcess();
    			BusinessProcess newprocessParent = businessProcessService.findBProcessById(Long.parseLong(fieldFatherId));
    			process.setName(fieldName);
        		process.setDescr(fieldDescr);
        		process.setLabel(fieldLabel);
        		process.setBusinessProcessParent(newprocessParent);
        		BusinessProcess bp=  businessProcessService.updateBProcess(process);
			} catch (Exception e) {
				// TODO: handle exception
			}
    		
    		break;
    	case "ns":
    		try {
    			ProcessStep step = new ProcessStep();
    			step.setName(fieldName);
        		step.setDescr(fieldDescr);
        		step.setLabel(fieldLabel);
        		ProcessStep ps= processStepService.save(step);
			} catch (Exception e) {
				// TODO: handle exception
			}
    		
    		break;

    	default:
    		try {
				
			} catch (Exception e) {
				// TODO: handle exception
			}
    		break;
    	}

        return "redirect:/settings";

    }
    
    
    
    
}


