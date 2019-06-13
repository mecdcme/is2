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
package it.istat.is2.workflow.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.app.bean.AssociazioneVarFormBean;
import it.istat.is2.app.dao.SqlGenericDao;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.app.util.Utility;
import it.istat.is2.dataset.dao.DatasetColonnaDao;
import it.istat.is2.dataset.domain.DatasetColonna;
import it.istat.is2.workflow.dao.BusinessProcessDao;
import it.istat.is2.workflow.dao.RuoloDao;
import it.istat.is2.workflow.dao.StepVariableDao;
import it.istat.is2.workflow.dao.SxBusinessStepDao;
import it.istat.is2.workflow.dao.SxParPatternDao;
import it.istat.is2.workflow.dao.SxStepInstanceDao;
import it.istat.is2.workflow.dao.SxTipoCampoDao;
import it.istat.is2.workflow.dao.WorkSetDao;
import it.istat.is2.workflow.dao.WorkflowDao;
import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.SXTipoCampo;
import it.istat.is2.workflow.domain.SxBusinessFunction;
import it.istat.is2.workflow.domain.SxBusinessProcess;
import it.istat.is2.workflow.domain.SxBusinessStep;
import it.istat.is2.workflow.domain.SxParPattern;
import it.istat.is2.workflow.domain.SxRuoli;
import it.istat.is2.workflow.domain.SxStepInstance;
import it.istat.is2.workflow.domain.SxStepPattern;
import it.istat.is2.workflow.domain.SxStepVariable;
import it.istat.is2.workflow.domain.SxTipoIO;
import it.istat.is2.workflow.domain.SxTipoVar;
import it.istat.is2.workflow.domain.SxWorkset;
import it.istat.is2.workflow.engine.EngineFactory;
import it.istat.is2.workflow.engine.EngineService;
import it.istat.is2.worksession.dao.WorkSessionDao;
import it.istat.is2.worksession.domain.WorkSession;

@Service
public class WorkflowService {

    @Autowired
    WorkSessionDao sessioneDao;
    @Autowired
    WorkflowDao elaborazioneDao;
    @Autowired
    WorkSetDao workSetDao;
    @Autowired
    SxBusinessStepDao sxBusinessStepDao;
    @Autowired
    StepVariableDao stepVariableDao;
    @Autowired
    RuoloDao ruoloDao;
    @Autowired
    DatasetColonnaDao datasetColonnaDao;
    @Autowired
    BusinessProcessDao businessProcessDao;
    @Autowired
    SxStepInstanceDao sxStepInstanceDao;
    @Autowired
    SxParPatternDao sxParPatternDao;
    @Autowired
    SxTipoCampoDao sxTipoCampoDao;
    @Autowired
    SqlGenericDao sqlGenericDao;
    @Autowired
    EngineFactory engineFactory;

    public WorkSession findSessioneLavoro(Long id) {
        return sessioneDao.findById(id).get();
    }

    public Elaborazione findElaborazione(Long id) {
        return elaborazioneDao.findById(id).get();
    }

    public void eliminaElaborazione(Long id) {
        elaborazioneDao.deleteById(id);
    }

    public String loadWorkSetValori(Long idelaborazione, Integer length, Integer start, Integer draw)
            throws JSONException {
        List<SxWorkset> dataList = workSetDao.findWorkSetDatasetColonnabyQuery(idelaborazione, start, start + length);
        Integer numRighe = 0;
        if (!dataList.isEmpty()) {
            numRighe = dataList.get(0).getValori().size();
        }

        JSONObject obj = new JSONObject();
        JSONArray data = new JSONArray();
        for (int i = 0; i < numRighe; i++) {
            JSONObject obji = new JSONObject();
            for (int j = 0; j < dataList.size(); j++) {
                obji.put(dataList.get(j).getNome(), dataList.get(j).getValori().get(i));
            }
            data.put(obji);
        }

        obj.put("data", data);
        obj.put("draw", draw);
        obj.put("recordsTotal", numRighe);
        obj.put("recordsFiltered", numRighe);

        return obj.toString();
    }

