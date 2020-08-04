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
package it.istat.is2.design.controller;

import java.util.ArrayList;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.TreeNode;
import it.istat.is2.workflow.domain.BusinessFunction;
import it.istat.is2.workflow.domain.BusinessProcess;
import it.istat.is2.workflow.domain.BusinessService;
import it.istat.is2.workflow.domain.ProcessStep;
import it.istat.is2.workflow.service.BusinessFunctionService;
import it.istat.is2.workflow.service.ProcessStepService;

import it.istat.is2.workflow.service.BusinessProcessService;
import it.istat.is2.workflow.service.BusinessServiceService;

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
    @Autowired
    private BusinessServiceService businessService;
    @Autowired
    private MessageSource messages;

    @GetMapping(value = "/settings")
    public String viewSettings(Model model, @ModelAttribute("selectedTab") String selectedTab) {

        List<BusinessFunction> listaFunzioni = businessFunctionService.findBFunctions();
        List<BusinessProcess> listaBp = businessProcessService.findAll();
        List<ProcessStep> listaBs = processStepService.findAll();
        List<BusinessProcess> listaAllBp = businessProcessService.findAllProcesses();
        List<BusinessProcess> listaAllSubBp = businessProcessService.findAllSubProcesses();
        List<BusinessService> listaAllBusinessServices = businessService.findBusinessServices();

        List<TreeNode> albero = new ArrayList<>();

        listaFunzioni.forEach((n) -> {
            albero.add(new TreeNode<>(n.getName()));
            n.getBusinessProcesses().forEach((m) -> {
                if (m.getBusinessProcessParent() == null) {
                    albero.get(albero.size() - 1).addChild(m.getName());
                    listaBp.forEach((s) -> {
                        if (s.getBusinessProcessParent() != null
                                && s.getBusinessProcessParent().getId().equals(m.getId())) {
                            TreeNode<String> tempNode = ((TreeNode<String>) albero.get(albero.size() - 1).getChildren()
                                    .get(albero.get(albero.size() - 1).getChildren().size() - 1)).addChild(s.getName());
                            listaBs.forEach((p) -> {
                                p.getBusinessProcesses().forEach((k) -> {
                                    if (k.getId().equals(s.getId())) {
                                        tempNode.addChild(p.getName());
                                    }
                                });
                            });
                        }
                    });
                }
            });
        });
        model.addAttribute("selectedTab", selectedTab);
        model.addAttribute("albero", albero);
        model.addAttribute("listaBp", listaBp);
        model.addAttribute("listaAllBp", listaAllBp);
        model.addAttribute("listaAllSubBp", listaAllSubBp);
        model.addAttribute("listaFunzioni", listaFunzioni);
        model.addAttribute("listaBusinessStep", listaBs);
        model.addAttribute("listaAllBusinessService", listaAllBusinessServices);

        return "design/home.html";

    }

    @GetMapping(value = "/drivensettings")
    public String viewdrivenSettings(Model model, @ModelAttribute("selectedTab") String selectedTab) {
        List<BusinessProcess> listaAllBp = businessProcessService.findAllProcesses();
        List<BusinessProcess> listaAllSubBp = businessProcessService.findAllSubProcesses();
        List<BusinessFunction> listaFunzioni = businessFunctionService.findBFunctions();
        List<ProcessStep> listaBs = processStepService.findAll();
        List<BusinessService> listaAllBusinessServices = businessService.findBusinessServices();
        List<BusinessProcess> listaBp = businessProcessService.findAll();

        List<TreeNode> albero = new ArrayList<>();

        listaFunzioni.forEach((n) -> {
            albero.add(new TreeNode<>(n.getName()));
            n.getBusinessProcesses().forEach((m) -> {
                if (m.getBusinessProcessParent() == null) {
                    albero.get(albero.size() - 1).addChild(m.getName());
                    listaBp.forEach((s) -> {
                        if (s.getBusinessProcessParent() != null
                                && s.getBusinessProcessParent().getId().equals(m.getId())) {
                            TreeNode<String> tempNode = ((TreeNode<String>) albero.get(albero.size() - 1).getChildren()
                                    .get(albero.get(albero.size() - 1).getChildren().size() - 1)).addChild(s.getName());
                            listaBs.forEach((p) -> {
                                p.getBusinessProcesses().forEach((k) -> {
                                    if (k.getId().equals(s.getId())) {
                                        tempNode.addChild(p.getName());
                                    }
                                });
                            });
                        }
                    });
                }
            });
        });
        model.addAttribute("albero", albero);
        model.addAttribute("listaAllBp", listaAllBp);
        model.addAttribute("listaAllSubBp", listaAllSubBp);
        model.addAttribute("listaFunzioni", listaFunzioni);
        model.addAttribute("listaBusinessStep", listaBs);
        model.addAttribute("listaAllBusinessService", listaAllBusinessServices);

        return "design/wizard.html";

    }

    @PostMapping(value = "/playaction")
    public String action(Model model, @RequestParam("fieldId") Long fieldId, RedirectAttributes ra,
                         @RequestParam("fieldName") String fieldName, @RequestParam("fieldDescription") String fieldDescr,
                         @RequestParam("fieldLabel") String fieldLabel,
                         @RequestParam("fieldBusinessProcessId") String fieldBusinessProcessId,
                         @RequestParam("selectedTab") String selectedTab,
                         @RequestParam("fieldFatherId") String fieldFatherId, @RequestParam("fieldAction") String fieldAction) {

        notificationService.removeAllMessages();
        switch (fieldAction) {

            case "uf":
                try {
                    BusinessFunction funzione = businessFunctionService.findBFunctionById(fieldId);
                    funzione.setName(fieldName);
                    funzione.setDescr(fieldDescr);
                    funzione.setLabel(fieldLabel);
                    businessFunctionService.updateBFunction(funzione);
                    notificationService.addInfoMessage(
                            messages.getMessage("design.update.success", null, LocaleContextHolder.getLocale()));
                } catch (Exception e) {

                    notificationService.addErrorMessage(
                            messages.getMessage("design.update.error", null, LocaleContextHolder.getLocale()) + ": "
                                    + e.getMessage());

                }

                break;
            case "up":
                try {
                    BusinessProcess process = businessProcessService.findBProcessById(fieldId);
                    process.setName(fieldName);
                    process.setDescr(fieldDescr);
                    process.setLabel(fieldLabel);
                    businessProcessService.updateBProcess(process);
                    notificationService.addInfoMessage(
                            messages.getMessage("design.update.success", null, LocaleContextHolder.getLocale()));
                } catch (Exception e) {

                    notificationService.addErrorMessage(
                            messages.getMessage("design.update.error", null, LocaleContextHolder.getLocale()) + ": "
                                    + e.getMessage());

                }

                break;
            case "usp":
                try {
                    BusinessProcess process = businessProcessService.findBProcessById(fieldId);
                    BusinessProcess fatherProcess = businessProcessService
                            .findBProcessById(Integer.parseInt(fieldFatherId));
                    process.setName(fieldName);
                    process.setDescr(fieldDescr);
                    process.setLabel(fieldLabel);
                    process.setBusinessProcessParent(fatherProcess);
                    businessProcessService.updateBProcess(process);
                    notificationService.addInfoMessage(
                            messages.getMessage("design.update.success", null, LocaleContextHolder.getLocale()));
                } catch (Exception e) {

                    notificationService.addErrorMessage(
                            messages.getMessage("design.update.error", null, LocaleContextHolder.getLocale()) + ": "
                                    + e.getMessage());

                }

                break;
            case "us":
                try {

                    ProcessStep step = processStepService.findProcessStepById(fieldId);
                    BusinessService newBusinessService = businessService
                            .findBusinessServiceById(Long.parseLong(fieldBusinessProcessId));
                    step.setName(fieldName);
                    step.setDescr(fieldDescr);
                    step.setLabel(fieldLabel);
                    step.setBusinessService(newBusinessService);
                    processStepService.save(step);
                    notificationService.addInfoMessage(
                            messages.getMessage("design.update.success", null, LocaleContextHolder.getLocale()));
                } catch (Exception e) {

                    notificationService.addErrorMessage(
                            messages.getMessage("design.update.error", null, LocaleContextHolder.getLocale()),
                            e.getMessage());

                }

                break;
            case "df":
                try {
                    BusinessFunction funzione = businessFunctionService.findBFunctionById(fieldId);
                    businessFunctionService.deleteBFunction(funzione);

                    notificationService.addInfoMessage(
                            messages.getMessage("design.delete.success", null, LocaleContextHolder.getLocale()));
                } catch (Exception e) {

                    notificationService.addErrorMessage(
                            messages.getMessage("design.delete.error", null, LocaleContextHolder.getLocale()) + ": "
                                    + e.getMessage());

                }

                break;
            case "dp":
                try {
                    BusinessProcess process = businessProcessService.findBProcessById(fieldId);
                    businessProcessService.deleteBProcess(process);

                    notificationService.addInfoMessage(
                            messages.getMessage("design.delete.success", null, LocaleContextHolder.getLocale()));
                } catch (Exception e) {

                    notificationService.addErrorMessage(
                            messages.getMessage("design.delete.error", null, LocaleContextHolder.getLocale()) + ": "
                                    + e.getMessage());

                }

                break;
            case "dsp":
                try {
                    BusinessProcess process = businessProcessService.findBProcessById(fieldId);
                    businessProcessService.deleteBProcess(process);

                    notificationService.addInfoMessage(
                            messages.getMessage("design.delete.success", null, LocaleContextHolder.getLocale()));
                } catch (Exception e) {

                    notificationService.addErrorMessage(
                            messages.getMessage("design.delete.error", null, LocaleContextHolder.getLocale()) + ": "
                                    + e.getMessage());

                }

                break;
            case "ds":
                try {
                    ProcessStep step = processStepService.findProcessStepById(fieldId);
                    processStepService.deleteStepService(step);

                    notificationService.addInfoMessage(
                            messages.getMessage("design.delete.success", null, LocaleContextHolder.getLocale()));
                } catch (Exception e) {

                    notificationService.addErrorMessage(
                            messages.getMessage("design.delete.error", null, LocaleContextHolder.getLocale()) + ": "
                                    + e.getMessage());

                }

                break;
            case "nf":
                try {
                    BusinessFunction funzione = new BusinessFunction();
                    funzione.setName(fieldName);
                    funzione.setDescr(fieldDescr);
                    funzione.setLabel(fieldLabel);
                    businessFunctionService.updateBFunction(funzione);

                    notificationService.addInfoMessage(
                            messages.getMessage("design.create.success", null, LocaleContextHolder.getLocale()));
                } catch (Exception e) {

                    notificationService.addErrorMessage(
                            messages.getMessage("design.create.error", null, LocaleContextHolder.getLocale()) + ": "
                                    + e.getMessage());

                }
                break;
            case "np":
                try {
                    BusinessProcess process = new BusinessProcess();
                    process.setName(fieldName);
                    process.setDescr(fieldDescr);
                    process.setLabel(fieldLabel);
                    businessProcessService.updateBProcess(process);
                    notificationService.addInfoMessage(
                            messages.getMessage("design.create.success", null, LocaleContextHolder.getLocale()));
                } catch (Exception e) {

                    notificationService.addErrorMessage(
                            messages.getMessage("design.create.error", null, LocaleContextHolder.getLocale()) + ": "
                                    + e.getMessage());

                }

                break;
            case "nsp":
                try {
                    BusinessProcess process = new BusinessProcess();
                    BusinessProcess fatherProcess = businessProcessService
                            .findBProcessById(Integer.parseInt(fieldFatherId));
                    process.setName(fieldName);
                    process.setDescr(fieldDescr);
                    process.setLabel(fieldLabel);
                    process.setBusinessProcessParent(fatherProcess);
                    businessProcessService.updateBProcess(process);
                    notificationService.addInfoMessage(
                            messages.getMessage("design.create.success", null, LocaleContextHolder.getLocale()));
                } catch (Exception e) {

                    notificationService.addErrorMessage(
                            messages.getMessage("design.create.error", null, LocaleContextHolder.getLocale()) + ": "
                                    + e.getMessage());

                }

                break;
            case "ns":
                try {
                    ProcessStep step = new ProcessStep();
                    BusinessService newBusinessService = businessService
                            .findBusinessServiceById(Long.parseLong(fieldBusinessProcessId));
                    step.setName(fieldName);
                    step.setDescr(fieldDescr);
                    step.setLabel(fieldLabel);
                    step.setBusinessService(newBusinessService);
                    processStepService.save(step);
                    notificationService.addInfoMessage(
                            messages.getMessage("design.create.success", null, LocaleContextHolder.getLocale()));
                } catch (Exception e) {

                    notificationService.addErrorMessage(
                            messages.getMessage("design.create.error", null, LocaleContextHolder.getLocale()) + ": "
                                    + e.getMessage());

                }

                break;

            default:

                break;
        }
        ra.addFlashAttribute("selectedTab", selectedTab);
        return "redirect:/settings";

    }

