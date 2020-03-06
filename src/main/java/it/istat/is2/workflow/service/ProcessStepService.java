package it.istat.is2.workflow.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.workflow.dao.ProcessStepDao;

import it.istat.is2.workflow.domain.BusinessProcess;
import it.istat.is2.workflow.domain.ProcessStep;

@Service
public class ProcessStepService {

	@Autowired
	ProcessStepDao processStepDao;

    public List<ProcessStep> findBStepByIdProcess(Long idprocess) {
        List<BusinessProcess> businessProcesses = new ArrayList<>();
        businessProcesses.add(new BusinessProcess(idprocess));
        return processStepDao.findByBusinessProcessesIn(businessProcesses);
    }

    public List<ProcessStep> findAll() {
        return processStepDao.findAll();
    }


   
      
	public ProcessStep findProcessStepById(Long idbstep) {
		ProcessStep returnValue = null;
		Optional<ProcessStep> value = processStepDao.findById(idbstep);
		if (value.isPresent()) {
			returnValue = value.get();
		}
		return returnValue;

    }

	public ProcessStep save(ProcessStep step) {
		 
		return processStepDao.save(step);
	}

	public ProcessStep deleteStepService(ProcessStep step) {
		// TODO Auto-generated method stub
		processStepDao.delete(step);
		return step;
	}
}
