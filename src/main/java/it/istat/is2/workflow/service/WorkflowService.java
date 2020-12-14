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
package it.istat.is2.workflow.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.app.bean.AssociazioneVarRoleBean;
import it.istat.is2.app.bean.MappingVarsFormBean;
import it.istat.is2.app.bean.Ruolo;
import it.istat.is2.app.bean.Variable;
import it.istat.is2.app.dao.SqlGenericDao;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.app.util.Utility;
import it.istat.is2.dataset.dao.DatasetColumnDao;
import it.istat.is2.dataset.domain.DatasetColumn;
import it.istat.is2.rule.domain.Rule;
import it.istat.is2.rule.domain.Ruleset;
import it.istat.is2.workflow.batch.WorkFlowBatchDao;
import it.istat.is2.workflow.dao.AppRoleDao;
import it.istat.is2.workflow.dao.DataProcessingDao;
import it.istat.is2.workflow.dao.DataTypeDao;
import it.istat.is2.workflow.dao.RulesetDao;
import it.istat.is2.workflow.dao.StepInstanceDao;
import it.istat.is2.workflow.dao.StepInstanceSignatureDao;
import it.istat.is2.workflow.dao.StepRuntimeDao;
import it.istat.is2.workflow.dao.TypeIODao;
import it.istat.is2.workflow.dao.WorkSetDao;
import it.istat.is2.workflow.domain.AppRole;
import it.istat.is2.workflow.domain.BusinessProcess;
import it.istat.is2.workflow.domain.DataProcessing;
import it.istat.is2.workflow.domain.DataTypeCls;
import it.istat.is2.workflow.domain.StepInstance;
import it.istat.is2.workflow.domain.StepInstanceSignature;
import it.istat.is2.workflow.domain.StepRuntime;
import it.istat.is2.workflow.domain.TypeIO;
import it.istat.is2.workflow.domain.Workset;
import it.istat.is2.workflow.engine.EngineFactory;
import it.istat.is2.workflow.engine.EngineService;
import it.istat.is2.worksession.dao.WorkSessionDao;
import it.istat.is2.worksession.domain.WorkSession;

@Service
public class WorkflowService {

    private static Logger LOG = LoggerFactory.getLogger(WorkflowService.class);

    private final String PATTERNNAME = "\\.|\\s";
    @Autowired
    private WorkSessionDao workSessionDao;
    @Autowired
    private DataProcessingDao dataProcessingDao;
    @Autowired
    private WorkSetDao workSetDao;
    @Autowired
    private StepRuntimeDao stepRuntimeDao;
    @Autowired
    private AppRoleDao appRoleDao;
    @Autowired
    private RulesetDao rulesetDao;
    @Autowired
    private DatasetColumnDao datasetColumnDao;
    @Autowired
    private StepInstanceDao stepInstanceDao;
    @Autowired
    private StepInstanceSignatureDao stepInstanceSignatureDao;
    @Autowired
    private DataTypeDao dataTypeDao;
    @Autowired
    private TypeIODao typeIODao;
    @Autowired
    private SqlGenericDao sqlGenericDao;
    @Autowired
    private WorkFlowBatchDao workFlowBatchDao;

    @Autowired
    protected EntityManager em;

    @Autowired
    EngineFactory engineFactory;

    @Autowired
    private NotificationService notificationService;

    public WorkSession findWorkSession(Long id) {
        return workSessionDao.findById(id).orElse(null);
    }

    public DataProcessing findDataProcessing(Long id) {
        return dataProcessingDao.findById(id).orElse(null);
    }

    public void eliminaDataProcessing(Long id) {
        dataProcessingDao.deleteById(id);
    }

    public String loadWorkSetValues(Long idDataProcessing, Integer length, Integer start, Integer draw)
            throws JSONException {
        List<Workset> dataList = workSetDao.findWorkSetDatasetColonnabyQuery(idDataProcessing, start, start + length);
        Integer numRighe = 0;
        if (!dataList.isEmpty()) {
            numRighe = dataList.get(0).getContents().size();
        }

        JSONObject obj = new JSONObject();
        JSONArray data = new JSONArray();
        for (int i = 0; i < numRighe; i++) {
            JSONObject obji = new JSONObject();
            for (int j = 0; j < dataList.size(); j++) {
                obji.put(dataList.get(j).getName(), dataList.get(j).getContents().get(i));
            }
            data.put(obji);
        }

        obj.put("data", data);
        obj.put("draw", draw);
        obj.put("recordsTotal", numRighe);
        obj.put("recordsFiltered", numRighe);

        return obj.toString();
    }

