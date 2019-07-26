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
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import it.istat.is2.catalogue.relais.decision.contingencyTable.BlockPatternFreqVector;

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
import it.istat.is2.catalogue.relais.project.ReconciledSchema;
import lombok.Data;

/**
 * @author framato
 *
 */
@Data
@Service
public class ContingencyService {
	private final int DIMMAX = 100000;
	private String blockingKey;
	private MetricMatchingVariableVector metricMatchingVariableVector;
	private BlockPatternFreqVector bpfv;
	private int numVar;
	private int dim;
	private int[][] combinations;
	private ReconciledSchema rsc;
	private AbstractStringMetric[] metrics;

	public void init() {
		metricMatchingVariableVector = new MetricMatchingVariableVector();
		// MetricMatchingVariable mm1 = new MetricMatchingVariable("VIA", "DSA_VIA",
		// "DSB_VIA", "Jaro", 0.8, 0);
		// MetricMatchingVariable mm2 = new MetricMatchingVariable("DENOMINAZIONE", "
		// DSA_DENOMINAZIONE", "DSB_DENOMINAZIONE", "Jaro", 0.8, 0);
		// MetricMatchingVariable mm3 = new MetricMatchingVariable("CITTA", "DSA_CITTA",
		// "DSB_CITTA", "Jaro", 0.8, 0);

		MetricMatchingVariable mm1 = new MetricMatchingVariable("SURNAME", "DSa_SURNAME", "DSb_SURNAME", "Jaro", 0.8,
				0);
		MetricMatchingVariable mm2 = new MetricMatchingVariable("NAME", "DSa_NAME", "DSb_NAME", "Jaro", 0.8, 0);
		MetricMatchingVariable mm3 = new MetricMatchingVariable("LASTCODE", "DSa_LASTCODE", "DSb_LASTCODE", "Jaro", 0.8,
				0);
		// MetricMatchingVariable mm3=new
		// MetricMatchingVariable("LASTCODE","da_LASTCODE","db_LASTCODE","Equality",1,0);
		metricMatchingVariableVector.add(mm1);
		metricMatchingVariableVector.add(mm2);
		metricMatchingVariableVector.add(mm3);
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

	public void init(String stringJson) throws JSONException {
		metricMatchingVariableVector = new MetricMatchingVariableVector();
		JSONObject jObject = new JSONObject(stringJson);
		JSONArray metricMatchingVariables = jObject.getJSONArray("MetricMatchingVariables");
		for (int i = 0; i < metricMatchingVariables.length(); i++) {
			JSONObject metricMatchingVariable = metricMatchingVariables.getJSONObject(i);
			String matchingVariable = metricMatchingVariable.getString("MatchingVariable");
			String matchingVariableA = metricMatchingVariable.getString("MatchingVariableA");
			String matchingVariableB = metricMatchingVariable.getString("MatchingVariableB");
			String method = metricMatchingVariable.getString("Method");
			double thresould = metricMatchingVariable.getDouble("Thresould");
			int window = metricMatchingVariable.getInt("Window");
			MetricMatchingVariable mm = new MetricMatchingVariable(matchingVariable, matchingVariableA,
					matchingVariableB, method, thresould, window);
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

	/**
	 * @param valuesI
	 * @return
	 */
	public ArrayList<String> getNameMatchingVariables() {
		// TODO Auto-generated method stub
		ArrayList<String> ret = new ArrayList<>();
		metricMatchingVariableVector.forEach(item -> {
			ret.add(item.getMatchingVariable());
		});
		return ret;
	}

	/**
	 * @param valuesI
	 * @return
	 */
	public String getPattern(Map<String, String> valuesI) {
		// TODO Auto-generated method stub
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
						matchingVariableNameVariableB) >= metricMatchingVariable.getMetricThreshold())
					pattern = pattern + "1";
				else
					pattern = pattern + "0";
			}
		}
		return pattern;
	}

	/**
	 * @param valuesI
	 * @return
	 */
	public Map<String, Integer> getEmptyContengencyTable() {
		// TODO Auto-generated method stub
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

}
