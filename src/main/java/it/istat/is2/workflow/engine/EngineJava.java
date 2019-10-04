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
package it.istat.is2.workflow.engine;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ReflectionUtils;

import it.istat.is2.app.util.IS2Const;
import it.istat.is2.app.util.Utility;
import it.istat.is2.catalogue.relais.service.RelaisService;
import it.istat.is2.workflow.dao.RuoloDao;
import it.istat.is2.workflow.dao.StepVariableDao;
import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.TipoCampo;
import it.istat.is2.workflow.domain.AppRole;
import it.istat.is2.workflow.domain.StepInstance;
import it.istat.is2.workflow.domain.StepInstanceAppRole;
import it.istat.is2.workflow.domain.StepVariable;
import it.istat.is2.workflow.domain.SxTipoVar;
import it.istat.is2.workflow.domain.Workset;

/**
 * @author framato
 *
 */
@Service
public class EngineJava implements EngineService {

    @Autowired
    RelaisService relaisService;
    @Autowired
    RuoloDao ruoloDao;
    @Autowired
    StepVariableDao stepVariableDao;

    private Elaborazione elaborazione;
    private StepInstance stepInstance;
    private Map<String, ArrayList<StepVariable>> dataMap;
    private Map<String, AppRole> ruoliAllMap;
    private Map<String, ArrayList<String>> worksetVariabili;
    private Map<String, String> parametriMap;
    private Map<String, ArrayList<String>> modelloMap;
    private Map<String, Map<?, ?>> worksetOut;
    private Map<String, Map<?, ?>> resultOut;
    private LinkedHashMap<String, ArrayList<String>> ruoliVariabileNome;

    private LinkedHashMap<String, ArrayList<String>> ruoliOutputStep;
    private HashMap<String, String> ruoliGruppoOutputStep;
    private LinkedHashMap<String, ArrayList<String>> parametriOutput = new LinkedHashMap<>();

    public EngineJava() {
        super();

    }

    @Override
    public void init(Elaborazione elaborazione, StepInstance stepInstance) throws Exception {
        // Create a connection to Rserve instance running on default port 6311
        this.elaborazione = elaborazione;
        this.stepInstance = stepInstance;
        prepareEnv();
    }

    @Override
    public void init() throws Exception {
        //do nothing
    }

    @SuppressWarnings("unchecked")
    @Override
    public void doAction() throws IllegalAccessException, IllegalArgumentException, InvocationTargetException {
        String fname = stepInstance.getFname();
        // Method method = RelaisService.class.getDeclaredMethod(fname);
        Method method = ReflectionUtils.findMethod(RelaisService.class, fname, Long.class, Map.class, Map.class, Map.class);

        resultOut = (Map<String, Map<?, ?>>) method.invoke(relaisService, elaborazione.getId(), ruoliVariabileNome, worksetVariabili, parametriMap);
        worksetOut = (Map<String, Map<?, ?>>) resultOut.get(IS2Const.WF_OUTPUT_WORKSET);
        ruoliOutputStep = (LinkedHashMap<String, ArrayList<String>>) resultOut.get(IS2Const.WF_OUTPUT_ROLES);
        ruoliGruppoOutputStep = (HashMap<String, String>) resultOut.get(IS2Const.WF_OUTPUT_ROLES_GROUP);
    }

    public void prepareEnv() {

        // get all roles by service
        ruoliAllMap = ruoloDao.findByServiceAsCodMap(stepInstance.getAppService());

        // REcupero dei ruoli di INPUT e OUTUPT e dalle istanze
        // {S=[S], X=[X], Y=[Y], Z=[Z]}
        HashMap<String, ArrayList<String>> ruoliInputStep = new HashMap<>();
        // {P=[P], M=[M], O=[O]}
        ruoliOutputStep = new LinkedHashMap<String, ArrayList<String>>();

        for (Iterator<?> iterator = stepInstance.getSxStepPatterns().iterator(); iterator.hasNext();) {
            StepInstanceAppRole sxStepPattern = (StepInstanceAppRole) iterator.next();
            if (sxStepPattern.getTipoIO().getId().intValue() == IS2Const.VARIABILE_TIPO_INPUT) {
                ArrayList<String> listv = ruoliInputStep.get(sxStepPattern.getAppRole().getCod());
                if (listv == null) {
                    listv = new ArrayList<>();
                }
                listv.add(sxStepPattern.getAppRole().getCod());
                ruoliInputStep.put(sxStepPattern.getAppRole().getCod(), listv);
            } else if (sxStepPattern.getTipoIO().getId().intValue() == IS2Const.VARIABILE_TIPO_OUTPUT) {
                ArrayList<String> listv = ruoliOutputStep.get(sxStepPattern.getAppRole().getCod());
                if (listv == null) {
                    listv = new ArrayList<>();
                }
                listv.add(sxStepPattern.getAppRole().getCod());
                ruoliOutputStep.put(sxStepPattern.getAppRole().getCod(), listv);
            }
        }

        //Recupero workset di input 
        List<StepVariable> dataList = stepVariableDao.findByElaborazione(elaborazione);
        // mappa delle colonne workset <nome campo, oggetto stepv>
        dataMap = Utility.getMapNameWorkSetStep(dataList);
        // mappa delle colonne workset <nome campo, oggetto stepv>
        Map<String, ArrayList<StepVariable>> dataRuoliStepVarMap = Utility.getMapCodiceRuoloStepVariabili(dataList);
        // mappa delle colonne workset <nome,lista valori>
        worksetVariabili = Utility.getMapWorkSetValuesInRoles(dataMap, new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE), ruoliInputStep.keySet());

