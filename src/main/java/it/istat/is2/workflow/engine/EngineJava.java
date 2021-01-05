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
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.util.ReflectionUtils;

import it.istat.is2.app.util.IS2Const;
import it.istat.is2.app.util.Utility;
import it.istat.is2.workflow.dao.AppRoleDao;
import it.istat.is2.workflow.dao.StepRuntimeDao;
import it.istat.is2.workflow.domain.AppRole;
import it.istat.is2.workflow.domain.DataProcessing;
import it.istat.is2.workflow.domain.DataTypeCls;
import it.istat.is2.workflow.domain.StepInstance;
import it.istat.is2.workflow.domain.StepInstanceSignature;
import it.istat.is2.workflow.domain.StepRuntime;
import it.istat.is2.workflow.domain.TypeIO;
import it.istat.is2.workflow.domain.Workset;

/**
 * @author framato
 *
 */
@Service
public class EngineJava implements EngineService {

	@Autowired
	AppRoleDao ruoloDao;
	@Autowired
	StepRuntimeDao stepVariableDao;
	@Autowired
	private ApplicationContext context;

	private DataProcessing dataProcessing;
	private StepInstance stepInstance;
	private Map<String, ArrayList<StepRuntime>> dataMap;
	private Map<String, AppRole> ruoliAllMap;
	private Map<String, Map<String, List<String>>> worksetInput;
	private Map<String, String> parametriMap;
	private Map<String, Map<?, ?>> worksetOut = new HashMap<>();
	private Map<String, Map<?, ?>> parametriOutput = new HashMap<>();
	private Map<String, Map<?, ?>> resultOut = new HashMap<>();
	private Map<String, ArrayList<String>> ruoliVariabileNome;

	private Map<String, ArrayList<String>> ruoliOutputStep = new HashMap<String, ArrayList<String>>();
	private Map<String, String> ruoliGruppoOutputStep;

	public EngineJava() {
		super();

	}

	@Override
	public void init(DataProcessing elaborazione, StepInstance stepInstance) throws Exception {
		// Create a connection to Rserve instance running on default port 6311
		this.dataProcessing = elaborazione;
		this.stepInstance = stepInstance;
		
		this.worksetOut = new HashMap<>();
		this.parametriOutput = new HashMap<>();
		this.resultOut = new HashMap<>();
		this.ruoliOutputStep = new HashMap<String, ArrayList<String>>();

		prepareEnv();
	}

	@Override
	public void init() throws Exception {
		// do nothing
	}

	@SuppressWarnings("unchecked")
	@Override
	public void doAction() throws IllegalAccessException, IllegalArgumentException, InvocationTargetException,
			ClassNotFoundException, InstantiationException {
		String fname = stepInstance.getMethod();
		String fnameClassName = stepInstance.getAppService().getSource();
		Class<?> fnameClass = Class.forName(fnameClassName);
		Method method = ReflectionUtils.findMethod(fnameClass, fname, Long.class, Map.class, Map.class, Map.class);
		if (method == null)
			throw new NullPointerException(fname + " function not Found");

		Object instance = context.getBean(fnameClass);
		resultOut = (Map<String, Map<?, ?>>) method.invoke(instance, dataProcessing.getId(), ruoliVariabileNome,
				worksetInput, parametriMap);
		if (resultOut == null)
			throw new NullPointerException(fname + " method return NULL");

		worksetOut = (Map<String, Map<?, ?>>) resultOut.get(WORKSET_OUT);
		parametriOutput = (Map<String, Map<?, ?>>) resultOut.get(PARAMETERS_OUT);
		ruoliOutputStep = (HashMap<String, ArrayList<String>>) resultOut.get(ROLES_OUT);
		ruoliGruppoOutputStep = (HashMap<String, String>) resultOut.get(ROLES_GROUP_OUT);

	}

