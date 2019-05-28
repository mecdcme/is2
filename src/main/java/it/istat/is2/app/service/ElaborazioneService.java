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

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.app.dao.ElaborazioneDao;
import it.istat.is2.app.domain.Elaborazione;
import it.istat.is2.worksession.domain.SessioneLavoro;

@Service
public class ElaborazioneService {

    @Autowired
    private ElaborazioneDao elaborazioneDao;

    public List<Elaborazione> getElaborazioneList(SessioneLavoro sessioneLavoro) {
        return elaborazioneDao.findBySessioneLavoroOrderByIdDesc(sessioneLavoro);
    }

    public Elaborazione salvaElaborazione(Elaborazione elaborazione) {
        return elaborazioneDao.save(elaborazione);
    }

    public Elaborazione findElaborazione(Long idelaborazione) {
        return elaborazioneDao.findById(idelaborazione).orElse(null);
    }
}
