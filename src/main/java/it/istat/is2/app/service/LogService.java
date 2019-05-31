/**
 * Copyright 2019 ISTAT
 *
 * Licensed under the EUPL, Version 1.1 or – as soon they will be approved by
 * the European Commission - subsequent versions of the EUPL (the "Licence");
 * You may not use this work except in compliance with the Licence. You may
 * obtain a copy of the Licence at:
 *
 * http://ec.europa.eu/idabc/eupl5
 *
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
package it.istat.is2.app.service;

import it.istat.is2.app.dao.LogDao;
import it.istat.is2.app.domain.Log;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class LogService {
    
    @Autowired
    private LogDao logDao;
    
    public List<Log> findAll() {
        return (List<Log>) this.logDao.findAll();
    }
    
    public List<Log> findByIdUtente(Long idUtente) {
        return (List<Log>) this.logDao.findByIdUtenteOrderByIdDesc(idUtente);
    }
    
    public List<Log> findByIdSessione(Long idSessione) {
        return (List<Log>) this.logDao.findByIdSessioneOrderByIdDesc(idSessione);
    }
    
    public long deleteByIdSessione(Long idSessione) {
        return this.logDao.deleteByIdSessione(idSessione);
    }
    
    public void save(String msg, Long idUtente, Long idSessione){
        
        Log log = new Log();
        log.setMsg(msg);
        log.setMsgtime(new Date());
        log.setIdUtente(idUtente);
        log.setIdSessione(idSessione);
        
        this.logDao.save(log);
    }
    
}
