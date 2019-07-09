package it.istat.is2.workflow.batch;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WorkFlowBatchDao extends CrudRepository<Batch, Long> {
	
	public void save(Optional<Batch> batch);
	
	public List<Batch> findByIdSessione(Long idSessione);
	
}
