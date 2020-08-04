package it.istat.is2.business.design.controller.rest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import it.istat.is2.app.bean.NotificationMessage;
import it.istat.is2.app.forms.UserCreateForm;
import it.istat.is2.business.design.dto.ApplicationServiceDto;
import it.istat.is2.business.design.dto.BusinessServiceDto;
import it.istat.is2.business.design.dto.GsbpmProcessDto;
import it.istat.is2.business.design.form.ServicesDesignForm;
import it.istat.is2.workflow.domain.AppService;
import it.istat.is2.workflow.domain.BusinessService;
import it.istat.is2.workflow.domain.GsbpmProcess;
import it.istat.is2.workflow.domain.StepInstance;
import it.istat.is2.workflow.service.AppServiceService;
import it.istat.is2.workflow.service.BusinessServiceService;
import it.istat.is2.workflow.service.GsbpmProcessService;
import it.istat.is2.workflow.service.StepInstanceService;

@RestController
public class BusinessDesignControllerRest {
    @Autowired
    private GsbpmProcessService gsbpmProcessService;
    @Autowired
    private BusinessServiceService businessServiceService;
    @Autowired
    private AppServiceService appServiceService;
    @Autowired
    private StepInstanceService stepInstanceService;

    @RequestMapping(value = "/loadGsbpmSubProcess/{idprocess}", method = RequestMethod.GET)
    public List<GsbpmProcessDto> loadGsbpmSubProcess(HttpServletRequest request, Model model,
                                                     @PathVariable("idprocess") Long idprocess) throws IOException {

        GsbpmProcess gsbpmProcess = gsbpmProcessService.findById(idprocess);
        List<GsbpmProcess> listaGsbpmSubProcess = gsbpmProcessService.findSubProcessesByGsbpmParentProcess(gsbpmProcess);

        ArrayList<GsbpmProcessDto> processDtoList = new ArrayList<GsbpmProcessDto>();
        GsbpmProcessDto processDto;
        Iterator<GsbpmProcess> iterator = listaGsbpmSubProcess.iterator();
        GsbpmProcess gsbpmp = new GsbpmProcess();
        while (iterator.hasNext()) {
            gsbpmp = iterator.next();
            processDto = new GsbpmProcessDto();
            processDto.setId(Long.toString(gsbpmp.getId()));
            processDto.setName(gsbpmp.getName());
            processDto.setDescr(gsbpmp.getDescr());
            processDtoList.add(processDto);
        }
        return processDtoList;
    }

    @RequestMapping(value = "/loadGsbpmParentProcess", method = RequestMethod.GET)
    public List<GsbpmProcessDto> loadGsbpmParentProcess(HttpServletRequest request, Model model)
            throws IOException {


        List<GsbpmProcess> listaGsbpmParentProcess = gsbpmProcessService.findAllProcesses();
        ArrayList<GsbpmProcessDto> processDtoList = new ArrayList<GsbpmProcessDto>();
        GsbpmProcessDto processDto;
        Iterator<GsbpmProcess> iterator = listaGsbpmParentProcess.iterator();
        GsbpmProcess gsbpmp = new GsbpmProcess();
        while (iterator.hasNext()) {
            gsbpmp = iterator.next();
            processDto = new GsbpmProcessDto();
            processDto.setId(Long.toString(gsbpmp.getId()));
            processDto.setName(gsbpmp.getName());
            processDto.setDescr(gsbpmp.getDescr());
            processDtoList.add(processDto);
        }
        return processDtoList;
    }

    @RequestMapping(value = "/loadstep1", method = RequestMethod.GET)
    public String loadBusinessServices(HttpSession session, Model model) {

        List<GsbpmProcess> listaGsbpmParentProcess = gsbpmProcessService.findAllProcesses();
        GsbpmProcess gsbpmProcess = listaGsbpmParentProcess.get(0);

        List<GsbpmProcess> listaGsbpmSubProcess = gsbpmProcessService
                .findSubProcessesByGsbpmParentProcess(gsbpmProcess);

        ArrayList<GsbpmProcess> listaAllGsbpmProcess = new ArrayList<GsbpmProcess>();
        listaAllGsbpmProcess.addAll(listaGsbpmParentProcess);
        listaAllGsbpmProcess.addAll(listaGsbpmSubProcess);

        model.addAttribute("listaGsbpmParentProcess", listaGsbpmParentProcess);

        model.addAttribute("listaGsbpmSubProcess", listaGsbpmSubProcess);
        model.addAttribute("businessService", "null");


        return "businessdesign/homewizard.html";

    }

