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
package it.istat.is2.preprocessing.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.FileHandler;

import it.istat.is2.dataset.domain.DatasetColumn;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.dataset.domain.StatisticalVariableCls;

import it.istat.is2.dataset.service.DatasetService;
import it.istat.is2.preprocessing.service.PreprocessingService;

@Controller
public class PreprocessingController {
    @Autowired
    private PreprocessingService preprocessingService;
    @Autowired
    private DatasetService datasetService;
    @Autowired
    ServletContext context;
    @Autowired
    private NotificationService notificationService;
    @Autowired
    private MessageSource messages;

    @GetMapping("/createField/{idfile}/{idColonna}/{commandField}/{charOrString}/{upperLower}/{newField}/{columnOrder}/{numRows}")
    public String createField(Model model, @PathVariable("idfile") String idfile,
                              @PathVariable("idColonna") String idColonna, @PathVariable("commandField") String commandField,
                              @PathVariable("charOrString") String charOrString, @PathVariable("upperLower") String upperLower,
                              @PathVariable("newField") String newField, @PathVariable("columnOrder") String columnOrder,
                              @PathVariable("numRows") String numRows) {

        DatasetFile dFile = preprocessingService.createField(idfile, idColonna, commandField, charOrString, upperLower,
                newField, columnOrder, numRows);

        List<DatasetColumn> colonne = datasetService.findAllNameColum(Long.parseLong(idfile));
        List<StatisticalVariableCls> variabiliSum = datasetService.findAllVariabiliSum();

        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idfile);
        model.addAttribute("variabili", variabiliSum);
        model.addAttribute("dfile", dFile);
        model.addAttribute("numRighe", numRows);

        return "dataset/preview";
    }

    @GetMapping("/createMergedField/{idfile}/{columnOrder}/{numRows}/{fieldsToMerge}/{newField}")
    public String createMergedField(Model model, @PathVariable("idfile") String idfile,
                                    @PathVariable("columnOrder") String columnOrder, @PathVariable("numRows") String numRows,
                                    @PathVariable("fieldsToMerge") String fieldsToMerge, @PathVariable("newField") String newField) {

        DatasetFile dFile = preprocessingService.createMergedField(idfile, columnOrder, numRows, fieldsToMerge,
                newField);

        List<DatasetColumn> colonne = datasetService.findAllNameColum(Long.parseLong(idfile));
        List<StatisticalVariableCls> variabiliSum = datasetService.findAllVariabiliSum();

        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idfile);
        model.addAttribute("variabili", variabiliSum);
        model.addAttribute("dfile", dFile);
        model.addAttribute("numRighe", numRows);

        return "dataset/preview";
    }

    @GetMapping("/createParsedFields/{idfile}/{idColonna}/{columnOrder}/{numRows}/{executeCommand}/{commandValue}/{startTo}/{newField1}/{newField2}")
    public String createParsedFields(Model model, @PathVariable("idfile") String idfile,
                                     @PathVariable("idColonna") String idColonna, @PathVariable("columnOrder") String columnOrder,
                                     @PathVariable("numRows") String numRows, @PathVariable("executeCommand") String executeCommand,
                                     @PathVariable("commandValue") String commandValue, @PathVariable("startTo") String startTo,
                                     @PathVariable("newField1") String newField1, @PathVariable("newField2") String newField2) {

        DatasetFile dFile = preprocessingService.createParsedFields(idfile, idColonna, columnOrder, numRows,
                executeCommand, commandValue, startTo, newField1, newField2);

        List<DatasetColumn> colonne = datasetService.findAllNameColum(Long.parseLong(idfile));
        List<StatisticalVariableCls> variabiliSum = datasetService.findAllVariabiliSum();

        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idfile);
        model.addAttribute("variabili", variabiliSum);
        model.addAttribute("dfile", dFile);
        model.addAttribute("numRighe", numRows);

        return "dataset/preview";
    }

    @GetMapping("/deleteField/{idfile}/{idColonna}/{numCols}/{numRows}")
    public String deleteField(Model model, @PathVariable("idfile") String idfile,
                              @PathVariable("idColonna") String idColonna, @PathVariable("numCols") String numCols,
                              @PathVariable("numRows") String numRows) {

        DatasetFile dFile = preprocessingService.deleteField(idfile, idColonna);

        List<DatasetColumn> colonne = datasetService.findAllNameColum(Long.parseLong(idfile));

        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idfile);
        model.addAttribute("dfile", dFile);
        model.addAttribute("numRighe", numRows);

        return "dataset/preview";
    }

    @PostMapping(value = "/repairField")
    public String loadRepairField(Model model, @RequestParam("fileCSV") MultipartFile[] fileCSV,
                                  @RequestParam("idDataset") String idDataset, @RequestParam("idColonna") String idColonna,
                                  @RequestParam("numRighe") String numRighe, @RequestParam("numColonne") String numColonne,
                                  @RequestParam("fieldName") String fieldName, @RequestParam("separatore") String separatore)
            throws IOException {

        notificationService.removeAllMessages();

        File f = FileHandler.convertMultipartFileToFile(fileCSV[0]);

        String pathTmpFile = f.getAbsolutePath().replace("\\", "/");
        HashMap<Integer, String> valoriHeaderNum = null;
        try {
            valoriHeaderNum = FileHandler.getCampiHeaderNumIndex(pathTmpFile, separatore.toCharArray()[0]);
        } catch (Exception e) {
            notificationService.addErrorMessage(
                    messages.getMessage("file.read.error", null, LocaleContextHolder.getLocale()), e.getMessage());
        }

        HashMap<String, ArrayList<String>> campiL = null;
        try {
            campiL = FileHandler.getArrayListFromCsv2(pathTmpFile, 2, separatore.toCharArray()[0], valoriHeaderNum);
        } catch (Exception e) {
            notificationService.addErrorMessage(
                    messages.getMessage("file.read.error", null, LocaleContextHolder.getLocale()), e.getMessage());
        }

        DatasetFile dFile = preprocessingService.createFixedField(idDataset, idColonna, valoriHeaderNum, campiL,
                fieldName, numColonne, numRighe);

        List<DatasetColumn> colonne = datasetService.findAllNameColum(Long.parseLong(idDataset));

        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idDataset);
        model.addAttribute("dfile", dFile);
        model.addAttribute("numRighe", numRighe);

        return "dataset/preview";
    }

}