    public String loadWorkSetValoriByElaborazione(Long idelaborazione, Integer tipoCampo, Integer length, Integer start,
            Integer draw, HashMap<String, String> paramsFilter) throws JSONException {

        List<SxWorkset> dataList = sqlGenericDao.findWorkSetDatasetColonnaByElaborazioneQuery(idelaborazione, tipoCampo,
                start, start + length, paramsFilter);
        // start, start + length, query_filter);
        Integer numRighe = 0;
        Integer valoriSize = 0;
        if (!dataList.isEmpty()) {
            numRighe = dataList.get(0).getValori().size();
            valoriSize = dataList.get(0).getValoriSize();
        }
        JSONObject obj = new JSONObject();
        JSONArray data = new JSONArray();
        for (int i = 0; i < numRighe; i++) {
            JSONObject obji = new JSONObject();
            for (int j = 0; j < dataList.size(); j++) {
                obji.put(dataList.get(j).getNome(), dataList.get(j).getValori().get(i));
            }
            data.put(obji);
        }

        obj.put("data", data);
        obj.put("draw", draw);
        obj.put("recordsTotal", valoriSize);
        obj.put("recordsFiltered", valoriSize);

        return obj.toString();
    }

    public List<SxWorkset> loadWorkSetValoriByElaborazione(Long idelaborazione, Integer tipoCampo,
            HashMap<String, String> paramsFilter) {
        List<SxWorkset> dataList = sqlGenericDao.findWorkSetDatasetColonnaByElaborazioneQuery(idelaborazione, tipoCampo,
                0, null, paramsFilter);

        return dataList;
    }

    public Map<String, List<String>> loadWorkSetValoriByElaborazioneMap(Long idelaborazione) {
        Map<String, List<String>> ret = new LinkedHashMap<>();
        Elaborazione el = findElaborazione(idelaborazione);
        for (Iterator<?> iterator = el.getSxStepVariables().iterator(); iterator.hasNext();) {
            SxStepVariable sxStepVariable = (SxStepVariable) iterator.next();
            if (sxStepVariable.getSxWorkset().getSxTipoVar().getNome().equals("VAR")) {
                ret.put(sxStepVariable.getSxWorkset().getNome(), sxStepVariable.getSxWorkset().getValori());
            }
        }

        return ret;
    }

    public Elaborazione doStep(Elaborazione elaborazione, SxStepInstance stepInstance) throws Exception {

        EngineService engine = engineFactory.getEngine(stepInstance.getSxAppService().getInterfaccia());
        try {

            engine.init(elaborazione, stepInstance);

            engine.doAction();
            engine.processOutput();

        } catch (Exception e) {
            Logger.getRootLogger().debug(e.getMessage());

            throw (e);
        } finally {
            engine.destroy();
        }

        return elaborazione;
    }

