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

import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import it.istat.is2.app.service.LogService;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.app.util.Utility;

/**
 * @author framato
 *
 */
@Component
public class RelaisService {

	final int stepService = 250;
	final int sizeFlushed = 20;

	final String codeMatchingA = "X1";
	final String codeMatchingB = "X2";
	final String codContengencyTable = "CT";
	final String codMachingTable = "MT";
	final String codPossibleMachingTable = "PM";
	final String codResidualA = "RA";
	final String codResidualB = "RB";
	final String codeFS = "FS";
	final String codeP_POST = "P_POST";
	final String params_MatchingVariables = "MATCHING_VARIABLES";
	final String params_ThresholdMatching = "THRESHOLD_MATCHING";
	final String params_ThresholdUnMatching = "THRESHOLD_UNMATCHING";
	final String params_BlockingVariables = "BLOCKING_VARIABLES";
	final String params_BlockingVariablesA = "BLOCKING_A";
	final String params_BlockingVariablesB = "BLOCKING_B";

	@Autowired
	private LogService logService;

	@Autowired
	private ContingencyService contingencyService;

	public Map<?, ?> contingencyTable(Long idelaborazione, Map<String, List<String>> ruoliVariabileNome,
			Map<String, List<String>> worksetVariabili, Map<String, String> parametriMap) throws Exception {

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

/*		final String sortFieldA = variabileNomeListMA.get(0);
		final String sortFieldB = variabileNomeListMB.get(0);
		Utility.printNElementsInMapValues(worksetVariabili, 5);
		Utility.sortDatasetInMapValues(worksetVariabili, variabileNomeListMA, sortFieldA, IS2Const.SORT_ASC);
		Utility.printNElementsInMapValues(worksetVariabili, 5);
		Utility.sortDatasetInMapValues(worksetVariabili, variabileNomeListMB, sortFieldB, IS2Const.SORT_ASC);
		Utility.printNElementsInMapValues(worksetVariabili, 5);
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
		return returnOut;
	}

	//versione parallel blocking
	public Map<?, ?> contingencyTableBlocking(Long idelaborazione, Map<String, List<String>> ruoliVariabileNome,
			Map<String, List<String>> worksetVariabili, Map<String, String> parametriMap) throws Exception {
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

		final String blockingVariableA = getFieldInParams(parametriMap.get(params_BlockingVariables),params_BlockingVariablesA);
		final String blockingVariableB = getFieldInParams(parametriMap.get(params_BlockingVariables),params_BlockingVariablesB);
		
		
		Map<String, List<Integer>> indexesBlockingVariableA = Utility.blockVariablesIndexMapValues(worksetVariabili,
				variabileNomeListMA, blockingVariableA);
		Map<String, List<Integer>> indexesBlockingVariableB = Utility.blockVariablesIndexMapValues(worksetVariabili,
				variabileNomeListMB, blockingVariableB);

		indexesBlockingVariableA.entrySet().parallelStream().forEach(entry -> {
			String keyBlock = entry.getKey();

			// Dataset A
			entry.getValue().forEach(innerIA -> {

				Map<String, String> valuesI = new HashMap<>();

				variabileNomeListMA.forEach(varnameMA -> {
					valuesI.put(varnameMA, worksetVariabili.get(varnameMA).get(innerIA));
				});
               if(indexesBlockingVariableB.get(keyBlock)!=null)
				indexesBlockingVariableB.get(keyBlock).forEach(innerIB -> {

					variabileNomeListMB.forEach(varnameMB -> {
						valuesI.put(varnameMB, worksetVariabili.get(varnameMB).get(innerIB));
					});

					String pattern = contingencyService.getPattern(valuesI);
					contengencyTable.put(pattern, contengencyTable.get(pattern) + 1);

				});

			});
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
		
		  Instant finish = Instant.now();
		  
	
		System.out.println("Durata in millis: "+ Duration.between(start, finish).toMillis());
		return returnOut;
	}

	private String getFieldInParams(String jsonString, String fieldName) throws Exception {
		String ret=null;
		try {
			JSONObject jSONObject = new JSONObject(jsonString) ;
			ret=jSONObject.getString(fieldName);
		} catch (Exception e) {
			logService.save("Error parsing " + params_BlockingVariables);
			throw new Exception("Error parsing " + params_BlockingVariables);
		}
		if(ret==null) throw new Exception("Error parsing " + params_BlockingVariables);
		return ret;
		
	}

	public Map<?, ?> resultTablesBlocking(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, List<String>> worksetIn, Map<String, String> parametriMap) throws Exception {

		Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
		Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
		Map<String, ArrayList<String>> matchingTable = new LinkedHashMap<>();
		Map<String, ArrayList<String>> possibleMatchingTable = new LinkedHashMap<>();
		Map<String, ArrayList<String>> residualATable = new LinkedHashMap<>();
		Map<String, ArrayList<String>> residualBTable = new LinkedHashMap<>();
		Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		Map<String, String> rolesGroupOut = new HashMap<>();

		// <codRuolo,[namevar1,namevar2..]
		int indexItems = 0;
		ArrayList<String> patternMatching = new ArrayList<>();
		ArrayList<String> patternPossibleMatching = new ArrayList<>();
		Map<String, String> patternPPostValues = new HashMap<>();
		String paramTM = parametriMap.get(params_ThresholdMatching);
		String paramTU = parametriMap.get(params_ThresholdUnMatching);

		checkThresholds(paramTM, paramTU);

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


		final String blockingVariableA = getFieldInParams(parametriMap.get(params_BlockingVariables),params_BlockingVariablesA);
		final String blockingVariableB = getFieldInParams(parametriMap.get(params_BlockingVariables),params_BlockingVariablesB);
	
		Map<String, List<Integer>> indexesBlockingVariableA = Utility.blockVariablesIndexMapValues(worksetIn,
				variabileNomeListMA, blockingVariableA);
		Map<String, List<Integer>> indexesBlockingVariableB = Utility.blockVariablesIndexMapValues(worksetIn,
				variabileNomeListMB, blockingVariableB);

		indexesBlockingVariableA.entrySet().parallelStream().forEach(entry -> {
			String keyBlock = entry.getKey();

			// Dataset A
			entry.getValue().forEach(innerIA -> {

			Map<String, String> valuesI = new HashMap<>();
			 
			variabileNomeListMA.forEach(varnameMA -> {
				valuesI.put(varnameMA, worksetIn.get(varnameMA).get(innerIA));
			});

			if(indexesBlockingVariableB.get(keyBlock)!=null)
				indexesBlockingVariableB.get(keyBlock).forEach(innerIB -> {
				 
				variabileNomeListMB.forEach(varnameMB -> {
					valuesI.put(varnameMB, worksetIn.get(varnameMB).get(innerIB));
				});
				String pattern = contingencyService.getPattern(valuesI);
				if (patternMatching.contains(pattern)) {
					valuesI.forEach((k, v) -> {
						matchingTable.get(k).add(v);
					});
					matchingTable.get(codeP_POST).add(patternPPostValues.get(pattern));
				} else if (patternPossibleMatching.contains(pattern)) {
					valuesI.forEach((k, v) -> {
						possibleMatchingTable.get(k).add(v);
					});
					possibleMatchingTable.get(codeP_POST).add(patternPPostValues.get(pattern));
				}
				 
			});
		});
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
	
	public Map<?, ?> resultTablesProductNM(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, ArrayList<String>> worksetIn, Map<String, String> parametriMap) throws Exception {

		Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
		Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
		Map<String, ArrayList<String>> matchingTable = new LinkedHashMap<>();
		Map<String, ArrayList<String>> possibleMatchingTable = new LinkedHashMap<>();
		Map<String, ArrayList<String>> residualATable = new LinkedHashMap<>();
		Map<String, ArrayList<String>> residualBTable = new LinkedHashMap<>();
		Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		Map<String, String> rolesGroupOut = new HashMap<>();

		// <codRuolo,[namevar1,namevar2..]
		int indexItems = 0;
		ArrayList<String> patternMatching = new ArrayList<>();
		ArrayList<String> patternPossibleMatching = new ArrayList<>();
		Map<String, String> patternPPostValues = new HashMap<>();
		String paramTM = parametriMap.get(params_ThresholdMatching);
		String paramTU = parametriMap.get(params_ThresholdUnMatching);

		checkThresholds(paramTM, paramTU);

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
		for (int iA = 0; iA < sizeA; iA++) {
			Map<String, String> valuesI = new HashMap<>();
			final Integer innerIA = Integer.valueOf(iA);
			variabileNomeListMA.forEach(varnameMA -> {
				valuesI.put(varnameMA, worksetIn.get(varnameMA).get(innerIA));
			});

			for (int iB = 0; iB < sizeB; iB++) {
				final Integer innerIB = Integer.valueOf(iB);
				variabileNomeListMB.forEach(varnameMB -> {
					valuesI.put(varnameMB, worksetIn.get(varnameMB).get(innerIB));
				});
				String pattern = contingencyService.getPattern(valuesI);
				if (patternMatching.contains(pattern)) {
					valuesI.forEach((k, v) -> {
						matchingTable.get(k).add(v);
					});
					matchingTable.get(codeP_POST).add(patternPPostValues.get(pattern));
				} else if (patternPossibleMatching.contains(pattern)) {
					valuesI.forEach((k, v) -> {
						possibleMatchingTable.get(k).add(v);
					});
					possibleMatchingTable.get(codeP_POST).add(patternPPostValues.get(pattern));
				}
				indexItems++;
			}
		}

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
