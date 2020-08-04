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
package it.istat.is2.app.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.istat.is2.app.bean.SessionBean;
import it.istat.is2.app.dao.LogDao;
import it.istat.is2.app.domain.Log;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.worksession.domain.WorkSession;

@Service
@Transactional
public class LogService {

    @Autowired
    private LogDao logDao;
    @Autowired
    private HttpSession httpSession;
    @Autowired
    protected EntityManager em;

    public List<Log> findAll() {
        return logDao.findAll();
    }

    public List<Log> findByIdSessione(Long idSessione) {

        return logDao.findByWorkSessionOrderByIdAsc(new WorkSession(idSessione));
    }

    public List<Log> findByIdSessioneAndTipo(Long idSessione, String tipo) {
        return logDao.findByWorkSessionAndTypeOrderByIdAsc(new WorkSession(idSessione), tipo);
    }

    public List<Log> findByIdSessione() {
        SessionBean sessionBean = (SessionBean) httpSession.getAttribute(IS2Const.SESSION_BEAN);
        List<Log> logs;
        if (sessionBean != null) {
            logs = logDao.findByWorkSessionAndTypeOrderByIdDesc(new WorkSession(sessionBean.getId()),
                    IS2Const.OUTPUT_DEFAULT);
        } else {
            logs = new ArrayList<>();
        }
        return logs;
    }

    public List<Log> findByIdSessioneAndTipo(String tipo) {
        SessionBean sessionBean = (SessionBean) httpSession.getAttribute(IS2Const.SESSION_BEAN);
        List<Log> logs;
        if (sessionBean != null) {
            logs = logDao.findByWorkSessionAndTypeOrderByIdAsc(new WorkSession(sessionBean.getId()), tipo);
        } else {
            logs = new ArrayList<>();
        }
        return logs;
    }

    public void deleteByIdSessione(Long idSessione) {
        logDao.deleteByWorkSession(idSessione);
    }

    public int deleteByIdSessioneAndTipo(Long idSessione, String tipo) {
        return logDao.deleteByWorkSessionAndType(idSessione, tipo);
    }

    public void save(String msg) {

        SessionBean sessionBean = (SessionBean) httpSession.getAttribute(IS2Const.SESSION_BEAN);
        Session session = em.unwrap(Session.class);
        Log log = new Log();
        if (sessionBean != null && sessionBean.getId() != null) {
            log.setWorkSession(new WorkSession(sessionBean.getId()));
        } else {
            log.setWorkSession(new WorkSession());
        }
        log.setMsg(msg);
        log.setType(IS2Const.OUTPUT_DEFAULT);
        log.setMsgTime(new Date());

        this.logDao.save(log);
        session.flush();
        session.clear();

    }

    public void save(String msg, String tipo) {

        SessionBean sessionBean = (SessionBean) httpSession.getAttribute(IS2Const.SESSION_BEAN);

        Log log = new Log();
        if (sessionBean != null) {
            log.setWorkSession(new WorkSession(sessionBean.getId()));
        } else {
            log.setWorkSession(null);
        }
        log.setMsg(msg);
        log.setType(tipo);
        log.setMsgTime(new Date());

        logDao.save(log);
    }

}
