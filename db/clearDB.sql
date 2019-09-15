SET FOREIGN_KEY_CHECKS=0;

truncate table batch_job_execution;
truncate table  batch_job_execution_context;
truncate table batch_job_execution_params;
truncate table  batch_job_execution_seq;
truncate table  batch_job_instance;
truncate table  batch_job_seq;
truncate table  batch_step_execution;
truncate table  batch_step_execution_context;
truncate table  batch_step_execution_seq;
SET FOREIGN_KEY_CHECKS=1;