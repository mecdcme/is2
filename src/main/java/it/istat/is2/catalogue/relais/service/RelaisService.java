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
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.IntStream;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.ReflectionUtils;
import org.springframework.util.StringUtils;

import it.istat.is2.app.service.LogService;
import it.istat.is2.app.util.IS2Exception;
import it.istat.is2.app.util.IS2ExceptionCodes;
import it.istat.is2.app.util.Utility;
import it.istat.is2.catalogue.relais.simhash.Simhash;
import it.istat.is2.catalogue.relais.utility.RelaisUtility;
import it.istat.is2.workflow.engine.EngineService;

/**
 * @author framato
 *
 */
@Component
public class RelaisService {

	final static int stepService = 250;
	final static int sizeFlushed = 20;
	final static int MAXINDEXNUM = 100000;
	final static String INDEX_SEPARATOR = ";";
	final static String PREFIX_PATTERN = "P_";
	final static String NOT_AV = "N.A.";

	final static String codeMatchingA = "X1";
	final static String codeMatchingB = "X2";
	final static String codContingencyTable = "CT";
	final static String codContingencyIndexTable = "CIT";
	final static String codMatchingTable = "MT";
	final static String codPossibleMatchingTable = "PM";
	final static String codResidualA = "RA";
	final static String codResidualB = "RB";
	final static String codQualityIndicators = "QI";
	final static String codeFS = "FS";
	final static String codeP_POST = "P_POST";
	final static String codeRATIO = "R";
	final static String codeOUT = "OUTPUTS";
	final static String codePREC = "PRECISION";
	final static String codeREC = "RECALL";
	final static String codeTHR = "THRESHOLD";
	final static String codMatchingTableReduced = "MTR";
	final static String codPossibleMatchingTableReduced = "PMR";

	final static String params_MatchingVariables = "MATCHING_VARIABLES";
	final static String params_ThresholdMatching = "THRESHOLD_MATCHING";
	final static String params_ThresholdUnMatching = "THRESHOLD_UNMATCHING";
	final static String params_BlockingVariables = "BLOCKING";
	final static String params_BlockingVariablesA = "BLOCKING A";
	final static String params_BlockingVariablesB = "BLOCKING B";
	final static String params_SortedNeghborhood = "SORTED NEIGHBORHOOD";
	final static String params_SortingVariablesA = "SORTING A";
	final static String params_SortingVariablesB = "SORTING B";
	final static String param_WindowSize = "WINDOW";
	final static String params_simhash = "SIMHASH";
	final static String params_ShinglingA = "SHINGLING A";
	final static String params_ShinglingB = "SHINGLING B";
	final static String params_HDThr = "HDTHRESHOLD";
	final static String params_Rotations = "ROTATIONS";

	final static String codeBlockingVariablesA = "BA";
	final static String codeBlockingVariablesB = "BB";
	final static String params_ReductionMethod = "REDUCTION_METHOD";
	final static String VARIABLE_FREQUENCY = "FREQUENCY";
	final static String ROW_IA = "ROW_A";
	final static String ROW_IB = "ROW_B";

	@Autowired
	private LogService logService;

	@Autowired
	private ContingencyService contingencyService;

	// used
	public Map<?, ?> probabilisticContingencyTable(Long idelaborazione,
			Map<String, ArrayList<String>> ruoliVariabileNome, Map<String, Map<String, List<String>>> worksetIn,
			Map<String, String> parametriMap) throws Exception {

		return callGenericMethod("pRLContingencyTable", idelaborazione, ruoliVariabileNome, worksetIn, parametriMap);
	}

	// not used?
	public Map<?, ?> deterministicRecordLinkage(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, Map<String, List<String>>> worksetIn, Map<String, String> parametriMap) throws Exception {

		return callGenericMethod("dRL", idelaborazione, ruoliVariabileNome, worksetIn, parametriMap);
	}

	// used
	private Map<?, ?> callGenericMethod(String prefixMethod, Long idelaborazione,
			Map<String, ArrayList<String>> ruoliVariabileNome, Map<String, Map<String, List<String>>> worksetIn,
			Map<String, String> parametriMap) throws Exception {

		final String jsonString = parametriMap.get(params_ReductionMethod);
		final JSONObject reductionJSONObject = new JSONObject(jsonString);
		final String dRLMethod = prefixMethod + reductionJSONObject.getString("REDUCTION-METHOD");
		if (StringUtils.isEmpty(dRLMethod))
			throw new IS2Exception(IS2ExceptionCodes.METHOD_NOT_FOUND);
		final Method method = ReflectionUtils.findMethod(this.getClass(), dRLMethod, Long.class, Map.class, Map.class,
				Map.class);

		Iterator<String> iterator = reductionJSONObject.keys();

		while (iterator.hasNext()) {
			String keyStr = iterator.next();

			parametriMap.put(keyStr, reductionJSONObject.get(keyStr).toString());
		}

		if (method == null) throw new Exception("Relais.Service-method not found");
		return (Map<?, ?>) method.invoke(this, idelaborazione, ruoliVariabileNome, worksetIn, parametriMap);
	}

	// used
	public Map<?, ?> pRLContingencyTableCartesianProduct(Long idelaborazione,
			Map<String, List<String>> ruoliVariabileNome, Map<String, Map<String, List<String>>> worksetIn,
			Map<String, String> parametriMap) throws Exception {

		final Map<String, Map<?, ?>> returnOut = new HashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new HashMap<>();

		final Map<String, ArrayList<String>> contingencyTableOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

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
		int sizeA = worksetIn.get(codeMatchingA).get(firstFiledMA).size();
		int sizeB = worksetIn.get(codeMatchingB).get(firstFiledMB).size();

		try {
			contingencyService.init(parametriMap.get(params_MatchingVariables), worksetIn.get(codeMatchingA),
					worksetIn.get(codeMatchingB));
		} catch (Exception e) {
			logService.save("Error parsing " + params_MatchingVariables);
			throw new Exception("Error parsing " + params_MatchingVariables);
		}
		List<String> nameMatchingVariables = new ArrayList<>();

		contingencyService.getMetricMatchingVariableVector().forEach(metricsm -> {
			contingencyTableOut.put(metricsm.getMatchingVariable(), new ArrayList<>());
			nameMatchingVariables.add(metricsm.getMatchingVariable());
		});

		final Map<String, Long> contingencyTable = Collections
				.synchronizedMap(contingencyService.getEmptyContingencyTable());

		final Map<String, List<String>> coupledIndexByPattern = RelaisUtility
				.getEmptyMapByKey(contingencyTable.keySet().stream(), PREFIX_PATTERN);

		final int CHUNK_SIZE = 8;

		int partitionSize = (sizeA / CHUNK_SIZE) + ((sizeA % CHUNK_SIZE) == 0 ? 0 : 1);
		ArrayList<String> notAv = new ArrayList<String>();
		notAv.add(NOT_AV);

		IntStream.range(0, partitionSize).parallel().forEach(chunkIndex -> {

			int inf = (chunkIndex * CHUNK_SIZE);
			int sup = (chunkIndex == partitionSize - 1) ? sizeA - 1 : (inf + CHUNK_SIZE - 1);

			final Map<String, Long> contingencyTableIA = contingencyService.getEmptyContingencyTable();
			final Map<String, List<String>> coupledIndexByPatternIA = RelaisUtility
					.getEmptyMapByKey(coupledIndexByPattern.keySet().stream(), "");

			IntStream.rangeClosed(inf, sup).forEach(innerIA -> {

				final Map<String, String> valuesI = new HashMap<>();

				variabileNomeListMA.forEach(varnameMA -> {
					valuesI.put(varnameMA, worksetIn.get(codeMatchingA).get(varnameMA).get(innerIA));
				});

				IntStream.range(0, sizeB).forEach(innerIB -> {
					variabileNomeListMB.forEach(varnameMB -> {
						valuesI.put(varnameMB, worksetIn.get(codeMatchingB).get(varnameMB).get(innerIB));
					});

					String pattern = contingencyService.getPattern(valuesI);
					long freq = contingencyTableIA.get(pattern);
					contingencyTableIA.put(pattern, freq + 1);

					if (freq < MAXINDEXNUM) {
						String phrase = (innerIA + 1) + ";" + (innerIB + 1);
						coupledIndexByPatternIA.get(PREFIX_PATTERN + pattern).add(phrase);
					} else {

						coupledIndexByPatternIA.put(PREFIX_PATTERN + pattern, notAv);

					}
				});
			});

			synchronized (contingencyTable) {
				contingencyTableIA.entrySet().stream().forEach(e -> contingencyTable.put(e.getKey(),
						contingencyTable.get(e.getKey()) + contingencyTableIA.get(e.getKey())));
			}

			synchronized (coupledIndexByPattern) {

				contingencyTableIA.entrySet().stream().forEach(e -> {
					String pattern = e.getKey();

					if (contingencyTable.get(pattern) <= MAXINDEXNUM)
						coupledIndexByPattern.get(PREFIX_PATTERN + pattern)
								.addAll(coupledIndexByPatternIA.get(PREFIX_PATTERN + pattern));
					else
						coupledIndexByPattern.put(PREFIX_PATTERN + pattern, notAv);
				});
			}

		});
		contingencyTableOut.put(VARIABLE_FREQUENCY, new ArrayList<>());

		contingencyTable.forEach((key, value) -> {
			int idx = 0;
			for (String nameMatchingVariable : nameMatchingVariables) {
				contingencyTableOut.get(nameMatchingVariable).add(String.valueOf(key.charAt(idx++)));
			}
			contingencyTableOut.get(VARIABLE_FREQUENCY).add(value.toString());
		});

		rolesOut.put(codContingencyTable, new ArrayList<>(contingencyTableOut.keySet()));

		rolesOut.put(codContingencyIndexTable, new ArrayList<>(coupledIndexByPattern.keySet()));
		returnOut.put(EngineService.ROLES_OUT, rolesOut);

		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

		worksetOut.put(codContingencyTable, contingencyTableOut);
		worksetOut.put(codContingencyIndexTable, coupledIndexByPattern);

		returnOut.put(EngineService.WORKSET_OUT, worksetOut);

		return returnOut;
	}

