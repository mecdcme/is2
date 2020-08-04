package it.istat.is2.workflow.batch;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface WorkFlowBatchDao extends CrudRepository<Batch, Long> {

    public void save(Optional<Batch> batch);

    public List<Batch> findByIdSessione(Long idSessione);

    public List<Batch> findByIdSessioneAndIdElaborazione(@Param("idSessione") Long idSessione, @Param("idElaborazione") Long idElaborazione);

    public void deleteByJobInstanceId(@Param("jobInstanceId") Long jobInstanceId);

    @Query("SELECT batch FROM Batch batch WHERE batch.idElaborazione = :idElab")
    public List<Batch> findJobInstanceIdByElabId(@Param("idElab") Long idElab);

    @Modifying
    @Query(value = "DELETE FROM BATCH_JOB_INSTANCE WHERE JOB_INSTANCE_ID = ?1", nativeQuery = true)
    public void deleteJobInstanceById(@Param("jobInstanceId") Long jobInstanceId);

    @Modifying
    @Query(value = "DELETE FROM batch_job_execution WHERE JOB_INSTANCE_ID = ?1", nativeQuery = true)
    public void deleteBatchJobExecutionById(@Param("jobInstanceId") Long jobInstanceId);

    @Modifying
    @Query(value = "DELETE FROM batch_job_execution_context WHERE JOB_EXECUTION_ID IN ( SELECT JOB_EXECUTION_ID FROM   batch_job_execution WHERE JOB_INSTANCE_ID = ?1)", nativeQuery = true)
    public void deleteBatchJobExecutionContextById(@Param("jobInstanceId") Long jobInstanceId);

    @Modifying
    @Query(value = "DELETE FROM batch_job_execution_params WHERE JOB_EXECUTION_ID IN ( SELECT JOB_EXECUTION_ID FROM   batch_job_execution WHERE JOB_INSTANCE_ID = ?1)", nativeQuery = true)
    public void deleteBatchJobExecutionParamsById(@Param("jobInstanceId") Long jobInstanceId);

    @Modifying
    @Query(value = "DELETE FROM batch_step_execution_context WHERE STEP_EXECUTION_ID IN ( SELECT STEP_EXECUTION_ID FROM   batch_STEP_execution WHERE JOB_EXECUTION_ID = ?1)", nativeQuery = true)
    public void deleteBaatchStepExecutionContextById(@Param("jobExecutionId") Long jobExecutionId);

    @Modifying
    @Query(value = "DELETE FROM   batch_STEP_execution WHERE JOB_EXECUTION_ID = ?1", nativeQuery = true)
    public void deleteBatchStepExecutionById(@Param("jobExecutionId") Long jobExecutionId);

}
