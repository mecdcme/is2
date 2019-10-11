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
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import javax.transaction.Transactional;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.app.bean.AssociazioneVarFormBean;
import it.istat.is2.app.bean.Ruolo;
import it.istat.is2.app.bean.Variable;
import it.istat.is2.app.dao.SqlGenericDao;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.app.util.Utility;
import it.istat.is2.dataset.dao.DatasetColonnaDao;
import it.istat.is2.dataset.domain.DatasetColonna;
import it.istat.is2.rule.domain.Rule;
import it.istat.is2.rule.domain.Ruleset;
import it.istat.is2.workflow.batch.WorkFlowBatchDao;
import it.istat.is2.workflow.dao.BusinessProcessDao;
import it.istat.is2.workflow.dao.ElaborazioneDao;
import it.istat.is2.workflow.dao.RulesetDao;
import it.istat.is2.workflow.dao.RuoloDao;
import it.istat.is2.workflow.dao.StepInstanceDao;
import it.istat.is2.workflow.dao.StepInstanceParameterDao;
import it.istat.is2.workflow.dao.StepVariableDao;
import it.istat.is2.workflow.dao.TipoCampoDao;
import it.istat.is2.workflow.dao.WorkSetDao;
import it.istat.is2.workflow.domain.AppRole;
import it.istat.is2.workflow.domain.BusinessProcess;
import it.istat.is2.workflow.domain.BusinessStep;
import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.StepInstance;
import it.istat.is2.workflow.domain.StepInstanceAppRole;
import it.istat.is2.workflow.domain.StepInstanceParameter;
import it.istat.is2.workflow.domain.StepVariable;
import it.istat.is2.workflow.domain.SxTipoVar;
import it.istat.is2.workflow.domain.TipoCampo;
import it.istat.is2.workflow.domain.TipoIO;
import it.istat.is2.workflow.domain.Workset;
import it.istat.is2.workflow.engine.EngineFactory;
import it.istat.is2.workflow.engine.EngineService;
import it.istat.is2.worksession.dao.WorkSessionDao;
import it.istat.is2.worksession.domain.WorkSession;

@Service
public class WorkflowService {

    @Autowired
    private WorkSessionDao sessioneDao;
    @Autowired
    private ElaborazioneDao elaborazioneDao;
    @Autowired
    private WorkSetDao workSetDao;
    @Autowired
    private StepVariableDao stepVariableDao;
    @Autowired
    private RuoloDao ruoloDao;
    @Autowired
    private RulesetDao rulesetDao;
    @Autowired
    private DatasetColonnaDao datasetColonnaDao;
    @Autowired
    private BusinessProcessDao businessProcessDao;
    @Autowired
    private StepInstanceDao stepInstanceDao;
    @Autowired
    private StepInstanceParameterDao stepInstanceParameterDao;
    @Autowired
    TipoCampoDao sxTipoCampoDao;
    @Autowired
    private SqlGenericDao sqlGenericDao;
    @Autowired
    private EngineFactory engineFactory;
    @Autowired
    private WorkFlowBatchDao workFlowBatchDao;

    public WorkSession findSessioneLavoro(Long id) {
        return sessioneDao.findById(id).get();
    }

    public Elaborazione findElaborazione(Long id) {
        return elaborazioneDao.findById(id).get();
    }

    public void eliminaElaborazione(Long id) {
        elaborazioneDao.deleteById(id);
    }