	// not used
	public Map<?, ?> pRLContingencyTableCartesianProduct_old(Long idelaborazione,
			Map<String, List<String>> ruoliVariabileNome, Map<String, Map<String, List<String>>> worksetIn,
			Map<String, String> parametriMap) throws Exception {

		final Map<String, Map<?, ?>> returnOut = new HashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new HashMap<>();

		final Map<String, ArrayList<String>> contingencyTableOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

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
		int sizeA = worksetIn.get(codeMatchingA).get(firstFiledMA).size();
		int sizeB = worksetIn.get(codeMatchingB).get(firstFiledMB).size();

		try {
			contingencyService.init(parametriMap.get(params_MatchingVariables), worksetIn.get(codeMatchingA),
					worksetIn.get(codeMatchingB));
		} catch (Exception e) {
			logService.save("Error parsing " + params_MatchingVariables);
			throw new Exception("Error parsing " + params_MatchingVariables);
		}
		List<String> nameMatchingVariables = new ArrayList<>();

		contingencyService.getMetricMatchingVariableVector().forEach(metricsm -> {
			contingencyTableOut.put(metricsm.getMatchingVariable(), new ArrayList<>());
			nameMatchingVariables.add(metricsm.getMatchingVariable());
		});

		final Map<String, Long> contingencyTable = Collections
				.synchronizedMap(contingencyService.getEmptyContingencyTable());

		final Map<String, StringBuilder> coupledIndexByPattern = RelaisUtility.getEmptyMapByKeyStringB(
				contingencyTable.keySet().stream().filter(key -> Integer.parseInt(key) > 0), PREFIX_PATTERN);

		IntStream.range(0, sizeA).parallel().forEach(innerIA -> {

			final Map<String, String> valuesI = new HashMap<>();
			final Map<String, Long> contingencyTableIA = contingencyService.getEmptyContingencyTable();
			final Map<String, StringBuilder> coupledIndexByPatternIA = RelaisUtility
					.getEmptyMapByKeyStringB(coupledIndexByPattern.keySet().stream(), "");

			variabileNomeListMA.forEach(varnameMA -> {
				valuesI.put(varnameMA, worksetIn.get(codeMatchingA).get(varnameMA).get(innerIA));
			});

			IntStream.range(0, sizeB).forEach(innerIB -> {
				variabileNomeListMB.forEach(varnameMB -> {
					valuesI.put(varnameMB, worksetIn.get(codeMatchingB).get(varnameMB).get(innerIB));
				});

				String pattern = contingencyService.getPattern(valuesI);
				contingencyTableIA.put(pattern, contingencyTableIA.get(pattern) + 1);
				if (Integer.parseInt(pattern) > 0) {
					CharSequence phrase = (innerIA + 1) + ";" + (innerIB + 1);
					coupledIndexByPatternIA.get(PREFIX_PATTERN + pattern).append(phrase); // store
																							// no
																							// zero
																							// based
				}

			});
			synchronized (contingencyTable) {
				contingencyTableIA.entrySet().stream().forEach(e -> contingencyTable.put(e.getKey(),
						contingencyTable.get(e.getKey()) + contingencyTableIA.get(e.getKey())));
			}
			synchronized (coupledIndexByPattern) {
				coupledIndexByPatternIA.entrySet().stream().forEach(
						e -> coupledIndexByPattern.get(e.getKey()).append(coupledIndexByPatternIA.get(e.getKey())));
			}

		});
		contingencyTableOut.put(VARIABLE_FREQUENCY, new ArrayList<>());
		// write to worksetout
		contingencyTable.forEach((key, value) -> {
			int idx = 0;
			for (String nameMatchingVariable : nameMatchingVariables) {
				contingencyTableOut.get(nameMatchingVariable).add(String.valueOf(key.charAt(idx++)));
			}
			contingencyTableOut.get(VARIABLE_FREQUENCY).add(value.toString());
		});

		rolesOut.put(codContingencyTable, new ArrayList<>(contingencyTableOut.keySet()));
		// rolesOut.put(codContingencyIndexTable, new
		// ArrayList<>(coupledIndexByPattern.keySet()));
		returnOut.put(EngineService.ROLES_OUT, rolesOut);

		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

		worksetOut.put(codContingencyTable, contingencyTableOut);

		returnOut.put(EngineService.WORKSET_OUT, worksetOut);

		return returnOut;
	}