    public String loadWorkSetValoriByDataProcessing(Long idDataProcessing, Integer typeIO, Integer groupRole,
                                                    Integer length, Integer start, Integer draw, Map<String, String> paramsFilter) {

        int offset = 2;
        List<Object[]> resulFieldstList = sqlGenericDao.findWorsetIdColAndName(idDataProcessing, typeIO, groupRole);
        List<Object[]> dataList = sqlGenericDao.findWorKSetDataViewParamsbyQuery(resulFieldstList, idDataProcessing,
                typeIO, groupRole, start, length, paramsFilter, null, null);

        Integer numRighe = 0;

        JSONObject obj = new JSONObject();
        JSONArray data = new JSONArray();
        if (dataList.size() > 0) {
            String rows = dataList.get(0)[resulFieldstList.size() + offset].toString();
            numRighe = Integer.valueOf(rows);
            for (Object[] row : dataList) {
                JSONObject obji = new JSONObject();
                for (int j = 0; j < resulFieldstList.size(); j++) {
                    obji.put((String) resulFieldstList.get(j)[1], row[j + offset]);
                }
                data.put(obji);
            }
        }
        obj.put("data", data);
        obj.put("draw", draw);
        obj.put("recordsTotal", numRighe);
        obj.put("recordsFiltered", numRighe);

        return obj.toString();
    }

    public Map<String, List<String>> loadWorkSetValoriByDataProcessingRoleGroupMap(Long idDataProcessing,
                                                                                   Long groupRole) {
        Map<String, List<String>> ret = new LinkedHashMap<>();
        DataProcessing el = findDataProcessing(idDataProcessing);
        AppRole groupAppRole = appRoleDao.findById(groupRole).orElse(null);
        if (groupAppRole != null) {
            for (Iterator<?> iterator = el.getStepRuntimes().iterator(); iterator.hasNext(); ) {
                StepRuntime stepRuntime = (StepRuntime) iterator.next();
                if (groupAppRole.equals(stepRuntime.getRoleGroup())) {
                    ret.put(stepRuntime.getWorkset().getName(), stepRuntime.getWorkset().getContents());
                }
            }
        }
        return ret;
    }

    public List<StepRuntime> getStepRuntimes(Long idDataProcessing) {
        return stepRuntimeDao.findByDataProcessing(new DataProcessing(idDataProcessing));
    }

