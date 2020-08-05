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
    final static String INDEX_SEPARATOR = ";";
    final static String PREFIX_PATTERN = "P_";

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
    final static String params_MatchingVariables = "MATCHING_VARIABLES";
    final static String params_ThresholdMatching = "THRESHOLD_MATCHING";
    final static String params_ThresholdUnMatching = "THRESHOLD_UNMATCHING";
    final static String params_BlockingVariables = "BLOCKING VARIABLES";
    final static String params_BlockingVariablesA = "BLOCKING A";
    final static String params_BlockingVariablesB = "BLOCKING B";
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

    public Map<?, ?> probabilisticContingencyTable(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
                                                   Map<String, Map<String, List<String>>> worksetIn, Map<String, String> parametriMap) throws Exception {

        return callGenericMethod("pRLContingencyTable", idelaborazione, ruoliVariabileNome, worksetIn, parametriMap);
    }

    public Map<?, ?> deterministicRecordLinkage(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
                                                Map<String, Map<String, List<String>>> worksetIn, Map<String, String> parametriMap) throws Exception {

        return callGenericMethod("dRL", idelaborazione, ruoliVariabileNome, worksetIn, parametriMap);
    }

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

        return (Map<?, ?>) method.invoke(this, idelaborazione, ruoliVariabileNome, worksetIn, parametriMap);
    }

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
            contingencyService.init(parametriMap.get(params_MatchingVariables));
        } catch (Exception e) {
            logService.save("Error parsing " + params_MatchingVariables);
            throw new Exception("Error parsing " + params_MatchingVariables);
        }
        List<String> nameMatchingVariables = new ArrayList<>();

        contingencyService.getMetricMatchingVariableVector().forEach(metricsm -> {
            contingencyTableOut.put(metricsm.getMatchingVariable(), new ArrayList<>());
            nameMatchingVariables.add(metricsm.getMatchingVariable());
        });

        final Map<String, Integer> contingencyTable = Collections
                .synchronizedMap(contingencyService.getEmptyContingencyTable());

