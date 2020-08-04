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
package it.istat.is2.worksession.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.app.dao.UserDao;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.service.UserService;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.dataset.service.DatasetService;
import it.istat.is2.workflow.domain.BusinessFunction;
import it.istat.is2.worksession.dao.WorkSessionDao;
import it.istat.is2.worksession.domain.WorkSession;

@Service
public class WorkSessionService {

    @Autowired
    private WorkSessionDao sessioneDao;
    @Autowired
    private UserService userService;
    @Autowired
    private UserDao userDao;
    @Autowired
    private DatasetService datasetService;

    public WorkSession getSessione(Long id) {
        return sessioneDao.findById(id).orElse(null);
    }

    public WorkSession getSessioneByIdFile(Long id) {
        DatasetFile dataset = datasetService.findDataSetFile(id);
        return dataset.getWorkSession();
    }

    public List<WorkSession> getSessioneList(String username) {
        User user = userDao.findByEmail(username);
        return sessioneDao.findByUserOrderByLastUpdateDesc(user);
    }

    public List<WorkSession> getSessioneList(String username, Long idBusinessFunction) {
        BusinessFunction businessFunction = new BusinessFunction(idBusinessFunction);
        User user = userDao.findByEmail(username);
        return sessioneDao.findByUserAndBusinessFunctionOrderByLastUpdateDesc(user, businessFunction);
    }

    public WorkSession newWorkSession(String username, String descr, String name, Long idBusinessFunction) {
        User user = userService.findByEmail(username);
        WorkSession sl = new WorkSession();
        BusinessFunction businessFunction = new BusinessFunction(idBusinessFunction);
        sl.setLastUpdate(new Date());
        sl.setDescr(descr);
        sl.setBusinessFunction(businessFunction);
        sl.setName(name);
        sl.setUser(user);
        return sessioneDao.save(sl);
    }

    public boolean deleteWorkSession(Long idsessione) {
        sessioneDao.deleteById(idsessione);
        return true;
    }
}
