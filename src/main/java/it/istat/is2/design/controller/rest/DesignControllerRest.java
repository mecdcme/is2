package it.istat.is2.design.controller.rest;


import java.util.ArrayList;
import java.util.List;

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
import it.istat.is2.workflow.domain.BusinessService;
import it.istat.is2.workflow.domain.ProcessStep;
import it.istat.is2.workflow.service.BusinessFunctionService;
import it.istat.is2.workflow.service.BusinessProcessService;
import it.istat.is2.workflow.service.BusinessServiceService;
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
    @Autowired
    private BusinessServiceService businessService;

    @PostMapping(value = "/rest/design/savewizard/{idf}/{namef}/{descriptionf}/{labelf}/{idp}/{namep}/{descriptionp}/{labelp}/{ids}/{names}/{descriptions}/{labels}/{idst}/{namest}/{descriptionst}/{labelst}/{businessServiceId}")
    public ProcessStep saveWizard(HttpServletRequest request,
                                  @PathVariable("idf") String idf,
                                  @PathVariable("namef") String namef,
                                  @PathVariable("descriptionf") String descriptionf,
                                  @PathVariable("labelf") String labelf,
                                  @PathVariable("idp") String idp,
                                  @PathVariable("namep") String namep,
                                  @PathVariable("descriptionp") String descriptionp,
                                  @PathVariable("labelp") String labelp,
                                  @PathVariable("ids") String ids,
                                  @PathVariable("names") String names,
                                  @PathVariable("descriptions") String descriptions,
                                  @PathVariable("labels") String labels,
                                  @PathVariable("idst") String idst,
                                  @PathVariable("namest") String namest,
                                  @PathVariable("descriptionst") String descriptionst,
                                  @PathVariable("labelst") String labelst,
                                  @PathVariable("businessServiceId") String businessServiceId

    ) {


        notificationService.removeAllMessages();
        Integer i;
        ProcessStep step = new ProcessStep();
        BusinessProcess process = new BusinessProcess();
        BusinessProcess subprocess = new BusinessProcess();
        BusinessFunction function = new BusinessFunction();
        try {


            if (idp.equals("0")) {
                process.setName(namep);
                process.setDescr(descriptionp);
                process.setLabel(labelp);
                process = businessProcessService.updateBProcess(process);
            } else {
                process = businessProcessService.findBProcessById(Long.parseLong(idp));
            }

            if (ids.equals("0")) {
                subprocess.setName(names);
                subprocess.setDescr(descriptions);
                subprocess.setLabel(labels);
                subprocess.setBusinessProcessParent(process);
                subprocess = businessProcessService.updateBProcess(subprocess);
            } else {
                subprocess = businessProcessService.findBProcessById(Long.parseLong(ids));
                subprocess.setBusinessProcessParent(process);
                subprocess = businessProcessService.updateBProcess(subprocess);
            }

            if (idf.equals("0")) {
                function.setName(namef);
                function.setDescr(descriptionf);
                function.setLabel(labelf);
                function = businessFunctionService.updateBFunction(function);
            } else {
                function = businessFunctionService.findBFunctionById(Long.parseLong(idf));
            }

            if (idst.equals("0")) {
                BusinessService newBusinessService = businessService
                        .findBusinessServiceById(Long.parseLong(businessServiceId));
                step.setName(namest);
                step.setDescr(descriptionst);
                step.setLabel(labelst);
                step.setBusinessService(newBusinessService);
                step = processStepService.save(step);
            } else {
                step = processStepService.findProcessStepById(Long.parseLong(idst));
            }

            List<BusinessFunction> listFunction = new ArrayList<>();
            List<BusinessProcess> listProcess = new ArrayList<>();
            List<BusinessProcess> listSubProcess = new ArrayList<>();
            List<ProcessStep> listStep = new ArrayList<>();


            try {
                function.getBusinessProcesses().forEach(item -> listProcess.add(item));
            } catch (Exception e) {

            }

            if (!listProcess.contains(process)) {
                listProcess.add(process);
            }
            ;
            function.setBusinessProcesses(listProcess);
            businessFunctionService.updateBFunction(function);

            try {
                process.getBusinessFunctions().forEach(item -> listFunction.add(item));
            } catch (Exception e) {

            }

            if (!listFunction.contains(function)) {
                listFunction.add(function);
            }
            ;
            process.setBusinessFunctions(listFunction);
            businessProcessService.updateBProcess(process);


            try {
                subprocess.getBusinessSteps().forEach(item -> listStep.add(item));
            } catch (Exception e) {

            }


            if (!listStep.contains(step)) {
                listStep.add(step);
            }
            ;
            subprocess.setBusinessSteps(listStep);
            businessProcessService.updateBProcess(subprocess);

            try {
                step.getBusinessProcesses().forEach(item -> listSubProcess.add(item));
            } catch (Exception e) {

            }

            if (!listSubProcess.contains(subprocess)) {
                listSubProcess.add(subprocess);
            }
            ;

            step.setBusinessProcesses(listSubProcess);
            processStepService.save(step);

            messages.getMessage("design.wizard.success", null, LocaleContextHolder.getLocale());


        } catch (Exception e) {
            // TODO: handle exception
            notificationService.addErrorMessage(messages.getMessage("design.wizard.error", null, LocaleContextHolder.getLocale()) + ": " + e.getMessage());


        }
        return step;
    }


    @GetMapping(value = "/rest/design/getProcess/{id}")
    public ResponseEntity<BusinessProcess> getProcess(HttpServletRequest request, @PathVariable("id") Integer id) {
        notificationService.removeAllMessages();
        BusinessProcess processo = null;
        try {
            processo = businessProcessService.findBProcessById(id);

        } catch (Exception e) {
            // TODO: handle exception
            notificationService.addErrorMessage(messages.getMessage("design.error", null, LocaleContextHolder.getLocale()) + ": " + e.getMessage());


        }
        return ResponseEntity.ok(processo);
    }

    @GetMapping(value = "/rest/design/getFunction/{id}")
    public ResponseEntity<BusinessFunction> getFunction(HttpServletRequest request, @PathVariable("id") Integer id) {
        notificationService.removeAllMessages();
        BusinessFunction function = null;
        try {
            function = businessFunctionService.findBFunctionById(id);

        } catch (Exception e) {
            // TODO: handle exception
            notificationService.addErrorMessage(messages.getMessage("design.error", null, LocaleContextHolder.getLocale()) + ": " + e.getMessage());


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
            notificationService.addErrorMessage(messages.getMessage("design.error", null, LocaleContextHolder.getLocale()) + ": " + e.getMessage());


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
            notificationService.addErrorMessage(messages.getMessage("design.error", null, LocaleContextHolder.getLocale()) + ": " + e.getMessage());


        }
        return proc;
    }


    @GetMapping(value = "/rest/design/getFunctionByName/{name}")
    public BusinessFunction getFunctionByName(HttpServletRequest request, @PathVariable("name") String name) {
        notificationService.removeAllMessages();
        BusinessFunction function = null;
        try {
            function = businessFunctionService.findBFunctionByName(name);

        } catch (Exception e) {
            // TODO: handle exception
            notificationService.addErrorMessage(messages.getMessage("design.error", null, LocaleContextHolder.getLocale()) + ": " + e.getMessage());


        }
        return function;
    }

}
