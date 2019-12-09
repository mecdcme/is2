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


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.TreeNode;
import it.istat.is2.workflow.dao.BusinessProcessDao;
import it.istat.is2.workflow.domain.BusinessFunction;
import it.istat.is2.workflow.domain.BusinessProcess;
import it.istat.is2.workflow.domain.ProcessStep;
import it.istat.is2.workflow.service.BusinessFunctionService;
import it.istat.is2.workflow.service.ProcessStepService;
import it.istat.is2.workflow.service.BusinessProcessService;



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
        //List<BusinessProcess> listaBp = businessProcessService.findBProcessByIdFunction(new Long(1));
        List<BusinessProcess> listaBp = businessProcessService.findAll();
        
        List<ProcessStep> listaBs = processStepService.findAll();
       
        
        List<BusinessProcess> listaAllBp = businessProcessService.findAllProcesses();
        List<BusinessProcess> listaAllSubBp = businessProcessService.findAllSubProcesses();
        
        
        List<TreeNode> albero = new ArrayList<TreeNode>();
        BusinessProcessDao temp = null;
       
       
        listaFunzioni.forEach((n) -> {albero.add(new TreeNode<String>(n.getName())); n.getBusinessProcesses().forEach((m) ->{ if(m.getBusinessProcessParent()==null){albero.get(albero.size()- 1).addChild(m.getName()); listaBp.forEach((s) -> 
        {if(s.getBusinessProcessParent()!=null && s.getBusinessProcessParent().getId()== m.getId()){TreeNode tempNode = ((TreeNode) albero.get(albero.size()- 1).getChildren().get(albero.get(albero.size()- 1).getChildren().size() - 1)).addChild(s.getName());  
        listaBs.forEach((p)->{p.getBusinessProcesses().forEach((k)->{if(k.getId().equals(s.getId())){tempNode.addChild(p.getDescr()); }; }); });   };  });}}); });
        
       
//        listaFunzioni.forEach((n) -> {albero.add(new TreeNode<String>(n.getNome())); n.getBusinessProcesses().forEach((m) ->{ if(m.getSxBProcessParent()==null){albero.get(albero.size()- 1).addChild(m.getNome()); listaBp.forEach((s) -> 
//        {if(s.getSxBProcessParent()!=null && s.getSxBProcessParent().getId()== m.getId()){TreeNode tempNode = ((TreeNode) albero.get(albero.size()- 1).getChildren().get(albero.get(albero.size()- 1).getChildren().size() - 1)).addChild(s.getNome());  
//        listaBs.forEach((p)->{p.getBusinessProcesses().forEach((k)->{if(k.getId().equals(s.getId())){tempNode.addChild(p.getNome()); }; }); });   };  });}}); });
//        
        
        model.addAttribute("albero", albero);
        

        
        
        
        
        model.addAttribute("listaBp", listaBp);
        model.addAttribute("listaAllBp", listaAllBp);
        model.addAttribute("listaAllSubBp", listaAllSubBp);
        model.addAttribute("listaFunzioni", listaFunzioni);
        model.addAttribute("listaBusinessStep", listaBs);
         
       
  
        return "design/process_design.html";

    }
	

}