    public String loadWorkSetValori(Long idelaborazione, Integer length, Integer start, Integer draw) throws JSONException {
        List<Workset> dataList = workSetDao.findWorkSetDatasetColonnabyQuery(idelaborazione, start, start + length);
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

    public String loadWorkSetValoriByElaborazione(Long idelaborazione, Integer tipoCampo, Integer groupRole,
            Integer length, Integer start, Integer draw, HashMap<String, String> paramsFilter) throws JSONException {

        List<Workset> dataList = sqlGenericDao.findWorkSetDatasetColonnaByElaborazioneQuery(idelaborazione, tipoCampo, groupRole, start, start + length, paramsFilter);
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

    public List<Workset> loadWorkSetValoriByElaborazione(Long idelaborazione, Integer tipoCampo, Integer groupRole,HashMap<String, String> paramsFilter) {
        List<Workset> dataList = sqlGenericDao.findWorkSetDatasetColonnaByElaborazioneQuery(idelaborazione, tipoCampo,groupRole, 0, null, paramsFilter);
        return dataList;
    }

    public Map<String, List<String>> loadWorkSetValoriByElaborazioneRoleGroupMap(Long idelaborazione,Integer groupRole) {
        Map<String, List<String>> ret = new LinkedHashMap<>();
        Elaborazione el = findElaborazione(idelaborazione);
        AppRole groupAppRole = new AppRole(groupRole);
        for (Iterator<?> iterator = el.getStepVariables().iterator(); iterator.hasNext();) {
            StepVariable stepVariable = (StepVariable) iterator.next();
            if (groupAppRole.equals(stepVariable.getSxRuoloGruppo())) {
                ret.put(stepVariable.getWorkset().getNome(), stepVariable.getWorkset().getValori());
            }
        }

        return ret;
    }

    public Elaborazione doStep(Elaborazione elaborazione, StepInstance stepInstance) throws Exception {
        EngineService engine = engineFactory.getEngine(stepInstance.getAppService().getInterfaccia());
        try {
            engine.init(elaborazione, stepInstance);
            engine.doAction();
            engine.processOutput();

        } catch (Exception e) {
            Logger.getRootLogger().error(e.getMessage());

            throw (e);
        } finally {
            engine.destroy();
        }

        return elaborazione;
    }

    public List<StepVariable> getStepVariables(Long idelaborazione) {
        return stepVariableDao.findByElaborazione(new Elaborazione(idelaborazione));
    }

    public void creaAssociazioni(AssociazioneVarFormBean form, Elaborazione elaborazione) {

        List<AppRole> ruoliAll = ruoloDao.findAll();
        Map<Integer, AppRole> ruoliAllMap = Utility.getMapRuoliById(ruoliAll);
        List<StepVariable> listaVar = elaborazione.getStepVariables();
        Workset workset = null;

        for (int i = 0; i < form.getElaborazione().length; i++) {
            StepVariable stepVariable = new StepVariable();
            stepVariable.setElaborazione(elaborazione);
            String idr = form.getRuolo()[i];
            String nomeVar = form.getValore()[i];
            AppRole sxruolo = ruoliAllMap.get(new Integer(idr));
            workset = null;
            for (int y = 0; y < listaVar.size(); y++) {
                if (listaVar.get(y).getWorkset() != null && nomeVar.equals(listaVar.get(y).getWorkset().getNome())
                        && sxruolo.getId().equals(listaVar.get(y).getAppRole().getId())) {
                    workset = listaVar.get(y).getWorkset();
                }
            }

            if (workset == null) {
                workset = new Workset();
                DatasetColonna dscolonna = datasetColonnaDao.findById((Long.parseLong(form.getVariabile()[i]))).get();
                workset.setNome(dscolonna.getDatasetFile().getLabelFile() + "_" + dscolonna.getNome().replaceAll("\\.", "_"));
                workset.setValori(dscolonna.getDatiColonna());
                workset.setValoriSize(workset.getValori().size());
            }

            stepVariable.setAppRole(sxruolo);
            stepVariable.setOrdine(sxruolo.getOrdine());
            stepVariable.setTipoCampo(new TipoCampo(IS2Const.TIPO_CAMPO_INPUT));
            workset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
            ArrayList<StepVariable> listaStepV = new ArrayList<>();
            listaStepV.add(stepVariable);
            workset.setStepVariables(listaStepV);
            stepVariable.setWorkset(workset);

            stepVariableDao.save(stepVariable);
        }
    }

    public void updateAssociazione(AssociazioneVarFormBean form, Elaborazione elaborazione) {

        List<AppRole> ruoliAll = ruoloDao.findAll();
        Map<Integer, AppRole> ruoliAllMap = Utility.getMapRuoliById(ruoliAll);
        List<StepVariable> listaVar = elaborazione.getStepVariables();
        Workset workset = null;
        Integer idVar = Integer.parseInt(form.getVariabile()[0]);
        StepVariable stepVariable = stepVariableDao.findById(idVar).get();
        String idr = form.getRuolo()[0];
        String nomeVar = form.getValore()[0];
        String nomeOld = form.getValoreOld();
        Short flagRicerca = Short.parseShort(form.getFlagRicerca());
        AppRole sxruolo = ruoliAllMap.get(new Integer(idr));
        workset = null;

        for (int y = 0; y < listaVar.size(); y++) {
            if (listaVar.get(y).getWorkset() != null && nomeOld.equals(listaVar.get(y).getWorkset().getNome())) {
                workset = listaVar.get(y).getWorkset();
            }
        }

        if (workset == null) {
            workset = new Workset();
            DatasetColonna dscolonna = datasetColonnaDao.findById((Long.parseLong(form.getVariabile()[0]))).orElse(new DatasetColonna());
            workset.setNome(dscolonna.getNome().replaceAll("\\.", "_"));
            workset.setValori(dscolonna.getDatiColonna());
            workset.setValoriSize(workset.getValori().size());
        }

        workset.setNome(nomeVar);
        stepVariable.setFlagRicerca(flagRicerca);
        stepVariable.setAppRole(sxruolo);
        ArrayList<StepVariable> listaStepV = new ArrayList<>();
        listaStepV.add(stepVariable);
        workset.setStepVariables(listaStepV);
        stepVariable.setWorkset(workset);

        stepVariableDao.save(stepVariable);
    }

    public Elaborazione doBusinessProc(Elaborazione elaborazione, Long idBProc) throws Exception {
        BusinessProcess businessProcess = businessProcessDao.findById(idBProc).orElse(new BusinessProcess());
        for (Iterator<?> iterator = businessProcess.getBusinessSteps().iterator(); iterator.hasNext();) {
            BusinessStep businessStep = (BusinessStep) iterator.next();
            for (Iterator<?> iteratorStep = businessStep.getStepInstances().iterator(); iteratorStep.hasNext();) {
                StepInstance stepInstance = (StepInstance) iteratorStep.next();
                elaborazione = doStep(elaborazione, stepInstance);
            }
        }
        return elaborazione;
    }

    public List<StepVariable> getStepVariablesNoValori(Long idelaborazione, SxTipoVar sxTipoVar) {
        return stepVariableDao.findByElaborazioneNoValori(new Elaborazione(idelaborazione), sxTipoVar);
    }

    public List<StepVariable> getStepVariablesTipoCampoNoValori(Long idelaborazione, SxTipoVar sxTipoVar,
            TipoCampo sxTipoCampo, AppRole sxRuoli) {
        return stepVariableDao.findByElaborazioneTipoCampoNoValori(new Elaborazione(idelaborazione), sxTipoVar,
                sxTipoCampo, sxRuoli);
    }

    public void associaParametri(AssociazioneVarFormBean form, Elaborazione elaborazione) {

        List<AppRole> ruoliAll = ruoloDao.findAll();
        Map<Integer, AppRole> ruoliAllMap = Utility.getMapRuoliById(ruoliAll);

        for (int i = 0; i < form.getElaborazione().length; i++) {
            String[] all_parametri = form.getParametri();
            String parametri = all_parametri[i];
            // String[] stringTokenizer = parametri.split("|");
            StringTokenizer stringTokenizer = new StringTokenizer(parametri, "|");

            AppRole sxruolo = null;
            String idparam = null;
            String nomeparam = null;
            String ruoloparam = null;

            while (stringTokenizer.hasMoreTokens()) {
                // ordine: nomeParam, idParam, ruolo
                nomeparam = stringTokenizer.nextToken();
                idparam = stringTokenizer.nextToken();
                ruoloparam = stringTokenizer.nextToken();
            }
            sxruolo = ruoliAllMap.get(new Integer(ruoloparam));
            StepVariable stepVariable = new StepVariable();
            stepVariable.setElaborazione(elaborazione);
            stepVariable.setAppRole(sxruolo);
            Workset workset = new Workset();
            workset.setNome(nomeparam);
            stepVariable.setOrdine(sxruolo.getOrdine());
            stepVariable.setTipoCampo(new TipoCampo(IS2Const.TIPO_CAMPO_INPUT));
            String valori = form.getValore()[i];
            // String[] values = valori.split(" ");
            workset.setValori(Arrays.asList("1"));
            workset.setParamValue(valori);
            workset.setValoriSize(1);
            workset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_PARAMETRO));

            ArrayList<StepVariable> listaStepV = new ArrayList<>();
            listaStepV.add(stepVariable);
            workset.setStepVariables(listaStepV);
            stepVariable.setWorkset(workset);
            stepVariableDao.save(stepVariable);
        }
    }

