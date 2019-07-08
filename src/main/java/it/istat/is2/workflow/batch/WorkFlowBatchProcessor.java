package it.istat.is2.workflow.batch;

import java.util.Iterator;

import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.item.ItemReader;
import org.springframework.batch.item.NonTransientResourceException;
import org.springframework.batch.item.ParseException;
import org.springframework.batch.item.UnexpectedInputException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import it.istat.is2.app.service.LogService;
import it.istat.is2.workflow.dao.BusinessProcessDao;
import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.SxBusinessProcess;
import it.istat.is2.workflow.domain.SxBusinessStep;
import it.istat.is2.workflow.domain.SxStepInstance;
import it.istat.is2.workflow.engine.EngineFactory;
import it.istat.is2.workflow.engine.EngineService;
import it.istat.is2.workflow.service.WorkflowService;

@Component
@StepScope
public class WorkFlowBatchProcessor implements ItemReader<Elaborazione>{

	@Value("#{jobParameters['idElaborazione']}")
	private Long idElaborazione;

	@Value("#{jobParameters['idBProc']}")
	private Long idBProc;

	@Autowired
	BusinessProcessDao businessProcessDao;

	@Autowired
	private WorkflowService workflowService;
	
	@Autowired
    EngineFactory engineFactory;
	
	@Autowired
	LogService logService;
	
	@Override
	public Elaborazione read()
			throws Exception, UnexpectedInputException, ParseException, NonTransientResourceException {
		Elaborazione elaborazione = workflowService.findElaborazione(idElaborazione);
		SxBusinessProcess sxBusinessProcess = businessProcessDao.findById(idBProc).orElse(new SxBusinessProcess());
		for (Iterator<?> iterator = sxBusinessProcess.getSxBusinessSteps().iterator(); iterator.hasNext();) {
			SxBusinessStep businessStep = (SxBusinessStep) iterator.next();
			for (Iterator<?> iteratorStep = businessStep.getSxStepInstances().iterator(); iteratorStep.hasNext();) {
				SxStepInstance sxStepInstance = (SxStepInstance) iteratorStep.next();
				elaborazione = doStep(elaborazione, sxStepInstance);
			}
		}
		Thread.sleep(10000);
		return null;
	}

	public Elaborazione doStep(Elaborazione elaborazione, SxStepInstance stepInstance) throws Exception {
		EngineService engine = engineFactory.getEngine(stepInstance.getSxAppService().getInterfaccia());
		try {
			engine.init(elaborazione, stepInstance);
			engine.doAction();
			engine.processOutput();
		} catch (Exception e) {
			throw (e);
		} finally {
			engine.destroy();
		}

		return elaborazione;
	}

	public void setIdElaborazione(Long idElaborazione) {
		this.idElaborazione = idElaborazione;
	}

	public void setIdBProc(Long idBProc) {
		this.idBProc = idBProc;
	}

}
