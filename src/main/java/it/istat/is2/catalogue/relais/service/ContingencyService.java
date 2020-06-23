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
import java.util.LinkedHashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Component;

import it.istat.is2.catalogue.relais.metrics.DiceSimilarity;
import it.istat.is2.catalogue.relais.metrics.Jaro;
import it.istat.is2.catalogue.relais.metrics.JaroWinkler;
import it.istat.is2.catalogue.relais.metrics.Levenshtein;
import it.istat.is2.catalogue.relais.metrics.QGramsDistance;
import it.istat.is2.catalogue.relais.metrics.Soundex;
import it.istat.is2.catalogue.relais.metrics.added.NumericComparison;
import it.istat.is2.catalogue.relais.metrics.added.NumericEuclideanDistance;
import it.istat.is2.catalogue.relais.metrics.added.QGramsInclusion;
import it.istat.is2.catalogue.relais.metrics.added.WindowEquality;
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
public class ContingencyService {
	private final int DIMMAX = 100000;
	private String blockingKey;
	private MetricMatchingVariableVector metricMatchingVariableVector;
	private int numVar;
	private int dim;
	private int[][] combinations;
	private AbstractStringMetric[] metrics;

	public void init(String stringJson) throws JSONException {
		metricMatchingVariableVector = new MetricMatchingVariableVector();
		JSONArray metricMatchingVariables = new JSONArray(stringJson);
		for (int i = 0; i < metricMatchingVariables.length(); i++) {
			JSONObject metricMatchingVariable = metricMatchingVariables.getJSONObject(i);
			String matchingVariable = metricMatchingVariable.getString("MatchingVariable");
			String matchingVariableA = metricMatchingVariable.getString("MatchingVariableA");
			String matchingVariableB = metricMatchingVariable.getString("MatchingVariableB");
			String method = metricMatchingVariable.getString("Method");
			Float thresould = metricMatchingVariable.isNull("Threshold") ? null
					: metricMatchingVariable.getFloat("Threshold");
			Integer windowSize = metricMatchingVariable.isNull("WindowSize") ? null
					: metricMatchingVariable.getInt("WindowSize");
			MetricMatchingVariable mm = new MetricMatchingVariable(matchingVariable, matchingVariableA,
					matchingVariableB, method, thresould, windowSize);
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

		String pattern = "";

		/* evaluation of patternd */

		for (int ii = 0; ii < numVar; ii++) {
			MetricMatchingVariable metricMatchingVariable = metricMatchingVariableVector.get(ii);
			String matchingVariableNameVariableA = valuesI
					.get(metricMatchingVariable.getMatchingVariableNameVariableA());
			String matchingVariableNameVariableB = valuesI
					.get(metricMatchingVariable.getMatchingVariableNameVariableB());

			if (matchingVariableNameVariableA == null || matchingVariableNameVariableB == null
					|| matchingVariableNameVariableA.equals("")) {

				pattern = pattern + "0";
			}
			// Equality
			else if (metrics[ii] == null) {
				if (matchingVariableNameVariableA.equals(matchingVariableNameVariableB))
					pattern = pattern + "1";
				else
					pattern = pattern + "0";
			} else {

				if (metrics[ii].getSimilarity(matchingVariableNameVariableA,
						matchingVariableNameVariableB) >= metricMatchingVariable.getMetricThreshold().floatValue())
					pattern = pattern + "1";
				else
					pattern = pattern + "0";
			}
		}
		return pattern;
	}

	public Map<String, Integer> getEmptyContengencyTable() {

		Map<String, Integer> contengencyTable = new LinkedHashMap<String, Integer>();
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

			contengencyTable.put(sb.substring(1), 0);

		}

		return contengencyTable;
	}

	public boolean isExactMatching(Map<String, String> valuesI) {

		for (int ii = 0; ii < numVar; ii++) {
			MetricMatchingVariable metricMatchingVariable = metricMatchingVariableVector.get(ii);
			String matchingVariableNameVariableA = valuesI
					.get(metricMatchingVariable.getMatchingVariableNameVariableA());
			String matchingVariableNameVariableB = valuesI
					.get(metricMatchingVariable.getMatchingVariableNameVariableB());

			if (matchingVariableNameVariableA == null || matchingVariableNameVariableB == null
					|| matchingVariableNameVariableA.equals("")) {

				return false;
			}
			// Equality
			else if (metrics[ii] == null) {
				if (!matchingVariableNameVariableA.equals(matchingVariableNameVariableB))
					return false;
			} else {

				if (metrics[ii].getSimilarity(matchingVariableNameVariableA,
						matchingVariableNameVariableB) < metricMatchingVariable.getMetricThreshold().floatValue())

					return false;
			}
		}
		return true;
	}

}