    public void creaAssociazioni(MappingVarsFormBean form, DataProcessing dataProcessing) {

        List<AppRole> appRolesAll = appRoleDao.findAll();
        Map<Long, AppRole> appRolesAllMap = Utility.getMapRuoliById(appRolesAll);
        List<StepRuntime> varList = dataProcessing.getStepRuntimes();
        Workset workset = null;

        Session session = em.unwrap(Session.class);

        for (int i = 0; i < form.getDataProcessing().length; i++) {
            final StepRuntime stepRuntime = new StepRuntime();
            stepRuntime.setDataProcessing(dataProcessing);
            String idr = form.getRole()[i];
            String nomeVar = form.getValue()[i];
            AppRole sxruolo = appRolesAllMap.get(Long.valueOf(idr));
            workset = null;
            for (int y = 0; y < varList.size(); y++) {
                if (varList.get(y).getWorkset() != null && nomeVar.equals(varList.get(y).getWorkset().getName())
                        && sxruolo.getId().equals(varList.get(y).getAppRole().getId())) {
                    workset = varList.get(y).getWorkset();
                }
            }

            if (workset == null) {
                workset = new Workset();
                DatasetColumn dscolumn = datasetColumnDao.findById((Long.parseLong(form.getVariable()[i])))
                        .orElse(new DatasetColumn());
                workset.setName(dscolumn.getDatasetFile().getFileLabel() + "_"
                        + dscolumn.getName().replaceAll(PATTERNNAME, "_"));
                workset.setContents(dscolumn.getContents());
                workset.setContentSize(workset.getContents().size());
                workset.setDatasetColumnId(dscolumn.getId());
            }

            stepRuntime.setAppRole(sxruolo);
            stepRuntime.setRoleGroup(sxruolo);

            stepRuntime.setOrderCode(sxruolo.getOrder());
            stepRuntime.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_VARIABLE));
            workset.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_VARIABLE));
            stepRuntime.setTypeIO(new TypeIO(IS2Const.TYPE_IO_INPUT));
            ArrayList<StepRuntime> listaStepV = new ArrayList<>();
            listaStepV.add(stepRuntime);
            workset.setStepRuntimes(listaStepV);
            stepRuntime.setWorkset(workset);

            stepRuntimeDao.save(stepRuntime);
            session.flush();
            session.clear();
        }
    }

    public void updateAssociazione(MappingVarsFormBean form, DataProcessing dataProcessing) {

        List<AppRole> appRolesAll = appRoleDao.findAll();
        Map<Long, AppRole> appRolesAllMap = Utility.getMapRuoliById(appRolesAll);
        List<StepRuntime> varList = dataProcessing.getStepRuntimes();
        Workset workset = null;
        Integer idVar = Integer.parseInt(form.getVariable()[0]);
        StepRuntime stepRuntime = stepRuntimeDao.findById(idVar).orElse(new StepRuntime());
        String idr = form.getRole()[0];
        String nomeVar = form.getValue()[0];
        String nomeOld = form.getValueOld();
        AppRole sxruolo = appRolesAllMap.get(Long.valueOf(idr));

        for (int y = 0; y < varList.size(); y++) {
            if (varList.get(y).getWorkset() != null && nomeOld.equals(varList.get(y).getWorkset().getName())) {
                workset = varList.get(y).getWorkset();
            }
        }

        if (workset == null) {
            workset = new Workset();
            DatasetColumn dscolumn = datasetColumnDao.findById((Long.parseLong(form.getVariable()[0])))
                    .orElse(new DatasetColumn());
            workset.setName(dscolumn.getName().replaceAll(PATTERNNAME, "_"));
            workset.setContents(dscolumn.getContents());
            workset.setContentSize(workset.getContents().size());
            workset.setDatasetColumnId(dscolumn.getId());
        }

        workset.setName(nomeVar);
        stepRuntime.setAppRole(sxruolo);
        ArrayList<StepRuntime> listaStepV = new ArrayList<>();
        listaStepV.add(stepRuntime);
        workset.setStepRuntimes(listaStepV);
        stepRuntime.setWorkset(workset);

        stepRuntimeDao.save(stepRuntime);
    }

    public List<StepRuntime> getStepRuntimesNoValues(Long idDataProcessing, DataTypeCls dataType) {
        return stepRuntimeDao.findByDataProcessingNoValues(new DataProcessing(idDataProcessing), dataType);
    }

    public List<StepRuntime> getStepRuntimesDataTypeNoValues(Long idDataProcessing, DataTypeCls dataType, TypeIO typeIO,
                                                             AppRole appRole) {
        return stepRuntimeDao.findByDataProcessingStatusNoValues(new DataProcessing(idDataProcessing), dataType, typeIO,
                appRole);
    }

    public void associaParametri(MappingVarsFormBean form, DataProcessing dataProcessing) {

        List<AppRole> appRolesAll = appRoleDao.findAll();
        Map<Long, AppRole> appRolesAllMap = Utility.getMapRuoliById(appRolesAll);

        for (int i = 0; i < form.getDataProcessing().length; i++) {
            String[] allParametri = form.getParameters();
            String parametri = allParametri[i];
            StringTokenizer stringTokenizer = new StringTokenizer(parametri, "|");

            AppRole sxruolo = null;
            String nomeparam = "";
            String ruoloparam = null;
            String idparam = null;

            while (stringTokenizer.hasMoreTokens()) {
                // ordine: nomeParam, idParam, ruolo
                nomeparam = stringTokenizer.nextToken();
                idparam = stringTokenizer.nextToken();
                ruoloparam = stringTokenizer.nextToken();
            }
            sxruolo = appRolesAllMap.get(Long.valueOf(ruoloparam));
            StepRuntime stepRuntime = new StepRuntime();
            stepRuntime.setDataProcessing(dataProcessing);
            stepRuntime.setAppRole(sxruolo);
            stepRuntime.setRoleGroup(sxruolo);
            Workset workset = new Workset();
            workset.setName(nomeparam.replaceAll(PATTERNNAME, "_"));
            stepRuntime.setOrderCode(sxruolo.getOrder());
            stepRuntime.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_PARAMETER));
            stepRuntime.setTypeIO(new TypeIO(IS2Const.TYPE_IO_INPUT));
            String value = form.getValue()[i];

            workset.setParamValue(value);
            workset.setContentSize(1);
            workset.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_PARAMETER));

            ArrayList<StepRuntime> listaStepV = new ArrayList<>();
            listaStepV.add(stepRuntime);
            workset.setStepRuntimes(listaStepV);
            stepRuntime.setWorkset(workset);
            stepRuntimeDao.save(stepRuntime);
        }
    }

    public void updateParametri(MappingVarsFormBean form) {
        for (int i = 0; i < form.getDataProcessing().length; i++) {
            String[] allParametri = form.getParameters();
            String idWorkset = allParametri[i];

            Workset workset = workSetDao.findById(Long.valueOf(idWorkset)).orElse(new Workset());
            String value = form.getValue()[i];
            workset.setParamValue(value);
            workSetDao.save(workset);
        }
    }

    public List<StepRuntime> getStepRuntimeParameters(Long idDataProcessing) {
        return stepRuntimeDao.findStepRuntimes(new DataProcessing(idDataProcessing),
                new DataTypeCls(IS2Const.DATA_TYPE_PARAMETER));
    }

    public List<StepRuntime> getStepRuntimesRuleset(Long idDataProcessing) {
        return stepRuntimeDao.findStepRuntimes(new DataProcessing(idDataProcessing),
                new DataTypeCls(IS2Const.DATA_TYPE_RULESET));
    }

    public List<AppRole> findAppRolesByProcess(BusinessProcess businessProcess, int flagIO, DataTypeCls dataType) {
        List<AppRole> ret = new ArrayList<>();
        List<AppRole> ret2 = new ArrayList<>();
        List<StepInstance> instanceBF = findAllStepInstanceByProcess(businessProcess);
        AppRole sxappRoles = null;

        for (Iterator<StepInstance> iterator = instanceBF.iterator(); iterator.hasNext(); ) {
            StepInstance stepInstance = iterator.next();
            List<StepInstanceSignature> stepSignatures = stepInstance.getStepInstanceSignatures();
            for (Iterator<StepInstanceSignature> iterator2 = stepSignatures.iterator(); iterator2.hasNext(); ) {
                StepInstanceSignature stepSignature = iterator2.next();
                if (flagIO == 0) {// flagIO All
                    if ((stepSignature.getTypeIO().equals(new TypeIO(IS2Const.TYPE_IO_INPUT))
                            && stepSignature.getAppRole().getDataType().equals(dataType))) {
                        ret.add(stepSignature.getAppRole());
                    }

                } else {
                    if ((stepSignature.getTypeIO().equals(new TypeIO(IS2Const.TYPE_IO_INPUT)) && stepSignature
                            .getAppRole().getDataType().getId().intValue() == IS2Const.DATA_TYPE_VARIABLE)
                            || (stepSignature.getTypeIO().equals(new TypeIO(IS2Const.TYPE_IO_OUTPUT))
                            && stepSignature.getAppRole().getDataType().equals(dataType))) {
                        ret.add(stepSignature.getAppRole());
                    }
                }

            }
        }
        // Rimuovo i appRoles duplicati nel caso si disponga di più variabili per
        // processo

        for (int i = 0; i < ret.size(); i++) {
            sxappRoles = ret.get(i);
            if (!ret2.contains(sxappRoles)) {
                ret2.add(sxappRoles);
            }
        }
        Collections.sort(ret2);
        return ret2;
    }

    private List<StepInstance> findAllStepInstanceByProcess(BusinessProcess businessProcess) {
        return stepInstanceDao.findAllStepInstanceByProcess(businessProcess);
    }

    private List<StepInstance> findAllStepInstanceBySubBProcess(BusinessProcess subBusinessProcess) {
        return stepInstanceDao.findAllStepInstanceBySubBProcess(subBusinessProcess);
    }

    public List<StepInstanceSignature> findParametersByProcess(BusinessProcess businessProcess) {

        List<StepInstanceSignature> ret = new ArrayList<>();
        List<StepInstance> instanceBF = findAllStepInstanceByProcess(businessProcess);
        for (Iterator<StepInstance> iterator = instanceBF.iterator(); iterator.hasNext(); ) {
            StepInstance stepInstance = iterator.next();
            List<StepInstanceSignature> sxsetpppList = stepInstanceSignatureDao.findAllStepSignaturesByStepAndTypeIO(
                    stepInstance, new TypeIO(IS2Const.TYPE_IO_INPUT),
                    new DataTypeCls(Long.valueOf(IS2Const.DATA_TYPE_PARAMETER))); // INPUT 1; 1 PARAMETRO
            ret.addAll(sxsetpppList);
        }
        return ret;
    }

    public Map<Long, List<StepInstanceSignature>> findParametriAndSubProcessesByProcess(
            BusinessProcess businessProcess) {

        Map<Long, List<StepInstanceSignature>> ret = new HashMap<>();

        for (Iterator<BusinessProcess> iteratorb = businessProcess.getBusinessSubProcesses().iterator(); iteratorb
                .hasNext(); ) {
            BusinessProcess suBusinessProcess = iteratorb.next();

            List<StepInstanceSignature> paramsList = new ArrayList<>();
            List<StepInstance> instanceBF = findAllStepInstanceBySubBProcess(suBusinessProcess);

            for (Iterator<StepInstance> iterator = instanceBF.iterator(); iterator.hasNext(); ) {
                StepInstance stepInstance = iterator.next();
                List<StepInstanceSignature> sxsetpppList = stepInstanceSignatureDao
                        .findAllStepSignaturesByStepAndTypeIO(stepInstance, new TypeIO(IS2Const.TYPE_IO_INPUT),
                                new DataTypeCls(Long.valueOf(IS2Const.DATA_TYPE_PARAMETER))); // INPUT 1; 1 PARAMETER
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

    public DataTypeCls getDataTypeById(Long dataType) {
        return dataTypeDao.findById(dataType).orElse(null);
    }

    public TypeIO getTypeIOById(Integer typeIo) {
        return typeIODao.findById(typeIo).orElse(null);
    }

    public List<AppRole> getOutputRoleGroupsStepRuntimes(Long idDataProcessing, TypeIO typeIO, DataTypeCls dataType) {
        return stepRuntimeDao.getOutputRoleGroupsStepRuntimes(idDataProcessing, dataType, typeIO);
    }

    public Map<Long, List<String>> findMissingAppRoleySubProcessAndTipoVar(DataProcessing dataProcessing,
                                                                           DataTypeCls dataType) {
        Map<Long, List<String>> ret = new HashMap<>();
        List<StepRuntime> stepRuntimes = getStepRuntimesNoValues(dataProcessing.getId(), dataType);
        List<AppRole> stepRuntimesRoles = new ArrayList<>();
        for (StepRuntime stepRuntime : stepRuntimes) {
            stepRuntimesRoles.add(stepRuntime.getAppRole());
        }

        for (Iterator<BusinessProcess> iteratorb = dataProcessing.getBusinessProcess().getBusinessSubProcesses()
                .iterator(); iteratorb.hasNext(); ) {
            BusinessProcess suBusinessProcess = iteratorb.next();

            Set<String> roleNameSet = new HashSet<>();
            List<StepInstance> instanceBF = findAllStepInstanceBySubBProcess(suBusinessProcess);
            boolean firstStepInInstance = true;
            for (Iterator<StepInstance> iterator = instanceBF.iterator(); iterator.hasNext(); ) {
                StepInstance stepInstance = (StepInstance) iterator.next();

                for (Iterator<StepInstanceSignature> iteratorAppRoles = stepInstance.getStepInstanceSignatures()
                        .iterator(); iteratorAppRoles.hasNext(); ) {

                    StepInstanceSignature stepInstanceSignature = iteratorAppRoles.next();
                    if (stepInstanceSignature.getTypeIO().equals(new TypeIO(IS2Const.TYPE_IO_INPUT))
                            && stepInstanceSignature.getIsRequerid() && firstStepInInstance) {
                        AppRole ar = stepInstanceSignature.getAppRole();
                        if (ar.getDataType().equals(dataType) && !stepRuntimesRoles.contains(ar)) {
                            roleNameSet.add(ar.getName());
                        }
                    }
                }

                firstStepInInstance = false;
            }
            ret.put(suBusinessProcess.getId(), new ArrayList<>(roleNameSet));
        }

        return ret;
    }

    @Transactional
    public void creaAssociazionVarRole(DataProcessing dataProcessing,
                                       AssociazioneVarRoleBean[] associazioneVarRoleBean) {
        List<AppRole> appRolesAll = appRoleDao.findAll();
        Map<Long, AppRole> appRolesAllMap = Utility.getMapRuoliById(appRolesAll);
        List<StepRuntime> varList = dataProcessing.getStepRuntimes();

        for (AssociazioneVarRoleBean varRoleBean : associazioneVarRoleBean) {
            Ruolo ruolo = varRoleBean.getRuolo();
            boolean prefixDataset = varRoleBean.isPrefixDataset();
            for (Variable variable : ruolo.getVariables()) {

                ArrayList<StepRuntime> listaStepV = new ArrayList<>();
                DatasetColumn dscolumn = null;
                Workset workset = null;
                StepRuntime stepRuntime = new StepRuntime();
                stepRuntime.setDataProcessing(dataProcessing);
                AppRole appRole = appRolesAllMap.get(ruolo.getIdRole());

                for (int i = 0; i < varList.size(); i++) {
                    if (varList.get(i).getWorkset() != null
                            && variable.getName().equals(varList.get(i).getWorkset().getName())
                            && appRole.getId().equals(varList.get(i).getAppRole().getId())) {
                        workset = varList.get(i).getWorkset();
                    }
                }

                if (workset == null) {
                    workset = new Workset();
                    dscolumn = datasetColumnDao.findById(variable.getIdVar()).orElse(new DatasetColumn());
                    String nameWorkset = "";
                    if (prefixDataset)
                        nameWorkset = dscolumn.getDatasetFile().getFileLabel() + "_";
                    nameWorkset += dscolumn.getName().replaceAll(PATTERNNAME, "_");
                    workset.setName(nameWorkset);
                    workset.setContents(dscolumn.getContents());
                    workset.setContentSize(workset.getContents().size());
                    workset.setDatasetColumnId(dscolumn.getId());
                }
                stepRuntime.setAppRole(appRole);
                stepRuntime.setRoleGroup(appRole);
                stepRuntime.setOrderCode(appRole.getOrder());
                stepRuntime.setTypeIO(new TypeIO(IS2Const.TYPE_IO_INPUT));
                stepRuntime.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_VARIABLE));
                workset.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_VARIABLE));
                listaStepV.add(stepRuntime);
                workset.setStepRuntimes(listaStepV);
                stepRuntime.setWorkset(workset);
                stepRuntimeDao.save(stepRuntime);
            }
        }
    }

    @Transactional
    public void cleanAllWorkset(Long idDataProcessing, Short flagIO) {

        try {
            List<StepRuntime> list = getStepRuntimes(idDataProcessing);
            for (StepRuntime step : list) {
                if (flagIO.equals(Short.valueOf("0")) || step.getTypeIO().equals(new TypeIO(flagIO))) {
                    stepRuntimeDao.findById(step.getId()).ifPresent(sr -> {
                      
                        Workset workset = sr.getWorkset();
                        workset.getStepRuntimes().remove(sr);
                        stepRuntimeDao.delete(sr);
                        if (workset.getStepRuntimes().size() == 0)
                            workSetDao.delete(sr.getWorkset());
                        else
                            workSetDao.save(sr.getWorkset());

                     });

                }
            }

            workFlowBatchDao.findJobInstanceIdByElabId(idDataProcessing).forEach(jobInstance -> {
                workFlowBatchDao.deleteBatchJobExecutionContextById(jobInstance.getJobInstanceId());
                workFlowBatchDao.deleteBatchJobExecutionParamsById(jobInstance.getJobInstanceId());

                workFlowBatchDao.deleteBaatchStepExecutionContextById(jobInstance.getJobExecutionId());
                workFlowBatchDao.deleteBatchStepExecutionById(jobInstance.getJobExecutionId());
                workFlowBatchDao.deleteBatchJobExecutionById(jobInstance.getJobInstanceId());
                workFlowBatchDao.deleteJobInstanceById(jobInstance.getJobInstanceId());

            });
        } catch (Exception e) {
            LOG.error(e.getLocalizedMessage());
        }

    }

    public void setRuleset(DataProcessing dataProcessing, Integer idResultset)
            throws NoSuchFieldException, IllegalAccessException {

        Ruleset ruleset = rulesetDao.findById(idResultset).orElse(new Ruleset());
        AppRole appRole = appRoleDao.findByName(IS2Const.ROLE_NAME_RULESET);

        StepRuntime stepRuntimeID = new StepRuntime();
        stepRuntimeID.setDataProcessing(dataProcessing);
        stepRuntimeID.setAppRole(appRole);
        stepRuntimeID.setOrderCode(Short.valueOf("1"));
        stepRuntimeID.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_RULESET));
        stepRuntimeID.setTypeIO(new TypeIO(IS2Const.TYPE_IO_INPUT));
        Workset worksetID = new Workset();
        worksetID.setName("ID");
        worksetID.setParamValue(ruleset.getFileLabel());
        worksetID.setOrderCode(Short.valueOf("1"));
        worksetID.setContents(Utility.convertToArrayListStringFieldOfObjects(ruleset.getRules(), Rule.class, "id"));
        worksetID.setContentSize(ruleset.getRules().size());
        worksetID.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_RULESET));
        ArrayList<StepRuntime> listaStepVID = new ArrayList<>();
        listaStepVID.add(stepRuntimeID);
        worksetID.setStepRuntimes(listaStepVID);
        stepRuntimeID.setWorkset(worksetID);
        stepRuntimeDao.save(stepRuntimeID);

        StepRuntime stepRuntime = new StepRuntime();
        stepRuntime.setDataProcessing(dataProcessing);
        stepRuntime.setAppRole(appRole);
        stepRuntime.setOrderCode(Short.valueOf("2"));
        stepRuntime.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_RULESET));
        stepRuntime.setTypeIO(new TypeIO(IS2Const.TYPE_IO_INPUT));
        Workset workset = new Workset();
        workset.setName(IS2Const.TEXT_RULE);
        workset.setOrderCode(Short.valueOf("1"));
        workset.setParamValue(ruleset.getFileLabel());
        workset.setContents(Utility.convertToArrayListStringFieldOfObjects(ruleset.getRules(), Rule.class, "rule"));
        workset.setContentSize(ruleset.getRules().size());
        workset.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_RULESET));
        ArrayList<StepRuntime> listaStepV = new ArrayList<>();
        listaStepV.add(stepRuntime);
        workset.setStepRuntimes(listaStepV);
        stepRuntime.setWorkset(workset);
        stepRuntimeDao.save(stepRuntime);
    }

    public String getAppRoleNameById(Long groupRole) {

        AppRole role = appRoleDao.findById(groupRole).orElse(new AppRole());
        return role.getName();
    }

    public DataProcessing doStep(DataProcessing elaborazione, StepInstance stepInstance) throws Exception {
        EngineService engine = engineFactory.getEngine(stepInstance.getAppService().getEngineType());

        try {
            engine.init(elaborazione, stepInstance);
            engine.doAction();
            engine.processOutput();
        } catch (Exception e) {
            LOG.error(e.getMessage());
            notificationService.addErrorMessage("Error: " + e.getMessage());
            throw (e);
        } finally {
            engine.destroy();
        }

        return elaborazione;
    }
}
