package it.istat.is2.workflow.dao;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import it.istat.is2.workflow.domain.Classification;

@Repository
public interface ClassificationDao extends CrudRepository<Classification,Integer> {

	Classification findById(short id);
}
