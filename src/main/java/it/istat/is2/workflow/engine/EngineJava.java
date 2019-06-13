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
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.ReflectionUtils;

import it.istat.is2.app.util.IS2Const;
import it.istat.is2.app.util.Utility;
import it.istat.is2.catalogue.relais.service.RelaisService;
import it.istat.is2.workflow.dao.RuoloDao;
import it.istat.is2.workflow.dao.StepVariableDao;
import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.SXTipoCampo;
import it.istat.is2.workflow.domain.SxRuoli;
import it.istat.is2.workflow.domain.SxStepInstance;
import it.istat.is2.workflow.domain.SxStepPattern;
import it.istat.is2.workflow.domain.SxStepVariable;
import it.istat.is2.workflow.domain.SxTipoVar;
import it.istat.is2.workflow.domain.SxWorkset;

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
	private SxStepInstance stepInstance;
	private Map<String, SxStepVariable> dataMap;
	private Map<String, SxRuoli> ruoliAllMap;
	private Map<String, ArrayList<String>> worksetVariabili;
	private Map<String, ArrayList<String>> parametriMap;
	private Map<String, ArrayList<String>> modelloMap;
	private Map<String, ArrayList<String>> worksetOut;
	private LinkedHashMap<String, ArrayList<String>> ruoliVariabileNome;

	private LinkedHashMap<String, ArrayList<String>> ruoliOutputStep;
	private LinkedHashMap<String, ArrayList<String>> parametriOutput = new LinkedHashMap<>();

	public EngineJava() {
		super();

	}

	@Override
	public void init(Elaborazione elaborazione, SxStepInstance stepInstance) throws Exception {
		// Create a connection to Rserve instance running on default port 6311
		this.elaborazione = elaborazione;
		this.stepInstance = stepInstance;
		prepareEnv();

	}

        @Override
        public void init() throws Exception{
            //do nothing
        
        }
        	
	@SuppressWarnings("unchecked")
	@Override
	public void doAction() throws IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		String fname = stepInstance.getFname();
		// Method method = RelaisService.class.getDeclaredMethod(fname);
		Method method = ReflectionUtils.findMethod(RelaisService.class, fname, Long.class, Map.class,Map.class);

		worksetOut = (HashMap<String, ArrayList<String>>) method.invoke(relaisService, elaborazione.getId(),
				ruoliVariabileNome,worksetVariabili);
	}

	public void prepareEnv() {

		// SxStepInstance stepInstance =sxStepInstanceDao.findOne(idStepInstance);
		List<SxStepVariable> dataList = stepVariableDao.findByElaborazione(elaborazione);
		// mappa delle colonne workset <nome campo, oggetto stepv>
		dataMap = Utility.getMapNameWorkSetStep(dataList);
		// mappa delle colonne workset <nome campo, oggetto stepv>
		Map<String, ArrayList<SxStepVariable>> dataRuoliStepVarMap = Utility.getMapCodiceRuoloStepVariabili(dataList);
		// List<SxRuoli> ruoliAll = ruoloDao.findAll();
		// ruoliAllMap = Utility.getMapRuoliByCod(ruoliAll);
		ruoliAllMap = ruoloDao.findByServiceAsCodMap(stepInstance.getSxAppService());
		// mappa delle colonne workset <nome,lista valori>
		worksetVariabili = Utility.getMapWorkSetValues(dataMap, new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
		// PARAMETRI
		parametriMap = Utility.getMapWorkSetValues(dataMap, new SxTipoVar(IS2Const.WORKSET_TIPO_PARAMETRO));
		modelloMap = Utility.getMapWorkSetValues(dataMap, new SxTipoVar(IS2Const.WORKSET_TIPO_MODELLO));

		// REcupero dei ruoli di INPUT e OUTUPT e dalle istanze

		// {S=[S], X=[X], Y=[Y], Z=[Z]}
		HashMap<String, ArrayList<String>> ruoliInputStep = new HashMap<>();
		// {P=[P], M=[M], O=[O]}
		ruoliOutputStep = new LinkedHashMap<>();

		for (Iterator<?> iterator = stepInstance.getSxStepPatterns().iterator(); iterator.hasNext();) {
			SxStepPattern sxStepPattern = (SxStepPattern) iterator.next();
			if (sxStepPattern.getTipoIO().getId().intValue() == IS2Const.VARIABILE_TIPO_INPUT) {
				ArrayList<String> listv = ruoliInputStep.get(sxStepPattern.getSxRuoli().getCod());
				if (listv == null) {
					listv = new ArrayList<>();
				}
				listv.add(sxStepPattern.getSxRuoli().getCod());
				ruoliInputStep.put(sxStepPattern.getSxRuoli().getCod(), listv);
			} else if (sxStepPattern.getTipoIO().getId().intValue() == IS2Const.VARIABILE_TIPO_OUTPUT) {
				ArrayList<String> listv = ruoliOutputStep.get(sxStepPattern.getSxRuoli().getCod());
				if (listv == null) {
					listv = new ArrayList<>();
				}
				listv.add(sxStepPattern.getSxRuoli().getCod());
				ruoliOutputStep.put(sxStepPattern.getSxRuoli().getCod(), listv);
			}
		}
		// associo il codice ruolo alla variabile
		// codiceRuolo, lista nome variabili {X=[X1], Y=[Y1]}
		ruoliVariabileNome = new LinkedHashMap<>();
		parametriOutput = new LinkedHashMap<>();

		for (Map.Entry<String, ArrayList<SxStepVariable>> entry : dataRuoliStepVarMap.entrySet()) {
			String codR = entry.getKey();
			ArrayList<SxStepVariable> listSVariable = entry.getValue();
			for (Iterator<SxStepVariable> iterator = listSVariable.iterator(); iterator.hasNext();) {
				SxStepVariable sxStepVariable = (SxStepVariable) iterator.next();
				ArrayList<String> listv = ruoliVariabileNome.get(codR);
				if (listv == null) {
					listv = new ArrayList<>();
				}
				listv.add(sxStepVariable.getSxWorkset().getNome());
				ruoliVariabileNome.put(codR, listv);
			}
		}

	}

	@Override
	public void processOutput() throws Exception {

		getGenericoOutput(ruoliOutputStep);

		saveOutputDB();

	}

	private void getGenericoOutput(HashMap<String, ArrayList<String>> ruoliOutputStep2) {
		// TODO Auto-generated method stub
		ArrayList<String> listValue = new ArrayList<String>(worksetOut.keySet());
		ruoliOutputStep2.put("CT", listValue);
	}

	private void saveOutputDB() {
		// TODO Auto-generated method stub

		HashMap<String, String> ruoliOutputStepInversa = new HashMap<>();
		for (Map.Entry<String, ArrayList<String>> entry : ruoliOutputStep.entrySet()) {
			String nomeR = entry.getKey();
			ArrayList<String> value = entry.getValue();
			value.forEach((nomevar) -> ruoliOutputStepInversa.put(nomevar, nomeR));
		}

		// salva output su DB
		for (Map.Entry<String, ArrayList<String>> entry : worksetOut.entrySet()) {
			String nomeW = entry.getKey();
			ArrayList<String> value = entry.getValue();
			SxStepVariable sxStepVariable;
			String ruolo = ruoliOutputStepInversa.get(nomeW);
			if (ruolo == null) {
				ruolo = RUOLO_SKIP_N;
			}
			SxRuoli sxRuolo = ruoliAllMap.get(ruolo);

			if (dataMap.keySet().contains(nomeW) && dataMap.get(nomeW).getSxRuoli().getCod().equals(sxRuolo.getCod())) { // update
																															// fields
				sxStepVariable = dataMap.get(nomeW);
				sxStepVariable.getSxWorkset().setValori(value);
				sxStepVariable.setTipoCampo(new SXTipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));
			} else {
				sxStepVariable = new SxStepVariable();
				sxStepVariable.setElaborazione(elaborazione);
				sxStepVariable.setTipoCampo(new SXTipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));

				sxStepVariable.setSxRuoli(sxRuolo);
				sxStepVariable.setOrdine(sxRuolo.getOrdine());
				SxWorkset sxWorkset = new SxWorkset();
				sxWorkset.setNome(nomeW.replaceAll("\\.", "_"));
				sxWorkset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
				ArrayList<SxStepVariable> l = new ArrayList<>();
				l.add(sxStepVariable);
				sxWorkset.setSxStepVariables(l);
				sxWorkset.setValori(value);
				sxWorkset.setValoriSize(sxWorkset.getValori().size());
				sxStepVariable.setSxWorkset(sxWorkset);
			}

			stepVariableDao.save(sxStepVariable);
		}

		for (Map.Entry<String, ArrayList<String>> entry : parametriOutput.entrySet()) {
			String nomeW = entry.getKey();
			ArrayList<String> value = entry.getValue();
			SxStepVariable sxStepVariable;

			if (dataMap.keySet().contains(nomeW)) {
				sxStepVariable = dataMap.get(nomeW);
				sxStepVariable.getSxWorkset().setValori(value);
				sxStepVariable.setTipoCampo(new SXTipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));

			} else {
				sxStepVariable = new SxStepVariable();
				sxStepVariable.setElaborazione(elaborazione);
				sxStepVariable.setTipoCampo(new SXTipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));
				String ruolo = ruoliOutputStepInversa.get(nomeW);
				if (ruolo == null) {
					ruolo = RUOLO_SKIP_N;
				}
				SxRuoli sxRuolo = ruoliAllMap.get(ruolo);
				sxStepVariable.setSxRuoli(sxRuolo);
				sxStepVariable.setOrdine(sxRuolo.getOrdine());
				SxWorkset sxWorkset = new SxWorkset();
				sxWorkset.setNome(nomeW.replaceAll("\\.", "_"));
				sxWorkset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_PARAMETRO));
				ArrayList<SxStepVariable> l = new ArrayList<>();
				l.add(sxStepVariable);
				sxWorkset.setSxStepVariables(l);
				sxWorkset.setValori(value);
				sxWorkset.setValoriSize(sxWorkset.getValori().size());
				sxStepVariable.setSxWorkset(sxWorkset);
			}

			stepVariableDao.save(sxStepVariable);
		}

	}

	
	@Override
	public void destroy() {
            // TODO Auto-generated method stub
	}

}