	public void prepareEnv() {

		// get all roles by service
		ruoliAllMap = ruoloDao.findByServiceAsCodMap(stepInstance.getAppService().getBusinessService());

		// REcupero dei ruoli di INPUT e OUTUPT e dalle istanze
		// {S=[S], X=[X], Y=[Y], Z=[Z]}
		HashMap<String, ArrayList<String>> ruoliInputStep = new HashMap<>();
		// {P=[P], M=[M], O=[O]}

		for (Iterator<?> iterator = stepInstance.getStepInstanceSignatures().iterator(); iterator.hasNext();) {
			StepInstanceSignature sxStepPattern = (StepInstanceSignature) iterator.next();
			if (sxStepPattern.getTypeIO().equals(new TypeIO(IS2Const.TYPE_IO_INPUT))) {
				ArrayList<String> listv = ruoliInputStep.get(sxStepPattern.getAppRole().getCode());
				if (listv == null) {
					listv = new ArrayList<>();
				}
				listv.add(sxStepPattern.getAppRole().getCode());
				ruoliInputStep.put(sxStepPattern.getAppRole().getCode(), listv);
			} else if (sxStepPattern.getTypeIO().equals(new TypeIO(IS2Const.TYPE_IO_OUTPUT))) {
				System.out.println(ruoliOutputStep);
				System.out.println(sxStepPattern.getAppRole().getCode());
				ArrayList<String> listv = ruoliOutputStep.get(sxStepPattern.getAppRole().getCode());
				if (listv == null) {
					listv = new ArrayList<>();
				}
				listv.add(sxStepPattern.getAppRole().getCode());
				ruoliOutputStep.put(sxStepPattern.getAppRole().getCode(), listv);
			}
		}

		// Recupero workset di input
		List<StepRuntime> dataList = stepVariableDao.findByDataProcessing(dataProcessing);
		// mappa delle colonne workset <nome campo, oggetto stepv>
		dataMap = Utility.getMapNameWorkSetStep(dataList);
		// mappa delle colonne workset <nome campo, oggetto stepv>
		Map<String, ArrayList<StepRuntime>> dataRuoliStepVarMap = Utility.getMapCodiceRuoloStepVariabili(dataList);
		// mappa delle colonne workset <nome,lista valori>
		worksetInput = Utility.getMapWorkSetValuesInRoles(dataMap, new DataTypeCls(IS2Const.DATA_TYPE_VARIABLE),
				ruoliInputStep.keySet());

		// PARAMETRI
		parametriMap = Utility.getMapWorkSetValuesParams(dataMap, new DataTypeCls(IS2Const.DATA_TYPE_PARAMETER));

		// associo il codice ruolo alla variabile
		// codiceRuolo, lista nome variabili {X=[X1], Y=[Y1]}
		ruoliVariabileNome = new LinkedHashMap<>();

		for (Map.Entry<String, ArrayList<StepRuntime>> entry : dataRuoliStepVarMap.entrySet()) {
			String codR = entry.getKey();
			ArrayList<StepRuntime> listSVariable = entry.getValue();
			for (Iterator<StepRuntime> iterator = listSVariable.iterator(); iterator.hasNext();) {
				StepRuntime stepVariable = (StepRuntime) iterator.next();
				ArrayList<String> listv = ruoliVariabileNome.get(codR);
				if (listv == null) {
					listv = new ArrayList<>();
				}
				listv.add(stepVariable.getWorkset().getName());
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
			@SuppressWarnings("unchecked")
			Map<String, ArrayList<String>> outContent = (Map<String, ArrayList<String>>) entry.getValue();

			for (Map.Entry<String, ArrayList<String>> entryWS : outContent.entrySet()) {
				String nomeW = entryWS.getKey();
				ArrayList<String> value = entryWS.getValue();
				StepRuntime stepVariable;
				// String ruolo = ruoliOutputStepInversa.get(nomeW);
				String ruolo = nameOut;
				String ruoloGruppo = ruoliGruppoOutputStep.get(ruolo);
				if (ruolo == null) {
					ruolo = ROLE_DEFAULT;
				}
				if (ruoloGruppo == null) {
					ruoloGruppo = ROLE_DEFAULT;
				}
				AppRole sxRuolo = ruoliAllMap.get(ruolo);
				AppRole sxRuoloGruppo = ruoliAllMap.get(ruoloGruppo);

				stepVariable = Utility.retrieveStepRuntime(dataMap, nomeW, sxRuolo);

				if (stepVariable != null) { // update

					stepVariable.getWorkset().setContents(value);
					stepVariable.setTypeIO(new TypeIO(IS2Const.TYPE_IO_OUTPUT));
				} else {
					stepVariable = new StepRuntime();
					stepVariable.setDataProcessing(dataProcessing);
					stepVariable.setTypeIO(new TypeIO(IS2Const.TYPE_IO_OUTPUT));

					stepVariable.setAppRole(sxRuolo);
					stepVariable.setDataType(sxRuolo.getDataType());
					stepVariable.setRoleGroup(sxRuoloGruppo);
					stepVariable.setOrderCode(sxRuolo.getOrder());
					Workset workset = new Workset();
					workset.setName(nomeW.replaceAll("\\.", "_"));
					workset.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_VARIABLE));
					ArrayList<StepRuntime> l = new ArrayList<>();
					l.add(stepVariable);
					workset.setStepRuntimes(l);
					workset.setContents(value);
					workset.setContentSize(workset.getContents().size());
					stepVariable.setWorkset(workset);
				}

				stepVariableDao.save(stepVariable);
			}
		}
		// save output Parameter DB
		if (parametriOutput != null) {
			for (Map.Entry<String, ?> entry : parametriOutput.entrySet()) {
				String nameOut = entry.getKey();
				@SuppressWarnings("unchecked")
				Map<String, String> outContent = (Map<String, String>) entry.getValue();

				for (Map.Entry<String, String> entryWS : outContent.entrySet()) {
					String nomeW = entryWS.getKey();
					String value = entryWS.getValue();
					StepRuntime stepRuntime;
					String ruolo = nameOut;
					String ruoloGruppo = ruoliGruppoOutputStep.get(ruolo);
					if (ruolo == null) {
						ruolo = ROLE_DEFAULT;
					}
					if (ruoloGruppo == null) {
						ruoloGruppo = ROLE_DEFAULT;
					}
					AppRole sxRuolo = ruoliAllMap.get(ruolo);
					AppRole sxRuoloGruppo = ruoliAllMap.get(ruoloGruppo);

					stepRuntime = Utility.retrieveStepRuntime(dataMap, nomeW, sxRuolo);

					if (stepRuntime != null) { // update
						stepRuntime.getWorkset().setParamValue(value);
						stepRuntime.setTypeIO(new TypeIO(IS2Const.TYPE_IO_OUTPUT));
					} else {
						stepRuntime = new StepRuntime();
						stepRuntime.setDataProcessing(dataProcessing);
						stepRuntime.setTypeIO(new TypeIO(IS2Const.TYPE_IO_OUTPUT));
						stepRuntime.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_PARAMETER));
						stepRuntime.setAppRole(sxRuolo);
						stepRuntime.setRoleGroup(sxRuoloGruppo);
						stepRuntime.setOrderCode(sxRuolo.getOrder());
						Workset workset = new Workset();
						workset.setName(nomeW.replaceAll("\\.", "_"));

						ArrayList<StepRuntime> l = new ArrayList<>();
						l.add(stepRuntime);
						workset.setStepRuntimes(l);
						workset.setParamValue(value);
						workset.setContentSize(1);
						workset.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_PARAMETER));
						stepRuntime.setWorkset(workset);
					}
					stepVariableDao.save(stepRuntime);
				}
			}
		}
	}

	@Override
	public void destroy() {
		// Nothing to do
	}

}
