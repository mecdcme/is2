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

import java.lang.reflect.Method;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.IntStream;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.ReflectionUtils;
import org.springframework.util.StringUtils;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import it.istat.is2.app.service.LogService;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.app.util.IS2Exception;
import it.istat.is2.app.util.IS2ExceptionCodes;
import it.istat.is2.app.util.Utility;

/**
 * @author framato
 *
 */
@Component
public class RelaisService {

	final static int stepService = 250;
	final static int sizeFlushed = 20;

	final static String codeMatchingA = "X1";
	final static String codeMatchingB = "X2";
	final static String codContengencyTable = "CT";
	final static String codMachingTable = "MT";
	final static String codPossibleMachingTable = "PM";
	final static String codResidualA = "RA";
	final static String codResidualB = "RB";
	final static String codeFS = "FS";
	final static String codeP_POST = "P_POST";
	final static String params_MatchingVariables = "MATCHING_VARIABLES";
	final static String params_ThresholdMatching = "THRESHOLD_MATCHING";
	final static String params_ThresholdUnMatching = "THRESHOLD_UNMATCHING";
	final static String params_BlockingVariables = "BLOCKING VARIABLES";
	final static String params_BlockingVariablesA = "BLOCKING A";
	final static String params_BlockingVariablesB = "BLOCKING B";
	final static String codeBlockingVariablesA = "BA";
	final static String codeBlockingVariablesB = "BB";
	final static String params_ReductionMethod = "REDUCTION_METHOD";

	@Autowired
	private LogService logService;

	@Autowired
	private ContingencyService contingencyService;

	public Map<?, ?> probabilisticContencyTable(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, ArrayList<String>> worksetIn, Map<String, String> parametriMap) throws Exception {

		return callGenericMethod("pRLContingencyTable", idelaborazione, ruoliVariabileNome, worksetIn, parametriMap);
	}

	public Map<?, ?> probabilisticResultTables(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, ArrayList<String>> worksetIn, Map<String, String> parametriMap) throws Exception {

		return callGenericMethod("pRLResultTables", idelaborazione, ruoliVariabileNome, worksetIn, parametriMap);
	}

	public Map<?, ?> deterministicRecorgeLinkage(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, ArrayList<String>> worksetIn, Map<String, String> parametriMap) throws Exception {

		return callGenericMethod("dRL", idelaborazione, ruoliVariabileNome, worksetIn, parametriMap);
	}

	private Map<?, ?> callGenericMethod(String prefixMethod, Long idelaborazione,
			Map<String, ArrayList<String>> ruoliVariabileNome, Map<String, ArrayList<String>> worksetIn,
			Map<String, String> parametriMap) throws Exception {

		final String jsonString = parametriMap.get(params_ReductionMethod);
		final JSONObject reductionJSONObject = new JSONObject(jsonString);
		final String dRLMethod = prefixMethod + reductionJSONObject.getString("REDUCTION-METHOD");
		if (StringUtils.isEmpty(dRLMethod))
			throw new IS2Exception(IS2ExceptionCodes.METHOD_NOT_FOUND);
		final Method method = ReflectionUtils.findMethod(this.getClass(), dRLMethod, Long.class, Map.class, Map.class,
				Map.class);
		reductionJSONObject.keySet()
				.forEach(keyStr -> parametriMap.put(keyStr, reductionJSONObject.get(keyStr).toString()));

		return (Map<?, ?>) method.invoke(this, idelaborazione, ruoliVariabileNome, worksetIn, parametriMap);
	}

