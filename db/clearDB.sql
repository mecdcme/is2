SET FOREIGN_KEY_CHECKS=0;

truncate table batch_job_execution;
truncate table  batch_job_execution_context;
truncate table batch_job_execution_params;
truncate table  batch_job_instance;
truncate table  batch_step_execution;
truncate table  batch_step_execution_context;
truncate table  sx_dataset_colonna;
truncate table  sx_dataset_file;
truncate table  sx_log;
truncate table  x_step_variable;
truncate table  sx_workset;
truncate table sx_ruleset;
SET FOREIGN_KEY_CHECKS=1;