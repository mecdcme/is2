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
	
	public void deleteByJobInstanceId(@Param("jobInstanceId")Long jobInstanceId);
	
	@Query("SELECT batch.jobInstanceId FROM Batch batch WHERE batch.idElaborazione = :idElab")
	public List<Long> findJobInstanceIdByElabId(@Param("idElab")Long idElab);
	
	@Modifying
	@Query(value="DELETE FROM BATCH_JOB_INSTANCE WHERE JOB_INSTANCE_ID = ?1", nativeQuery=true)
	public void deleteJobInstanceById(@Param("jobInstanceId")Long jobInstanceId);
	
	@Modifying
	@Query(value="DELETE FROM batch_job_execution WHERE JOB_INSTANCE_ID = ?1", nativeQuery=true)
	public void deleteBatchJobExecutionById(@Param("jobInstanceId")Long jobInstanceId);
	
	@Modifying
	@Query(value="DELETE FROM batch_job_execution_context WHERE JOB_INSTANCE_ID = ?1", nativeQuery=true)
	public void deleteBatchJobExecutionContextById(@Param("jobInstanceId")Long jobInstanceId);
	
}