	// used
	public Map<?, ?> pRLContingencyTableBlockingVariables(Long idelaborazione,
			Map<String, List<String>> ruoliVariabileNome, Map<String, Map<String, List<String>>> worksetIn,
			Map<String, String> parametriMap) throws Exception {

		final Map<String, Map<?, ?>> returnOut = new HashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new HashMap<>();
		final Map<String, ArrayList<String>> contingencyTableOut = new LinkedHashMap<>();
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

		blockingVariablesA.addAll(
				RelaisUtility.getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesA));
		blockingVariablesB.addAll(
				RelaisUtility.getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesB));

		logService.save("Blocking variables dataset A: " + blockingVariablesA);
		logService.save("Blocking variables dataset B: " + blockingVariablesB);

		ruoliVariabileNome.values().forEach((list) -> {
			variabileNomeListOut.addAll(list);
		});

		try {
			contingencyService.init(parametriMap.get(params_MatchingVariables), worksetIn.get(codeMatchingA),
					worksetIn.get(codeMatchingB));
		} catch (Exception e) {
			logService.save("Error parsing " + params_MatchingVariables);
			throw new Exception("Error parsing " + params_MatchingVariables);
		}
		List<String> nameMatchingVariables = new ArrayList<>();

		contingencyService.getMetricMatchingVariableVector().forEach(metricsm -> {
			contingencyTableOut.put(metricsm.getMatchingVariable(), new ArrayList<>());
			nameMatchingVariables.add(metricsm.getMatchingVariable());
		});

		if (Utility.isNullOrEmpty(blockingVariablesA) || Utility.isNullOrEmpty(blockingVariablesB)) {
			logService.save("Error parsing BLOCKING VARAIABLES");
			throw new Exception("Error parsing BLOCKING VARAIABLES");
		}

		Map<String, List<Integer>> indexesBlockingVariableA = RelaisUtility
				.blockVariablesIndexMapValues(worksetIn.get(codeMatchingA), blockingVariablesA);
		Map<String, List<Integer>> indexesBlockingVariableB = RelaisUtility
				.blockVariablesIndexMapValues(worksetIn.get(codeMatchingB), blockingVariablesB);
		logService.save("Size Blocking dataset A: " + indexesBlockingVariableA.size());
		logService.save("Size Blocking dataset B: " + indexesBlockingVariableB.size());

		final Map<String, Long> contingencyTable = Collections
				.synchronizedMap(contingencyService.getEmptyContingencyTable());

		final Map<String, List<String>> coupledIndexByPattern = RelaisUtility
				.getEmptyMapByKey(contingencyTable.keySet().stream(), PREFIX_PATTERN);

		ArrayList<String> notAv = new ArrayList<String>();
		notAv.add(NOT_AV);

		indexesBlockingVariableA.entrySet().parallelStream().forEach(entry -> {
			String keyBlock = entry.getKey();

			final Map<String, Long> contingencyTableIA = contingencyService.getEmptyContingencyTable();
			final Map<String, List<String>> coupledIndexByPatternIA = RelaisUtility
					.getEmptyMapByKey(coupledIndexByPattern.keySet().stream(), "");

			// Dataset A
			entry.getValue().forEach(innerIA -> {

				final Map<String, String> valuesI = new HashMap<>();

				variabileNomeListMA.forEach(varnameMA -> {
					valuesI.put(varnameMA, worksetIn.get(codeMatchingA).get(varnameMA).get(innerIA));
				});
				if (indexesBlockingVariableB.get(keyBlock) != null)
					indexesBlockingVariableB.get(keyBlock).forEach(innerIB -> {

						variabileNomeListMB.forEach(varnameMB -> {
							valuesI.put(varnameMB, worksetIn.get(codeMatchingB).get(varnameMB).get(innerIB));
						});

						String pattern = contingencyService.getPattern(valuesI);
						long freq = contingencyTableIA.get(pattern);
						contingencyTableIA.put(pattern, freq + 1);

						if (freq < MAXINDEXNUM)
							coupledIndexByPatternIA.get(PREFIX_PATTERN + pattern)
									.add((innerIA + 1) + ";" + (innerIB + 1));
						else
							coupledIndexByPatternIA.put(PREFIX_PATTERN + pattern, notAv);

					});

			});

			synchronized (contingencyTable) {
				contingencyTableIA.entrySet().stream().forEach(e -> contingencyTable.put(e.getKey(),
						contingencyTable.get(e.getKey()) + contingencyTableIA.get(e.getKey())));
			}

			synchronized (coupledIndexByPattern) {
				// coupledIndexByPatternIA.entrySet().stream().forEach( e ->
				contingencyTableIA.entrySet().stream().forEach(e -> {
					String pattern = e.getKey();
					if (contingencyTable.get(pattern) <= MAXINDEXNUM)
						coupledIndexByPattern.get(PREFIX_PATTERN + pattern)
								.addAll(coupledIndexByPatternIA.get(PREFIX_PATTERN + pattern));
					else
						coupledIndexByPattern.put(PREFIX_PATTERN + pattern, notAv);
				});
			}

		});
		contingencyTableOut.put(VARIABLE_FREQUENCY, new ArrayList<>());

		// write to worksetout
		contingencyTable.forEach((key, value) -> {
			int idx = 0;
			for (String nameMatchingVariable : nameMatchingVariables) {
				contingencyTableOut.get(nameMatchingVariable).add(String.valueOf(key.charAt(idx++)));
			}
			contingencyTableOut.get(VARIABLE_FREQUENCY).add(value.toString());
		});

		rolesOut.put(codContingencyTable, new ArrayList<>(contingencyTableOut.keySet()));
		rolesOut.put(codContingencyIndexTable, new ArrayList<>(coupledIndexByPattern.keySet()));

		returnOut.put(EngineService.ROLES_OUT, rolesOut);

		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

		worksetOut.put(codContingencyTable, contingencyTableOut);
		worksetOut.put(codContingencyIndexTable, coupledIndexByPattern);

		returnOut.put(EngineService.WORKSET_OUT, worksetOut);
		logService.save("Process Contingency Table Blocking End");
		return returnOut;
	}

	// used?
	public Map<?, ?> probabilisticResultTables(final Long idelaborazione,
			final Map<String, ArrayList<String>> ruoliVariabileNome,
			final Map<String, Map<String, List<String>>> worksetIn, final Map<String, String> parametriMap)
			throws Exception {

		return callGenericMethod("pRLResultTables", idelaborazione, ruoliVariabileNome, worksetIn, parametriMap);
	}

	// not used
	public Map<?, ?> pRLResultTablesBlockingVariables(final Long idelaborazione,
			final Map<String, ArrayList<String>> ruoliVariabileNome,
			final Map<String, Map<String, List<String>>> worksetInn, final Map<String, String> parametriMap)
			throws Exception {

		final Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> matchingTable = Collections.synchronizedMap(new LinkedHashMap<>());
		final Map<String, ArrayList<String>> possibleMatchingTable = Collections.synchronizedMap(new LinkedHashMap<>());
		final Map<String, ArrayList<String>> residualATable = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> residualBTable = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> qualityIndicators = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

		logService.save("Process Matching Tables Blocking Starting...");

// <codRuolo,[namevar1,namevar2..]
		int indexItems = 0;
		final ArrayList<String> patternMatching = new ArrayList<>();
		final ArrayList<String> patternPossibleMatching = new ArrayList<>();
		final Map<String, String> patternPPostValues = new HashMap<>();
		final Map<String, String> patternRValues = new HashMap<>();
		final String paramTM = parametriMap.get(params_ThresholdMatching);
		final String paramTU = parametriMap.get(params_ThresholdUnMatching);
		float mprec = 1f, pprec = 1f, mrec = 0f, prec = 0f;

		checkThresholds(paramTM, paramTU);

		logService.save("Threshold Matching: " + paramTM);
		logService.save("Threshold UnMatching: " + paramTU);

// select pattern by P_POST value
		for (String pPostVarname : ruoliVariabileNome.get(codeFS)) {

			if (codeP_POST.equals(pPostVarname)) {
				indexItems = 0;

				for (String pPostValue : worksetInn.get(codeFS).get(pPostVarname)) {
					if (Float.parseFloat(pPostValue) >= Float.parseFloat(paramTU)) {
						StringBuffer pattern = new StringBuffer();

						String RValue = worksetInn.get(codeFS).get(codeRATIO).get(indexItems);
						float cprec = Float.parseFloat(worksetInn.get(codeFS).get(codePREC).get(indexItems));
						float crec = Float.parseFloat(worksetInn.get(codeFS).get(codeREC).get(indexItems));

						for (String ctVarname : ruoliVariabileNome.get(codContingencyTable)) {
							if (!ctVarname.equals(VARIABLE_FREQUENCY)) {
								String p = worksetInn.get(codeFS).get(ctVarname).get(indexItems);
								pattern.append(Double.valueOf(p).intValue());
							}
						}

						if (Float.parseFloat(pPostValue) >= Float.parseFloat(paramTM)) {
							patternMatching.add(pattern.toString());
							if (cprec < mprec)
								mprec = cprec;
							if (cprec < pprec)
								pprec = cprec;
							if (crec > mrec)
								mrec = crec;
							if (crec > prec)
								prec = crec;
						} else {
							patternPossibleMatching.add(pattern.toString());
							if (cprec < pprec)
								pprec = cprec;
							if (crec > prec)
								prec = crec;
						}
						patternPPostValues.put(pattern.toString(), pPostValue);
						patternRValues.put(pattern.toString(), RValue);
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

		variabileNomeListMA.add(ROW_IA);
		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});

		variabileNomeListMB.add(ROW_IB);
		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});

		blockingVariablesA.addAll(
				RelaisUtility.getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesA));
		blockingVariablesB.addAll(
				RelaisUtility.getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesB));

		logService.save("Matching variables dataset A: " + variabileNomeListMA);
		logService.save("Matching variables dataset B: " + variabileNomeListMB);
		logService.save("Blocking variables dataset A: " + blockingVariablesA);
		logService.save("Blocking variables dataset B: " + blockingVariablesB);

		variabileNomeListOut.addAll(variabileNomeListMA);
		variabileNomeListOut.addAll(variabileNomeListMB);
		variabileNomeListOut.add(codeP_POST);
		variabileNomeListOut.add(codeRATIO);

		final ArrayList<String> variableQuality = new ArrayList<>();
		variableQuality.add(codeOUT);
		variableQuality.add(codeTHR);
		variableQuality.add(codePREC);
		variableQuality.add(codeREC);

		rolesOut.put(codMatchingTable, variabileNomeListOut);
		rolesOut.put(codPossibleMatchingTable, variabileNomeListOut);
		rolesOut.put(codResidualA, variabileNomeListMA);
		rolesOut.put(codResidualB, variabileNomeListMB);
		rolesOut.put(codQualityIndicators, variableQuality);

		contingencyService.init(parametriMap.get(params_MatchingVariables), worksetInn.get(codeMatchingA),
				worksetInn.get(codeMatchingB));
		variabileNomeListOut.forEach(varname -> {
			matchingTable.put(varname, new ArrayList<>());
			possibleMatchingTable.put(varname, new ArrayList<>());
		});

		Map<String, List<Integer>> indexesBlockingVariableA = RelaisUtility
				.blockVariablesIndexMapValues(worksetInn.get(codeMatchingA), blockingVariablesA);
		Map<String, List<Integer>> indexesBlockingVariableB = RelaisUtility
				.blockVariablesIndexMapValues(worksetInn.get(codeMatchingB), blockingVariablesB);

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

				valuesI.put(ROW_IA, Integer.toString(innerIA + 1));// store index no zero-based +1
				variabileNomeListMA.stream().filter(varname -> !ROW_IA.equals(varname)).forEach(varnameMA -> {
					valuesI.put(varnameMA, worksetInn.get(codeMatchingA).get(varnameMA).get(innerIA));// get value
																										// zero-based
				});

				if (indexesBlockingVariableB.get(keyBlock) != null)
					indexesBlockingVariableB.get(keyBlock).forEach(innerIB -> {

						valuesI.put(ROW_IB, Integer.toString(innerIB + 1));
						variabileNomeListMB.stream().filter(varname -> !ROW_IB.equals(varname)).forEach(varnameMB -> {
							valuesI.put(varnameMB, worksetInn.get(codeMatchingB).get(varnameMB).get(innerIB));// get
																												// value
																												// zero-based
						});
						String pattern = contingencyService.getPattern(valuesI);
						if (patternMatching.contains(pattern)) {
							valuesI.forEach((k, v) -> {
								matchingTableIA.get(k).add(v);
							});
							matchingTableIA.get(codeP_POST).add(patternPPostValues.get(pattern));
							matchingTableIA.get(codeRATIO).add(patternRValues.get(pattern));
						} else if (patternPossibleMatching.contains(pattern)) {
							valuesI.forEach((k, v) -> {
								possibleMatchingTableIA.get(k).add(v);
							});
							possibleMatchingTableIA.get(codeP_POST).add(patternPPostValues.get(pattern));
							possibleMatchingTableIA.get(codeRATIO).add(patternRValues.get(pattern));
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

		/* load quality indicators */
		logService.save("Quality Indicators (" + codQualityIndicators + ") :" + String.valueOf(mprec) + " "
				+ String.valueOf(mrec));

		qualityIndicators.put(codeOUT, new ArrayList<>(List.of("MATCHES", "MATCHES+POSSIBLE")));
		qualityIndicators.put(codeTHR, new ArrayList<>(List.of(paramTM, paramTU)));
		qualityIndicators.put(codePREC, new ArrayList<>(List.of(String.valueOf(mprec), String.valueOf(pprec))));
		qualityIndicators.put(codeREC, new ArrayList<>(List.of(String.valueOf(mrec), String.valueOf(prec))));

		returnOut.put(EngineService.ROLES_OUT, rolesOut);
		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

		worksetOut.put(codResidualB, residualBTable);
		worksetOut.put(codResidualA, residualATable);
		worksetOut.put(codPossibleMatchingTable, possibleMatchingTable);
		worksetOut.put(codMatchingTable, matchingTable);
		worksetOut.put(codQualityIndicators, qualityIndicators);

		returnOut.put(EngineService.WORKSET_OUT, worksetOut);
		return returnOut;
	}

	// not used
	public Map<?, ?> pRLResultTablesCartesianProduct(final Long idelaborazione,
			final Map<String, ArrayList<String>> ruoliVariabileNome,
			final Map<String, Map<String, List<String>>> worksetInn, final Map<String, String> parametriMap)
			throws Exception {

		final Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> matchingTable = Collections.synchronizedMap(new LinkedHashMap<>());
		final Map<String, ArrayList<String>> possibleMatchingTable = Collections.synchronizedMap(new LinkedHashMap<>());
		// final Map<String, ArrayList<String>> residualATable = new LinkedHashMap<>();
		// final Map<String, ArrayList<String>> residualBTable = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> qualityIndicators = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

		logService.save("Process Matching Tables  Starting...");

// <codRuolo,[namevar1,namevar2..]
		int indexItems = 0;
		ArrayList<String> patternMatching = new ArrayList<>();
		ArrayList<String> patternPossibleMatching = new ArrayList<>();
		Map<String, String> patternPPostValues = new HashMap<>();
		final Map<String, String> patternRValues = new HashMap<>();
		String paramTM = parametriMap.get(params_ThresholdMatching);
		String paramTU = parametriMap.get(params_ThresholdUnMatching);
		float mprec = 1f, pprec = 1f, mrec = 0f, prec = 0f;

		checkThresholds(paramTM, paramTU);

		logService.save("Threshold Matching: " + paramTM);
		logService.save("Threshold UnMatching: " + paramTU);

// select pattern by P_POST value
		for (String pPostVarname : ruoliVariabileNome.get(codeFS)) {

			if (codeP_POST.equals(pPostVarname)) {
				indexItems = 0;

				for (String pPostValue : worksetInn.get(codeFS).get(pPostVarname)) {
					if (Float.parseFloat(pPostValue) >= Float.parseFloat(paramTU)) {
						StringBuffer pattern = new StringBuffer();
						float cprec = Float.parseFloat(worksetInn.get(codeFS).get(codePREC).get(indexItems));
						float crec = Float.parseFloat(worksetInn.get(codeFS).get(codeREC).get(indexItems));

						String RValue = worksetInn.get(codeFS).get(codeRATIO).get(indexItems);
						for (String ctVarname : ruoliVariabileNome.get(codContingencyTable)) {
							if (!ctVarname.equals(VARIABLE_FREQUENCY)) {
								String p = worksetInn.get(codeFS).get(ctVarname).get(indexItems);
								pattern.append(Double.valueOf(p).intValue());
							}
						}

						if (Float.parseFloat(pPostValue) >= Float.parseFloat(paramTM)) {
							patternMatching.add(pattern.toString());
							if (cprec < mprec)
								mprec = cprec;
							if (cprec < pprec)
								pprec = cprec;
							if (crec > mrec)
								mrec = crec;
							if (crec > prec)
								prec = crec;
						} else {
							patternPossibleMatching.add(pattern.toString());
							if (cprec < pprec)
								pprec = cprec;
							if (crec > prec)
								prec = crec;
						}
						patternPPostValues.put(pattern.toString(), pPostValue);
						patternRValues.put(pattern.toString(), RValue);
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

		variabileNomeListMA.add(ROW_IA);
		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});
		variabileNomeListMB.add(ROW_IB);
		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});

		logService.save("Matching variables dataset A: " + variabileNomeListMA);
		logService.save("Matching variables dataset B: " + variabileNomeListMB);

		variabileNomeListOut.addAll(variabileNomeListMA);
		variabileNomeListOut.addAll(variabileNomeListMB);
		variabileNomeListOut.add(codeP_POST);
		variabileNomeListOut.add(codeRATIO);

		final ArrayList<String> variableQuality = new ArrayList<>();
		variableQuality.add(codeOUT);
		variableQuality.add(codeTHR);
		variableQuality.add(codePREC);
		variableQuality.add(codeREC);

		rolesOut.put(codMatchingTable, variabileNomeListOut);
		rolesOut.put(codPossibleMatchingTable, variabileNomeListOut);
		rolesOut.put(codResidualA, variabileNomeListMA);
		rolesOut.put(codResidualB, variabileNomeListMB);
		rolesOut.put(codQualityIndicators, variableQuality);

		String firstFiledMA = ruoliVariabileNome.get(codeMatchingA).get(0);
		String firstFiledMB = ruoliVariabileNome.get(codeMatchingB).get(0);
		int sizeA = worksetInn.get(codeMatchingA).get(firstFiledMA).size();
		int sizeB = worksetInn.get(codeMatchingB).get(firstFiledMB).size();

		contingencyService.init(parametriMap.get(params_MatchingVariables), worksetInn.get(codeMatchingA),
				worksetInn.get(codeMatchingB));
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

			valuesI.put(ROW_IA, Integer.toString(innerIA + 1));
			variabileNomeListMA.stream().filter(varname -> !ROW_IA.equals(varname)).forEach(varnameMA -> {

				valuesI.put(varnameMA, worksetInn.get(codeMatchingA).get(varnameMA).get(innerIA));
			});

			IntStream.range(0, sizeB).forEach(innerIB -> {

				valuesI.put(ROW_IB, Integer.toString(innerIB + 1));
				variabileNomeListMB.stream().filter(varname -> !ROW_IB.equals(varname)).forEach(varnameMB -> {
					valuesI.put(varnameMB, worksetInn.get(codeMatchingB).get(varnameMB).get(innerIB));
				});
				String pattern = contingencyService.getPattern(valuesI);
				if (patternMatching.contains(pattern)) {
					valuesI.forEach((k, v) -> {
						matchingTableIA.get(k).add(v);
					});
					matchingTableIA.get(codeP_POST).add(patternPPostValues.get(pattern));
					matchingTableIA.get(codeRATIO).add(patternRValues.get(pattern));
				} else if (patternPossibleMatching.contains(pattern)) {
					valuesI.forEach((k, v) -> {
						possibleMatchingTableIA.get(k).add(v);
					});
					possibleMatchingTableIA.get(codeP_POST).add(patternPPostValues.get(pattern));
					possibleMatchingTableIA.get(codeRATIO).add(patternRValues.get(pattern));
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

		/* load quality indicators */
		logService.save("Quality Indicators (" + codQualityIndicators + ") :" + String.valueOf(mprec) + " "
				+ String.valueOf(mrec));

		qualityIndicators.put(codeOUT, new ArrayList<>(List.of("MATCHES", "MATCHES+POSSIBLE")));
		qualityIndicators.put(codeTHR, new ArrayList<>(List.of(paramTM, paramTU)));
		qualityIndicators.put(codePREC, new ArrayList<>(List.of(String.valueOf(mprec), String.valueOf(pprec))));
		qualityIndicators.put(codeREC, new ArrayList<>(List.of(String.valueOf(mrec), String.valueOf(prec))));

		returnOut.put(EngineService.ROLES_OUT, rolesOut);
		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

		worksetOut.put(codPossibleMatchingTable, possibleMatchingTable);
		worksetOut.put(codMatchingTable, matchingTable);
		worksetOut.put(codQualityIndicators, qualityIndicators);

		returnOut.put(EngineService.WORKSET_OUT, worksetOut);

		return returnOut;
	}

	// not used
	public Map<?, ?> pRLResultTablesCartesianProduct_canc(final Long idelaborazione,
			final Map<String, ArrayList<String>> ruoliVariabileNome,
			final Map<String, Map<String, List<String>>> worksetInn, final Map<String, String> parametriMap)
			throws Exception {

		final Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> residualATable = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> residualBTable = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

		logService.save("Process Matching Tables  Starting...");

		// <codRuolo,[namevar1,namevar2..]
		int indexItems = 0;
		final ArrayList<String> patternMatching = new ArrayList<>();
		final ArrayList<String> patternPossibleMatching = new ArrayList<>();
		final Map<String, String> patternPPostValues = new HashMap<>();
		final Map<String, String> patternRValues = new HashMap<>();

		String paramTM = parametriMap.get(params_ThresholdMatching);
		String paramTU = parametriMap.get(params_ThresholdUnMatching);

		checkThresholds(paramTM, paramTU);

		logService.save("Threshold Matching: " + paramTM);
		logService.save("Threshold UnMatching: " + paramTU);

		// select pattern by P_POST value
		for (String pPostVarname : ruoliVariabileNome.get(codeFS)) {

			if (codeP_POST.equals(pPostVarname)) {
				indexItems = 0;

				for (String pPostValue : worksetInn.get(codeFS).get(pPostVarname)) {
					if (Float.parseFloat(pPostValue) >= Float.parseFloat(paramTU)) {
						StringBuffer pattern = new StringBuffer();

						String RValue = worksetInn.get(codeFS).get(codeRATIO).get(indexItems);
						for (String ctVarname : ruoliVariabileNome.get(codContingencyTable)) {
							if (!ctVarname.equals(VARIABLE_FREQUENCY)) {
								String p = worksetInn.get(codeFS).get(ctVarname).get(indexItems);
								pattern.append(Double.valueOf(p).intValue());
							}
						}

						if (Float.parseFloat(pPostValue) >= Float.parseFloat(paramTM)) {
							patternMatching.add(pattern.toString());
						} else {
							patternPossibleMatching.add(pattern.toString());
						}
						patternPPostValues.put(pattern.toString(), pPostValue);
						patternRValues.put(pattern.toString(), RValue);
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

		variabileNomeListMA.add(ROW_IA);
		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});
		variabileNomeListMB.add(ROW_IB);
		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});

		logService.save("Matching variables dataset A: " + variabileNomeListMA);
		logService.save("Matching variables dataset B: " + variabileNomeListMB);

		variabileNomeListOut.addAll(variabileNomeListMA);
		variabileNomeListOut.addAll(variabileNomeListMB);
		variabileNomeListOut.add(codeP_POST);
		variabileNomeListOut.add(codeRATIO);

		rolesOut.put(codMatchingTable, variabileNomeListOut);
		rolesOut.put(codPossibleMatchingTable, variabileNomeListOut);
		rolesOut.put(codResidualA, variabileNomeListMA);
		rolesOut.put(codResidualB, variabileNomeListMB);

		// final Map<String, ArrayList<String>> matchingTable =
		// Collections.synchronizedMap(new LinkedHashMap<>());
		// final Map<String, ArrayList<String>> possibleMatchingTable =
		// Collections.synchronizedMap(new LinkedHashMap<>());

		final Map<String, ArrayList<String>> matchingTable = elaborateResultTable(worksetInn, variabileNomeListMA,
				variabileNomeListMB, variabileNomeListOut, patternMatching, patternPPostValues, patternRValues);
		final Map<String, ArrayList<String>> possibleMatchingTable = elaborateResultTable(worksetInn,
				variabileNomeListMA, variabileNomeListMB, variabileNomeListOut, patternPossibleMatching,
				patternPPostValues, patternRValues);

		returnOut.put(EngineService.ROLES_OUT, rolesOut);
		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

		worksetOut.put(codResidualB, residualBTable);
		worksetOut.put(codResidualA, residualATable);
		worksetOut.put(codPossibleMatchingTable, possibleMatchingTable);
		worksetOut.put(codMatchingTable, matchingTable);
		returnOut.put(EngineService.WORKSET_OUT, worksetOut);
		return returnOut;
	}

	// used
	public Map<?, ?> probabilisticResultTablesByIndex(Long idelaborazione,
			Map<String, ArrayList<String>> ruoliVariabileNome, Map<String, Map<String, List<String>>> worksetInn,
			Map<String, String> parametriMap) throws Exception {

		final Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
		// final Map<String, ArrayList<String>> residualATable = new LinkedHashMap<>();
		// final Map<String, ArrayList<String>> residualBTable = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();
		final Map<String, ArrayList<String>> qualityIndicators = new LinkedHashMap<>();
		int errorLevel = 0; /* 0-> no_error 1 -> Error: Indexes not available */

		logService.save("Process Matching Tables  Starting...");

		// <codRuolo,[namevar1,namevar2..]
		int indexItems = 0;
		ArrayList<String> patternMatching = new ArrayList<>();
		ArrayList<String> patternPossibleMatching = new ArrayList<>();
		Map<String, String> patternPPostValues = new HashMap<>();
		Map<String, String> patternRValues = new HashMap<>();
		String paramTM = parametriMap.get(params_ThresholdMatching);
		String paramTU = parametriMap.get(params_ThresholdUnMatching);

		checkThresholds(paramTM, paramTU);

		logService.save("Threshold Matching: " + paramTM);
		logService.save("Threshold UnMatching: " + paramTU);

		float mprec = 1f, pprec = 1f, mrec = 0f, prec = 0f;

		// select pattern by P_POST value
		for (String pPostVarname : ruoliVariabileNome.get(codeFS)) {

			if (codeP_POST.equals(pPostVarname)) {
				indexItems = 0;

				for (String pPostValue : worksetInn.get(codeFS).get(pPostVarname)) {

					if (Float.parseFloat(pPostValue) >= Float.parseFloat(paramTU)) {
						StringBuffer pattern = new StringBuffer();

						float cprec = Float.parseFloat(worksetInn.get(codeFS).get(codePREC).get(indexItems));
						float crec = Float.parseFloat(worksetInn.get(codeFS).get(codeREC).get(indexItems));

						String RValue = worksetInn.get(codeFS).get(codeRATIO).get(indexItems);
						for (String ctVarname : ruoliVariabileNome.get(codContingencyTable)) {
							if (!ctVarname.equals(VARIABLE_FREQUENCY)) {
								String p = worksetInn.get(codeFS).get(ctVarname).get(indexItems);
								pattern.append(Double.valueOf(p).intValue());
							}
						}

						if (!worksetInn.get(codContingencyIndexTable).get(PREFIX_PATTERN + pattern).isEmpty()
								&& worksetInn.get(codContingencyIndexTable).get(PREFIX_PATTERN + pattern).get(0)
								.equals(NOT_AV)) {
							logService.save("ERROR: The number of pairs with '" + pattern
									+ "' pattern is too large to enter into a solution");
							errorLevel = 1;
						} else {

							if (Float.parseFloat(pPostValue) >= Float.parseFloat(paramTM)) {
								patternMatching.add(pattern.toString());
								if (cprec < mprec)
									mprec = cprec;
								if (cprec < pprec)
									pprec = cprec;
								if (crec > mrec)
									mrec = crec;
								if (crec > prec)
									prec = crec;
							} else {
								patternPossibleMatching.add(pattern.toString());
								if (cprec < pprec)
									pprec = cprec;
								if (crec > prec)
									prec = crec;
							}

							patternPPostValues.put(pattern.toString(), pPostValue);
							patternRValues.put(pattern.toString(), RValue);
						}
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

		variabileNomeListMA.add(ROW_IA);
		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});
		variabileNomeListMB.add(ROW_IB);
		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});

		logService.save("Matching variables dataset A: " + variabileNomeListMA);
		logService.save("Matching variables dataset B: " + variabileNomeListMB);

		variabileNomeListOut.addAll(variabileNomeListMA);
		variabileNomeListOut.addAll(variabileNomeListMB);
		variabileNomeListOut.add(codeP_POST);
		variabileNomeListOut.add(codeRATIO);

		final ArrayList<String> variableQuality = new ArrayList<>();
		variableQuality.add(codeOUT);
		variableQuality.add(codeTHR);
		variableQuality.add(codePREC);
		variableQuality.add(codeREC);

		rolesOut.put(codMatchingTable, variabileNomeListOut);
		rolesOut.put(codPossibleMatchingTable, variabileNomeListOut);
		rolesOut.put(codQualityIndicators, variableQuality);

		// final Map<String, ArrayList<String>> matchingTable =
		// Collections.synchronizedMap(new LinkedHashMap<>());
		// final Map<String, ArrayList<String>> possibleMatchingTable =
		// Collections.synchronizedMap(new LinkedHashMap<>());

		final Map<String, ArrayList<String>> matchingTable = elaborateResultTable(worksetInn, variabileNomeListMA,
				variabileNomeListMB, variabileNomeListOut, patternMatching, patternPPostValues, patternRValues);
		final Map<String, ArrayList<String>> possibleMatchingTable = elaborateResultTable(worksetInn,
				variabileNomeListMA, variabileNomeListMB, variabileNomeListOut, patternPossibleMatching,
				patternPPostValues, patternRValues);

		returnOut.put(EngineService.ROLES_OUT, rolesOut);
		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

		/* load quality indicators */
		logService.save("Quality Indicators (" + codQualityIndicators + ") :" + String.valueOf(mprec) + " "
				+ String.valueOf(mrec));

		qualityIndicators.put(codeOUT, new ArrayList<>(List.of("MATCHES", "MATCHES+POSSIBLE")));
		qualityIndicators.put(codeTHR, new ArrayList<>(List.of(paramTM, paramTU)));
		qualityIndicators.put(codePREC, new ArrayList<>(List.of(String.valueOf(mprec), String.valueOf(pprec))));
		qualityIndicators.put(codeREC, new ArrayList<>(List.of(String.valueOf(mrec), String.valueOf(prec))));

		// worksetOut.put(codResidualB, residualBTable);
		// worksetOut.put(codResidualA, residualATable);
		if (errorLevel == 0) {
			worksetOut.put(codPossibleMatchingTable, possibleMatchingTable);
			worksetOut.put(codMatchingTable, matchingTable);
			worksetOut.put(codQualityIndicators, qualityIndicators);
		}
		if (errorLevel == 1)
			logService.save("ERROR: The outputs were not produced. The number of pairs is too large into a solution");

		returnOut.put(EngineService.WORKSET_OUT, worksetOut);
		return returnOut;
	}

	// used
	public Map<?, ?> deterministicResultTablesByIndex(Long idelaborazione,
			Map<String, ArrayList<String>> ruoliVariabileNome, Map<String, Map<String, List<String>>> worksetInn,
			Map<String, String> parametriMap) throws Exception {

		final Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
		// final Map<String, ArrayList<String>> residualATable = new LinkedHashMap<>();
		// final Map<String, ArrayList<String>> residualBTable = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();
		int errorLevel = 0; /* 0 -> no_error 1 -> Error: indexes not available */

		logService.save("Process Matching Tables  Starting...");

		ArrayList<String> variabileNomeListMA = new ArrayList<>();
		ArrayList<String> variabileNomeListMB = new ArrayList<>();
		ArrayList<String> variabileNomeListOut = new ArrayList<>();

		variabileNomeListMA.add(ROW_IA);
		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});
		variabileNomeListMB.add(ROW_IB);
		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});

		logService.save("Variables dataset A: " + variabileNomeListMA);
		logService.save("Variables dataset B: " + variabileNomeListMB);

		variabileNomeListOut.addAll(variabileNomeListMA);
		variabileNomeListOut.addAll(variabileNomeListMB);

		rolesOut.put(codMatchingTable, variabileNomeListOut);

		returnOut.put(EngineService.ROLES_OUT, rolesOut);
		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

		final Map<String, ArrayList<String>> resultMatchTable = Collections.synchronizedMap(new LinkedHashMap<>());

		variabileNomeListOut.forEach(varname -> {
			resultMatchTable.put(varname, new ArrayList<>());
		});

		final int CHUNK_SIZE = 100;

		// final Map<String, List<String>>
		// coupledIndexByPattern=worksetIn.get(codContengencyIndexTable );
		int nVarM = worksetInn.get(codContingencyTable).size() - 1;
		String pattern1 = new String("1").repeat(nVarM);

		ArrayList<String> patternList = new ArrayList<String>();
		patternList.add(pattern1);

		logService.save("Patterns of Matches " + patternList);
		for (int i = 0; i < patternList.size(); i++) {
			String pattern = patternList.get(i);
			int sizeList = worksetInn.get(codContingencyIndexTable).get(PREFIX_PATTERN + pattern).size();
			if (sizeList == 1) {
				if (worksetInn.get(codContingencyIndexTable).get(PREFIX_PATTERN + pattern).get(0).equals(NOT_AV)) {
					errorLevel = 1;
					continue;
				}

			}
			int partitionSize = (sizeList / CHUNK_SIZE) + ((sizeList % CHUNK_SIZE) == 0 ? 0 : 1);

			IntStream.range(0, partitionSize).parallel().forEach(chunkIndex -> {

				int inf = (chunkIndex * CHUNK_SIZE);
				int sup = (chunkIndex == partitionSize - 1) ? sizeList - 1 : (inf + CHUNK_SIZE - 1);

				final Map<String, ArrayList<String>> resultMatchTableI = new HashMap<>();
				variabileNomeListOut.forEach(varname -> {
					resultMatchTableI.put(varname, new ArrayList<>());
				});

				IntStream.rangeClosed(inf, sup).forEach(innerIndex -> {

					String[] indexesArr = worksetInn.get(codContingencyIndexTable).get(PREFIX_PATTERN + pattern)
							.get(innerIndex).split(INDEX_SEPARATOR);
					int innerIA = Integer.parseInt(indexesArr[0]);
					int innerIB = Integer.parseInt(indexesArr[1]);

					final Map<String, String> valuesI = new HashMap<>();

					valuesI.put(ROW_IA, Integer.toString(innerIA));
					variabileNomeListMA.stream().filter(varname -> !ROW_IA.equals(varname)).forEach(varnameMA -> {

						valuesI.put(varnameMA, worksetInn.get(codeMatchingA).get(varnameMA).get(innerIA - 1));// to
																												// zero-based
					});

					valuesI.put(ROW_IB, Integer.toString(innerIB));
					variabileNomeListMB.stream().filter(varname -> !ROW_IB.equals(varname)).forEach(varnameMB -> {
						valuesI.put(varnameMB, worksetInn.get(codeMatchingB).get(varnameMB).get(innerIB - 1));// get
																												// value
																												// zero-based
					});

					valuesI.forEach((k, v) -> {
						resultMatchTableI.get(k).add(v);
					});

				});

				synchronized (resultMatchTable) {
					resultMatchTableI.entrySet().stream()
							.forEach(e -> resultMatchTable.get(e.getKey()).addAll(resultMatchTableI.get(e.getKey())));
				}
			});
		}

		if (errorLevel == 0) {
			worksetOut.put(codMatchingTable, resultMatchTable);
		}
		if (errorLevel == 1)
			logService.save("ERROR: The outputs were not produced. The number of pairs is too large into a solution");

		returnOut.put(EngineService.WORKSET_OUT, worksetOut);
		return returnOut;
	}

	// used in probabilisticResultTablesByIndex
	private Map<String, ArrayList<String>> elaborateResultTable(Map<String, Map<String, List<String>>> worksetInn,
			ArrayList<String> variabileNomeListMA, ArrayList<String> variabileNomeListMB,
			ArrayList<String> variabileNomeListOut, ArrayList<String> patternList,
			Map<String, String> patternPPostValues, Map<String, String> patternRValues) {

		final Map<String, ArrayList<String>> resultMatchTable = Collections.synchronizedMap(new LinkedHashMap<>());

		variabileNomeListOut.forEach(varname -> {
			resultMatchTable.put(varname, new ArrayList<>());
		});

		final int CHUNK_SIZE = 100;

		// final Map<String, List<String>>
		// coupledIndexByPattern=worksetIn.get(codContengencyIndexTable );

		patternList.forEach(pattern -> {

			int sizeList = worksetInn.get(codContingencyIndexTable).get(PREFIX_PATTERN + pattern).size();
			int partitionSize = (sizeList / CHUNK_SIZE) + ((sizeList % CHUNK_SIZE) == 0 ? 0 : 1);

			IntStream.range(0, partitionSize).parallel().forEach(chunkIndex -> {

				int inf = (chunkIndex * CHUNK_SIZE);
				int sup = (chunkIndex == partitionSize - 1) ? sizeList - 1 : (inf + CHUNK_SIZE - 1);

				final Map<String, ArrayList<String>> resultMatchTableI = new HashMap<>();
				variabileNomeListOut.forEach(varname -> {
					resultMatchTableI.put(varname, new ArrayList<>());
				});

				IntStream.rangeClosed(inf, sup).forEach(innerIndex -> {

					String[] indexesArr = worksetInn.get(codContingencyIndexTable).get(PREFIX_PATTERN + pattern)
							.get(innerIndex).split(INDEX_SEPARATOR);
					int innerIA = Integer.parseInt(indexesArr[0]);
					int innerIB = Integer.parseInt(indexesArr[1]);

					final Map<String, String> valuesI = new HashMap<>();

					valuesI.put(ROW_IA, Integer.toString(innerIA));
					variabileNomeListMA.stream().filter(varname -> !ROW_IA.equals(varname)).forEach(varnameMA -> {

						valuesI.put(varnameMA, worksetInn.get(codeMatchingA).get(varnameMA).get(innerIA - 1));// to
																												// zero-based
					});

					valuesI.put(ROW_IB, Integer.toString(innerIB));
					variabileNomeListMB.stream().filter(varname -> !ROW_IB.equals(varname)).forEach(varnameMB -> {
						valuesI.put(varnameMB, worksetInn.get(codeMatchingB).get(varnameMB).get(innerIB - 1));// get
																												// value
																												// zero-based
					});

					valuesI.forEach((k, v) -> {
						resultMatchTableI.get(k).add(v);
					});
					resultMatchTableI.get(codeP_POST).add(patternPPostValues.get(pattern));
					resultMatchTableI.get(codeRATIO).add(patternRValues.get(pattern));

				});

				synchronized (resultMatchTable) {
					resultMatchTableI.entrySet().stream()
							.forEach(e -> resultMatchTable.get(e.getKey()).addAll(resultMatchTableI.get(e.getKey())));
				}
			});
		});

		return resultMatchTable;
	}

	// not used?
	public Map<String, ArrayList<String>> elaborateResultTableByCIT(Map<String, Map<String, List<String>>> worksetInn,
			ArrayList<String> variabileNomeListMA, ArrayList<String> variabileNomeListMB,
			ArrayList<String> variabileNomeListOut, ArrayList<String> patternList,
			Map<String, String> patternPPostValues, Map<String, String> patternRValues) {

		final Map<String, ArrayList<String>> resultMatchTable = Collections.synchronizedMap(new LinkedHashMap<>());

		variabileNomeListOut.forEach(varname -> {
			resultMatchTable.put(varname, new ArrayList<>());
		});

		final int CHUNK_SIZE = 100;

		// final Map<String, List<String>>
		// coupledIndexByPattern=worksetIn.get(codContengencyIndexTable );

		patternList.forEach(pattern -> {

			int sizeList = worksetInn.get(codContingencyIndexTable).get(PREFIX_PATTERN + pattern).size();
			int partitionSize = (sizeList / CHUNK_SIZE) + ((sizeList % CHUNK_SIZE) == 0 ? 0 : 1);

			IntStream.range(0, partitionSize).parallel().forEach(chunkIndex -> {

				int inf = (chunkIndex * CHUNK_SIZE);
				int sup = (chunkIndex == partitionSize - 1) ? sizeList - 1 : (inf + CHUNK_SIZE - 1);

				final Map<String, ArrayList<String>> resultMatchTableI = new HashMap<>();
				variabileNomeListOut.forEach(varname -> {
					resultMatchTableI.put(varname, new ArrayList<>());
				});

				IntStream.rangeClosed(inf, sup).forEach(innerIndex -> {

					String[] indexesArr = worksetInn.get(codContingencyIndexTable).get(PREFIX_PATTERN + pattern)
							.get(innerIndex).split(INDEX_SEPARATOR);
					int innerIA = Integer.parseInt(indexesArr[0]);
					int innerIB = Integer.parseInt(indexesArr[1]);

					final Map<String, String> valuesI = new HashMap<>();

					valuesI.put(ROW_IA, Integer.toString(innerIA));
					variabileNomeListMA.stream().filter(varname -> !ROW_IA.equals(varname)).forEach(varnameMA -> {

						valuesI.put(varnameMA, worksetInn.get(codeMatchingA).get(varnameMA).get(innerIA - 1));// to
																												// zero-based
					});

					valuesI.put(ROW_IB, Integer.toString(innerIB));
					variabileNomeListMB.stream().filter(varname -> !ROW_IB.equals(varname)).forEach(varnameMB -> {
						valuesI.put(varnameMB, worksetInn.get(codeMatchingB).get(varnameMB).get(innerIB - 1));// get
																												// value
																												// zero-based
					});

					valuesI.forEach((k, v) -> {
						resultMatchTableI.get(k).add(v);
					});
					resultMatchTableI.get(codeP_POST).add(patternPPostValues.get(pattern));
					resultMatchTableI.get(codeRATIO).add(patternRValues.get(pattern));

				});

				synchronized (resultMatchTable) {
					resultMatchTableI.entrySet().stream()
							.forEach(e -> resultMatchTable.get(e.getKey()).addAll(resultMatchTableI.get(e.getKey())));
				}
			});
		});

		return resultMatchTable;
	}

	// not used
	public Map<?, ?> dRLCartesianProduct(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, Map<String, List<String>>> worksetInn, Map<String, String> parametriMap) throws Exception {

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

		rolesOut.put(codMatchingTable, variabileNomeListOut);

		String firstFiledMA = ruoliVariabileNome.get(codeMatchingA).get(0);
		String firstFiledMB = ruoliVariabileNome.get(codeMatchingB).get(0);
		int sizeA = worksetInn.get(codeMatchingA).get(firstFiledMA).size();
		int sizeB = worksetInn.get(codeMatchingB).get(firstFiledMB).size();

		contingencyService.init(parametriMap.get(params_MatchingVariables), worksetInn.get(codeMatchingA),
				worksetInn.get(codeMatchingB));
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
				valuesI.put(varnameMA, worksetInn.get(codeMatchingA).get(varnameMA).get(innerIA));
			});

			IntStream.range(0, sizeB).forEach(innerIB -> {
				variabileNomeListMB.forEach(varnameMB -> {
					valuesI.put(varnameMB, worksetInn.get(codeMatchingB).get(varnameMB).get(innerIB));
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

		returnOut.put(EngineService.ROLES_OUT, rolesOut);
		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

		worksetOut.put(codMatchingTable, matchingTable);
		returnOut.put(EngineService.WORKSET_OUT, worksetOut);
		return returnOut;

	}

	// not used
	public Map<?, ?> dRLBlockingVariables(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, Map<String, List<String>>> worksetInn, Map<String, String> parametriMap) throws Exception {

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

		blockingVariablesA.addAll(
				RelaisUtility.getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesA));

		blockingVariablesB.addAll(
				RelaisUtility.getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesB));

		logService.save("Matching variables dataset A: " + variabileNomeListMA);
		logService.save("Matching variables dataset B: " + variabileNomeListMB);
		logService.save("Blocking variables dataset A: " + blockingVariablesA);
		logService.save("Blocking variables dataset B: " + blockingVariablesB);

		variabileNomeListOut.addAll(variabileNomeListMA);
		variabileNomeListOut.addAll(variabileNomeListMB);

		rolesOut.put(codMatchingTable, variabileNomeListOut);

		contingencyService.init(parametriMap.get(params_MatchingVariables), worksetInn.get(codeMatchingA),
				worksetInn.get(codeMatchingB));
		variabileNomeListOut.forEach(varname -> {
			matchingTable.put(varname, new ArrayList<>());

		});

		Map<String, List<Integer>> indexesBlockingVariableA = RelaisUtility
				.blockVariablesIndexMapValues(worksetInn.get(codeMatchingA), blockingVariablesA);
		Map<String, List<Integer>> indexesBlockingVariableB = RelaisUtility
				.blockVariablesIndexMapValues(worksetInn.get(codeMatchingB), blockingVariablesB);

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
					valuesI.put(varnameMA, worksetInn.get(codeMatchingA).get(varnameMA).get(innerIA));
				});

				if (indexesBlockingVariableB.get(keyBlock) != null)
					indexesBlockingVariableB.get(keyBlock).forEach(innerIB -> {

						variabileNomeListMB.forEach(varnameMB -> {
							valuesI.put(varnameMB, worksetInn.get(codeMatchingB).get(varnameMB).get(innerIB));
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
		returnOut.put(EngineService.ROLES_OUT, rolesOut);
		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

		worksetOut.put(codMatchingTable, matchingTable);
		returnOut.put(EngineService.WORKSET_OUT, worksetOut);
		return returnOut;
	}

	// used
	private void checkThresholds(String paramTM, String paramTU) throws Exception {
		try {
			if (Float.parseFloat(paramTU) > Float.parseFloat(paramTM)) {
				throw new Exception();
			}
		} catch (Exception e) {
			throw new Exception("Incorrect Threshold value!");
		}

	}

	// used in reducedResultTablesGreedy
	public class ReducElem implements Comparable<ReducElem> {

		public int dataset;
		public int nrow;
		public float sortingKey;

		public ReducElem(int dataset, int nrow, float sortingKey) {
			this.dataset = dataset;
			this.nrow = nrow;
			this.sortingKey = sortingKey;
		}

		public int compareTo(ReducElem o) {
			if (this.sortingKey > o.sortingKey) {
				return 1;
			}
			if (this.sortingKey < o.sortingKey) {
				return -1;
			}
			return 0;
		}
	}

	// used
	public Map<?, ?> reducedResultTablesGreedy(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, Map<String, List<String>>> worksetInn, Map<String, String> parametriMap) throws Exception {

		final Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

		logService.save("Process greedy reduction result tables  Starting...");

		ArrayList<String> variabileNomeListMA = new ArrayList<>();
		ArrayList<String> variabileNomeListMB = new ArrayList<>();
		ArrayList<String> variabileNomeListOut = new ArrayList<>();

		variabileNomeListMA.add(ROW_IA);
		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});
		variabileNomeListMB.add(ROW_IB);
		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});

		variabileNomeListOut.addAll(variabileNomeListMA);
		variabileNomeListOut.addAll(variabileNomeListMB);
		variabileNomeListOut.add(codeP_POST);
		variabileNomeListOut.add(codeRATIO);

		rolesOut.put(codMatchingTableReduced, variabileNomeListOut);
		rolesOut.put(codPossibleMatchingTableReduced, variabileNomeListOut);

		final Map<String, ArrayList<String>> matchingTableReduced = Collections.synchronizedMap(new LinkedHashMap<>());
		final Map<String, ArrayList<String>> possibleTableReduced = Collections.synchronizedMap(new LinkedHashMap<>());

		variabileNomeListOut.forEach(varname -> {
			matchingTableReduced.put(varname, new ArrayList<>());
			possibleTableReduced.put(varname, new ArrayList<>());
		});

		Map<String, String> KeyA = new HashMap<>();
		Map<String, String> KeyB = new HashMap<String, String>();

		Map<String, List<String>> matches = worksetInn.get(codMatchingTable);

		int size = matches.get(ROW_IA).size();

		ArrayList<ReducElem> sortlist = new ArrayList<ReducElem>();
		for (int innerIndex = 0; innerIndex < size; innerIndex++) {
			float ppost = Float.parseFloat(matches.get(codeP_POST).get(innerIndex));
			sortlist.add(new ReducElem(1, innerIndex, ppost));
		}
		Collections.sort(sortlist);
		int reducsize = 0;
		/* IntStream.rangeClosed(0, size).forEach(innerIndex -> */
		for (ReducElem curr : sortlist) {

			if ((!KeyA.containsKey(matches.get(ROW_IA).get(curr.nrow)))
					&& (!KeyB.containsKey(matches.get(ROW_IB).get(curr.nrow)))) {

				reducsize++;
				/* variabileNomeListOut.forEach(varname -> */
				for (String varname : variabileNomeListOut) {
					matchingTableReduced.get(varname).add(matches.get(varname).get(curr.nrow));
				}

				KeyA.put(matches.get(ROW_IA).get(curr.nrow), matches.get(ROW_IB).get(curr.nrow));
				KeyB.put(matches.get(ROW_IB).get(curr.nrow), matches.get(ROW_IA).get(curr.nrow));
			}

		}

		logService.save("Match pairs are reduced from " + size + " to " + reducsize);

		Map<String, List<String>> pmatches = worksetInn.get(codPossibleMatchingTable);

		size = pmatches.get(ROW_IA).size();

		sortlist = new ArrayList<ReducElem>();
		for (int innerIndex = 0; innerIndex < size; innerIndex++) {
			float ppost = Float.parseFloat(pmatches.get(codeP_POST).get(innerIndex));
			sortlist.add(new ReducElem(2, innerIndex, ppost));
		}
		Collections.sort(sortlist);

		reducsize = 0;
		/* IntStream.rangeClosed(0, size).forEach(innerIndex -> */
		for (ReducElem curr : sortlist) {

			if ((!KeyA.containsKey(pmatches.get(ROW_IA).get(curr.nrow)))
					&& (!KeyB.containsKey(pmatches.get(ROW_IB).get(curr.nrow)))) {

				reducsize++;
				/* variabileNomeListOut.forEach(varname -> */
				for (String varname : variabileNomeListOut) {
					possibleTableReduced.get(varname).add(pmatches.get(varname).get(curr.nrow));
				}

				KeyA.put(pmatches.get(ROW_IA).get(curr.nrow), pmatches.get(ROW_IB).get(curr.nrow));
				KeyB.put(pmatches.get(ROW_IB).get(curr.nrow), pmatches.get(ROW_IA).get(curr.nrow));
			}

		}

		logService.save("Possiblematch pairs are reduced from " + size + " to " + reducsize);

		// end elab

		returnOut.put(EngineService.ROLES_OUT, rolesOut);
		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

		worksetOut.put(codPossibleMatchingTableReduced, possibleTableReduced);
		worksetOut.put(codMatchingTableReduced, matchingTableReduced);
		returnOut.put(EngineService.WORKSET_OUT, worksetOut);
		return returnOut;
	}

	// used in pRLContingencyTableSortedNeighborhood
	public class SNelem implements Comparable<SNelem> {

		public int dataset;
		public int nrow;
		public String sortingKey;

		public SNelem(int dataset, int nrow, String sortingKey) {
			this.dataset = dataset;
			this.nrow = nrow;
			this.sortingKey = sortingKey;
		}

		public int compareTo(SNelem o) {
			return this.sortingKey.compareTo(o.sortingKey);
		}
	}

	// used
	public Map<?, ?> pRLContingencyTableSortedNeighborhood(Long idelaborazione,
			Map<String, List<String>> ruoliVariabileNome, Map<String, Map<String, List<String>>> worksetIn,
			Map<String, String> parametriMap) throws Exception {

		final Map<String, Map<?, ?>> returnOut = new HashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new HashMap<>();
		final Map<String, ArrayList<String>> contingencyTableOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

		// <codRuolo,[namevar1,namevar2..]

		final ArrayList<String> variabileNomeListMA = new ArrayList<>();
		final ArrayList<String> variabileNomeListMB = new ArrayList<>();
		final List<String> sortingVariablesA = new ArrayList<>();
		final List<String> sortingVariablesB = new ArrayList<>();
		final int window;

		final ArrayList<String> variabileNomeListOut = new ArrayList<>();

		logService.save("Process Contingency Table Sorted Neighborhood Starting...");
		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});
		// logService.save("Matching variables dataset A: " + variabileNomeListMA);
		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});
		// logService.save("Matching variables dataset B: " + variabileNomeListMB);

		sortingVariablesA.addAll(
				RelaisUtility.getFieldsInParams(parametriMap.get(params_SortedNeghborhood), params_SortingVariablesA));
		sortingVariablesB.addAll(
				RelaisUtility.getFieldsInParams(parametriMap.get(params_SortedNeghborhood), params_SortingVariablesB));

		window = RelaisUtility.getIntField(parametriMap.get(params_SortedNeghborhood), param_WindowSize);

		logService.save("Sorting variables dataset A: " + sortingVariablesA);
		logService.save("Sorting variables dataset B: " + sortingVariablesB);
		logService.save("Window size: " + window);

		ruoliVariabileNome.values().forEach((list) -> {
			variabileNomeListOut.addAll(list);
		});

		try {
			contingencyService.init(parametriMap.get(params_MatchingVariables), worksetIn.get(codeMatchingA),
					worksetIn.get(codeMatchingB));
		} catch (Exception e) {
			logService.save("Error parsing " + params_MatchingVariables);
			throw new Exception("Error parsing " + params_MatchingVariables);
		}
		List<String> nameMatchingVariables = new ArrayList<>();

		contingencyService.getMetricMatchingVariableVector().forEach(metricsm -> {
			contingencyTableOut.put(metricsm.getMatchingVariable(), new ArrayList<>());
			nameMatchingVariables.add(metricsm.getMatchingVariable());
		});

		if (Utility.isNullOrEmpty(sortingVariablesA) || Utility.isNullOrEmpty(sortingVariablesB)) {
			logService.save("Error parsing SORTING VARAIABLES");
			throw new Exception("Error parsing SORTING VARAIABLES");
		}

		final Map<String, Long> contingencyTable = Collections
				.synchronizedMap(contingencyService.getEmptyContingencyTable());

		final Map<String, List<String>> coupledIndexByPattern = RelaisUtility
				.getEmptyMapByKey(contingencyTable.keySet().stream(), PREFIX_PATTERN);

		int dimA = worksetIn.get(codeMatchingA).get(sortingVariablesA.get(0)).size();
		int dimB = worksetIn.get(codeMatchingB).get(sortingVariablesB.get(0)).size();
		int nVarSort = sortingVariablesA.size();
		List<Integer[]> listPairs = new ArrayList<>();

		ArrayList<SNelem> sortlist = new ArrayList<SNelem>();
		for (int index = 0; index < dimA; index++) {
			String sortKey;
			sortKey = new String("");
			for (int numv = 0; numv < nVarSort; numv++) {
				sortKey = sortKey.concat(worksetIn.get(codeMatchingA).get(sortingVariablesA.get(numv)).get(index));
			}
			sortlist.add(new SNelem(0, index, sortKey));
		}
		for (int index = 0; index < dimB; index++) {
			String sortKey;
			sortKey = new String("");
			for (int numv = 0; numv < nVarSort; numv++) {
				sortKey = sortKey.concat(worksetIn.get(codeMatchingB).get(sortingVariablesB.get(numv)).get(index));
			}
			sortlist.add(new SNelem(1, index, sortKey));
		}

		Collections.sort(sortlist);
		Integer[] pair;
		ArrayList<String> notAv = new ArrayList<String>();
		notAv.add(NOT_AV);

		for (int index = 0; index < (dimA + dimB); index++) {
			for (int adding = 1; adding < window && (adding + index) < (dimA + dimB); adding++) {
				int index2 = index + adding;

				if (sortlist.get(index2).dataset > sortlist.get(index).dataset) {
					pair = new Integer[2];
					pair[0] = sortlist.get(index).nrow;
					pair[1] = sortlist.get(index2).nrow;
					listPairs.add(pair);

				}
				if (sortlist.get(index2).dataset < sortlist.get(index).dataset) {
					pair = new Integer[2];
					pair[0] = sortlist.get(index2).nrow;
					pair[1] = sortlist.get(index).nrow;
					listPairs.add(pair);

				}
			}
		}

		long freq;

		// contingency evaluation
		for (Integer[] curr : listPairs) {

			final Map<String, String> valuesI = new HashMap<>();

			variabileNomeListMA.forEach(varnameMA -> {
				valuesI.put(varnameMA, worksetIn.get(codeMatchingA).get(varnameMA).get(curr[0]));
			});
			variabileNomeListMB.forEach(varnameMB -> {
				valuesI.put(varnameMB, worksetIn.get(codeMatchingB).get(varnameMB).get(curr[1]));
			});

			String pattern = contingencyService.getPattern(valuesI);
			freq = contingencyTable.get(pattern);
			contingencyTable.put(pattern, freq + 1);

			if (freq < MAXINDEXNUM)
				coupledIndexByPattern.get(PREFIX_PATTERN + pattern).add((curr[0] + 1) + ";" + (curr[1] + 1));
			else
				coupledIndexByPattern.put(PREFIX_PATTERN + pattern, notAv);

		}
		;

		contingencyTableOut.put(VARIABLE_FREQUENCY, new ArrayList<>());
		logService.save("Matching variables: " + nameMatchingVariables);

		// write to worksetout
		contingencyTable.forEach((key, value) -> {
			int idx = 0;
			for (String nameMatchingVariable : nameMatchingVariables) {
				contingencyTableOut.get(nameMatchingVariable).add(String.valueOf(key.charAt(idx++)));
			}
			contingencyTableOut.get(VARIABLE_FREQUENCY).add(value.toString());
		});

		rolesOut.put(codContingencyTable, new ArrayList<>(contingencyTableOut.keySet()));
		rolesOut.put(codContingencyIndexTable, new ArrayList<>(coupledIndexByPattern.keySet()));

		returnOut.put(EngineService.ROLES_OUT, rolesOut);

		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

		worksetOut.put(codContingencyTable, contingencyTableOut);
		worksetOut.put(codContingencyIndexTable, coupledIndexByPattern);

		returnOut.put(EngineService.WORKSET_OUT, worksetOut);
		logService.save("Process Contingency Table End");
		return returnOut;
	}

	// used
	public Map<?, ?> pRLContingencyTableSimHash(Long idelaborazione, Map<String, List<String>> ruoliVariabileNome,
			Map<String, Map<String, List<String>>> worksetIn, Map<String, String> parametriMap) throws Exception {
		final Map<String, Map<?, ?>> returnOut = new HashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new HashMap<>();
		final Map<String, ArrayList<String>> contingencyTableOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

		// <codRuolo,[namevar1,namevar2..]

		final ArrayList<String> variabileNomeListMA = new ArrayList<>();
		final ArrayList<String> variabileNomeListMB = new ArrayList<>();
		final List<String> hashVariablesA = new ArrayList<>();
		final List<String> hashVariablesB = new ArrayList<>();
		final int hdThr, rotations;

		final ArrayList<String> variabileNomeListOut = new ArrayList<>();

		logService.save("Process Contingency Table reduced by SimHash Method Starting...");
		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});
		logService.save("Variables dataset A: " + variabileNomeListMA);
		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});
		logService.save("Variables dataset B: " + variabileNomeListMB);

		hashVariablesA.addAll(RelaisUtility.getFieldsInParams(parametriMap.get(params_simhash), params_ShinglingA));
		hashVariablesB.addAll(RelaisUtility.getFieldsInParams(parametriMap.get(params_simhash), params_ShinglingB));
		String sAppo = RelaisUtility.getStringField(parametriMap.get(params_simhash), params_HDThr);
		hdThr = Integer.parseInt(sAppo);
		sAppo = RelaisUtility.getStringField(parametriMap.get(params_simhash), params_Rotations);
		rotations = Integer.parseInt(sAppo.trim());

		logService.save("Shingling variables dataset A: " + hashVariablesA);
		logService.save("Shingling variables dataset B: " + hashVariablesB);
		logService.save("SimHash parameters [HD threshold:" + hdThr + " Rotations:" + rotations + "]");
		int gramdim = 3;
		int hashdim = 128;
		boolean weights = false;
		boolean dedup = false;
		int gradino = hashdim / rotations;

		ruoliVariabileNome.values().forEach((list) -> {
			variabileNomeListOut.addAll(list);
		});

		try {
			contingencyService.init(parametriMap.get(params_MatchingVariables), worksetIn.get(codeMatchingA),
					worksetIn.get(codeMatchingB));
		} catch (Exception e) {
			logService.save("Error parsing " + params_MatchingVariables);
			throw new Exception("Error parsing " + params_MatchingVariables);
		}
		List<String> nameMatchingVariables = new ArrayList<>();

		contingencyService.getMetricMatchingVariableVector().forEach(metricsm -> {
			contingencyTableOut.put(metricsm.getMatchingVariable(), new ArrayList<>());
			nameMatchingVariables.add(metricsm.getMatchingVariable());
		});

		if (Utility.isNullOrEmpty(hashVariablesA) || Utility.isNullOrEmpty(hashVariablesB)) {
			logService.save("Error parsing Shingling VARAIABLES");
			throw new Exception("Error parsing Shingling VARAIABLES");
		}

		final Map<String, Long> contingencyTable = Collections
				.synchronizedMap(contingencyService.getEmptyContingencyTable());

		final Map<String, List<String>> coupledIndexByPattern = RelaisUtility
				.getEmptyMapByKey(contingencyTable.keySet().stream(), PREFIX_PATTERN);

		final int dimA = worksetIn.get(codeMatchingA).get(hashVariablesA.get(0)).size();

		int dim2 = 0;
		if (!dedup) {
			dim2 = worksetIn.get(codeMatchingB).get(hashVariablesB.get(0)).size();
		}

		final int dimB = dim2;
		final int totRec = dimA + dimB;

		int nVarSort = hashVariablesA.size();

		List<Integer[]> listPairs = new ArrayList<>();

		/*
		 * HashMap wgrams = new HashMap(); HashMap wgramsi = new HashMap(); if (weights)
		 * { for (FileRec frec : strnumA) { addGrams(frec.value,wgrams);
		 * addGrams(invert(frec.value),wgramsi); } if (!dedup) { for (FileRec frec :
		 * strnumB){ addGrams(frec.value,wgrams); addGrams(invert(frec.value),wgramsi);
		 * } } }
		 */

		ArrayList<Simhash.HashRec> set = new ArrayList<Simhash.HashRec>();
		HashMap<String, String> ssr = new HashMap<String, String>();

		// parallel eval of hash fingerprints
		final int CHUNK_SIZE = 8;

		int partitionSizeA = (dimA / CHUNK_SIZE) + ((dimA % CHUNK_SIZE) == 0 ? 0 : 1);
		int partitionSizeB = (dimB / CHUNK_SIZE) + ((dimB % CHUNK_SIZE) == 0 ? 0 : 1);

		IntStream.range(0, partitionSizeA).parallel().forEach(chunkIndex -> {

			int inf = (chunkIndex * CHUNK_SIZE);
			int sup = (chunkIndex == partitionSizeA - 1) ? dimA - 1 : (inf + CHUNK_SIZE - 1);

			Simhash sh = new Simhash(hdThr, rotations, gramdim, weights);
			ArrayList<Simhash.HashRec> setI = new ArrayList<Simhash.HashRec>();

			for (int index = inf; index <= sup; index++) {
				String hashKey;
				hashKey = new String("");
				for (int numv = 0; numv < nVarSort; numv++) {
					hashKey = hashKey.concat(worksetIn.get(codeMatchingA).get(hashVariablesA.get(numv)).get(index));
				}
				try {
					setI.add(sh.new HashRec(0, index, hashKey, hashdim, totRec, weights));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			// syncronise
			synchronized (set) {
				set.addAll(setI);
			}
		});

		if (!dedup) {
			IntStream.range(0, partitionSizeB).parallel().forEach(chunkIndex -> {
				int inf = (chunkIndex * CHUNK_SIZE);
				int sup = (chunkIndex == partitionSizeB - 1) ? dimB - 1 : (inf + CHUNK_SIZE - 1);

				Simhash sh = new Simhash(hdThr, rotations, gramdim, weights);
				ArrayList<Simhash.HashRec> setI = new ArrayList<Simhash.HashRec>();

				for (int index = inf; index <= sup; index++) {
					String hashKey;
					hashKey = new String("");
					for (int numv = 0; numv < nVarSort; numv++) {
						hashKey = hashKey.concat(worksetIn.get(codeMatchingB).get(hashVariablesB.get(numv)).get(index));
					}
					try {
						setI.add(sh.new HashRec(1, index, hashKey, hashdim, totRec, weights));
					} catch (Exception e) {
						e.printStackTrace();
					}
				}

				// syncronise
				synchronized (set) {
					set.addAll(setI);
				}
			});
		}

		Simhash.HashRec h1;
		Simhash.HashRec h2;
		int soglia = hdThr;
		int soglia2 = (int) (hdThr * 0.75);
		int outsoglia = hashdim;
		int sogliagiro;
		int dist;
		String tipogiro = "";
		Integer[] pair;

		for (int giri = 0; giri <= (hashdim / gradino); giri++)
			for (int inv = 0; inv < 2; inv++) {

				sogliagiro = soglia;
				if (giri == (hashdim / gradino)) {
					if (inv == 0) {
						Collections.sort(set, new Simhash.SortValue());
						tipogiro = "SNM  ";
						sogliagiro = soglia2;
					} else {
						Collections.sort(set, new Simhash.SortInvert());
						tipogiro = "SNM/r";
						sogliagiro = soglia2;
					}
				} else {
					if (inv == 0) {
						Collections.sort(set, new Simhash.SortHash());
						tipogiro = "SH" + giri + "  ";
					} else {
						Collections.sort(set, new Simhash.SortHashInvert());
						tipogiro = "SH" + giri + "/r";
					}
				}

				for (int ix = 0; ix < (set.size() - 1); ix++) {

					outsoglia = hashdim;
					for (int ix2 = ix + 1; ix2 < set.size(); ix2++) {
						h1 = set.get(ix);
						h2 = set.get(ix2);
						if (h1.ds != h2.ds || dedup) {
							// confronti++;
							if (inv == 0)
								dist = Simhash.hashdist(h1.hashcodeRec, h2.hashcodeRec);
							else
								dist = Simhash.hashdist(h1.hashinvert, h2.hashinvert);

							if (dist < sogliagiro) {
								outsoglia = hashdim;
								if (((h1.ds == 0 && h2.ds == 1) || (dedup && (h1.num < h2.num)))
										&& (ssr.get(h1.num + ";" + h2.num) == null)) {
									ssr.put(h1.num + ";" + h2.num,
											h1.num + "," + h2.num + ",'" + tipogiro + "'," + dist);
									pair = new Integer[2];
									pair[0] = h1.num;
									pair[1] = h2.num;
									listPairs.add(pair);
								} else if (((h2.ds == 0 && h1.ds == 1) || (dedup && (h1.num > h2.num)))
										&& (ssr.get(h2.num + ";" + h1.num) == null)) {
									ssr.put(h2.num + ";" + h1.num,
											h2.num + "," + h1.num + ",'" + tipogiro + "'," + dist);
									pair = new Integer[2];
									pair[0] = h2.num;
									pair[1] = h1.num;
									listPairs.add(pair);
								}
							} else if (tipogiro.equals("SNM  ")) {
								if (dist > outsoglia) {
									outsoglia = hashdim;
									break;
								} else
									outsoglia = dist;
							} else {
								break;
							}
						}
					}
				}

				for (Simhash.HashRec h : set)
					h.progres(gradino, inv);
			}

		long freq;
		ArrayList<String> notAv = new ArrayList<String>();
		notAv.add(NOT_AV);

		for (Integer[] curr : listPairs) {

			final Map<String, String> valuesI = new HashMap<>();

			variabileNomeListMA.forEach(varnameMA -> {
				valuesI.put(varnameMA, worksetIn.get(codeMatchingA).get(varnameMA).get(curr[0]));
			});
			variabileNomeListMB.forEach(varnameMB -> {
				valuesI.put(varnameMB, worksetIn.get(codeMatchingB).get(varnameMB).get(curr[1]));
			});

			String pattern = contingencyService.getPattern(valuesI);
			freq = contingencyTable.get(pattern);
			contingencyTable.put(pattern, freq + 1);

			if (freq < MAXINDEXNUM)
				coupledIndexByPattern.get(PREFIX_PATTERN + pattern).add((curr[0] + 1) + ";" + (curr[1] + 1));
			else
				coupledIndexByPattern.put(PREFIX_PATTERN + pattern, notAv);

		}
		;

		/* preparig outputs */
		contingencyTableOut.put(VARIABLE_FREQUENCY, new ArrayList<>());
		logService.save("Matching variables: " + nameMatchingVariables);

		// write to worksetout
		contingencyTable.forEach((key, value) -> {
			int idx = 0;
			for (String nameMatchingVariable : nameMatchingVariables) {
				contingencyTableOut.get(nameMatchingVariable).add(String.valueOf(key.charAt(idx++)));
			}
			contingencyTableOut.get(VARIABLE_FREQUENCY).add(value.toString());
		});

		rolesOut.put(codContingencyTable, new ArrayList<>(contingencyTableOut.keySet()));
		rolesOut.put(codContingencyIndexTable, new ArrayList<>(coupledIndexByPattern.keySet()));

		returnOut.put(EngineService.ROLES_OUT, rolesOut);

		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

		worksetOut.put(codContingencyTable, contingencyTableOut);
		worksetOut.put(codContingencyIndexTable, coupledIndexByPattern);

		returnOut.put(EngineService.WORKSET_OUT, worksetOut);
		logService.save("Process Contingency Table End");
		return returnOut;
	}

	// used
	public Map<?, ?> createResiduals(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, Map<String, List<String>>> worksetIn, Map<String, String> parametriMap) throws Exception {

		final Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

		logService.save("Creation of residual datasets starting...");

		ArrayList<String> variabileNomeListMA = new ArrayList<>();
		ArrayList<String> variabileNomeListMB = new ArrayList<>();

		ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
			variabileNomeListMA.add(varname);
		});
		/*
		 * worksetIn.get(codeMatchingA).keySet().forEach((varname) -> {
		 * variabileNomeListMA.add(varname); });
		 */

		ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
			variabileNomeListMB.add(varname);
		});

		logService.save("Variables dataset A: " + variabileNomeListMA);
		logService.save("Variables dataset B: " + variabileNomeListMB);

		rolesOut.put(codResidualA, variabileNomeListMA);
		rolesOut.put(codResidualB, variabileNomeListMB);

		final Map<String, ArrayList<String>> residualA = Collections.synchronizedMap(new LinkedHashMap<>());
		final Map<String, ArrayList<String>> residualB = Collections.synchronizedMap(new LinkedHashMap<>());

		variabileNomeListMA.forEach(varname -> {
			residualA.put(varname, new ArrayList<>());
		});
		variabileNomeListMB.forEach(varname -> {
			residualB.put(varname, new ArrayList<>());
		});

		Map<String, String> KeyA = new HashMap<String, String>();
		Map<String, String> KeyB = new HashMap<String, String>();

		Map<String, List<String>> matches = worksetIn.get(codMatchingTableReduced);
		if (matches == null) {
			matches = worksetIn.get(codMatchingTable);
		}

		int size = matches.get(ROW_IA).size();

		for (int innerIndex = 0; innerIndex < size; innerIndex++) {
			System.out.println("Insert key"+matches.get(ROW_IA).get(innerIndex));
			KeyA.put(matches.get(ROW_IA).get(innerIndex), matches.get(ROW_IB).get(innerIndex));
			KeyB.put(matches.get(ROW_IB).get(innerIndex), matches.get(ROW_IA).get(innerIndex));
		}

		int ressize = 0;

		int dimset = worksetIn.get(codeMatchingA).get(variabileNomeListMA.get(0)).size();

		for (int innerIndex = 0; innerIndex < dimset; innerIndex++) {
			if (!KeyA.containsKey(Integer.toString((innerIndex+1)))) {
				for (String varname : variabileNomeListMA) {
					residualA.get(varname).add(worksetIn.get(codeMatchingA).get(varname).get(innerIndex));
				}
				ressize++;
			}
		}

		ressize = 0;

		dimset = worksetIn.get(codeMatchingB).get(variabileNomeListMB.get(0)).size();

		for (int innerIndex = 0; innerIndex < dimset; innerIndex++) {
			if (!KeyB.containsKey(Integer.toString((innerIndex+1)))) {
				for (String varname : variabileNomeListMB) {
					residualB.get(varname).add(worksetIn.get(codeMatchingB).get(varname).get(innerIndex));
				}
				;
				ressize++;
			}
		}

		returnOut.put(EngineService.ROLES_OUT, rolesOut);
		rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

		worksetOut.put(codResidualA, residualA);
		worksetOut.put(codResidualB, residualB);
		returnOut.put(EngineService.WORKSET_OUT, worksetOut);
		return returnOut;
	}

}