    /*
	 * public Elaborazione doStep_old(Elaborazione elaborazione, SxStepInstance
	 * stepInstance) throws Exception {
	 * 
	 * // SxBusinessStep sxBusinessStep = sxBusinessStepDao.findOne(idStep);
	 * 
	 * // SxStepInstance stepInstance =sxStepInstanceDao.findOne(idStepInstance);
	 * List<SxStepVariable> dataList =
	 * stepVariableDao.findByElaborazione(elaborazione); // mappa delle colonne
	 * workset <nome campo, oggetto stepv> Map<String, SxStepVariable> dataMap =
	 * Utility.getMapNameWorkSetStep(dataList); // mappa delle colonne workset <nome
	 * campo, oggetto stepv> Map<String, ArrayList<SxStepVariable>>
	 * dataRuoliStepVarMap = Utility.getMapCodiceRuoloStepVariabili(dataList);
	 * List<SxRuoli> ruoliAll = ruoloDao.findAll(); Map<String, SxRuoli> ruoliAllMap
	 * = Utility.getMapRuoliByCod(ruoliAll); // mappa delle colonne workset
	 * <nome,lista valori> HashMap<String, ArrayList<String>> worksetVariabili =
	 * Utility.getMapWorkSetValues(dataMap, new
	 * SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE)); // PARAMETRI HashMap<String,
	 * ArrayList<String>> parametriMap = Utility.getMapWorkSetValues(dataMap, new
	 * SxTipoVar(IS2Const.WORKSET_TIPO_PARAMETRO)); HashMap<String,
	 * ArrayList<String>> modelloMap = Utility.getMapWorkSetValues(dataMap, new
	 * SxTipoVar(IS2Const.WORKSET_TIPO_MODELLO)); HashMap<String, ArrayList<String>>
	 * worksetOut = new HashMap<>();
	 * 
	 * // REcupero dei ruoli di INPUT e OUTUPT e dalle istanze
	 * 
	 * 
	 * 
	 * 
	 * 
	 * // {S=[S], X=[X], Y=[Y], Z=[Z]} HashMap<String, ArrayList<String>>
	 * ruoliInputStep = new HashMap<>(); // {P=[P], M=[M], O=[O]} HashMap<String,
	 * ArrayList<String>> ruoliOutputStep = new HashMap<>();
	 * 
	 * for (Iterator<?> iterator = stepInstance.getSxStepPatterns().iterator();
	 * iterator.hasNext();) { SxStepPattern sxStepPattern = (SxStepPattern)
	 * iterator.next(); if (sxStepPattern.getTipoIO().getId().intValue() ==
	 * IS2Const.VARIABILE_TIPO_INPUT) { ArrayList<String> listv =
	 * ruoliInputStep.get(sxStepPattern.getSxRuoli().getCod()); if (listv == null) {
	 * listv = new ArrayList<>(); } listv.add(sxStepPattern.getSxRuoli().getCod());
	 * ruoliInputStep.put(sxStepPattern.getSxRuoli().getCod(), listv); } else if
	 * (sxStepPattern.getTipoIO().getId().intValue() ==
	 * IS2Const.VARIABILE_TIPO_OUTPUT) { ArrayList<String> listv =
	 * ruoliOutputStep.get(sxStepPattern.getSxRuoli().getCod()); if (listv == null)
	 * { listv = new ArrayList<>(); }
	 * listv.add(sxStepPattern.getSxRuoli().getCod());
	 * ruoliOutputStep.put(sxStepPattern.getSxRuoli().getCod(), listv); } } //
	 * associo il codice ruolo alla variabile // codiceRuolo, lista nome variabili
	 * {X=[X1], Y=[Y1]} HashMap<String, ArrayList<String>> ruoliVariabileNome = new
	 * HashMap<>(); HashMap<String, ArrayList<String>> parametriOutput = new
	 * HashMap<>();
	 * 
	 * for (Map.Entry<String, ArrayList<SxStepVariable>> entry :
	 * dataRuoliStepVarMap.entrySet()) { String codR = entry.getKey();
	 * ArrayList<SxStepVariable> listSVariable = entry.getValue(); for
	 * (Iterator<SxStepVariable> iterator = listSVariable.iterator();
	 * iterator.hasNext();) { SxStepVariable sxStepVariable = (SxStepVariable)
	 * iterator.next(); ArrayList<String> listv = ruoliVariabileNome.get(codR); if
	 * (listv == null) { listv = new ArrayList<>(); }
	 * listv.add(sxStepVariable.getSxWorkset().getNome());
	 * ruoliVariabileNome.put(codR, listv); } }
	 * 
	 * 
	 * EngineService engine =
	 * engineFactory.getEngine(stepInstance.getSxAppService().getInterfaccia()); try
	 * { engine.init(); engine.bindInputColumns(worksetVariabili,
	 * EngineR.SELEMIX_WORKSET); engine.bindInputParams(parametriMap);
	 * engine.bindInputParams(modelloMap); engine.setRuoli(ruoliVariabileNome);
	 * engine.eseguiStringaIstruzione(stepInstance.getFname(), ruoliVariabileNome);
	 * engine.getGenericoOutput(worksetOut, EngineR.SELEMIX_RESULTSET,
	 * EngineR.SELEMIX_RESULT_OUTPUT); engine.getGenericoOutput(ruoliOutputStep,
	 * EngineR.SELEMIX_RESULTSET, EngineR.SELEMIX_RESULT_RUOLI);
	 * engine.getGenericoOutput(parametriOutput, EngineR.SELEMIX_RESULTSET,
	 * EngineR.SELEMIX_RESULT_PARAM); engine.getGenericoOutput(parametriOutput,
	 * EngineR.SELEMIX_RESULTSET, EngineR.SELEMIX_RESULT_REPORT);
	 * 
	 * } catch (Exception e) {
	 * Logger.getRootLogger().debug("Dostep error: Something just exploded!");
	 * 
	 * throw (e); }finally { engine.closeConnection(); }
	 * 
	 * 
	 * HashMap<String, String> ruoliOutputStepInversa = new HashMap<>(); for
	 * (Map.Entry<String, ArrayList<String>> entry : ruoliOutputStep.entrySet()) {
	 * String nomeR = entry.getKey(); ArrayList<String> value = entry.getValue();
	 * value.forEach((nomevar) -> ruoliOutputStepInversa.put(nomevar, nomeR)); }
	 * 
	 * // salva output su DB for (Map.Entry<String, ArrayList<String>> entry :
	 * worksetOut.entrySet()) { String nomeW = entry.getKey(); ArrayList<String>
	 * value = entry.getValue(); SxStepVariable sxStepVariable;
	 * 
	 * if (dataMap.keySet().contains(nomeW)) { sxStepVariable = dataMap.get(nomeW);
	 * sxStepVariable.getSxWorkset().setValori(value);
	 * sxStepVariable.setTipoCampo(new SXTipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));
	 * } else { sxStepVariable = new SxStepVariable();
	 * sxStepVariable.setElaborazione(elaborazione); sxStepVariable.setTipoCampo(new
	 * SXTipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));
	 * 
	 * String ruolo = ruoliOutputStepInversa.get(nomeW); if (ruolo == null) { ruolo
	 * = EngineR.SELEMIX_RUOLO_SKIP_N; } SxRuoli sxRuolo = ruoliAllMap.get(ruolo);
	 * sxStepVariable.setSxRuoli(sxRuolo);
	 * sxStepVariable.setOrdine(sxRuolo.getOrdine()); SxWorkset sxWorkset = new
	 * SxWorkset(); sxWorkset.setNome(nomeW.replaceAll("\\.", "_"));
	 * sxWorkset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
	 * ArrayList<SxStepVariable> l = new ArrayList<>(); l.add(sxStepVariable);
	 * sxWorkset.setSxStepVariables(l); sxWorkset.setValori(value);
	 * sxWorkset.setValoriSize(sxWorkset.getValori().size());
	 * sxStepVariable.setSxWorkset(sxWorkset); }
	 * 
	 * stepVariableDao.save(sxStepVariable); }
	 * 
	 * for (Map.Entry<String, ArrayList<String>> entry : parametriOutput.entrySet())
	 * { String nomeW = entry.getKey(); ArrayList<String> value = entry.getValue();
	 * SxStepVariable sxStepVariable;
	 * 
	 * if (dataMap.keySet().contains(nomeW)) { sxStepVariable = dataMap.get(nomeW);
	 * sxStepVariable.getSxWorkset().setValori(value);
	 * sxStepVariable.setTipoCampo(new SXTipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));
	 * 
	 * } else { sxStepVariable = new SxStepVariable();
	 * sxStepVariable.setElaborazione(elaborazione); sxStepVariable.setTipoCampo(new
	 * SXTipoCampo(IS2Const.TIPO_CAMPO_ELABORATO)); String ruolo =
	 * ruoliOutputStepInversa.get(nomeW); if (ruolo == null) { ruolo =
	 * EngineR.SELEMIX_RUOLO_SKIP_N; } SxRuoli sxRuolo = ruoliAllMap.get(ruolo);
	 * sxStepVariable.setSxRuoli(sxRuolo);
	 * sxStepVariable.setOrdine(sxRuolo.getOrdine()); SxWorkset sxWorkset = new
	 * SxWorkset(); sxWorkset.setNome(nomeW.replaceAll("\\.", "_"));
	 * sxWorkset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_PARAMETRO));
	 * ArrayList<SxStepVariable> l = new ArrayList<>(); l.add(sxStepVariable);
	 * sxWorkset.setSxStepVariables(l); sxWorkset.setValori(value);
	 * sxWorkset.setValoriSize(sxWorkset.getValori().size());
	 * sxStepVariable.setSxWorkset(sxWorkset); }
	 * 
	 * stepVariableDao.save(sxStepVariable); }
	 * 
	 * return elaborazione; }
     */
    public List<SxStepVariable> getSxStepVariables(Long idelaborazione) {

        return stepVariableDao.findByElaborazione(new Elaborazione(idelaborazione));
    }

