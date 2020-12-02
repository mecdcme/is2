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

import java.io.Serializable;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Component;

import it.istat.is2.catalogue.relais.metrics.*;
import it.istat.is2.catalogue.relais.metrics.added.*;
import it.istat.is2.catalogue.relais.metrics.dataStructure.MetricMatchingVariable;
import it.istat.is2.catalogue.relais.metrics.dataStructure.MetricMatchingVariableVector;
import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import lombok.Data;

/**
 * @author framato
 *
 */
@Data
@Component
public class ContingencyService implements Serializable {
    private static final long serialVersionUID = -4825885817709343718L;
    private final int DIMMAX = 100000;
    private String blockingKey;
    private MetricMatchingVariableVector metricMatchingVariableVector;
    private int numVar;
    private int dim;
    private int[][] combinations;
    private AbstractStringMetric[] metrics;

    public void init(String stringJson,Map <String, List<String>> dsa,Map <String, List<String>> dsb) throws JSONException {
        metricMatchingVariableVector = new MetricMatchingVariableVector();
        JSONArray metricMatchingVariables = new JSONArray(stringJson);
        for (int i = 0; i < metricMatchingVariables.length(); i++) {
            JSONObject metricMatchingVariable = metricMatchingVariables.getJSONObject(i);
            String matchingVariable = metricMatchingVariable.getString("MatchingVariable");
            String matchingVariableA = metricMatchingVariable.getString("MatchingVariableA");
            String matchingVariableB = metricMatchingVariable.getString("MatchingVariableB");
            String method = metricMatchingVariable.getString("Method");
            Float threshold = metricMatchingVariable.isNull("Threshold") ? null
                    : Float.parseFloat(metricMatchingVariable.get("Threshold").toString());
            Integer windowSize = metricMatchingVariable.isNull("WindowSize") ? null
                    : Integer.parseInt(metricMatchingVariable.get("WindowSize").toString());
            MetricMatchingVariable mm = new MetricMatchingVariable(matchingVariable, matchingVariableA,
                    matchingVariableB, method, threshold, windowSize);
            metricMatchingVariableVector.add(mm);

        }

        this.numVar = metricMatchingVariableVector.size();
        metrics = new AbstractStringMetric[numVar];
        for (int ind = 0; ind < numVar; ind++) {
        	if (metricMatchingVariableVector.get(ind).getComparisonFunction().equals("Equality"))
				metrics[ind] = null;
			else if (metricMatchingVariableVector.get(ind).getComparisonFunction().equals("Jaro"))
				metrics[ind] = new Jaro();
			else if (metricMatchingVariableVector.get(ind).getComparisonFunction().equals("Dice"))
				metrics[ind] = new DiceSimilarity();
			else if (metricMatchingVariableVector.get(ind).getComparisonFunction().equals("JaroWinkler"))
				metrics[ind] = new JaroWinkler();
			else if (metricMatchingVariableVector.get(ind).getComparisonFunction().equals("Levenshtein"))
				metrics[ind] = new Levenshtein();
			else if (metricMatchingVariableVector.get(ind).getComparisonFunction().equals("3Grams"))
				metrics[ind] = new QGramsDistance();
			else if (metricMatchingVariableVector.get(ind).getComparisonFunction().equals("Soundex"))
				metrics[ind] = new Soundex();
			else if (metricMatchingVariableVector.get(ind).getComparisonFunction().equals("NumericComparison"))
				metrics[ind] = new NumericComparison();
			else if (metricMatchingVariableVector.get(ind).getComparisonFunction().equals("NumericEuclideanDistance"))
				metrics[ind] = new NumericEuclideanDistance();
			else if (metricMatchingVariableVector.get(ind).getComparisonFunction().equals("WindowEquality"))
				metrics[ind] = new WindowEquality(metricMatchingVariableVector.get(ind));
			else if (metricMatchingVariableVector.get(ind).getComparisonFunction().equals("Inclusion3Grams"))
				metrics[ind] = new QGramsInclusion();
			else if (metricMatchingVariableVector.get(ind).getComparisonFunction().equals("SimHash"))
				metrics[ind] = new Simhash();
			else if (metricMatchingVariableVector.get(ind).getComparisonFunction().equals("Weighed3Grams")) {
				metrics[ind] = new Likeness();
				metrics[ind].prepareMap(dsa.get(metricMatchingVariableVector.get(ind).getMatchingVariableNameVariableA()));
				metrics[ind].prepareMap(dsb.get(metricMatchingVariableVector.get(ind).getMatchingVariableNameVariableB()));
			}
         
        }

    }

    public ArrayList<String> getNameMatchingVariables() {

        ArrayList<String> ret = new ArrayList<>();
        metricMatchingVariableVector.forEach(item -> {
            ret.add(item.getMatchingVariable());
        });
        return ret;
    }

    public String getPattern(Map<String, String> valuesI) {

        StringBuilder pattern = new StringBuilder();

        /* evaluation of pattern */

        for (int ii = 0; ii < numVar; ii++) {

            StringBuilder matchingVariableA = new StringBuilder();
            StringBuilder matchingVariableB = new StringBuilder();

            MetricMatchingVariable metricMatchingVariable = metricMatchingVariableVector.get(ii);

            matchingVariableA.append(valuesI
                    .get(metricMatchingVariable.getMatchingVariableNameVariableA()));
            matchingVariableB.append(valuesI
                    .get(metricMatchingVariable.getMatchingVariableNameVariableB()));

            if (matchingVariableA == null || matchingVariableB == null
                    || matchingVariableA.length()==0) {

                pattern.append("0");
            }
            // Equality
            else if (metrics[ii] == null) {
                if (matchingVariableA.compareTo(matchingVariableB)==0)
                    pattern.append("1");
                else
                    pattern.append("0");
            } else {

                if (metrics[ii].getSimilarity(matchingVariableA,
                        matchingVariableB) >= metricMatchingVariable.getMetricThreshold().floatValue())
                    pattern.append("1");
                else
                    pattern.append("0");
            }
        }
        return pattern.toString();
    }

    public Map<String, Integer> getEmptyContingencyTable() {

        Map<String, Integer> contingencyTable = new LinkedHashMap<String, Integer>();
        int mask1 = (int) Math.pow(2, numVar);
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < mask1; i++) {
            sb = new StringBuffer();
            int mask = mask1;
            while (mask > 0) {
                if ((mask & i) == 0) {
                    sb.append("0");

                } else {
                    sb.append("1");
                }
                mask = mask >> 1;
            }
            contingencyTable.put(sb.substring(1), 0);
        }
        return contingencyTable;
    }

    public boolean isExactMatching(Map<String, String> valuesI) {

        for (int ii = 0; ii < numVar; ii++) {

            StringBuilder matchingVariableA = new StringBuilder();
            StringBuilder matchingVariableB = new StringBuilder();

            MetricMatchingVariable metricMatchingVariable = metricMatchingVariableVector.get(ii);
            matchingVariableA.append(valuesI
                    .get(metricMatchingVariable.getMatchingVariableNameVariableA()));
            matchingVariableB.append(valuesI
                    .get(metricMatchingVariable.getMatchingVariableNameVariableB()));

            if (matchingVariableA == null || matchingVariableB == null
                    || matchingVariableA.length()==0) {
                return false;
            }
            // Equality
            else if (metrics[ii] == null) {
                if (matchingVariableA.compareTo(matchingVariableB)!=0)
                    return false;
            } else {
                if (metrics[ii].getSimilarity(matchingVariableA,
                        matchingVariableB) < metricMatchingVariable.getMetricThreshold().floatValue())
                    return false;
            }
        }
        return true;
    }

}
