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
package it.istat.rservice.app.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.rservice.app.dao.SessioneDao;
import it.istat.rservice.app.domain.SessioneLavoro;
import it.istat.rservice.app.domain.User;
import it.istat.rservice.dataset.domain.DatasetFile;
import it.istat.rservice.dataset.service.DatasetService;

@Service
public class SessioneLavoroService {

    @Autowired
    private SessioneDao sessioneDao;
    @Autowired
    private UserService userService;
    @Autowired
    private DatasetService datasetService;

    public List<SessioneLavoro> getSessioni(User user) {
        return sessioneDao.findByUserOrderByDataCreazioneDesc(user);
    }

    public Optional<SessioneLavoro> getSessione(Long id) {
        return sessioneDao.findById(id);
    }

    public SessioneLavoro getSessioneByIdFile(Long id) {
        DatasetFile dataset = datasetService.findDataSetFile(id);
        return dataset.getSessioneLavoro();
    }

    public List<SessioneLavoro> getSessioneList(User user) {
        return sessioneDao.findByUserOrderByDataCreazioneDesc(user);
    }

    public SessioneLavoro nuovaSessioneLavoro(String username, String descrizione, String nome) {
        User user = userService.findByEmail(username);
        SessioneLavoro sl = new SessioneLavoro();
        sl.setDataCreazione(new Date());
        sl.setDescrizione(descrizione);
        sl.setNome(nome);
        sl.setUser(user);
        return sessioneDao.save(sl);
    }

    public boolean eliminaSessioneLavoro(Long idsessione) {
        sessioneDao.deleteById(idsessione);
        return true;
    }
}