    public void updateParametri(AssociazioneVarFormBean form, Elaborazione elaborazione) {
        for (int i = 0; i < form.getElaborazione().length; i++) {
            String[] all_parametri = form.getParametri();
            String idWorkset = all_parametri[i];

            Workset workset = workSetDao.findById(new Long(idWorkset)).get();
            String valori = form.getValore()[i];
            workset.setParamValue(valori);
            workSetDao.save(workset);
        }
    }

    public List<StepVariable> getStepVariablesParametri(Long idElaborazione) {
        return stepVariableDao.findStepVariables(new Elaborazione(idElaborazione),
                new SxTipoVar(IS2Const.WORKSET_TIPO_PARAMETRO));
    }

    public List<StepVariable> getStepVariablesRuleset(Long idElaborazione) {
        return stepVariableDao.findStepVariables(new Elaborazione(idElaborazione),
                new SxTipoVar(IS2Const.WORKSET_TIPO_RULESET));
    }

    public List<AppRole> findRuoliByProcess(BusinessProcess businessProcess, int flagIO, SxTipoVar sxTipoVar) {
        List<AppRole> ret = new ArrayList<>();
        List<AppRole> ret2 = new ArrayList<>();
        List<StepInstance> instanceBF = findAllStepInstanceByProcess(businessProcess);
        AppRole sxruoli = new AppRole();

        for (Iterator<StepInstance> iterator = instanceBF.iterator(); iterator.hasNext();) {
            StepInstance stepInstance = (StepInstance) iterator.next();
            List<StepInstanceAppRole> sxsetpppList = stepInstance.getSxStepPatterns();
            for (Iterator<StepInstanceAppRole> iterator2 = sxsetpppList.iterator(); iterator2.hasNext();) {
                StepInstanceAppRole sxStepPattern = (StepInstanceAppRole) iterator2.next();
                if (flagIO == 0) {// flagIO All
                    if ((sxStepPattern.getTipoIO().getId().intValue() == IS2Const.VARIABILE_TIPO_INPUT && sxStepPattern
                            .getAppRole().getSxTipoVar().equals(sxTipoVar))) {
                        ret.add(sxStepPattern.getAppRole());
                    }

                } else {
                    if ((sxStepPattern.getTipoIO().getId().intValue() == IS2Const.VARIABILE_TIPO_INPUT && sxStepPattern
                            .getAppRole().getSxTipoVar().getId().intValue() == IS2Const.WORKSET_TIPO_VARIABILE)
                            || (sxStepPattern.getTipoIO().getId().intValue() == IS2Const.VARIABILE_TIPO_OUTPUT
                            && sxStepPattern.getAppRole().getSxTipoVar().equals(sxTipoVar))) {
                        ret.add(sxStepPattern.getAppRole());
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

        return ret2;
    }

    private List<StepInstance> findAllStepInstanceByProcess(BusinessProcess businessProcess) {
        return stepInstanceDao.findAllStepInstanceByProcess(businessProcess);
    }

    private List<StepInstance> findAllStepInstanceBySubBProcess(BusinessProcess subBusinessProcess) {
        return stepInstanceDao.findAllStepInstanceBySubBProcess(subBusinessProcess);
    }

    public List<StepInstanceParameter> findParametriByProcess(BusinessProcess businessProcess) {

        List<StepInstanceParameter> ret = new ArrayList<>();
        List<StepInstance> instanceBF = findAllStepInstanceByProcess(businessProcess);
        for (Iterator<StepInstance> iterator = instanceBF.iterator(); iterator.hasNext();) {
            StepInstance stepInstance = (StepInstance) iterator.next();
            List<StepInstanceParameter> sxsetpppList = stepInstanceParameterDao.findAllSxParPatternByStepAndTypeIOVar(
                    stepInstance, new TipoIO(new Integer(IS2Const.VARIABILE_TIPO_INPUT)),
                    new SxTipoVar(new Integer(IS2Const.WORKSET_TIPO_PARAMETRO))); // INPUT 1; 1 PARAMETRO
            ret.addAll(sxsetpppList);
        }
        return ret;
    }

    public Map<Long, List<StepInstanceParameter>> findParametriAndSubProcessesByProcess(BusinessProcess businessProcess) {

        Map<Long, List<StepInstanceParameter>> ret = new HashMap<>();

        for (Iterator iteratorb = businessProcess.getBusinessSubProcesses().iterator(); iteratorb.hasNext();) {
            BusinessProcess suBusinessProcess = (BusinessProcess) iteratorb.next();

            List<StepInstanceParameter> paramsList = new ArrayList();
            List<StepInstance> instanceBF = findAllStepInstanceBySubBProcess(suBusinessProcess);

            for (Iterator<StepInstance> iterator = instanceBF.iterator(); iterator.hasNext();) {
                StepInstance stepInstance = (StepInstance) iterator.next();
                List<StepInstanceParameter> sxsetpppList = stepInstanceParameterDao
                        .findAllSxParPatternByStepAndTypeIOVar(stepInstance,
                                new TipoIO(new Integer(IS2Const.VARIABILE_TIPO_INPUT)),
                                new SxTipoVar(new Integer(IS2Const.WORKSET_TIPO_PARAMETRO))); // INPUT 1; 1 PARAMETRO
                paramsList.addAll(sxsetpppList);
            }
            ret.put(suBusinessProcess.getId(), paramsList);
        }

        return ret;
    }

    public boolean deleteWorkset(Workset workset) {
        Long aa = workset.getId();
        workSetDao.deleteById(aa);
        return true;
    }

    public TipoCampo getTipoCampoById(Integer tipoCampo) {
        return sxTipoCampoDao.findById(tipoCampo).get();
    }

    public List<AppRole> getOutputRoleGroupsStepVariables(Long idElaborazione, SxTipoVar sxTipoVar,TipoCampo sxTipoCampo) {
        return stepVariableDao.getOutputRoleGroupsStepVariables(idElaborazione, sxTipoVar, sxTipoCampo);
    }

    public HashMap<Long, List<String>> findMissingAppRoleySubProcessAndTipoVar(Elaborazione elaborazione, SxTipoVar sxTipoVar) {
        HashMap<Long, List<String>> ret = new HashMap<>();
        List<StepVariable> stepVariables = getStepVariablesNoValori(elaborazione.getId(), sxTipoVar);
        List<AppRole> stepVariablesRoles = new ArrayList<>();
        for (StepVariable stepVariable : stepVariables) {
            stepVariablesRoles.add(stepVariable.getAppRole());
        }

        for (Iterator iteratorb = elaborazione.getBusinessProcess().getBusinessSubProcesses().iterator(); iteratorb.hasNext();) {
            BusinessProcess suBusinessProcess = (BusinessProcess) iteratorb.next();

            Set<String> roleNameSet = new HashSet<String>();
            List<StepInstance> instanceBF = findAllStepInstanceBySubBProcess(suBusinessProcess);

            for (Iterator<StepInstance> iterator = instanceBF.iterator(); iterator.hasNext();) {
                StepInstance stepInstance = (StepInstance) iterator.next();

                for (Iterator<StepInstanceAppRole> iteratorAppRoles = stepInstance.getSxStepPatterns()
                        .iterator(); iteratorAppRoles.hasNext();) {
                    {
                        StepInstanceAppRole stepInstanceAppRole = iteratorAppRoles.next();
                        if (stepInstanceAppRole.getTipoIO().getId().equals(new Integer(IS2Const.TIPO_CAMPO_INPUT))
                                && stepInstanceAppRole.getIsRequerid()) {
                            AppRole ar = stepInstanceAppRole.getAppRole();
                            if (ar.getSxTipoVar().equals(sxTipoVar) && !stepVariablesRoles.contains(ar)) {
                                roleNameSet.add(ar.getNome());
                            }
                        }
                    }
                }

            }
            ret.put(suBusinessProcess.getId(), new ArrayList<>(roleNameSet));
        }

        return ret;
    }

    public HashMap<Long, List<String>> findMissingVariablesParamsBySubProcess(Elaborazione elaborazione) {
        return null;
    }

    public void creaAssociazionVarRole(Elaborazione elaborazione, Ruolo ruolo, Variable variable) {
        List<AppRole> ruoliAll = ruoloDao.findAll();
        Map<Integer, AppRole> ruoliAllMap = Utility.getMapRuoliById(ruoliAll);
        List<StepVariable> listaVar = elaborazione.getStepVariables();
        ArrayList<StepVariable> listaStepV = new ArrayList<>();
        DatasetColonna dscolonna = null;
        Workset workset = null;
        StepVariable sxStepVariable = new StepVariable();
        sxStepVariable.setElaborazione(elaborazione);
        AppRole appRole = ruoliAllMap.get((int) ruolo.getIdRole());

        for (int i = 0; i < listaVar.size(); i++) {
            if (listaVar.get(i).getWorkset() != null && variable.getName().equals(listaVar.get(i).getWorkset().getNome())
                    && appRole.getId().equals(listaVar.get(i).getAppRole().getId())) {
                workset = listaVar.get(i).getWorkset();
            }
        }

        if (workset == null) {
            workset = new Workset();
            dscolonna = datasetColonnaDao.findById(variable.getIdVar()).orElse(null);
            workset.setNome(dscolonna.getDatasetFile().getLabelFile() + "_" + dscolonna.getNome().replaceAll("\\.", "_"));
            workset.setValori(dscolonna.getDatiColonna());
            workset.setValoriSize(workset.getValori().size());
        }
        sxStepVariable.setAppRole(appRole);
        sxStepVariable.setOrdine(appRole.getOrdine());
        sxStepVariable.setTipoCampo(new TipoCampo(IS2Const.TIPO_CAMPO_INPUT));
        workset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
        listaStepV.add(sxStepVariable);
        workset.setStepVariables(listaStepV);
        sxStepVariable.setWorkset(workset);
        stepVariableDao.save(sxStepVariable);
    }

    @Transactional
    public void cleanAllWorkset(Long idelaborazione, Integer flagIO) {

        List<StepVariable> list = getStepVariables(idelaborazione);
        for (StepVariable step : list) {
            if (flagIO.equals(new Integer(0)) || step.getTipoCampo().getId().equals(flagIO)) {
                stepVariableDao.deleteById(step.getId());
            }
        }

        List<Long> jobInstanceIds = workFlowBatchDao.findJobInstanceIdByElabId(idelaborazione);
        if (jobInstanceIds != null && jobInstanceIds.size() > 0) {
            for (int i = 0; i < jobInstanceIds.size(); i++) {
                workFlowBatchDao.deleteJobInstanceById(jobInstanceIds.get(i));
            }
        }

    }

    public void setResultset(Elaborazione elaborazione, Integer idRuolo, Integer idResultset) {

        Ruleset ruleset = rulesetDao.findById(idResultset).get();

        StepVariable stepVariableID = new StepVariable();
        stepVariableID.setElaborazione(elaborazione);
        stepVariableID.setAppRole(new AppRole(idRuolo));
        stepVariableID.setOrdine(new Short("1"));
        stepVariableID.setTipoCampo(new TipoCampo(IS2Const.TIPO_CAMPO_INPUT));
        Workset worksetID = new Workset();
        worksetID.setNome("ID");
        worksetID.setParamValue(ruleset.getLabelFile());
        worksetID.setValori(Utility.convertToArrayListStringFieldOfObjects(ruleset.getRules(), Rule.class, "id"));
        worksetID.setValoriSize(ruleset.getRules().size());
        worksetID.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_RULESET));
        ArrayList<StepVariable> listaStepVID = new ArrayList<>();
        listaStepVID.add(stepVariableID);
        worksetID.setStepVariables(listaStepVID);
        stepVariableID.setWorkset(worksetID);
        stepVariableDao.save(stepVariableID);

        StepVariable stepVariable = new StepVariable();
        stepVariable.setElaborazione(elaborazione);
        stepVariable.setAppRole(new AppRole(idRuolo));
        stepVariable.setOrdine(new Short("2"));
        stepVariable.setTipoCampo(new TipoCampo(IS2Const.TIPO_CAMPO_INPUT));
        Workset workset = new Workset();
        workset.setNome(IS2Const.TEXT_RULE);
        workset.setParamValue(ruleset.getLabelFile());
        workset.setValori(Utility.convertToArrayListStringFieldOfObjects(ruleset.getRules(), Rule.class, "rule"));
        workset.setValoriSize(ruleset.getRules().size());
        workset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_RULESET));
        ArrayList<StepVariable> listaStepV = new ArrayList<>();
        listaStepV.add(stepVariable);
        workset.setStepVariables(listaStepV);
        stepVariable.setWorkset(workset);
        stepVariableDao.save(stepVariable);
    }

}
