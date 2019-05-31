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
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.catalogue.relais.dao.RelaisGenericDao;

/**
 * @author framato
 *
 */
@Service
public class RelaisService {

	@Autowired
	private RelaisGenericDao relaisGenericDao;

	@Autowired
	private ContingencyService contingencyService;

	public Map<?, ?> crossTableSQL(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, ArrayList<String>> worksetVariabili) throws Exception {
		Map<String, ArrayList<String>> worksetOut = new LinkedHashMap<String, ArrayList<String>>();

		// <codRuolo,[namevar1,namevar2..]

		String codeMatchingA = "X1";
		String codeMatchingB = "X2";
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

		// init worksetOut
		variabileNomeListOut.forEach(name -> {
			worksetOut.put(name, new ArrayList<>());
		});

		contingencyService.init();
		// contingencyService.getMetricMatchingVariableVector().forEach(metricsm-> {
		// worksetOut.put(metricsm.getMatchingVariable(), new ArrayList<>());
		// });

		worksetOut.put("PATTERN", new ArrayList<>());

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

				// write to worksetout
				valuesI.forEach((key, value) -> {
					worksetOut.get(key).add(value);

				});
				
			//	worksetOut.get("PATTERN").add(contingencyService.getPattern(valuesI));
				
			}

		} 

		return worksetOut;
	}

	public Map<?, ?> crossTable(Long idelaborazione, Map ruoliVariabileNome,Map<String, ArrayList<String>> worksetVariabili) throws Exception {
		return relaisGenericDao.crossTable(idelaborazione,	(LinkedHashMap<String, ArrayList<String>>) ruoliVariabileNome);
	}

}
