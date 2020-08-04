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
package it.istat.is2.app.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import it.istat.is2.app.domain.Log;
import it.istat.is2.worksession.domain.WorkSession;

@Repository
public interface LogDao extends JpaRepository<Log, Long> {

    public void save(Optional<Log> log);

    public List<Log> findByWorkSessionOrderByIdDesc(WorkSession idWorkSession);

    public List<Log> findByWorkSessionOrderByIdAsc(WorkSession idWorkSession);

    public List<Log> findByWorkSessionAndTypeOrderByIdDesc(WorkSession idWorkSession, String type);

    public List<Log> findByWorkSessionAndTypeOrderByIdAsc(WorkSession idWorkSession, String type);


    @Modifying
    @Query("delete from Log lg where lg.workSession = :idWorkSession and lg.type = :type")
    public int deleteByWorkSessionAndType(@Param("idWorkSession") Long idWorkSession, @Param("type") String type);

    @Modifying
    @Query("delete from Log lg where lg.workSession.id = :idWorkSession")
    public int deleteByWorkSession(@Param("idWorkSession") Long idWorkSession);

}