	public Map<?, ?> pRLContingencyTableCartesianProduct(Long idelaborazione,
			Map<String, List<String>> ruoliVariabileNome, Map<String, List<String>> worksetVariabili,
			Map<String, String> parametriMap) throws Exception {

		Map<String, Map<?, ?>> returnOut = new HashMap<>();
		Map<String, Map<?, ?>> worksetOut = new HashMap<>();
		Map<String, ArrayList<String>> contengencyTableOut = new LinkedHashMap<>();
		Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		Map<String, String> rolesGroupOut = new HashMap<>();

		// <codRuolo,[namevar1,namevar2..]

		ArrayList<String> variabileNomeListMA = new ArrayList<>();
		ArrayList<String> variabileNomeListMB = new ArrayList<>();

		ArrayList<String> variabileNomeListOut = new ArrayList<>();

		logService.save("Process Contingency Table Starting...");

		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});
		logService.save("Matching variables dataset A: " + variabileNomeListMA);
		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});
		logService.save("Matching variables dataset B: " + variabileNomeListMB);
		ruoliVariabileNome.values().forEach((list) -> {
			variabileNomeListOut.addAll(list);
		});

		String firstFiledMA = ruoliVariabileNome.get(codeMatchingA).get(0);
		String firstFiledMB = ruoliVariabileNome.get(codeMatchingB).get(0);
		int sizeA = worksetVariabili.get(firstFiledMA).size();
		int sizeB = worksetVariabili.get(firstFiledMB).size();

		try {
			contingencyService.init(parametriMap.get(params_MatchingVariables));
		} catch (Exception e) {
			logService.save("Error parsing " + params_MatchingVariables);
			throw new Exception("Error parsing " + params_MatchingVariables);
		}
		List<String> nameMatchingVariables = new ArrayList<>();

		contingencyService.getMetricMatchingVariableVector().forEach(metricsm -> {
			contengencyTableOut.put(metricsm.getMatchingVariable(), new ArrayList<>());
			nameMatchingVariables.add(metricsm.getMatchingVariable());
		});

		final Map<String, Integer> contengencyTable = Collections
				.synchronizedMap(contingencyService.getEmptyContengencyTable());

		IntStream.range(0, sizeA).parallel().forEach(innerIA -> {

			final Map<String, String> valuesI = new HashMap<>();
			final Map<String, Integer> contengencyTableIA = contingencyService.getEmptyContengencyTable();

			variabileNomeListMA.forEach(varnameMA -> {
				valuesI.put(varnameMA, worksetVariabili.get(varnameMA).get(innerIA));
			});

			IntStream.range(0, sizeB).forEach(innerIB -> {
				variabileNomeListMB.forEach(varnameMB -> {
					valuesI.put(varnameMB, worksetVariabili.get(varnameMB).get(innerIB));
				});

				String pattern = contingencyService.getPattern(valuesI);
				contengencyTableIA.put(pattern, contengencyTableIA.get(pattern) + 1);

			});
			synchronized (contengencyTable) {
				contengencyTableIA.entrySet().stream().forEach(e -> contengencyTable.put(e.getKey(),
						contengencyTable.get(e.getKey()) + contengencyTableIA.get(e.getKey())));
			}

		});
		contengencyTableOut.put("FREQUENCY", new ArrayList<>());
		// write to worksetout
		contengencyTable.forEach((key, value) -> {
			int idx = 0;
			for (String nameMatchingVariable : nameMatchingVariables) {
				contengencyTableOut.get(nameMatchingVariable).add(String.valueOf(key.charAt(idx++)));
			}
			contengencyTableOut.get("FREQUENCY").add(value.toString());
		});

		rolesOut.put(codContengencyTable, new ArrayList<>(contengencyTableOut.keySet()));
		returnOut.put(IS2Const.WF_OUTPUT_ROLES, rolesOut);

		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, codContengencyTable);
		});
		returnOut.put(IS2Const.WF_OUTPUT_ROLES_GROUP, rolesGroupOut);

		worksetOut.put(codContengencyTable, contengencyTableOut);
		returnOut.put(IS2Const.WF_OUTPUT_WORKSET, worksetOut);

		return returnOut;
	}

	// parallel blocking
	public Map<?, ?> pRLContingencyTableBlockingVariables(Long idelaborazione,
			Map<String, List<String>> ruoliVariabileNome, Map<String, List<String>> worksetVariabili,
			Map<String, String> parametriMap) throws Exception {

		final Map<String, Map<?, ?>> returnOut = new HashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new HashMap<>();
		final Map<String, ArrayList<String>> contengencyTableOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

		// <codRuolo,[namevar1,namevar2..]

		final ArrayList<String> variabileNomeListMA = new ArrayList<>();
		final ArrayList<String> variabileNomeListMB = new ArrayList<>();
		final List<String> blockingVariablesA = new ArrayList<>();
		final List<String> blockingVariablesB = new ArrayList<>();

		final ArrayList<String> variabileNomeListOut = new ArrayList<>();
		logService.save("Process Contingency Table Blocking Starting...");
		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});
		logService.save("Matching variables dataset A: " + variabileNomeListMA);
		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});
		logService.save("Matching variables dataset B: " + variabileNomeListMB);

		blockingVariablesA
				.addAll(getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesA));
		blockingVariablesB
				.addAll(getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesB));

		logService.save("Blocking variables dataset A: " + blockingVariablesA);

		logService.save("Blocking variables dataset B: " + blockingVariablesB);

		ruoliVariabileNome.values().forEach((list) -> {
			variabileNomeListOut.addAll(list);
		});

		try {
			contingencyService.init(parametriMap.get(params_MatchingVariables));
		} catch (Exception e) {
			logService.save("Error parsing " + params_MatchingVariables);
			throw new Exception("Error parsing " + params_MatchingVariables);
		}
		List<String> nameMatchingVariables = new ArrayList<>();

		contingencyService.getMetricMatchingVariableVector().forEach(metricsm -> {
			contengencyTableOut.put(metricsm.getMatchingVariable(), new ArrayList<>());
			nameMatchingVariables.add(metricsm.getMatchingVariable());
		});

		if (Utility.isNullOrEmpty(blockingVariablesA) || Utility.isNullOrEmpty(blockingVariablesB)) {
			logService.save("Error parsing BLOCKING VARAIABLES");
			throw new Exception("Error parsing BLOCKING VARAIABLES");
		}

		Map<String, List<Integer>> indexesBlockingVariableA = Utility.blockVariablesIndexMapValues(worksetVariabili,
				blockingVariablesA);
		Map<String, List<Integer>> indexesBlockingVariableB = Utility.blockVariablesIndexMapValues(worksetVariabili,
				blockingVariablesB);
		logService.save("Size Blocking dataset A: " + indexesBlockingVariableA.size());
		logService.save("Size Blocking dataset B: " + indexesBlockingVariableB.size());
		final Map<String, Integer> contengencyTable = Collections
				.synchronizedMap(contingencyService.getEmptyContengencyTable());

		indexesBlockingVariableA.entrySet().parallelStream().forEach(entry -> {
			String keyBlock = entry.getKey();

			final Map<String, Integer> contengencyTableIA = contingencyService.getEmptyContengencyTable();
			// Dataset A
			entry.getValue().forEach(innerIA -> {

				final Map<String, String> valuesI = new HashMap<>();

				variabileNomeListMA.forEach(varnameMA -> {
					valuesI.put(varnameMA, worksetVariabili.get(varnameMA).get(innerIA));
				});
				if (indexesBlockingVariableB.get(keyBlock) != null)
					indexesBlockingVariableB.get(keyBlock).forEach(innerIB -> {

						variabileNomeListMB.forEach(varnameMB -> {
							valuesI.put(varnameMB, worksetVariabili.get(varnameMB).get(innerIB));
						});

						String pattern = contingencyService.getPattern(valuesI);
						contengencyTableIA.put(pattern, contengencyTableIA.get(pattern) + 1);

					});

			});

			synchronized (contengencyTable) {
				contengencyTableIA.entrySet().stream().forEach(e -> contengencyTable.put(e.getKey(),
						contengencyTable.get(e.getKey()) + contengencyTableIA.get(e.getKey())));
			}

		});
		contengencyTableOut.put("FREQUENCY", new ArrayList<>());

		// write to worksetout
		contengencyTable.forEach((key, value) -> {
			int idx = 0;
			for (String nameMatchingVariable : nameMatchingVariables) {
				contengencyTableOut.get(nameMatchingVariable).add(String.valueOf(key.charAt(idx++)));
			}
			contengencyTableOut.get("FREQUENCY").add(value.toString());
		});

		rolesOut.put(codContengencyTable, new ArrayList<>(contengencyTableOut.keySet()));
		returnOut.put(IS2Const.WF_OUTPUT_ROLES, rolesOut);

		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, codContengencyTable);
		});
		returnOut.put(IS2Const.WF_OUTPUT_ROLES_GROUP, rolesGroupOut);

		worksetOut.put(codContengencyTable, contengencyTableOut);
		returnOut.put(IS2Const.WF_OUTPUT_WORKSET, worksetOut);
		logService.save("Process Contingency Table Blocking End");
		return returnOut;
	}

	public Map<?, ?> contingencyTableNP(Long idelaborazione, Map<String, List<String>> ruoliVariabileNome,
			Map<String, List<String>> worksetVariabili, Map<String, String> parametriMap) throws Exception {
		System.out.println("contingencyTableNoParalel");

		Instant start = Instant.now();
		Map<String, Map<?, ?>> returnOut = new HashMap<>();
		Map<String, Map<?, ?>> worksetOut = new HashMap<>();
		Map<String, ArrayList<String>> contengencyTableOut = new LinkedHashMap<>();
		Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		Map<String, String> rolesGroupOut = new HashMap<>();

		// <codRuolo,[namevar1,namevar2..]

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

		try {
			contingencyService.init(parametriMap.get(params_MatchingVariables));
		} catch (Exception e) {
			logService.save("Error parsing " + params_MatchingVariables);
			throw new Exception("Error parsing " + params_MatchingVariables);
		}
		List<String> nameMatchingVariables = new ArrayList<>();

		contingencyService.getMetricMatchingVariableVector().forEach(metricsm -> {
			contengencyTableOut.put(metricsm.getMatchingVariable(), new ArrayList<>());
			nameMatchingVariables.add(metricsm.getMatchingVariable());
		});

		Map<String, Integer> contengencyTable = contingencyService.getEmptyContengencyTable();

		/*
		 * final String sortFieldA = variabileNomeListMA.get(0); final String sortFieldB
		 * = variabileNomeListMB.get(0);
		 * Utility.printNElementsInMapValues(worksetVariabili, 5);
		 * Utility.sortDatasetInMapValues(worksetVariabili, variabileNomeListMA,
		 * sortFieldA, IS2Const.SORT_ASC);
		 * Utility.printNElementsInMapValues(worksetVariabili, 5);
		 * Utility.sortDatasetInMapValues(worksetVariabili, variabileNomeListMB,
		 * sortFieldB, IS2Const.SORT_ASC);
		 * Utility.printNElementsInMapValues(worksetVariabili, 5);
		 */
		for (int iA = 0; iA < sizeA; iA++) {
			Map<String, String> valuesI = new HashMap<>();
			final Integer innerIA = Integer.valueOf(iA);
			variabileNomeListMA.forEach(varnameMA -> {
				valuesI.put(varnameMA, worksetVariabili.get(varnameMA).get(innerIA));
			});

			for (int iB = 0; iB < sizeB; iB++) {
				final Integer innerIB = Integer.valueOf(iB);
				variabileNomeListMB.forEach(varnameMB -> {
					valuesI.put(varnameMB, worksetVariabili.get(varnameMB).get(innerIB));
				});

				String pattern = contingencyService.getPattern(valuesI);
				contengencyTable.put(pattern, contengencyTable.get(pattern) + 1);

			}

		}
		contengencyTableOut.put("FREQUENCY", new ArrayList<>());

		// write to worksetout
		contengencyTable.forEach((key, value) -> {
			int idx = 0;
			for (String nameMatchingVariable : nameMatchingVariables) {
				contengencyTableOut.get(nameMatchingVariable).add(String.valueOf(key.charAt(idx++)));
			}
			contengencyTableOut.get("FREQUENCY").add(value.toString());
		});

		rolesOut.put(codContengencyTable, new ArrayList<>(contengencyTableOut.keySet()));
		returnOut.put(IS2Const.WF_OUTPUT_ROLES, rolesOut);

		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, codContengencyTable);
		});
		returnOut.put(IS2Const.WF_OUTPUT_ROLES_GROUP, rolesGroupOut);

		worksetOut.put(codContengencyTable, contengencyTableOut);
		returnOut.put(IS2Const.WF_OUTPUT_WORKSET, worksetOut);

		Instant finish = Instant.now();
		System.out
				.println(" contingencyTableNoParalel Durata in millis: " + Duration.between(start, finish).toMillis());

		return returnOut;
	}

	public static List<String> getFieldsInParams(String jsonString, String fieldName) throws Exception {
		List<String> ret = new ArrayList<>();
		try {
			JSONObject jSONObject = new JSONObject(jsonString);
			JSONArray fields = jSONObject.getJSONArray(fieldName);
			for (int i = 0; i < fields.length(); i++) {
				ret.add(fields.getString(i));
			}

		} catch (Exception e) {

			throw new Exception("Error parsing parameter " + fieldName);
		}

		return ret;

	}

	public Map<?, ?> pRLResultTablesBlockingVariables(Long idelaborazione,
			Map<String, ArrayList<String>> ruoliVariabileNome, Map<String, List<String>> worksetIn,
			Map<String, String> parametriMap) throws Exception {

		final Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> matchingTable = Collections.synchronizedMap(new LinkedHashMap<>());
		final Map<String, ArrayList<String>> possibleMatchingTable = Collections.synchronizedMap(new LinkedHashMap<>());
		final Map<String, ArrayList<String>> residualATable = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> residualBTable = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

		logService.save("Process Matching Tables Blocking Starting...");

		// <codRuolo,[namevar1,namevar2..]
		int indexItems = 0;
		ArrayList<String> patternMatching = new ArrayList<>();
		ArrayList<String> patternPossibleMatching = new ArrayList<>();
		Map<String, String> patternPPostValues = new HashMap<>();
		String paramTM = parametriMap.get(params_ThresholdMatching);
		String paramTU = parametriMap.get(params_ThresholdUnMatching);

		checkThresholds(paramTM, paramTU);

		logService.save("Threshold Matching: " + paramTM);
		logService.save("Threshold UnMatching: " + paramTU);

		// select pattern by P_POST value
		for (String pPostVarname : ruoliVariabileNome.get(codeFS)) {

			if (codeP_POST.equals(pPostVarname)) {
				indexItems = 0;

				for (String pPostValue : worksetIn.get(pPostVarname)) {
					if (Float.parseFloat(pPostValue) >= Float.parseFloat(paramTU)) {
						StringBuffer pattern = new StringBuffer();

						for (String ctVarname : ruoliVariabileNome.get(codContengencyTable)) {
							if (!ctVarname.equals(IS2Const.WORKSET_FREQUENCY)) {
								String p = worksetIn.get(ctVarname).get(indexItems);
								pattern.append(Double.valueOf(p).intValue());
							}
						}

						if (Float.parseFloat(pPostValue) >= Float.parseFloat(paramTM)) {
							patternMatching.add(pattern.toString());
						} else {
							patternPossibleMatching.add(pattern.toString());
						}
						patternPPostValues.put(pattern.toString(), pPostValue);
					}
					indexItems++;
				}
			}
		}

		logService.save("Pattern  Matching: " + patternMatching);
		logService.save("Pattern  Possible Matching: " + patternPossibleMatching);

		final ArrayList<String> variabileNomeListMA = new ArrayList<>();
		final ArrayList<String> variabileNomeListMB = new ArrayList<>();

		final List<String> blockingVariablesA = new ArrayList<>();
		final List<String> blockingVariablesB = new ArrayList<>();

		final ArrayList<String> variabileNomeListOut = new ArrayList<>();

		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});

		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});

		blockingVariablesA
				.addAll(getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesA));
		blockingVariablesB
				.addAll(getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesB));

		logService.save("Matching variables dataset A: " + variabileNomeListMA);
		logService.save("Matching variables dataset B: " + variabileNomeListMB);
		logService.save("Blocking variables dataset A: " + blockingVariablesA);
		logService.save("Blocking variables dataset B: " + blockingVariablesB);

		variabileNomeListOut.addAll(variabileNomeListMA);
		variabileNomeListOut.addAll(variabileNomeListMB);
		variabileNomeListOut.add(codeP_POST);

		rolesOut.put(codMachingTable, variabileNomeListOut);
		rolesOut.put(codPossibleMachingTable, variabileNomeListOut);
		rolesOut.put(codResidualA, variabileNomeListMA);
		rolesOut.put(codResidualB, variabileNomeListMB);

		contingencyService.init(parametriMap.get(params_MatchingVariables));
		variabileNomeListOut.forEach(varname -> {
			matchingTable.put(varname, new ArrayList<>());
			possibleMatchingTable.put(varname, new ArrayList<>());
		});

		Map<String, List<Integer>> indexesBlockingVariableA = Utility.blockVariablesIndexMapValues(worksetIn,
				blockingVariablesA);
		Map<String, List<Integer>> indexesBlockingVariableB = Utility.blockVariablesIndexMapValues(worksetIn,
				blockingVariablesB);

		logService.save("Size Blocking dataset A: " + indexesBlockingVariableA.size());
		logService.save("Size Blocking dataset B: " + indexesBlockingVariableB.size());

		indexesBlockingVariableA.entrySet().parallelStream().forEach(entry -> {
			String keyBlock = entry.getKey();
			final Map<String, ArrayList<String>> matchingTableIA = new LinkedHashMap<>();
			final Map<String, ArrayList<String>> possibleMatchingTableIA = new LinkedHashMap<>();

			variabileNomeListOut.forEach(varname -> {
				matchingTableIA.put(varname, new ArrayList<>());
				possibleMatchingTableIA.put(varname, new ArrayList<>());
			});

			// Dataset A
			entry.getValue().forEach(innerIA -> {

				Map<String, String> valuesI = new HashMap<>();

				variabileNomeListMA.forEach(varnameMA -> {
					valuesI.put(varnameMA, worksetIn.get(varnameMA).get(innerIA));
				});

				if (indexesBlockingVariableB.get(keyBlock) != null)
					indexesBlockingVariableB.get(keyBlock).forEach(innerIB -> {

						variabileNomeListMB.forEach(varnameMB -> {
							valuesI.put(varnameMB, worksetIn.get(varnameMB).get(innerIB));
						});
						String pattern = contingencyService.getPattern(valuesI);
						if (patternMatching.contains(pattern)) {
							valuesI.forEach((k, v) -> {
								matchingTableIA.get(k).add(v);
							});
							matchingTableIA.get(codeP_POST).add(patternPPostValues.get(pattern));
						} else if (patternPossibleMatching.contains(pattern)) {
							valuesI.forEach((k, v) -> {
								possibleMatchingTableIA.get(k).add(v);
							});
							possibleMatchingTableIA.get(codeP_POST).add(patternPPostValues.get(pattern));
						}

					});
			});

			synchronized (matchingTable) {
				matchingTableIA.entrySet().stream()
						.forEach(e -> matchingTable.get(e.getKey()).addAll(matchingTableIA.get(e.getKey())));
			}

			synchronized (possibleMatchingTable) {
				possibleMatchingTableIA.entrySet().stream().forEach(
						e -> possibleMatchingTable.get(e.getKey()).addAll(possibleMatchingTableIA.get(e.getKey())));
			}

		});
		returnOut.put(IS2Const.WF_OUTPUT_ROLES, rolesOut);
		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(IS2Const.WF_OUTPUT_ROLES_GROUP, rolesGroupOut);

		worksetOut.put(codResidualB, residualBTable);
		worksetOut.put(codResidualA, residualATable);
		worksetOut.put(codPossibleMachingTable, possibleMatchingTable);
		worksetOut.put(codMachingTable, matchingTable);
		returnOut.put(IS2Const.WF_OUTPUT_WORKSET, worksetOut);
		return returnOut;
	}

	public Map<?, ?> pRLResultTablesCartesianProduct(Long idelaborazione,
			Map<String, ArrayList<String>> ruoliVariabileNome, Map<String, ArrayList<String>> worksetIn,
			Map<String, String> parametriMap) throws Exception {

		final Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> matchingTable = Collections.synchronizedMap(new LinkedHashMap<>());
		final Map<String, ArrayList<String>> possibleMatchingTable = Collections.synchronizedMap(new LinkedHashMap<>());
		final Map<String, ArrayList<String>> residualATable = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> residualBTable = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

		logService.save("Process Matching Tables  Starting...");

		// <codRuolo,[namevar1,namevar2..]
		int indexItems = 0;
		ArrayList<String> patternMatching = new ArrayList<>();
		ArrayList<String> patternPossibleMatching = new ArrayList<>();
		Map<String, String> patternPPostValues = new HashMap<>();
		String paramTM = parametriMap.get(params_ThresholdMatching);
		String paramTU = parametriMap.get(params_ThresholdUnMatching);

		checkThresholds(paramTM, paramTU);

		logService.save("Threshold Matching: " + paramTM);
		logService.save("Threshold UnMatching: " + paramTU);

		// select pattern by P_POST value
		for (String pPostVarname : ruoliVariabileNome.get(codeFS)) {

			if (codeP_POST.equals(pPostVarname)) {
				indexItems = 0;

				for (String pPostValue : worksetIn.get(pPostVarname)) {
					if (Float.parseFloat(pPostValue) >= Float.parseFloat(paramTU)) {
						StringBuffer pattern = new StringBuffer();

						for (String ctVarname : ruoliVariabileNome.get(codContengencyTable)) {
							if (!ctVarname.equals(IS2Const.WORKSET_FREQUENCY)) {
								String p = worksetIn.get(ctVarname).get(indexItems);
								pattern.append(Double.valueOf(p).intValue());
							}
						}

						if (Float.parseFloat(pPostValue) >= Float.parseFloat(paramTM)) {
							patternMatching.add(pattern.toString());
						} else {
							patternPossibleMatching.add(pattern.toString());
						}
						patternPPostValues.put(pattern.toString(), pPostValue);
					}
					indexItems++;
				}
			}
		}

		logService.save("Pattern  Matching: " + patternMatching);
		logService.save("Pattern  Possible Matching: " + patternPossibleMatching);

		ArrayList<String> variabileNomeListMA = new ArrayList<>();
		ArrayList<String> variabileNomeListMB = new ArrayList<>();
		ArrayList<String> variabileNomeListOut = new ArrayList<>();

		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});
		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});

		logService.save("Matching variables dataset A: " + variabileNomeListMA);
		logService.save("Matching variables dataset B: " + variabileNomeListMB);

		variabileNomeListOut.addAll(variabileNomeListMA);
		variabileNomeListOut.addAll(variabileNomeListMB);
		variabileNomeListOut.add(codeP_POST);

		rolesOut.put(codMachingTable, variabileNomeListOut);
		rolesOut.put(codPossibleMachingTable, variabileNomeListOut);
		rolesOut.put(codResidualA, variabileNomeListMA);
		rolesOut.put(codResidualB, variabileNomeListMB);

		String firstFiledMA = ruoliVariabileNome.get(codeMatchingA).get(0);
		String firstFiledMB = ruoliVariabileNome.get(codeMatchingB).get(0);
		int sizeA = worksetIn.get(firstFiledMA).size();
		int sizeB = worksetIn.get(firstFiledMB).size();

		contingencyService.init(parametriMap.get(params_MatchingVariables));
		variabileNomeListOut.forEach(varname -> {
			matchingTable.put(varname, new ArrayList<>());
			possibleMatchingTable.put(varname, new ArrayList<>());
		});

		indexItems = 0;
		IntStream.range(0, sizeA).parallel().forEach(innerIA -> {

			final Map<String, String> valuesI = new HashMap<>();
			final Map<String, ArrayList<String>> matchingTableIA = new HashMap<>();
			final Map<String, ArrayList<String>> possibleMatchingTableIA = new HashMap<>();

			variabileNomeListOut.forEach(varname -> {
				matchingTableIA.put(varname, new ArrayList<>());
				possibleMatchingTableIA.put(varname, new ArrayList<>());
			});

			variabileNomeListMA.forEach(varnameMA -> {
				valuesI.put(varnameMA, worksetIn.get(varnameMA).get(innerIA));
			});

			IntStream.range(0, sizeB).forEach(innerIB -> {
				variabileNomeListMB.forEach(varnameMB -> {
					valuesI.put(varnameMB, worksetIn.get(varnameMB).get(innerIB));
				});
				String pattern = contingencyService.getPattern(valuesI);
				if (patternMatching.contains(pattern)) {
					valuesI.forEach((k, v) -> {
						matchingTableIA.get(k).add(v);
					});
					matchingTableIA.get(codeP_POST).add(patternPPostValues.get(pattern));
				} else if (patternPossibleMatching.contains(pattern)) {
					valuesI.forEach((k, v) -> {
						possibleMatchingTableIA.get(k).add(v);
					});
					possibleMatchingTableIA.get(codeP_POST).add(patternPPostValues.get(pattern));
				}

			});

			synchronized (matchingTable) {
				matchingTableIA.entrySet().stream()
						.forEach(e -> matchingTable.get(e.getKey()).addAll(matchingTableIA.get(e.getKey())));
			}

			synchronized (possibleMatchingTable) {
				possibleMatchingTableIA.entrySet().stream().forEach(
						e -> possibleMatchingTable.get(e.getKey()).addAll(possibleMatchingTableIA.get(e.getKey())));
			}

		});

		returnOut.put(IS2Const.WF_OUTPUT_ROLES, rolesOut);
		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(IS2Const.WF_OUTPUT_ROLES_GROUP, rolesGroupOut);

		worksetOut.put(codResidualB, residualBTable);
		worksetOut.put(codResidualA, residualATable);
		worksetOut.put(codPossibleMachingTable, possibleMatchingTable);
		worksetOut.put(codMachingTable, matchingTable);
		returnOut.put(IS2Const.WF_OUTPUT_WORKSET, worksetOut);
		return returnOut;
	}

	public Map<?, ?> dRLCartesianProduct(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, ArrayList<String>> worksetIn, Map<String, String> parametriMap) throws Exception {

		final Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> matchingTable = Collections.synchronizedMap(new LinkedHashMap<>());
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

		logService.save("Process deterministic Matching Tables  Starting...");

		// <codRuolo,[namevar1,namevar2..]
		ArrayList<String> variabileNomeListMA = new ArrayList<>();
		ArrayList<String> variabileNomeListMB = new ArrayList<>();
		ArrayList<String> variabileNomeListOut = new ArrayList<>();

		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});
		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});

		logService.save("Matching variables dataset A: " + variabileNomeListMA);
		logService.save("Matching variables dataset B: " + variabileNomeListMB);

		variabileNomeListOut.addAll(variabileNomeListMA);
		variabileNomeListOut.addAll(variabileNomeListMB);

		rolesOut.put(codMachingTable, variabileNomeListOut);

		String firstFiledMA = ruoliVariabileNome.get(codeMatchingA).get(0);
		String firstFiledMB = ruoliVariabileNome.get(codeMatchingB).get(0);
		int sizeA = worksetIn.get(firstFiledMA).size();
		int sizeB = worksetIn.get(firstFiledMB).size();

		contingencyService.init(parametriMap.get(params_MatchingVariables));
		variabileNomeListOut.forEach(varname -> {
			matchingTable.put(varname, new ArrayList<>());

		});

		IntStream.range(0, sizeA).parallel().forEach(innerIA -> {

			final Map<String, String> valuesI = new HashMap<>();
			final Map<String, ArrayList<String>> matchingTableIA = new HashMap<>();
			final Map<String, ArrayList<String>> possibleMatchingTableIA = new HashMap<>();

			variabileNomeListOut.forEach(varname -> {
				matchingTableIA.put(varname, new ArrayList<>());
				possibleMatchingTableIA.put(varname, new ArrayList<>());
			});

			variabileNomeListMA.forEach(varnameMA -> {
				valuesI.put(varnameMA, worksetIn.get(varnameMA).get(innerIA));
			});

			IntStream.range(0, sizeB).forEach(innerIB -> {
				variabileNomeListMB.forEach(varnameMB -> {
					valuesI.put(varnameMB, worksetIn.get(varnameMB).get(innerIB));
				});
				if (contingencyService.isExactMatching(valuesI)) {
					valuesI.forEach((k, v) -> {
						matchingTableIA.get(k).add(v);
					});

				}

			});

			synchronized (matchingTable) {
				matchingTableIA.entrySet().stream()
						.forEach(e -> matchingTable.get(e.getKey()).addAll(matchingTableIA.get(e.getKey())));
			}

		});

		returnOut.put(IS2Const.WF_OUTPUT_ROLES, rolesOut);
		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(IS2Const.WF_OUTPUT_ROLES_GROUP, rolesGroupOut);

		worksetOut.put(codMachingTable, matchingTable);
		returnOut.put(IS2Const.WF_OUTPUT_WORKSET, worksetOut);
		return returnOut;

	}

	public Map<?, ?> dRLBlockingVariables(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, List<String>> worksetIn, Map<String, String> parametriMap) throws Exception {

		final Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> matchingTable = Collections.synchronizedMap(new LinkedHashMap<>());
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

		logService.save("Process Deterministic Matching Tables Blocking Starting...");

		final ArrayList<String> variabileNomeListMA = new ArrayList<>();
		final ArrayList<String> variabileNomeListMB = new ArrayList<>();

		final List<String> blockingVariablesA = new ArrayList<>();
		final List<String> blockingVariablesB = new ArrayList<>();

		final ArrayList<String> variabileNomeListOut = new ArrayList<>();

		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});

		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});

		blockingVariablesA
				.addAll(getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesA));

		// ruoliVariabileNome.get(codeBlockingVariablesA).forEach((varname) -> {
		// blockingVariablesA.add(varname);
		// });

		// ruoliVariabileNome.get(codeBlockingVariablesB).forEach((varname) -> {
		// blockingVariablesB.add(varname);
		// });
		blockingVariablesB
				.addAll(getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesB));

		logService.save("Matching variables dataset A: " + variabileNomeListMA);
		logService.save("Matching variables dataset B: " + variabileNomeListMB);
		logService.save("Blocking variables dataset A: " + blockingVariablesA);
		logService.save("Blocking variables dataset B: " + blockingVariablesB);

		variabileNomeListOut.addAll(variabileNomeListMA);
		variabileNomeListOut.addAll(variabileNomeListMB);

		rolesOut.put(codMachingTable, variabileNomeListOut);

		contingencyService.init(parametriMap.get(params_MatchingVariables));
		variabileNomeListOut.forEach(varname -> {
			matchingTable.put(varname, new ArrayList<>());

		});

		Map<String, List<Integer>> indexesBlockingVariableA = Utility.blockVariablesIndexMapValues(worksetIn,
				blockingVariablesA);
		Map<String, List<Integer>> indexesBlockingVariableB = Utility.blockVariablesIndexMapValues(worksetIn,
				blockingVariablesB);

		logService.save("Size Blocking dataset A: " + indexesBlockingVariableA.size());
		logService.save("Size Blocking dataset B: " + indexesBlockingVariableB.size());

		indexesBlockingVariableA.entrySet().parallelStream().forEach(entry -> {

			String keyBlock = entry.getKey();
			final Map<String, ArrayList<String>> matchingTableIA = new LinkedHashMap<>();
			final Map<String, ArrayList<String>> possibleMatchingTableIA = new LinkedHashMap<>();

			variabileNomeListOut.forEach(varname -> {
				matchingTableIA.put(varname, new ArrayList<>());
				possibleMatchingTableIA.put(varname, new ArrayList<>());
			});

			// Dataset A
			entry.getValue().forEach(innerIA -> {

				Map<String, String> valuesI = new HashMap<>();

				variabileNomeListMA.forEach(varnameMA -> {
					valuesI.put(varnameMA, worksetIn.get(varnameMA).get(innerIA));
				});

				if (indexesBlockingVariableB.get(keyBlock) != null)
					indexesBlockingVariableB.get(keyBlock).forEach(innerIB -> {

						variabileNomeListMB.forEach(varnameMB -> {
							valuesI.put(varnameMB, worksetIn.get(varnameMB).get(innerIB));
						});

						if (contingencyService.isExactMatching(valuesI)) {
							valuesI.forEach((k, v) -> {
								matchingTableIA.get(k).add(v);
							});

						}

					});
			});

			synchronized (matchingTable) {
				matchingTableIA.entrySet().stream()
						.forEach(e -> matchingTable.get(e.getKey()).addAll(matchingTableIA.get(e.getKey())));
			}

		});
		returnOut.put(IS2Const.WF_OUTPUT_ROLES, rolesOut);
		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(IS2Const.WF_OUTPUT_ROLES_GROUP, rolesGroupOut);

		worksetOut.put(codMachingTable, matchingTable);
		returnOut.put(IS2Const.WF_OUTPUT_WORKSET, worksetOut);
		return returnOut;
	}

	private void checkThresholds(String paramTM, String paramTU) throws Exception {
		try {
			if (Float.parseFloat(paramTU) > Float.parseFloat(paramTM)) {
				throw new Exception();
			}
		} catch (Exception e) {
			throw new Exception("Incorrect Threshold value!");
		}

	}

}
