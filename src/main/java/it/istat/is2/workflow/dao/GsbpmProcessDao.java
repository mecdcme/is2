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
package it.istat.is2.workflow.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import it.istat.is2.workflow.domain.GsbpmProcess;

@Repository
public interface GsbpmProcessDao extends CrudRepository<GsbpmProcess, Long> {

    @Query("SELECT gp FROM GsbpmProcess gp WHERE gp.gsbpmProcessParent IS NULL and gp.active = 1 ORDER BY gp.orderCode ASC ")
    List<GsbpmProcess> findAllProcesses();

    @Query("SELECT gp FROM GsbpmProcess gp WHERE gp.gsbpmProcessParent IS NOT NULL and gp.active = 1 ORDER BY gp.gsbpmProcessParent, gp.orderCode ASC")
    List<GsbpmProcess> findAllSubProcesses();

    @Query("SELECT gp FROM GsbpmProcess gp WHERE gp.gsbpmProcessParent=:gsbpmProcess and gp.active = 1 ORDER BY gp.gsbpmProcessParent, gp.orderCode ASC")
    List<GsbpmProcess> findSubProcessesByGsbpmParentProcess(@Param("gsbpmProcess") GsbpmProcess gsbpmProcess);

    @Query("SELECT max(gp.orderCode) FROM GsbpmProcess gp")
    Integer getGsbpmRows();

    @Query("SELECT count(*) FROM GsbpmProcess gp WHERE gp.gsbpmProcessParent IS NULL and gp.active = 1")
    Integer getGsbpmColumns();
}