    public void creaAssociazioni(AssociazioneVarFormBean form, Elaborazione elaborazione) {

        List<SxRuoli> ruoliAll = ruoloDao.findAll();
        Map<Long, SxRuoli> ruoliAllMap = Utility.getMapRuoliById(ruoliAll);
        List<SxStepVariable> listaVar = elaborazione.getSxStepVariables();
        SxWorkset sxWorkset = null;

        for (int i = 0; i < form.getElaborazione().length; i++) {
            SxStepVariable sxStepVariable = new SxStepVariable();
            sxStepVariable.setElaborazione(elaborazione);
            String idr = form.getRuolo()[i];
            String nomeVar = form.getValore()[i];
            SxRuoli sxruolo = ruoliAllMap.get(new Long(idr));
            sxWorkset = null;
            for (int y = 0; y < listaVar.size(); y++) {
                if (listaVar.get(y).getSxWorkset() != null && nomeVar.equals(listaVar.get(y).getSxWorkset().getNome())
                        && sxruolo.getId().equals(listaVar.get(y).getSxRuoli().getId())) {
                    sxWorkset = listaVar.get(y).getSxWorkset();
                }
            }

            if (sxWorkset == null) {
                sxWorkset = new SxWorkset();
                DatasetColonna dscolonna = datasetColonnaDao.findById((Long.parseLong(form.getVariabile()[i]))).get();
                ;
                sxWorkset.setNome(
                        dscolonna.getDatasetFile().getLabelFile() + "_" + dscolonna.getNome().replaceAll("\\.", "_"));
                sxWorkset.setValori(dscolonna.getDatiColonna());
                sxWorkset.setValoriSize(sxWorkset.getValori().size());
            }

            sxStepVariable.setSxRuoli(sxruolo);
            sxStepVariable.setOrdine(sxruolo.getOrdine());
            sxStepVariable.setTipoCampo(new SXTipoCampo(IS2Const.TIPO_CAMPO_INPUT));
            sxWorkset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
            ArrayList<SxStepVariable> listaStepV = new ArrayList<>();
            listaStepV.add(sxStepVariable);
            sxWorkset.setSxStepVariables(listaStepV);
            sxStepVariable.setSxWorkset(sxWorkset);

            stepVariableDao.save(sxStepVariable);
        }
    }

