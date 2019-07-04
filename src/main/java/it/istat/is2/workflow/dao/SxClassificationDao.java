package it.istat.is2.workflow.dao;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import it.istat.is2.workflow.domain.SxClassification;

@Repository
public interface SxClassificationDao extends CrudRepository<SxClassification,Integer> {

	SxClassification findById(short id);
}
