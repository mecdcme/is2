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
package it.istat.is2.dataset.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import it.istat.is2.app.bean.InputFormBean;
import it.istat.is2.app.bean.SessionBean;
import it.istat.is2.app.domain.Log;
import it.istat.is2.app.service.LogService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.FileHandler;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.dataset.domain.DatasetColumn;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.dataset.domain.StatisticalVariableCls;
import it.istat.is2.dataset.service.DatasetService;
import it.istat.is2.workflow.domain.DataTypeCls;
import it.istat.is2.workflow.service.DataTypeService;
import it.istat.is2.worksession.domain.WorkSession;
import it.istat.is2.worksession.service.WorkSessionService;
import lombok.extern.slf4j.Slf4j;

import org.springframework.security.core.annotation.AuthenticationPrincipal;

@Controller

public class DatasetController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());


    @Autowired
    private DatasetService datasetService;
    @Autowired
    ServletContext context;
    @Autowired
    private NotificationService notificationService;
    @Autowired
    private MessageSource messages;
    @Autowired
    private WorkSessionService workSessionService;
    @Autowired
    private DataTypeService dataTypeService;
    @Autowired
    private LogService logService;

    @GetMapping("/viewDataset/{idfile}")
    public String caricafile(HttpSession session, Model model, @PathVariable("idfile") Long idfile) {

        notificationService.removeAllMessages();

        DatasetFile dfile = datasetService.findDataSetFile(idfile);
        List<DatasetColumn> colonne = datasetService.findAllNameColum(idfile);
        List<StatisticalVariableCls> variabiliSum = datasetService.findAllVariabiliSum();
        Integer numRighe = dfile.getTotalRows();

        SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
        List<DatasetFile> files = null;
        if (sessionBean != null) {
            files = datasetService.findDatasetFilesByIdWorkSession(sessionBean.getId());
        }

        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idfile);
        model.addAttribute("variabili", variabiliSum);
        model.addAttribute("dfile", dfile);
        model.addAttribute("numRighe", numRighe.toString());
        model.addAttribute("files", files);

        return "dataset/preview";
    }

    @GetMapping("/metadatiDataset/{idfile}")
    public String caricaMetadati(Model model, @PathVariable("idfile") Long idfile) {

        DatasetFile dfile = datasetService.findDataSetFile(idfile);

        List<DatasetColumn> colonne = datasetService.findAllNameColum(idfile);
        List<StatisticalVariableCls> variabiliSum = datasetService.findAllVariabiliSum();

        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idfile);
        model.addAttribute("variabili", variabiliSum);
        model.addAttribute("dfile", dfile);

        return "dataset/metadata";
    }

    @GetMapping(value = "/sessione/mostradataset/{id}")
    public String viewDataset(HttpSession session, Model model, @PathVariable("id") Long id) {

        List<Log> logs = logService.findByIdSessione(id);

        WorkSession sessionelv = workSessionService.getSessione(id);
        if (sessionelv.getDatasetFiles() != null && !sessionelv.getDatasetFiles().isEmpty()) {
            session.setAttribute(IS2Const.SESSION_DATASET, true);
        }

        List<DatasetFile> datasetList = sessionelv.getDatasetFiles();
        List<DataTypeCls> fileTypeList = new ArrayList<>();
        fileTypeList.addAll(dataTypeService.findListTipoDato());

        String etichetta = null;
        if (datasetList != null && datasetList.size() > 0) {
            etichetta = "DS" + Integer.toString(datasetList.size() + 1);
        } else {
            etichetta = "DS1";
        }

        model.addAttribute("fileTypeList", fileTypeList);
        model.addAttribute("datasetList", datasetList);
        model.addAttribute("logs", logs);
        model.addAttribute("etichetta", etichetta);
        return "dataset/list";
    }

    @PostMapping(value = "/associaVarSum")
    public String caricaMetadati(Model model, String idfile, String idvar, String filtro, String idsum) {

        DatasetFile dfile = datasetService.findDataSetFile(Long.valueOf(idfile));
        DatasetColumn dcol = datasetService.findOneColonna(Long.parseLong(idvar));
        StatisticalVariableCls sum = new StatisticalVariableCls(Integer.parseInt(idsum));

        dcol.setVariabileType(sum);

        try {
            datasetService.salvaColonna(dcol);
            notificationService
                    .addInfoMessage(messages.getMessage("generic.save.success", null, LocaleContextHolder.getLocale()));
        } catch (Exception e) {
            notificationService.addErrorMessage("Errore: ", e.getMessage());

        }

        List<DatasetColumn> colonne = datasetService.findAllNameColum(Long.parseLong(idfile));
        List<StatisticalVariableCls> variabiliSum = datasetService.findAllVariabiliSum();

        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idfile);
        model.addAttribute("dfile", dfile);
        model.addAttribute("variabili", variabiliSum);

        return "dataset/metadata";
    }

    @PostMapping(value = "/loadInputData")
    public String loadInputData(HttpSession session, HttpServletRequest request, Model model,
                                @AuthenticationPrincipal Principal user, @ModelAttribute("inputFormBean") InputFormBean form)
            throws IOException {

        notificationService.removeAllMessages();

        String labelFile = form.getLabelFile();
        Long tipoDato = form.getFileType();
        String separatore = form.getDelimiter();
        String idsessione = form.getIdsessione();

        File f = FileHandler.convertMultipartFileToFile(form.getFileName());
        String pathTmpFile = f.getAbsolutePath().replace("\\", "/");

        HashMap<Integer, String> valoriHeaderNum = null;
        try {
            valoriHeaderNum = FileHandler.getCampiHeaderNumIndex(pathTmpFile, separatore.toCharArray()[0]);
        } catch (Exception e) {
            notificationService.addErrorMessage(
                    messages.getMessage("file.read.error", null, LocaleContextHolder.getLocale()), e.getMessage());
            return "redirect:/sessione/mostradataset/" + idsessione;
        }

        HashMap<String, ArrayList<String>> campiL = null;
        try {
            campiL = FileHandler.getArrayListFromCsv2(pathTmpFile, form.getNumeroCampi(), separatore.toCharArray()[0],
                    valoriHeaderNum);
        } catch (Exception e) {
            notificationService.addErrorMessage(
                    messages.getMessage("file.read.error", null, LocaleContextHolder.getLocale()), e.getMessage());
        }

        try {
            datasetService.save(campiL, valoriHeaderNum, labelFile, tipoDato, separatore, form.getDescrizione(),
                    idsessione);
            logService.save("File " + labelFile + " salvato con successo");
            notificationService
                    .addInfoMessage(messages.getMessage("generic.save.success", null, LocaleContextHolder.getLocale()));
            SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
            sessionBean.getFile().add(form.getDescrizione());
            session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);
        } catch (Exception e) {
            logger.error(e.getMessage());
            notificationService.addErrorMessage("Errore nel salvataggio del file.");
            return "redirect:/sessione/mostradataset/" + idsessione;
        }

        return "redirect:/sessione/mostradataset/" + idsessione;
    }

    @GetMapping(value = "/deleteDataset/{datasetid}")
    public String deleteDataset(HttpSession session, Model model,
                                @PathVariable("datasetid") Long idDataset) {

        notificationService.removeAllMessages();

        WorkSession sessionelv = workSessionService.getSessioneByIdFile(idDataset);
        datasetService.deleteDataset(idDataset);
        logService.save("File " + idDataset + " eliminato con successo");
        notificationService.addInfoMessage("Eliminazione avvenuta con successo");

        return "redirect:/sessione/mostradataset/" + sessionelv.getId();
    }

    @PostMapping(value = "/dataset/loadtable")
    public String loadDatasetFromTable(HttpSession session, HttpServletRequest request, Model model,
                                       @ModelAttribute("idsessione") String idsessione, @RequestParam("dbschema") String dbschema,
                                       @RequestParam("tablename") String tablename, @RequestParam("fields") String[] fields) throws IOException {
        notificationService.removeAllMessages();
        try {
            datasetService.loadDatasetFromTable(idsessione, dbschema, tablename, fields);
            logService.save("Table " + tablename + " loaded");
            notificationService.addInfoMessage("Table " + tablename + " loaded");
        } catch (Exception e) {
            notificationService.addErrorMessage("Error: " + e.getMessage());
        }
        return "redirect:/sessione/mostradataset/" + idsessione;
    }
}