    public void updateAssociazione(AssociazioneVarFormBean form, Elaborazione elaborazione) {

        List<SxRuoli> ruoliAll = ruoloDao.findAll();
        Map<Long, SxRuoli> ruoliAllMap = Utility.getMapRuoliById(ruoliAll);
        List<SxStepVariable> listaVar = elaborazione.getSxStepVariables();
        SxWorkset sxWorkset = null;
        Long idVar = Long.parseLong(form.getVariabile()[0]);
        SxStepVariable sxStepVariable = stepVariableDao.findById(idVar).get();
        String idr = form.getRuolo()[0];
        String nomeVar = form.getValore()[0];
        String nomeOld = form.getValoreOld();
        Short flagRicerca = Short.parseShort(form.getFlagRicerca());
        SxRuoli sxruolo = ruoliAllMap.get(new Long(idr));
        sxWorkset = null;

        for (int y = 0; y < listaVar.size(); y++) {
            if (listaVar.get(y).getSxWorkset() != null && nomeOld.equals(listaVar.get(y).getSxWorkset().getNome())) {
                sxWorkset = listaVar.get(y).getSxWorkset();
            }
        }

        if (sxWorkset == null) {
            sxWorkset = new SxWorkset();
            DatasetColonna dscolonna = datasetColonnaDao.findById((Long.parseLong(form.getVariabile()[0])))
                    .orElse(new DatasetColonna());
            sxWorkset.setNome(dscolonna.getNome().replaceAll("\\.", "_"));
            sxWorkset.setValori(dscolonna.getDatiColonna());
            sxWorkset.setValoriSize(sxWorkset.getValori().size());
        }

        sxWorkset.setNome(nomeVar);
        sxStepVariable.setFlagRicerca(flagRicerca);
        sxStepVariable.setSxRuoli(sxruolo);
        sxStepVariable.setOrdine(sxruolo.getOrdine());
        sxStepVariable.setTipoCampo(new SXTipoCampo(IS2Const.TIPO_CAMPO_INPUT));
        sxWorkset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
        ArrayList<SxStepVariable> listaStepV = new ArrayList<>();
        listaStepV.add(sxStepVariable);
        sxWorkset.setSxStepVariables(listaStepV);
        sxStepVariable.setSxWorkset(sxWorkset);

        stepVariableDao.save(sxStepVariable);
    }

