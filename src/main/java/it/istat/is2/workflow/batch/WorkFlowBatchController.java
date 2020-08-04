package it.istat.is2.workflow.batch;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersBuilder;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.launch.JobOperator;
import org.springframework.batch.core.launch.NoSuchJobException;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.ResponseEntity;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import it.istat.is2.app.bean.SessionBean;
import it.istat.is2.app.domain.Log;

import it.istat.is2.app.service.LogService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.IS2Const;

@RequestMapping("/rest")
@RestController
public class WorkFlowBatchController {

    @Autowired
    JobLauncher jobLauncher;
    @Autowired
    private NotificationService notificationService;
    @Autowired
    private MessageSource messages;
    @Autowired
    Job doBusinessProc;
    @Autowired
    LogService logService;
    @Autowired
    WorkFlowBatchService workFlowBatchService;

    @Autowired
    JobOperator jobOperator;

    @Autowired
    JobRepository jobRepository;

    @RequestMapping(value = "/batch/{idElaborazione}/{idBProc}", method = RequestMethod.GET)
    public ResponseEntity<?> doBatch(HttpSession session, Model model,
                                     @PathVariable("idElaborazione") Long idElaborazione, @PathVariable("idBProc") Long idBProc)
            throws NoSuchJobException {
        notificationService.removeAllMessages();
        JobParameters jobParameters = new JobParametersBuilder().addLong("idElaborazione", idElaborazione)
                .addLong("idBProc", idBProc).addLong("time", System.currentTimeMillis()).toJobParameters();
        try {
            jobLauncher.run(doBusinessProc, jobParameters);
            notificationService.addInfoMessage(
                    messages.getMessage("generic.process.start", null, LocaleContextHolder.getLocale()));
        } catch (Exception e) {
            logService.save(e.getMessage());
        }

        return ResponseEntity.ok(notificationService.getNotificationMessages());
    }

    @GetMapping("/batch/logs")
    public ResponseEntity<?> getLogs(HttpSession httpSession, Model model) {
        SessionBean sessionBean = (SessionBean) httpSession.getAttribute(IS2Const.SESSION_BEAN);
        List<Log> logs;
        if (sessionBean != null) {
            logs = logService.findByIdSessione(sessionBean.getId());
        } else {
            logs = new ArrayList<>();
        }
        return ResponseEntity.ok(logs);
    }

    @GetMapping("/batch/jobs/{idSessione}/{idElaborazione}")
    public ResponseEntity<?> getJobs(@PathVariable("idSessione") Long idSessione, @PathVariable("idElaborazione") Long idElaborazione) {


        return ResponseEntity.ok(workFlowBatchService.findByIdSessioneAndIdElaborazione(idSessione, idElaborazione));

    }

}
