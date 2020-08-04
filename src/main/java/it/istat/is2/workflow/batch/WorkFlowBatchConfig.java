package it.istat.is2.workflow.batch;

import java.lang.management.ManagementFactory;
import java.util.Date;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.batch.core.BatchStatus;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobExecutionListener;
import org.springframework.batch.core.JobInstance;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.configuration.annotation.BatchConfigurer;
import org.springframework.batch.core.configuration.annotation.DefaultBatchConfigurer;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.explore.JobExplorer;
import org.springframework.batch.core.launch.JobOperator;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.event.ContextRefreshedEvent;

import it.istat.is2.workflow.domain.DataProcessing;

@Configuration
@EnableBatchProcessing
@PropertySource("classpath:application.properties")
public class WorkFlowBatchConfig extends DefaultBatchConfigurer implements BatchConfigurer {

    @Autowired
    public JobBuilderFactory jobs;

    @Autowired
    public StepBuilderFactory steps;

    @Autowired
    private WorkFlowBatchProcessor workFlowBatchProcessor;

    @Override
    @Autowired
    public void setDataSource(DataSource dataSource) {
        super.setDataSource(dataSource);
    }

    @Bean
    public Job doBusinessProc() {
        return (Job) jobs.get("doBusinessProc").listener(listener()).flow(doStep()).end().build();
    }

    @Bean
    public Step doStep() {
        return steps.get("doStep").<DataProcessing, DataProcessing>chunk(1).reader(workFlowBatchProcessor)
                .writer(new WorkFlowBatchWriter()).build();
    }

    @Bean
    public JobExecutionListener listener() {
        return new WorkFlowBatchListener();
    }

    @Bean
    public ApplicationListener<ContextRefreshedEvent> resumeJobsListener(@Autowired JobOperator jobOperator,
                                                                         @Autowired JobRepository jobRepository, @Autowired JobExplorer jobExplorer) {
        // restart jobs that failed due to
        return event -> {
            Date jvmStartTime = new Date(ManagementFactory.getRuntimeMXBean().getStartTime());
            // for each job
            for (String jobName : jobExplorer.getJobNames()) {
                // get latest job instance
                for (JobInstance instance : jobExplorer.getJobInstances(jobName, 0, 2)) {
                    // for each of the executions
                    for (JobExecution execution : jobExplorer.getJobExecutions(instance)) {
                        if (execution.getStatus().equals(BatchStatus.STARTED)
                                && execution.getCreateTime().before(jvmStartTime)) {
                            // this job is broken and must be restarted
                            execution.setEndTime(new Date());
                            execution.setStatus(BatchStatus.FAILED);
                            execution.setExitStatus(ExitStatus.FAILED);
                            for (StepExecution se : execution.getStepExecutions()) {
                                if (se.getStatus().equals(BatchStatus.STARTED)) {
                                    se.setEndTime(new Date());
                                    se.setStatus(BatchStatus.FAILED);
                                    se.setExitStatus(ExitStatus.FAILED);
                                    jobRepository.update(se);
                                }
                            }
                            try {
                                jobRepository.update(execution);
                            } catch (Exception e) {
                                Logger.getRootLogger().error(e.getMessage());
                            }
                        }
                    }
                }
            }
        };
    }
}