    public Elaborazione doBusinessProc(Elaborazione elaborazione, Long idBProc) throws Exception {
        SxBusinessProcess sxBusinessProcess = businessProcessDao.findById(idBProc).orElse(new SxBusinessProcess());
        for (Iterator<?> iterator = sxBusinessProcess.getSxBusinessSteps().iterator(); iterator.hasNext();) {
            SxBusinessStep businessStep = (SxBusinessStep) iterator.next();
            for (Iterator<?> iteratorStep = businessStep.getSxStepInstances().iterator(); iteratorStep.hasNext();) {
                SxStepInstance sxStepInstance = (SxStepInstance) iteratorStep.next();
                elaborazione = doStep(elaborazione, sxStepInstance);
            }
        }
        return elaborazione;
    }

    public List<SxStepVariable> getSxStepVariablesNoValori(Long idelaborazione, SxTipoVar sxTipoVar) {
        return stepVariableDao.findByElaborazioneNoValori(new Elaborazione(idelaborazione), sxTipoVar);
    }

    public List<SxStepVariable> getSxStepVariablesTipoCampoNoValori(Long idelaborazione, SxTipoVar sxTipoVar,
            SXTipoCampo sxTipoCampo) {
        return stepVariableDao.findByElaborazioneTipoCampoNoValori(new Elaborazione(idelaborazione), sxTipoVar,
                sxTipoCampo);
    }

