package it.istat.is2.workflow.batch;

import javax.servlet.http.HttpSession;

import org.springframework.batch.core.BatchStatus;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.listener.JobExecutionListenerSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import it.istat.is2.app.bean.SessionBean;
import it.istat.is2.app.service.LogService;
import it.istat.is2.app.util.IS2Const;

@Component
public class WorkFlowBatchListener extends JobExecutionListenerSupport {

    @Autowired
    private LogService logService;

    @Autowired
    private WorkFlowBatchService workFlowBatchService;

    @Autowired
    private HttpSession httpSession;


    @Override
    public void beforeJob(JobExecution jobExecution) {
        JobParameters params = jobExecution.getJobParameters();
        SessionBean sessionBean = (SessionBean) httpSession.getAttribute(IS2Const.SESSION_BEAN);
        String msg = "Job for elaborazione[" + params.getLong("idElaborazione") + "] and " + " process["
                + params.getLong("idBProc") + "] " + BatchStatus.STARTED.name();
        try {
            this.save(jobExecution, sessionBean, params, msg);
        } catch (Exception e) {
            logService.save(e.getMessage());
        }
    }

    @Override
    public void afterJob(JobExecution jobExecution) {
        JobParameters params = jobExecution.getJobParameters();
        String msg = null;
        if (jobExecution.getStatus() == BatchStatus.COMPLETED) {
            msg = "Job for elaborazione[" + params.getLong("idElaborazione") + "] and " + " processo["
                    + params.getLong("idBProc") + "] " + BatchStatus.COMPLETED.name();
        } else if (jobExecution.getStatus() == BatchStatus.FAILED) {
            msg = "Job for elaborazione[" + params.getLong("idElaborazione") + "] and  processo["
                    + params.getLong("idBProc") + "] " + BatchStatus.FAILED.name();
        } else if (jobExecution.getStatus() == BatchStatus.ABANDONED) {
            msg = "Job for elaborazione[" + params.getLong("idElaborazione") + "] and processo["
                    + params.getLong("idBProc") + "] " + BatchStatus.ABANDONED.name();
        }
        logService.save(msg);
    }

    private Batch save(JobExecution jobExecution, SessionBean sessionBean, JobParameters params,
                       String msg) throws Exception {
        Batch batch = workFlowBatchService.findById(jobExecution.getJobId()).orElse(new Batch());
        batch.setIdElaborazione(params.getLong("idElaborazione"));
        batch.setIdProcesso(params.getLong("idBProc"));
        if (sessionBean != null) {
            batch.setIdSessione(sessionBean.getId());
        } else {
            batch.setIdSessione(Long.valueOf(-1));
        }
        logService.save(msg);
        if (!jobExecution.getAllFailureExceptions().isEmpty()) {
            for (int i = 0; i < jobExecution.getAllFailureExceptions().size(); i++) {
                logService.save("ERROR: " + jobExecution.getAllFailureExceptions().get(i));
            }
        }
        return workFlowBatchService.save(batch);
    }

}
