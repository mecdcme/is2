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
    ProcessStepDao ProcessStepDao;

    public List<ProcessStep> findBStepByIdProcess(Long idprocess) {
        List<BusinessProcess> businessProcesses = new ArrayList<>();
        businessProcesses.add(new BusinessProcess(idprocess));
        return ProcessStepDao.findByBusinessProcessesIn(businessProcesses);
    }

    public List<ProcessStep> findAll() {
        return ProcessStepDao.findAll();
    }

    public ProcessStep findProcessStep(Long idbstep) {
        return ProcessStepDao.findById(idbstep).get();
    }
    public Optional<ProcessStep> findProcessStepById(Long idbstep) {
        return ProcessStepDao.findById(idbstep);
    }

	public ProcessStep save(ProcessStep step) {
		// TODO Auto-generated method stub
		return ProcessStepDao.save(step);
	}
}