    public void associaParametri(AssociazioneVarFormBean form, Elaborazione elaborazione) {

        List<SxRuoli> ruoliAll = ruoloDao.findAll();
        Map<Long, SxRuoli> ruoliAllMap = Utility.getMapRuoliById(ruoliAll);




		for (int i = 0; i < form.getElaborazione().length; i++) {
			String[] all_parametri = form.getParametri();
			String parametri = all_parametri[i];
		//	String[] stringTokenizer = parametri.split("|");
			StringTokenizer stringTokenizer = new StringTokenizer(parametri, "|");
			 
			SxRuoli sxruolo = null;
			String idparam = null;
			String nomeparam = null;
			String ruoloparam = null;
			SxWorkset sxWorkset = new SxWorkset();
				
			while (stringTokenizer.hasMoreTokens()) {
			// ordine: nomeParam, idParam, ruolo
			nomeparam = stringTokenizer.nextToken(); 
			idparam = stringTokenizer.nextToken(); 
			ruoloparam =stringTokenizer.nextToken(); 
		}
			sxruolo = ruoliAllMap.get(new Long(ruoloparam));
			SxStepVariable sxStepVariable = new SxStepVariable();
			sxStepVariable.setElaborazione(elaborazione);
			sxStepVariable.setSxRuoli(sxruolo);
			sxWorkset.setNome(nomeparam);
			sxStepVariable.setOrdine(sxruolo.getOrdine());
			sxStepVariable.setTipoCampo(new SXTipoCampo(IS2Const.TIPO_CAMPO_INPUT));
			String valori = form.getValore()[i];
			String[] values = valori.split(" ");
			sxWorkset.setValori(Arrays.asList(values));
			sxWorkset.setValoriSize(values.length);
			sxWorkset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_PARAMETRO));