        // PARAMETRI
        parametriMap = Utility.getMapWorkSetValuesParams(dataMap, new SxTipoVar(IS2Const.WORKSET_TIPO_PARAMETRO));
        modelloMap = Utility.getMapWorkSetValues(dataMap, new SxTipoVar(IS2Const.WORKSET_TIPO_MODELLO));
        worksetOut = new HashMap<>();

        // associo il codice ruolo alla variabile
        // codiceRuolo, lista nome variabili {X=[X1], Y=[Y1]}
        ruoliVariabileNome = new LinkedHashMap<>();
        parametriOutput = new LinkedHashMap<>();

        for (Map.Entry<String, ArrayList<StepVariable>> entry : dataRuoliStepVarMap.entrySet()) {
            String codR = entry.getKey();
            ArrayList<StepVariable> listSVariable = entry.getValue();
            for (Iterator<StepVariable> iterator = listSVariable.iterator(); iterator.hasNext();) {
                StepVariable stepVariable = (StepVariable) iterator.next();
                ArrayList<String> listv = ruoliVariabileNome.get(codR);
                if (listv == null) {
                    listv = new ArrayList<>();
                }
                listv.add(stepVariable.getWorkset().getNome());
                ruoliVariabileNome.put(codR, listv);
            }
        }
    }

    @Override
    public void processOutput() throws Exception {

        saveOutputDB();

    }

    private void saveOutputDB() {
        // salva output su DB
        for (Map.Entry<String, ?> entry : worksetOut.entrySet()) {
            String nameOut = entry.getKey();
            Map<String, ArrayList<String>> outContent = (Map<String, ArrayList<String>>) entry.getValue();

            for (Map.Entry<String, ArrayList<String>> entryWS : outContent.entrySet()) {
                String nomeW = entryWS.getKey();
                ArrayList<String> value = entryWS.getValue();
                StepVariable stepVariable;
                //String ruolo = ruoliOutputStepInversa.get(nomeW);
                String ruolo = nameOut;
                String ruoloGruppo = ruoliGruppoOutputStep.get(ruolo);
                if (ruolo == null) {
                    ruolo = RUOLO_SKIP_N;
                }
                if (ruoloGruppo == null) {
                    ruoloGruppo = RUOLO_SKIP_N;
                }
                AppRole sxRuolo = ruoliAllMap.get(ruolo);
                AppRole sxRuoloGruppo = ruoliAllMap.get(ruoloGruppo);

                stepVariable = Utility.retrieveStepVariable(dataMap, nomeW, sxRuolo);

                if (stepVariable != null) { // update

                    stepVariable.getWorkset().setValori(value);
                    stepVariable.setTipoCampo(new TipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));
                } else {
                    stepVariable = new StepVariable();
                    stepVariable.setElaborazione(elaborazione);
                    stepVariable.setTipoCampo(new TipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));

                    stepVariable.setAppRole(sxRuolo);
                    stepVariable.setSxRuoloGruppo(sxRuoloGruppo);
                    stepVariable.setOrdine(sxRuolo.getOrdine());
                    Workset workset = new Workset();
                    workset.setNome(nomeW.replaceAll("\\.", "_"));
                    workset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
                    ArrayList<StepVariable> l = new ArrayList<>();
                    l.add(stepVariable);
                    workset.setStepVariables(l);
                    workset.setValori(value);
                    workset.setValoriSize(workset.getValori().size());
                    stepVariable.setWorkset(workset);
                }

                stepVariableDao.save(stepVariable);
            }
        }
    }

    @Override
    public void destroy() {
        // TODO Auto-generated method stub
    }

}
