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
package it.istat.is2.worksession.controller;

import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import it.istat.is2.app.bean.ElaborazioneFormBean;
import it.istat.is2.app.bean.SessionBean;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.service.ElaborazioneService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.SxBusinessFunction;
import it.istat.is2.workflow.service.BusinessFunctionService;
import it.istat.is2.worksession.domain.WorkSession;
import it.istat.is2.worksession.service.WorkSessionService;
import java.util.ArrayList;

@Controller
public class WorkSessionController {

    @Autowired
    private WorkSessionService sessioneLavoroService;
    @Autowired
    private NotificationService notificationService;
    @Autowired
    private ElaborazioneService elaborazioneService;
    @Autowired
    private BusinessFunctionService businessFunctionService;

    @GetMapping(value = "/sessione/mostraSessioni")
    public String mostraSessioni(HttpSession session, Model model, @AuthenticationPrincipal User user) {
        notificationService.removeAllMessages();

        List<WorkSession> listasessioni = sessioneLavoroService.getSessioneList(user);
        model.addAttribute("listasessioni", listasessioni);

        return "worksession/list";
    }

    @RequestMapping(value = "/sessione/nuovasessione")
    public String nuovaSessione(HttpSession session, Model model, @AuthenticationPrincipal User user, @RequestParam("descrizione") String descrizione, @RequestParam("nome") String nome) {
        notificationService.removeAllMessages();
        try {
            WorkSession sessionelv = sessioneLavoroService.nuovaSessioneLavoro(user.getEmail(), descrizione, nome);
            notificationService.addInfoMessage("Sessione creata con ID:" + sessionelv.getId());
        } catch (Exception e) {
            notificationService.addErrorMessage("Errore creazione nuova sessione.", e.getMessage());
        }
        return "redirect:/sessione/mostraSessioni";
    }

    @GetMapping(value = "/sessione/apriseselab/{idSessione}/{idElaborazione}")
    public String apriSesElab(HttpSession session, Model model, @AuthenticationPrincipal User user, @PathVariable("idSessione") Long idSessione, @PathVariable("idElaborazione") Long idElaborazione) {

        WorkSession sessionelv = sessioneLavoroService.getSessione(idSessione).get();
        if (sessionelv.getDatasetFiles() != null) {
            session.setAttribute(IS2Const.SESSION_DATASET, true);
        }
        session.setAttribute(IS2Const.SESSION_LV, sessionelv);
        
        session.setAttribute(IS2Const.SESSION_BEAN, new SessionBean(idSessione, sessionelv.getNome()));
        
        return "redirect:/ws/home/" + idElaborazione;
    }

    @GetMapping(value = "/sessione/apri/{id}")
    public String apriSessione(HttpSession session, Model model, @PathVariable("id") Long id) {

        notificationService.removeAllMessages();

        WorkSession sessionelv = sessioneLavoroService.getSessione(id).get();
        List<String> files = new ArrayList();
        if (sessionelv.getDatasetFiles() != null) {
            session.setAttribute(IS2Const.SESSION_DATASET, true);
            for (DatasetFile datasetFile : sessionelv.getDatasetFiles()) {
                files.add(datasetFile.getNomeFile());
            }
        }
        List<Elaborazione> listaElaborazioni = elaborazioneService.getElaborazioneList(sessionelv);
        List<SxBusinessFunction> listaFunzioni = businessFunctionService.findBFunctions();

        session.setAttribute(IS2Const.SESSION_LV, sessionelv);

        SessionBean sessionBean;
        if (session.getAttribute(IS2Const.SESSION_BEAN) != null) {
            sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
            if(!sessionBean.getId().equals(id)){
                sessionBean = new SessionBean(id, sessionelv.getNome());
            }
        } else {
            sessionBean = new SessionBean(id, sessionelv.getNome());
        }
        sessionBean.setFile(files);
        session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);

        model.addAttribute("listaFunzioni", listaFunzioni);
        model.addAttribute("listaElaborazioni", listaElaborazioni);
        return "worksession/home";
    }

    @RequestMapping(value = "/sessione/nuovoworkingset", method = RequestMethod.POST)
    public String nuovoWorkingSet(HttpSession session, Model model, @AuthenticationPrincipal User user, @ModelAttribute("elaborazioneFormBean") ElaborazioneFormBean form) {
        notificationService.removeAllMessages();

        session.setAttribute(IS2Const.WORKINGSET, "workingset");
        WorkSession sessionelv = sessioneLavoroService.getSessione(form.getIdsessione()).get();
        try {
            Elaborazione elaborazione = new Elaborazione();
            elaborazione.setSessioneLavoro(sessionelv);
            elaborazione.setDescrizione(form.getDescrizione());
            elaborazione.setNome(form.getNome());
            elaborazione.setDataElaborazione(new Date());
            elaborazione.setSxBusinessFunction(businessFunctionService.findBFunctionById(form.getIdfunzione()).get());

            elaborazioneService.salvaElaborazione(elaborazione);
            notificationService.addInfoMessage("Elaborazione creata.");
        } catch (Exception e) {
            notificationService.addErrorMessage("Errore creazione elaborazione", e.getMessage());
        }
        return "redirect:/sessione/apri/" + sessionelv.getId();
    }

    @GetMapping(value = "/sessione/workingset/{id}")
    public String workingSet(HttpSession session, Model model, @PathVariable("id") Long id) {
        session.setAttribute(IS2Const.WORKINGSET, "workingset");
        return "elaborazione/nuovo_ws";
    }

    @GetMapping(value = "/sessione/chiudisessione")
    public String chiudiSessione(HttpSession session, @AuthenticationPrincipal User user) {
        session.removeAttribute(IS2Const.SESSION_LV);
        session.removeAttribute(IS2Const.SESSION_BEAN);
        session.removeAttribute(IS2Const.SESSION_DATASET);
        session.removeAttribute(IS2Const.SESSION_ELABORAZIONE);
        return "redirect:/sessione/mostraSessioni";
    }

    @GetMapping(value = "/sessione/elimina/{idsessione}")
    public String eliminaWS(HttpSession session, Model model, @AuthenticationPrincipal User user, @PathVariable("idsessione") Long idsessione) {
        notificationService.removeAllMessages();
        if (sessioneLavoroService.eliminaSessioneLavoro(idsessione)) {
            notificationService.addInfoMessage("La sessione lavoro è stata rimossa.");
        } else {
            notificationService.addErrorMessage("Errore nell'eliminazione della Sessione di lavoro.");
        }
        session.removeAttribute(IS2Const.SESSION_LV);
        session.removeAttribute(IS2Const.SESSION_ELABORAZIONE);
        return "redirect:/sessione/mostraSessioni";
    }
}
