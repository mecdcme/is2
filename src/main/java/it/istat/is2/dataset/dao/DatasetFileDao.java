/**
 * Copyright 2019 ISTAT
 * <p>
 * Licensed under the EUPL, Version 1.1 or – as soon they will be approved by
 * the European Commission - subsequent versions of the EUPL (the "Licence");
 * You may not use this work except in compliance with the Licence. You may
 * obtain a copy of the Licence at:
 * <p>
 * http://ec.europa.eu/idabc/eupl5
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the Licence is distributed on an "AS IS" basis, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * Licence for the specific language governing permissions and limitations under
 * the Licence.
 *
 * @author Francesco Amato <framato @ istat.it>
 * @author Mauro Bruno <mbruno @ istat.it>
 * @author Paolo Francescangeli  <pafrance @ istat.it>
 * @author Renzo Iannacone <iannacone @ istat.it>
 * @author Stefano Macone <macone @ istat.it>
 * @version 1.0
 */
package it.istat.is2.dataset.dao;


import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.worksession.domain.WorkSession;

@Repository
public interface DatasetFileDao extends JpaRepository<DatasetFile, Long> {

    @Query(value = "SELECT u FROM DatasetFile u.id = 1", nativeQuery = true)
    DatasetFile findQuery();

    @Query(value = "SELECT df.totalRows from DatasetFile df where df.id =:dFile")
    Integer findTotalRows(@Param("dFile") Long dFile);

    List<DatasetFile> findDatasetFilesByWorkSession(WorkSession workSession);

    @Transactional
    @Modifying
    @Query(value = "delete from DatasetFile df where df.id=:dFile ")
    void deleteDatasetFile(@Param("dFile") Long dFile);
}
