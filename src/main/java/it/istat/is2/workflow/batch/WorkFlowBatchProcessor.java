package it.istat.is2.workflow.batch;

import java.util.Iterator;

import org.apache.log4j.Logger;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.item.ItemReader;
import org.springframework.batch.item.NonTransientResourceException;
import org.springframework.batch.item.ParseException;
import org.springframework.batch.item.UnexpectedInputException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import it.istat.is2.app.service.LogService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.workflow.dao.BusinessProcessDao;
import it.istat.is2.workflow.domain.DataProcessing;
import it.istat.is2.workflow.domain.BusinessProcess;
import it.istat.is2.workflow.domain.ProcessStep;
import it.istat.is2.workflow.domain.StepInstance;
import it.istat.is2.workflow.engine.EngineFactory;
import it.istat.is2.workflow.engine.EngineService;
import it.istat.is2.workflow.service.WorkflowService;

@Component
@StepScope
public class WorkFlowBatchProcessor implements ItemReader<DataProcessing> {

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
    private LogService logService;

    @Autowired
    private NotificationService notificationService;

    @Override
    public DataProcessing read()
            throws Exception, UnexpectedInputException, ParseException, NonTransientResourceException {
        final DataProcessing elaborazione = workflowService.findDataProcessing(idElaborazione);
        final BusinessProcess businessProcess = businessProcessDao.findById(idBProc).orElse(new BusinessProcess());
        businessProcess.getBusinessSteps().forEach(businessStep -> {

            businessStep.getStepInstances().forEach(stepInstance -> {
                try {
                    doStep(elaborazione, stepInstance);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            });

        });

        return null;
    }

    public DataProcessing doStep(DataProcessing elaborazione, StepInstance stepInstance) throws Exception {
        EngineService engine = engineFactory.getEngine(stepInstance.getAppService().getEngineType());

        try {
            engine.init(elaborazione, stepInstance);
            engine.doAction();
            engine.processOutput();
        } catch (Exception e) {
            Logger.getRootLogger().error(e.getMessage());
            logService.save("Error: " + e.getMessage());
            notificationService.addErrorMessage("Error: " + e.getMessage());
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