//		final Map<String, List<String>> coupledIndexByPattern = RelaisUtility.getEmptyMapByKey(
//				contingencyTable.keySet().stream().filter(key -> Integer.parseInt(key) > 0), PREFIX_PATTERN);

        IntStream.range(0, sizeA).parallel().forEach(innerIA -> {

            final Map<String, String> valuesI = new HashMap<>();
            final Map<String, Integer> contingencyTableIA = contingencyService.getEmptyContingencyTable();
            //	final Map<String, List<String>> coupledIndexByPatternIA = RelaisUtility
            //			.getEmptyMapByKey(coupledIndexByPattern.keySet().stream(), "");

            variabileNomeListMA.forEach(varnameMA -> {
                valuesI.put(varnameMA, worksetIn.get(codeMatchingA).get(varnameMA).get(innerIA));
            });

            IntStream.range(0, sizeB).forEach(innerIB -> {
                variabileNomeListMB.forEach(varnameMB -> {
                    valuesI.put(varnameMB, worksetIn.get(codeMatchingB).get(varnameMB).get(innerIB));
                });

                String pattern = contingencyService.getPattern(valuesI);
                contingencyTableIA.put(pattern, contingencyTableIA.get(pattern) + 1);
                //		if (Integer.parseInt(pattern) > 0)
                //			coupledIndexByPatternIA.get(PREFIX_PATTERN + pattern).add((innerIA + 1) + ";" + (innerIB + 1)); // store
                // no
                // zero
                // based

            });
            synchronized (contingencyTable) {
                contingencyTableIA.entrySet().stream().forEach(e -> contingencyTable.put(e.getKey(),
                        contingencyTable.get(e.getKey()) + contingencyTableIA.get(e.getKey())));
            }
	/*		synchronized (coupledIndexByPattern) {
				coupledIndexByPatternIA.entrySet().stream().forEach(
						e -> coupledIndexByPattern.get(e.getKey()).addAll(coupledIndexByPatternIA.get(e.getKey())));
			}
*/
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
        //	rolesOut.put(codContengencyIndexTable, new ArrayList<>(coupledIndexByPattern.keySet()));
        returnOut.put(EngineService.ROLES_OUT, rolesOut);

        rolesOut.keySet().forEach(code -> {
            rolesGroupOut.put(code, code);
        });
        returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

        worksetOut.put(codContingencyTable, contingencyTableOut);
        //	worksetOut.put(codContengencyIndexTable, coupledIndexByPattern);

        returnOut.put(EngineService.WORKSET_OUT, worksetOut);

        return returnOut;
    }

    // parallel blocking
    public Map<?, ?> pRLContingencyTableBlockingVariables(Long idelaborazione,
                                                          Map<String, List<String>> ruoliVariabileNome, Map<String, Map<String, List<String>>> worksetIn,
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

        Map<String, List<Integer>> indexesBlockingVariableA = RelaisUtility
                .blockVariablesIndexMapValues(worksetIn.get(codeMatchingA), blockingVariablesA);
        Map<String, List<Integer>> indexesBlockingVariableB = RelaisUtility
                .blockVariablesIndexMapValues(worksetIn.get(codeMatchingB), blockingVariablesB);
        logService.save("Size Blocking dataset A: " + indexesBlockingVariableA.size());
        logService.save("Size Blocking dataset B: " + indexesBlockingVariableB.size());

        final Map<String, Integer> contengencyTable = Collections
                .synchronizedMap(contingencyService.getEmptyContingencyTable());

	/*	final Map<String, List<String>> coupledIndexByPattern = RelaisUtility.getEmptyMapByKey(
				contengencyTable.keySet().stream().filter(key -> Integer.parseInt(key) > 0), PREFIX_PATTERN);
*/
        indexesBlockingVariableA.entrySet().parallelStream().forEach(entry -> {
            String keyBlock = entry.getKey();

            final Map<String, Integer> contengencyTableIA = contingencyService.getEmptyContingencyTable();

	/*		final Map<String, List<String>> coupledIndexByPatternIA = RelaisUtility
					.getEmptyMapByKey(coupledIndexByPattern.keySet().stream(), "");
*/

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
                        contengencyTableIA.put(pattern, contengencyTableIA.get(pattern) + 1);
			/*			if (Integer.parseInt(pattern) > 0)
							coupledIndexByPatternIA.get(PREFIX_PATTERN + pattern)
									.add((innerIA + 1) + ";" + (innerIB + 1)); // store no zero based

				*/
                    });

            });

            synchronized (contengencyTable) {
                contengencyTableIA.entrySet().stream().forEach(e -> contengencyTable.put(e.getKey(),
                        contengencyTable.get(e.getKey()) + contengencyTableIA.get(e.getKey())));
            }
		/*	synchronized (coupledIndexByPattern) {
				coupledIndexByPatternIA.entrySet().stream().forEach(
						e -> coupledIndexByPattern.get(e.getKey()).addAll(coupledIndexByPatternIA.get(e.getKey())));
			}
			*/
        });
        contengencyTableOut.put(VARIABLE_FREQUENCY, new ArrayList<>());

        // write to worksetout
        contengencyTable.forEach((key, value) -> {
            int idx = 0;
            for (String nameMatchingVariable : nameMatchingVariables) {
                contengencyTableOut.get(nameMatchingVariable).add(String.valueOf(key.charAt(idx++)));
            }
            contengencyTableOut.get(VARIABLE_FREQUENCY).add(value.toString());
        });

        rolesOut.put(codContingencyTable, new ArrayList<>(contengencyTableOut.keySet()));
        //rolesOut.put(codContengencyIndexTable, new ArrayList<>(coupledIndexByPattern.keySet()));

        returnOut.put(EngineService.ROLES_OUT, rolesOut);

        rolesOut.keySet().forEach(code -> {
            rolesGroupOut.put(code, code);
        });
        returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

        worksetOut.put(codContingencyTable, contengencyTableOut);
        //	worksetOut.put(codContengencyIndexTable, coupledIndexByPattern);

        returnOut.put(EngineService.WORKSET_OUT, worksetOut);
        logService.save("Process Contingency Table Blocking End");
        return returnOut;
    }

    public Map<?, ?> probabilisticResultTables(final Long idelaborazione, final Map<String, ArrayList<String>> ruoliVariabileNome,
                                               final Map<String, Map<String, List<String>>> worksetIn, final Map<String, String> parametriMap) throws Exception {

        return callGenericMethod("pRLResultTables", idelaborazione, ruoliVariabileNome, worksetIn, parametriMap);
    }

    public Map<?, ?> pRLResultTablesBlockingVariables(final Long idelaborazione,
                                                      final Map<String, ArrayList<String>> ruoliVariabileNome, final Map<String, Map<String, List<String>>> worksetInn,
                                                      final Map<String, String> parametriMap) throws Exception {

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
                            if (cprec < mprec) mprec = cprec;
                            if (cprec < pprec) pprec = cprec;
                            if (crec > mrec) mrec = crec;
                            if (crec > prec) prec = crec;
                        } else {
                            patternPossibleMatching.add(pattern.toString());
                            if (cprec < pprec) pprec = cprec;
                            if (crec > prec) prec = crec;
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

        blockingVariablesA
                .addAll(RelaisUtility.getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesA));
        blockingVariablesB
                .addAll(RelaisUtility.getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesB));

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

        contingencyService.init(parametriMap.get(params_MatchingVariables));
        variabileNomeListOut.forEach(varname -> {
            matchingTable.put(varname, new ArrayList<>());
            possibleMatchingTable.put(varname, new ArrayList<>());
        });

        Map<String, List<Integer>> indexesBlockingVariableA = RelaisUtility.blockVariablesIndexMapValues(worksetInn.get(codeMatchingA),
                blockingVariablesA);
        Map<String, List<Integer>> indexesBlockingVariableB = RelaisUtility.blockVariablesIndexMapValues(worksetInn.get(codeMatchingB),
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

                valuesI.put(ROW_IA, Integer.toString(innerIA + 1));// store index no zero-based +1
                variabileNomeListMA.stream().filter(varname -> !ROW_IA.equals(varname)).forEach(varnameMA -> {
                    valuesI.put(varnameMA, worksetInn.get(codeMatchingA).get(varnameMA).get(innerIA));// get value zero-based
                });

                if (indexesBlockingVariableB.get(keyBlock) != null)
                    indexesBlockingVariableB.get(keyBlock).forEach(innerIB -> {

                        valuesI.put(ROW_IB, Integer.toString(innerIB + 1));
                        variabileNomeListMB.stream().filter(varname -> !ROW_IB.equals(varname)).forEach(varnameMB -> {
                            valuesI.put(varnameMB, worksetInn.get(codeMatchingB).get(varnameMB).get(innerIB));// get value zero-based
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

        /*load quality indicators */
        logService.save("Quality Indicators (" + codQualityIndicators + ") :" + String.valueOf(mprec) + " " + String.valueOf(mrec));

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

    public Map<?, ?> pRLResultTablesCartesianProduct(final Long idelaborazione,
                                                     final Map<String, ArrayList<String>> ruoliVariabileNome, final Map<String, Map<String, List<String>>> worksetInn,
                                                     final Map<String, String> parametriMap) throws Exception {

        final Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
        final Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
        final Map<String, ArrayList<String>> matchingTable = Collections.synchronizedMap(new LinkedHashMap<>());
        final Map<String, ArrayList<String>> possibleMatchingTable = Collections.synchronizedMap(new LinkedHashMap<>());
        final Map<String, ArrayList<String>> residualATable = new LinkedHashMap<>();
        final Map<String, ArrayList<String>> residualBTable = new LinkedHashMap<>();
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
                            if (cprec < mprec) mprec = cprec;
                            if (cprec < pprec) pprec = cprec;
                            if (crec > mrec) mrec = crec;
                            if (crec > prec) prec = crec;
                        } else {
                            patternPossibleMatching.add(pattern.toString());
                            if (cprec < pprec) pprec = cprec;
                            if (crec > prec) prec = crec;
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

        /*load quality indicators */
        logService.save("Quality Indicators (" + codQualityIndicators + ") :" + String.valueOf(mprec) + " " + String.valueOf(mrec));

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

    public Map<?, ?> pRLResultTablesCartesianProduct_canc(final Long idelaborazione,
                                                          final Map<String, ArrayList<String>> ruoliVariabileNome, final Map<String, Map<String, List<String>>> worksetInn,
                                                          final Map<String, String> parametriMap) throws Exception {

        final Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
        final Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
        final Map<String, ArrayList<String>> residualATable = new LinkedHashMap<>();
        final Map<String, ArrayList<String>> residualBTable = new LinkedHashMap<>();
        final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
        final Map<String, ArrayList<String>> qualityIndicators = new LinkedHashMap<>();
        final Map<String, String> rolesGroupOut = new HashMap<>();

        logService.save("Process Matching Tables  Starting...");

        // <codRuolo,[namevar1,namevar2..]
        int indexItems = 0;
        final ArrayList<String> patternMatching = new ArrayList<>();
        final ArrayList<String> patternPossibleMatching = new ArrayList<>();
        final Map<String, String> patternPPostValues = new HashMap<>();
        final Map<String, String> patternRValues = new HashMap<>();
        float mprec = 1f, pprec = 1f, mrec = 0f, prec = 0f;

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
                            if (cprec < mprec) mprec = cprec;
                            if (cprec < pprec) pprec = cprec;
                            if (crec > mrec) mrec = crec;
                            if (crec > prec) prec = crec;
                        } else {
                            patternPossibleMatching.add(pattern.toString());
                            if (cprec < pprec) pprec = cprec;
                            if (crec > prec) prec = crec;
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


        // final Map<String, ArrayList<String>> matchingTable =
        // Collections.synchronizedMap(new LinkedHashMap<>());
        // final Map<String, ArrayList<String>> possibleMatchingTable =
        // Collections.synchronizedMap(new LinkedHashMap<>());

        final Map<String, ArrayList<String>> matchingTable = elaborateResultTable(worksetInn, variabileNomeListMA,
                variabileNomeListMB, variabileNomeListOut, patternMatching, patternPPostValues, patternRValues);
        final Map<String, ArrayList<String>> possibleMatchingTable = elaborateResultTable(worksetInn,
                variabileNomeListMA, variabileNomeListMB, variabileNomeListOut, patternPossibleMatching,
                patternPPostValues, patternRValues);

        /*load quality indicators */

        logService.save("Quality Indicators :" + String.valueOf(mprec) + " " + String.valueOf(mrec));

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


    public Map<?, ?> probabilisticResultTablesByIndex(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
                                                      Map<String, Map<String, List<String>>> worksetInn, Map<String, String> parametriMap) throws Exception {

        final Map<String, Map<?, ?>> returnOut = new LinkedHashMap<>();
        final Map<String, Map<?, ?>> worksetOut = new LinkedHashMap<>();
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
        Map<String, String> patternRValues = new HashMap<>();
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

            int sizeList = worksetInn.get(codContingencyTable).get(pattern).size();
            int partitionSize = (sizeList / CHUNK_SIZE) + ((sizeList % CHUNK_SIZE) == 0 ? 0 : 1);

            IntStream.range(0, partitionSize).parallel().forEach(chunkIndex -> {

                int inf = (chunkIndex * CHUNK_SIZE);
                int sup = (chunkIndex == partitionSize - 1) ? sizeList - 1 : (inf + CHUNK_SIZE - 1);

                final Map<String, ArrayList<String>> resultMatchTableI = new HashMap<>();
                variabileNomeListOut.forEach(varname -> {
                    resultMatchTableI.put(varname, new ArrayList<>());
                });


                IntStream.rangeClosed(inf, sup).forEach(innerIndex -> {

                    String[] indexesArr = worksetInn.get(codContingencyTable).get(pattern).get(innerIndex).split(INDEX_SEPARATOR);
                    int innerIA = Integer.parseInt(indexesArr[0]);
                    int innerIB = Integer.parseInt(indexesArr[1]);

                    final Map<String, String> valuesI = new HashMap<>();


                    valuesI.put(ROW_IA, Integer.toString(innerIA));
                    variabileNomeListMA.stream().filter(varname -> !ROW_IA.equals(varname)).forEach(varnameMA -> {

                        valuesI.put(varnameMA, worksetInn.get(codeMatchingA).get(varnameMA).get(innerIA - 1));// to zero-based
                    });

                    valuesI.put(ROW_IB, Integer.toString(innerIB));
                    variabileNomeListMB.stream().filter(varname -> !ROW_IB.equals(varname)).forEach(varnameMB -> {
                        valuesI.put(varnameMB, worksetInn.get(codeMatchingB).get(varnameMB).get(innerIB - 1));// get value zero-based
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

        // ruoliVariabileNome.get(codeBlockingVariablesA).forEach((varname) -> {
        // blockingVariablesA.add(varname);
        // });

        // ruoliVariabileNome.get(codeBlockingVariablesB).forEach((varname) -> {
        // blockingVariablesB.add(varname);
        // });
        blockingVariablesB.addAll(
                RelaisUtility.getFieldsInParams(parametriMap.get(params_BlockingVariables), params_BlockingVariablesB));

        logService.save("Matching variables dataset A: " + variabileNomeListMA);
        logService.save("Matching variables dataset B: " + variabileNomeListMB);
        logService.save("Blocking variables dataset A: " + blockingVariablesA);
        logService.save("Blocking variables dataset B: " + blockingVariablesB);

        variabileNomeListOut.addAll(variabileNomeListMA);
        variabileNomeListOut.addAll(variabileNomeListMB);

        rolesOut.put(codMatchingTable, variabileNomeListOut);

        contingencyService.init(parametriMap.get(params_MatchingVariables));
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
