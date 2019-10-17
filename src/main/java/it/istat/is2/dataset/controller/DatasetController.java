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
package it.istat.is2.dataset.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import it.istat.is2.app.bean.InputFormBean;
import it.istat.is2.app.bean.SessionBean;
import it.istat.is2.app.domain.Log;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.service.LogService;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.FileHandler;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.dataset.domain.DatasetColonna;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.dataset.domain.TipoVariabileSum;
import it.istat.is2.dataset.service.DatasetService;
import it.istat.is2.workflow.domain.TipoDato;
import it.istat.is2.workflow.service.TipoDatoService;
import it.istat.is2.worksession.domain.WorkSession;
import it.istat.is2.worksession.service.WorkSessionService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;

@Controller
public class DatasetController {

    @Autowired
    private DatasetService datasetService;
    @Autowired
    ServletContext context;
    @Autowired
    private NotificationService notificationService;
    @Autowired
    private MessageSource messages;
    @Autowired
    private WorkSessionService sessioneLavoroService;
    @Autowired
    private TipoDatoService tipoDatoService;
    @Autowired
    private LogService logService;

    @RequestMapping("/viewDataset/{idfile}")
    public String caricafile(HttpSession session, Model model, @PathVariable("idfile") Long idfile) {

        notificationService.removeAllMessages();

        DatasetFile dfile = datasetService.findDataSetFile(idfile);
        List<DatasetColonna> colonne = datasetService.findAllNomeColonne(idfile);
        List<TipoVariabileSum> variabiliSum = datasetService.findAllVariabiliSum();
        Integer numRighe = dfile.getNumerorighe();
        
        SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
        List<DatasetFile> files = null;
        if (sessionBean != null) {
            files = datasetService.findDatasetFilesByIdSessioneLavoro(sessionBean.getId());
        }
        
        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idfile);
        model.addAttribute("variabili", variabiliSum);
        model.addAttribute("dfile", dfile);
        model.addAttribute("numRighe", numRighe.toString());
        model.addAttribute("files", files);
        