//    @RequestParam Map<String,String> allParams 

    @PostMapping(value = "/bindingFunctions")
    public String bindingFunctions(Model model, @RequestParam("fieldId") Long fieldId, RedirectAttributes ra,
                                   @RequestParam("fieldName") String fieldName, @RequestParam("fieldDescription") String fieldDescr,
                                   @RequestParam("selectedTab") String selectedTab,
                                   @RequestParam(value = "duallistbox_demo[]", required = false) String duallistbox_demo[]) {


        notificationService.removeAllMessages();


        try {
            int i;
            int j;
            List<BusinessFunction> allFunctions = businessFunctionService.findBFunctions();
            List<BusinessFunction> elencoFunzioni = new ArrayList<>();
            BusinessProcess process = businessProcessService.findBProcessById(fieldId);
            if (duallistbox_demo != null && duallistbox_demo.length != 0) {


                for (i = 0; i < allFunctions.size(); i++) {

                    for (j = 0; j < duallistbox_demo.length; j++) {

                        if (allFunctions.get(i).getBusinessProcesses().contains(process)) {

                            BusinessFunction temp = businessFunctionService
                                    .findBFunctionById(allFunctions.get(i).getId());

                            temp.getBusinessProcesses().remove(process);
                            businessFunctionService.updateBFunction(temp);
                            process.getBusinessFunctions().remove(temp);
                            businessProcessService.updateBProcess(process);

                        }

                    }
                }
                for (i = 0; i < duallistbox_demo.length; i++) {

                    BusinessFunction temp = businessFunctionService.findBFunctionById(Long.parseLong(duallistbox_demo[i]));
                    if (!temp.getBusinessProcesses().contains(process)) {
                        temp.getBusinessProcesses().add(process);
                    }

                    businessFunctionService.updateBFunction(temp);
                    elencoFunzioni.add(temp);

                }


                process.getBusinessFunctions().clear();
                process.setBusinessFunctions(elencoFunzioni);
                businessProcessService.updateBProcess(process);

            } else {

                for (i = 0; i < allFunctions.size(); i++) {


                    if (allFunctions.get(i).getBusinessProcesses().contains(process)) {

                        BusinessFunction temp = businessFunctionService
                                .findBFunctionById(allFunctions.get(i).getId());

                        temp.getBusinessProcesses().remove(process);
                        businessFunctionService.updateBFunction(temp);
                        process.getBusinessFunctions().remove(temp);
                        businessProcessService.updateBProcess(process);

                    }


                }

            }
            notificationService.addInfoMessage(
                    messages.getMessage("design.binding.success", null, LocaleContextHolder.getLocale()));
        } catch (Exception e) {
            // TODO: handle exception
            notificationService.addErrorMessage(
                    messages.getMessage("design.binding.error", null, LocaleContextHolder.getLocale()), e.getMessage());

        }
        ra.addFlashAttribute("selectedTab", selectedTab);
        return "redirect:/settings";

    }

    @PostMapping(value = "/bindingProcesses")
    public String bindingProcesses(Model model, @RequestParam("fieldId") Long fieldId, RedirectAttributes ra,
                                   @RequestParam("fieldName") String fieldName, @RequestParam("fieldDescription") String fieldDescr,
                                   @RequestParam("selectedTab") String selectedTab,
                                   @RequestParam(value = "duallistbox_demo1[]", required = false) String duallistbox_demo1[]) {

        notificationService.removeAllMessages();
        try {
            int i;
            int j;

            List<BusinessProcess> allSubProcesses = businessProcessService.findAllSubProcesses();
            List<BusinessProcess> listSubProcesses = new ArrayList<>();
            ProcessStep step = processStepService.findProcessStepById(fieldId);
            if (duallistbox_demo1 != null && duallistbox_demo1.length != 0) {
                for (i = 0; i < allSubProcesses.size(); i++) {

                    for (j = 0; j < duallistbox_demo1.length; j++) {

                        if (allSubProcesses.get(i).getBusinessSteps().contains(step)) {

                            BusinessProcess temp = businessProcessService.findBProcessById(allSubProcesses.get(i).getId());

                            temp.getBusinessSteps().remove(step);
                            businessProcessService.updateBProcess(temp);
                            step.getBusinessProcesses().remove(temp);
                            processStepService.save(step);

                        }

                    }
                }
                for (i = 0; i < duallistbox_demo1.length; i++) {

                    BusinessProcess temp = businessProcessService.findBProcessById(Long.parseLong(duallistbox_demo1[i]));
                    if (!temp.getBusinessSteps().contains(step)) {
                        temp.getBusinessSteps().add(step);
                    }

                    businessProcessService.updateBProcess(temp);
                    listSubProcesses.add(temp);

                }

                step.getBusinessProcesses().clear();
                step.setBusinessProcesses(listSubProcesses);
                processStepService.save(step);
            } else {
                for (i = 0; i < allSubProcesses.size(); i++) {


                    if (allSubProcesses.get(i).getBusinessSteps().contains(step)) {

                        BusinessProcess temp = businessProcessService.findBProcessById(allSubProcesses.get(i).getId());

                        temp.getBusinessSteps().remove(step);
                        businessProcessService.updateBProcess(temp);
                        step.getBusinessProcesses().remove(temp);
                        processStepService.save(step);

                    }


                }
            }


            notificationService.addInfoMessage(
                    messages.getMessage("design.binding.success", null, LocaleContextHolder.getLocale()));
        } catch (Exception e) {
            notificationService.addErrorMessage(
                    messages.getMessage("design.binding.error", null, LocaleContextHolder.getLocale()), e.getMessage());

        }
        ra.addFlashAttribute("selectedTab", selectedTab);
        return "redirect:/settings";

    }

}
