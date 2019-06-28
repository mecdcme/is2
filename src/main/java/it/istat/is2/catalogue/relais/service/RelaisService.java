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
 * @version 0.1.1
 */
/**
 *
 */
package it.istat.is2.catalogue.relais.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.app.util.IS2Const;
import it.istat.is2.app.util.Utility;
import it.istat.is2.catalogue.relais.dao.RelaisGenericDao;
import it.istat.is2.workflow.dao.RuoloDao;
import it.istat.is2.workflow.dao.StepVariableDao;
import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.SXTipoCampo;
import it.istat.is2.workflow.domain.SxAppService;
import it.istat.is2.workflow.domain.SxRuoli;
import it.istat.is2.workflow.domain.SxStepVariable;
import it.istat.is2.workflow.domain.SxTipoVar;
import it.istat.is2.workflow.domain.SxWorkset;

/**
 * @author framato
 *
 */
@Service
public class RelaisService {

	final int stepService = 250;
	final int sizeFlushed = 20;

	@Autowired
	private RelaisGenericDao relaisGenericDao;
	@Autowired
	RuoloDao ruoloDao;
	@Autowired
	StepVariableDao stepVariableDao;

	private Map<String, SxRuoli> ruoliAllMap;

	@Autowired
	private ContingencyService contingencyService;