            stepVariableDao.save(sxStepVariable);
        }
    }

    public void updateParametri(AssociazioneVarFormBean form, Elaborazione elaborazione) {

        List<SxRuoli> ruoliAll = ruoloDao.findAll();
        Map<Long, SxRuoli> ruoliAllMap = Utility.getMapRuoliById(ruoliAll);

        for (int i = 0; i < form.getElaborazione().length; i++) {
            String[] all_parametri = form.getParametri();
            String parametri = all_parametri[i];
            String[] stringTokenizer = parametri.split("|");
            SxRuoli sxruolo = null;
            String nomeparam = null;
            String idparam = null;
            String ruoloparam = null;
            SxWorkset sxWorkset = new SxWorkset();
            // ordine: nomeParam, idParam, ruolo
            nomeparam = stringTokenizer[0];
            idparam = stringTokenizer[1];
            ruoloparam = stringTokenizer[2];

            String idStepVar = form.getIdStepVar();
            sxruolo = ruoliAllMap.get(new Long(ruoloparam));
            SxStepVariable sxStepVariable = new SxStepVariable();
            Long idstep = Long.parseLong(idStepVar);
            sxStepVariable = stepVariableDao.findById(idstep).get();
            sxStepVariable.setElaborazione(elaborazione);
            sxStepVariable.setSxRuoli(sxruolo);
            sxWorkset.setNome(nomeparam);
            sxStepVariable.setOrdine(sxruolo.getOrdine());
            sxStepVariable.setTipoCampo(new SXTipoCampo(IS2Const.TIPO_CAMPO_INPUT));
            String valori = form.getValore()[i];
            String[] values = valori.split(" ");
            sxWorkset.setValori(Arrays.asList(values));
            sxWorkset.setValoriSize(values.length);
            sxWorkset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_PARAMETRO));

            ArrayList<SxStepVariable> listaStepV = new ArrayList<>();
            listaStepV.add(sxStepVariable);
            sxWorkset.setSxStepVariables(listaStepV);
            sxStepVariable.setSxWorkset(sxWorkset);

            stepVariableDao.save(sxStepVariable);
        }
    }

    public List<SxStepVariable> getSxStepVariablesParametri(Long idElaborazione) {
        return stepVariableDao.findSxStepVariablesParametri(new Elaborazione(idElaborazione),
                new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
    }

    public List<SxRuoli> findRuoliByFunction(SxBusinessFunction businessFunction, int num) {
        List<SxRuoli> ret = new ArrayList<>();
        List<SxRuoli> ret2 = new ArrayList<>();
        List<SxStepInstance> instanceBF = findAllSxStepInstanceByFunction(businessFunction,
                IS2Const.CODICE_APP_SERVICE_R);
        SxRuoli sxruoli = new SxRuoli();

        for (Iterator<SxStepInstance> iterator = instanceBF.iterator(); iterator.hasNext();) {
            SxStepInstance sxStepInstance = (SxStepInstance) iterator.next();
            List<SxStepPattern> sxsetpppList = sxStepInstance.getSxStepPatterns();
            for (Iterator<SxStepPattern> iterator2 = sxsetpppList.iterator(); iterator2.hasNext();) {
                SxStepPattern sxStepPattern = (SxStepPattern) iterator2.next();
                if (num == 0) {
                    if ((sxStepPattern.getTipoIO().getId().intValue() == IS2Const.VARIABILE_TIPO_INPUT && sxStepPattern
                            .getSxRuoli().getSxTipoVar().getId().intValue() == IS2Const.WORKSET_TIPO_VARIABILE)) {
                        ret.add(sxStepPattern.getSxRuoli());
                    }

                } else {
                    if ((sxStepPattern.getTipoIO().getId().intValue() == IS2Const.VARIABILE_TIPO_INPUT && sxStepPattern
                            .getSxRuoli().getSxTipoVar().getId().intValue() == IS2Const.WORKSET_TIPO_VARIABILE)
                            || (sxStepPattern.getTipoIO().getId().intValue() == IS2Const.VARIABILE_TIPO_OUTPUT
                            && sxStepPattern.getSxRuoli().getSxTipoVar().getId()
                                    .intValue() == IS2Const.WORKSET_TIPO_VARIABILE)) {
                        ret.add(sxStepPattern.getSxRuoli());
                    }
                }

            }
        }
        // Rimuovo i ruoli duplicati nel caso si disponga di più variabili per processo
        for (int i = 0; i < ret.size(); i++) {
            sxruoli = ret.get(i);
            if (!ret2.contains(sxruoli)) {
                ret2.add(sxruoli);
            }
        }
        Long skip = new Long(0);
        SxRuoli ruoloSkip = ruoloDao.findById(skip).get();
        ret2.add(ruoloSkip);

        return ret2;
    }

    private List<SxStepInstance> findAllSxStepInstanceByFunction(SxBusinessFunction businessFunction,
            int codiceAppServiceR) {
        return sxStepInstanceDao.findAllSxStepInstanceByFunction(businessFunction);
    }

    public List<SxParPattern> findParametriByFunction(SxBusinessFunction businessFunction) {

        List<SxParPattern> ret = new ArrayList<>();
        List<SxStepInstance> instanceBF = findAllSxStepInstanceByFunction(businessFunction,
                IS2Const.CODICE_APP_SERVICE_R);
        for (Iterator<SxStepInstance> iterator = instanceBF.iterator(); iterator.hasNext();) {
            SxStepInstance sxStepInstance = (SxStepInstance) iterator.next();
            List<SxParPattern> sxsetpppList = sxParPatternDao.findAllSxParPatternByStepAndTypeIOVar(sxStepInstance,
                    new SxTipoIO(new Integer(IS2Const.VARIABILE_TIPO_INPUT)),
                    new SxTipoVar(new Integer(IS2Const.WORKSET_TIPO_VARIABILE))); // INPUT 1; 1 PARAMETRO
            ret.addAll(sxsetpppList);
        }
        return ret;
    }

    public boolean deleteWorkset(SxWorkset workset) {
        workSetDao.deleteById(workset.getId());
        return true;
    }

    /**
     * @param tipoCampo
     * @return
     */
    public SXTipoCampo getTipoCampoById(Integer tipoCampo) {
        // TODO Auto-generated method stub
        return sxTipoCampoDao.findById(tipoCampo).get();
    }
}