        return "dataset/preview";
    }

    @RequestMapping("/metadatiDataset/{idfile}")
    public String caricaMetadati(Model model, @PathVariable("idfile") Long idfile) {

        DatasetFile dfile = datasetService.findDataSetFile(idfile);

        List<DatasetColonna> colonne = datasetService.findAllNomeColonne(idfile);
        List<TipoVariabileSum> variabiliSum = datasetService.findAllVariabiliSum();

        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idfile);
        model.addAttribute("variabili", variabiliSum);
        model.addAttribute("dfile", dfile);

        return "dataset/metadata";
    }

    @GetMapping(value = "/sessione/mostradataset/{id}")
    public String mostradataset(HttpSession session, Model model, @PathVariable("id") Long id) {

        List<Log> logs = logService.findByIdSessione(id);

        WorkSession sessionelv = sessioneLavoroService.getSessione(id);
        if (sessionelv.getDatasetFiles() != null) {
            session.setAttribute(IS2Const.SESSION_DATASET, true);
        }

        List<DatasetFile> listaDataset = sessionelv.getDatasetFiles();
        List<TipoDato> listaTipoDato = tipoDatoService.findListTipoDato();

        String etichetta = null;
        if(listaDataset!=null && listaDataset.size()>0) {
        	etichetta = "DS" + Integer.toString( listaDataset.size()+1 );
        }else {
        	etichetta = "DS1";
        }
        
        model.addAttribute("listaTipoDato", listaTipoDato);
        model.addAttribute("listaDataset", listaDataset);
        model.addAttribute("logs", logs);
        model.addAttribute("etichetta", etichetta);
        return "dataset/list";
    }

    @RequestMapping(value = "/associaVarSum", method = RequestMethod.POST)
    public String caricaMetadati(Model model, String idfile, String idvar, String filtro, String idsum) {

        DatasetFile dfile = datasetService.findDataSetFile(new Long(idfile));
        DatasetColonna dcol = datasetService.findOneColonna(Long.parseLong(idvar));
        TipoVariabileSum sum = new TipoVariabileSum(Integer.parseInt(idsum));

        dcol.setTipoVariabile(sum);
        dcol.setFiltro(new Short(filtro));
        try {
            datasetService.salvaColonna(dcol);
            notificationService.addInfoMessage(messages.getMessage("generic.save.success", null, LocaleContextHolder.getLocale()));
       } catch (Exception e) {
            notificationService.addErrorMessage("Errore: ", e.getMessage());

        }

        List<DatasetColonna> colonne = datasetService.findAllNomeColonne(Long.parseLong(idfile));
        List<TipoVariabileSum> variabiliSum = datasetService.findAllVariabiliSum();

        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idfile);
        model.addAttribute("dfile", dfile);
        model.addAttribute("variabili", variabiliSum);

        return "dataset/metadata";
    }

    @RequestMapping(value = "/loadInputData", method = RequestMethod.POST)
    public String loadInputData(HttpSession session, HttpServletRequest request, Model model,
            @AuthenticationPrincipal User user, @ModelAttribute("inputFormBean") InputFormBean form) throws IOException {

        notificationService.removeAllMessages();

        String labelFile = form.getLabelFile();
        Integer tipoDato = form.getTipoDato();
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
            campiL = FileHandler.getArrayListFromCsv2(pathTmpFile, form.getNumeroCampi(), separatore.toCharArray()[0], valoriHeaderNum);
        } catch (Exception e) {
            notificationService.addErrorMessage(
                    messages.getMessage("file.read.error", null, LocaleContextHolder.getLocale()), e.getMessage());
        }

        try {
            datasetService.salva(campiL, valoriHeaderNum, labelFile, tipoDato, separatore, form.getDescrizione(), idsessione);
            logService.save("File " + labelFile + " salvato con successo");
            notificationService.addInfoMessage(messages.getMessage("generic.save.success", null, LocaleContextHolder.getLocale()));
            SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
            sessionBean.getFile().add(form.getDescrizione());
            session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);
        } catch (Exception e) {
            notificationService.addErrorMessage("Errore nel salvataggio del file.");
            return "redirect:/sessione/mostradataset/" + idsessione;
        }

        return "redirect:/sessione/mostradataset/" + idsessione;
    }

    @RequestMapping("/createField/{idfile}/{idColonna}/{commandField}/{charOrString}/{upperLower}/{newField}/{columnOrder}/{numRows}")
    public String createField(Model model, @PathVariable("idfile") String idfile,
            @PathVariable("idColonna") String idColonna, @PathVariable("commandField") String commandField,
            @PathVariable("charOrString") String charOrString, @PathVariable("upperLower") String upperLower,
            @PathVariable("newField") String newField, @PathVariable("columnOrder") String columnOrder,
            @PathVariable("numRows") String numRows) {

        DatasetFile dFile = datasetService.createField(idfile, idColonna, commandField, charOrString, upperLower,
                newField, columnOrder, numRows);

        List<DatasetColonna> colonne = datasetService.findAllNomeColonne(Long.parseLong(idfile));
        List<TipoVariabileSum> variabiliSum = datasetService.findAllVariabiliSum();

        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idfile);
        model.addAttribute("variabili", variabiliSum);
        model.addAttribute("dfile", dFile);
        model.addAttribute("numRighe", numRows);

        return "dataset/preview";
    }

    @RequestMapping("/createMergedField/{idfile}/{columnOrder}/{numRows}/{fieldsToMerge}/{newField}")
    public String createMergedField(Model model, @PathVariable("idfile") String idfile,
            @PathVariable("columnOrder") String columnOrder, @PathVariable("numRows") String numRows,
            @PathVariable("fieldsToMerge") String fieldsToMerge, @PathVariable("newField") String newField) {

        DatasetFile dFile = datasetService.createMergedField(idfile, columnOrder, numRows, fieldsToMerge, newField);

        List<DatasetColonna> colonne = datasetService.findAllNomeColonne(Long.parseLong(idfile));
        List<TipoVariabileSum> variabiliSum = datasetService.findAllVariabiliSum();

        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idfile);
        model.addAttribute("variabili", variabiliSum);
        model.addAttribute("dfile", dFile);
        model.addAttribute("numRighe", numRows);

        return "dataset/preview";
    }
    
    @RequestMapping("/createParsedFields/{idfile}/{idColonna}/{columnOrder}/{numRows}/{executeCommand}/{commandValue}/{startTo}/{newField1}/{newField2}")
	public String createParsedFields(Model model, @PathVariable("idfile") String idfile, @PathVariable("idColonna") String idColonna,
			@PathVariable("columnOrder") String columnOrder, @PathVariable("numRows") String numRows,
			@PathVariable("executeCommand") String executeCommand, @PathVariable("commandValue") String commandValue, @PathVariable("startTo") String startTo,  @PathVariable("newField1") String newField1 , @PathVariable("newField2") String newField2) {

		DatasetFile dFile = datasetService.createParsedFields(idfile, idColonna, columnOrder, numRows, executeCommand, commandValue, startTo, newField1, newField2);

		List<DatasetColonna> colonne = datasetService.findAllNomeColonne(Long.parseLong(idfile));
		List<TipoVariabileSum> variabiliSum = datasetService.findAllVariabiliSum();

		model.addAttribute("colonne", colonne);
		model.addAttribute("idfile", idfile);
		model.addAttribute("variabili", variabiliSum);
		model.addAttribute("dfile", dFile);
		model.addAttribute("numRighe", numRows);

		return "dataset/preview";
	}
	
	
	@RequestMapping("/deleteField/{idfile}/{idColonna}/{numCols}/{numRows}")
	public String deleteField(Model model, @PathVariable("idfile") String idfile, @PathVariable("idColonna") String idColonna,
			@PathVariable("numCols") String numCols, @PathVariable("numRows") String numRows) {

		DatasetFile dFile = datasetService.deleteField(idfile, idColonna);

		
		
		
		List<DatasetColonna> colonne = datasetService.findAllNomeColonne(Long.parseLong(idfile));
		

		model.addAttribute("colonne", colonne);
		model.addAttribute("idfile", idfile);
		model.addAttribute("dfile", dFile);
		model.addAttribute("numRighe", numRows);

		return "dataset/preview";
	}
	
	
	
	
	@RequestMapping(value = "/repairField", method = RequestMethod.POST)
	public String loadRepairField(Model model, @RequestParam("fileCSV") MultipartFile[] fileCSV, @RequestParam("idDataset") String idDataset, @RequestParam("idColonna") String idColonna , @RequestParam("numRighe") String numRighe,
			@RequestParam("numColonne") String numColonne,  @RequestParam("fieldName") String fieldName,  @RequestParam("separatore") String separatore) throws IOException {

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
			campiL = FileHandler.getArrayListFromCsv2(pathTmpFile, 2, separatore.toCharArray()[0],
					valoriHeaderNum);
		} catch (Exception e) {
			notificationService.addErrorMessage(
					messages.getMessage("file.read.error", null, LocaleContextHolder.getLocale()), e.getMessage());
		}
		
		
		
		DatasetFile dFile = datasetService.createFixedField(idDataset, idColonna, valoriHeaderNum, campiL,
				fieldName, numColonne, numRighe);
		
		List<DatasetColonna> colonne = datasetService.findAllNomeColonne(Long.parseLong(idDataset));

		model.addAttribute("colonne", colonne);
		model.addAttribute("idfile", idDataset);
		model.addAttribute("dfile", dFile);
		model.addAttribute("numRighe", numRighe);


		return "dataset/preview";
	}
	

    @GetMapping(value = "/deleteDataset/{datasetid}")
    public String deleteDataset(HttpSession session, Model model, @AuthenticationPrincipal User user,
            @PathVariable("datasetid") Long idDataset) {

        notificationService.removeAllMessages();

        WorkSession sessionelv = sessioneLavoroService.getSessioneByIdFile(idDataset);
        datasetService.deleteDataset(idDataset);
        logService.save("File " + idDataset + " eliminato con successo");
        notificationService.addInfoMessage("Eliminazione avvenuta con successo");

      //  SessionBean sessionBean = (SessionBean) session.getAttribute(IS2Const.SESSION_BEAN);
      //  sessionBean.getFile().remove(0);
      //  session.setAttribute(IS2Const.SESSION_BEAN, sessionBean);

        return "redirect:/sessione/mostradataset/" + sessionelv.getId();
    }
    
    @RequestMapping(value = "/dataset/loadtable", method = RequestMethod.POST)
	public String loadDatasetFromTable(HttpSession session, HttpServletRequest request, Model model,
			@ModelAttribute("idsessione") String idsessione, @RequestParam("dbschema") String dbschema,
			@RequestParam("tablename") String tablename, @RequestParam("fields") String[] fields)
			throws IOException {
		notificationService.removeAllMessages();
		try {
			datasetService.loadDatasetFromTable(idsessione,dbschema,tablename,fields);
			logService.save("Table " + tablename + " loaded");
			notificationService.addInfoMessage("Table " + tablename + " loaded");
		} catch (Exception e) {
			notificationService.addErrorMessage("Error: "+e.getMessage() );
		}
		return "redirect:/sessione/mostradataset/" + idsessione;
	}
}