	public Map<?, ?> contengencyTable(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, ArrayList<String>> worksetVariabili) throws Exception {

		Map<String, Map<?, ?>> returnOut = new HashMap<>();
		Map<String, ArrayList<String>> worksetOut = new LinkedHashMap<String, ArrayList<String>>();
		Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<String, ArrayList<String>>();
		Map<String, String> rolesGroupOut = new HashMap<String, String>();

		// <codRuolo,[namevar1,namevar2..]

		String codeMatchingA = "X1";
		String codeMatchingB = "X2";
		String codContengencyTable = "CT";
		int indexItems = 0;
		ArrayList<String> variabileNomeListMA = new ArrayList<>();
		ArrayList<String> variabileNomeListMB = new ArrayList<>();

		ArrayList<String> variabileNomeListOut = new ArrayList<>();

		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});
		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});

		ruoliVariabileNome.values().forEach((list) -> {
			variabileNomeListOut.addAll(list);
		});

		String firstFiledMA = ruoliVariabileNome.get(codeMatchingA).get(0);
		String firstFiledMB = ruoliVariabileNome.get(codeMatchingB).get(0);
		int sizeA = worksetVariabili.get(firstFiledMA).size();
		int sizeB = worksetVariabili.get(firstFiledMB).size();

		contingencyService.init();
		List<String> nameMatchingVariables = new ArrayList<>();

		contingencyService.getMetricMatchingVariableVector().forEach(metricsm -> {
			worksetOut.put(metricsm.getMatchingVariable(), new ArrayList<>());
			nameMatchingVariables.add(metricsm.getMatchingVariable());
		});

		Map<String, Integer> contengencyTable = contingencyService.getEmptyContengencyTable();

		for (int iA = 0; iA < sizeA; iA++) {
			Map<String, String> valuesI = new HashMap<>();
			final Integer innerIA = new Integer(iA);
			variabileNomeListMA.forEach(varnameMA -> {
				valuesI.put(varnameMA, worksetVariabili.get(varnameMA).get(innerIA));
			});

			for (int iB = 0; iB < sizeB; iB++) {
				ArrayList<String> valueIB = new ArrayList<>();
				final Integer innerIB = new Integer(iB);
				variabileNomeListMB.forEach(varnameMB -> {
					valuesI.put(varnameMB, worksetVariabili.get(varnameMB).get(innerIB));
				});

				String pattern = contingencyService.getPattern(valuesI);
				contengencyTable.put(pattern, contengencyTable.get(pattern) + 1);
				indexItems++;
			}

		}
		worksetOut.put("FREQUENCY", new ArrayList<>());

		// write to worksetout
		contengencyTable.forEach((key, value) -> {

			int idx = 0;
			for (String nameMatchingVariable : nameMatchingVariables)
				worksetOut.get(nameMatchingVariable).add(String.valueOf(key.charAt(idx++)));
			worksetOut.get("FREQUENCY").add(value.toString());

		});

		rolesOut.put(codContengencyTable, new ArrayList<>(worksetOut.keySet()));
		returnOut.put(IS2Const.WF_OUTPUT_ROLES, rolesOut);
		
		rolesOut.keySet().forEach(code ->{
		  	rolesGroupOut.put(code, codContengencyTable);
		});
	 		returnOut.put(IS2Const.WF_OUTPUT_ROLES_GROUP, rolesGroupOut);
		returnOut.put(IS2Const.WF_OUTPUT_WORKSET, worksetOut);
		return returnOut;

	}

	public Map<?, ?> resultTables(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, ArrayList<String>> worksetVariabili) throws Exception {

		Map<String, Map<?, ?>> returnOut = new HashMap<>();
		Map<String, ArrayList<String>> worksetOut = new LinkedHashMap<String, ArrayList<String>>();
		Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<String, ArrayList<String>>();
		Map<String, String> rolesGroupOut = new HashMap<String, String>();

		// <codRuolo,[namevar1,namevar2..]

		String codeMatchingA = "X1";
		String codeMatchingB = "X2";
		String codContengencyTable = "CT";
		String codMachingTable = "MT";
		String codeFS = "FS";
		String codeP_POST = "P_POST";
		String paramTh = "0.8";
		int indexItems = 0;

		ArrayList<String> patternOk = new ArrayList<>();

		//
		for (String pPostVarname : ruoliVariabileNome.get(codeFS)) {

			if (codeP_POST.equals(pPostVarname)) {
				indexItems = 0;

				for (String pPostValue : worksetVariabili.get(pPostVarname)) {
					if (Float.parseFloat(pPostValue) >= Float.parseFloat(paramTh)) {
						StringBuffer pattern = new StringBuffer();

						for (String ctVarname : ruoliVariabileNome.get(codContengencyTable)) {
							if (!ctVarname.equals(IS2Const.WORKSET_FREQUENCY)) {
								String p = worksetVariabili.get(ctVarname).get(indexItems);
								pattern.append(Double.valueOf(p).intValue());
							}

						}

						patternOk.add(pattern.toString());
					}

					indexItems++;
				}
			}

		}

		ArrayList<String> variabileNomeListMA = new ArrayList<>();
		ArrayList<String> variabileNomeListMB = new ArrayList<>();

		ArrayList<String> variabileNomeListOut = new ArrayList<>();

		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});
		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});

		variabileNomeListOut.addAll(variabileNomeListMA);
		variabileNomeListOut.addAll(variabileNomeListMB);

		rolesOut.put(codMachingTable, variabileNomeListOut);

		String firstFiledMA = ruoliVariabileNome.get(codeMatchingA).get(0);
		String firstFiledMB = ruoliVariabileNome.get(codeMatchingB).get(0);
		int sizeA = worksetVariabili.get(firstFiledMA).size();
		int sizeB = worksetVariabili.get(firstFiledMB).size();

		contingencyService.init();

		variabileNomeListOut.forEach(varname -> {
			worksetOut.put(varname, new ArrayList<>());

		});

		indexItems = 0;
		for (int iA = 0; iA < sizeA; iA++) {
			Map<String, String> valuesI = new HashMap<>();
			final Integer innerIA = new Integer(iA);
			variabileNomeListMA.forEach(varnameMA -> {
				valuesI.put(varnameMA, worksetVariabili.get(varnameMA).get(innerIA));
			});

			for (int iB = 0; iB < sizeB; iB++) {

				final Integer innerIB = new Integer(iB);
				variabileNomeListMB.forEach(varnameMB -> {
					valuesI.put(varnameMB, worksetVariabili.get(varnameMB).get(innerIB));
				});

				String pattern = contingencyService.getPattern(valuesI);
				if (patternOk.contains(pattern)) {
					valuesI.forEach((k, v) -> {
						worksetOut.get(k).add(v);
					});

				}

				indexItems++;
			}

		}

		returnOut.put(IS2Const.WF_OUTPUT_ROLES, rolesOut);
		rolesOut.keySet().forEach(code ->{
		  	rolesGroupOut.put(code, codMachingTable);
		});
    		returnOut.put(IS2Const.WF_OUTPUT_ROLES_GROUP, rolesGroupOut);
		returnOut.put(IS2Const.WF_OUTPUT_WORKSET, worksetOut);
		return returnOut;
	}

	/**
	 * @param worksetOut
	 */
	private void cleanValuesWorksetOut(Map<String, ArrayList<String>> worksetOut) {
		// TODO Auto-generated method stub
		worksetOut.values().forEach(value -> {
			value.clear();
		});

	}

}
