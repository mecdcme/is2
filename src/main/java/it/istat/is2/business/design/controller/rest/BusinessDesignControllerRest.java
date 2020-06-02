package it.istat.is2.business.design.controller.rest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import it.istat.is2.business.design.dto.GsbpmProcessDto;
import it.istat.is2.workflow.domain.GsbpmProcess;
import it.istat.is2.workflow.service.GsbpmProcessService;

@RestController
public class BusinessDesignControllerRest {
	@Autowired
    private GsbpmProcessService gsbpmProcessService;
	
	@RequestMapping(value = "/loadGsbpmSubProcess/{idprocess}", method = RequestMethod.GET)
    public List<GsbpmProcessDto> loadGsbpmSubProcess(HttpServletRequest request, Model model,
            @PathVariable("idprocess") Long idprocess) throws IOException {

		GsbpmProcess gsbpmProcess = gsbpmProcessService.findById(idprocess);
		List<GsbpmProcess> listaGsbpmSubProcess = gsbpmProcessService.findSubProcessesByGsbpmParentProcess(gsbpmProcess);
		
		ArrayList<GsbpmProcessDto> processDtoList = new ArrayList<GsbpmProcessDto>();
		GsbpmProcessDto processDto;
		Iterator<GsbpmProcess> iterator = listaGsbpmSubProcess.iterator();
		GsbpmProcess gsbpmp = new GsbpmProcess();
		while(iterator.hasNext()) {
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
		while(iterator.hasNext()) {
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
	@RequestMapping(value = "/loadstep2", method = RequestMethod.GET)
	public String loadApplicationServices(HttpSession session, Model model) {

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
}