    @RequestMapping(value = "/loadbusinessservices", method = RequestMethod.GET)
    public ArrayList<BusinessServiceDto> loadBusinessServices(RedirectAttributes redirectAttributes, HttpSession session, Model model) {

        List<BusinessService> listaBusinessService = businessServiceService.findBusinessServices();
        BusinessService bservice = new BusinessService();
        BusinessServiceDto businessServiceDto;
        ArrayList<BusinessServiceDto> businessDtoList = new ArrayList<BusinessServiceDto>();

        Iterator<BusinessService> iterator = listaBusinessService.iterator();
        while (iterator.hasNext()) {
            bservice = iterator.next();
            businessServiceDto = new BusinessServiceDto();
            businessServiceDto.setId(bservice.getId().toString());
            businessServiceDto.setName(bservice.getName());
            businessServiceDto.setDescr(bservice.getDescr());
            businessDtoList.add(businessServiceDto);
        }


        redirectAttributes.addAttribute("param", 2);
        return businessDtoList;
    }

    @RequestMapping(value = "/loadapplicationservices", method = RequestMethod.GET)
    public ArrayList<ApplicationServiceDto> loadApplicationServices(RedirectAttributes redirectAttributes, HttpSession session, Model model) {

        List<AppService> listaAppService = appServiceService.findAllAppService();
        AppService appservice = new AppService();
        ApplicationServiceDto applicationServiceDto;
        ArrayList<ApplicationServiceDto> applicationDtoList = new ArrayList<ApplicationServiceDto>();

        Iterator<AppService> iterator = listaAppService.iterator();
        while (iterator.hasNext()) {
            appservice = iterator.next();
            applicationServiceDto = new ApplicationServiceDto();
            applicationServiceDto.setId(appservice.getId().toString());
            applicationServiceDto.setName(appservice.getName());
            applicationServiceDto.setDescr(appservice.getDescr());
            applicationDtoList.add(applicationServiceDto);
        }


        redirectAttributes.addAttribute("param", 3);
        return applicationDtoList;
    }

    @PostMapping(value = "/saveallservices")
    public String saveAllServices(RedirectAttributes redirectAttributes, HttpSession session, Model model, @ModelAttribute("servicesDesignForm") ServicesDesignForm form) {


        BusinessService businessService = new BusinessService();
        AppService appService = new AppService();
        StepInstance stepInstance = new StepInstance();

        businessService.setName(form.getNameb());
        businessService.setDescr(form.getDecriptionb());

        GsbpmProcess gsbpmProcess = new GsbpmProcess();
        gsbpmProcess = gsbpmProcessService.findById(form.getGsbpmid());
        businessService.setGsbpmProcess(gsbpmProcess);

        String rtnMessage = "success";
        BusinessService bs = null;
        AppService as = null;
        try {
            bs = businessServiceService.save(businessService);
        } catch (Exception e) {
            rtnMessage = e + "Impossibile inserire il Business Service.";
        }

        appService.setName(form.getNamea());
        appService.setDescr(form.getDecriptiona());
        appService.setLanguage(form.getLanguage());
        appService.setEngineType(form.getEngine());
        appService.setSource(form.getSoucepath());
        appService.setSourceCode(form.getSourcecode());
        appService.setAuthor(form.getAuthor());
        appService.setLicence(form.getLicence());
        appService.setContact(form.getContact());

        Long idbs = form.getIdbservice();
        //BusinessService bs = businessServiceService.findBusinessServiceById(idbs);
        appService.setBusinessService(bs);

        stepInstance.setMethod(form.getMethod());
        stepInstance.setDescr(form.getDescriptions());
        stepInstance.setLabel(form.getLabel());

        try {
            as = appServiceService.save(appService);
        } catch (Exception e) {
            rtnMessage = e + "Impossibile inserire l'Application Service.";
        }
        //AppService apps = appServiceService.findAppServiceById(form.getAppserviceid());
        stepInstance.setAppService(as);

        try {
            stepInstanceService.save(stepInstance);

        } catch (Exception e) {
            rtnMessage = e + "Impossibile inserire la Step Instance.";
        }
        return rtnMessage;

    }


}
