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
package it.istat.is2.catalogue.arc.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;

import it.istat.is2.catalogue.arc.service.pojo.ExecuteParameterPojo;
import it.istat.is2.catalogue.arc.service.pojo.ExecuteQueryPojo;
import it.istat.is2.catalogue.arc.service.view.ReturnView;
import it.istat.is2.workflow.engine.EngineService;

/**
 * @author framato
 *
 */
@Component
public class MapService extends Constants {

	final int stepService = 250;
	final int sizeFlushed = 20;

	final String params_LP = "LP";
	final String params_DATA = "DATA";

	@Autowired
	private WsSender send;

	public Map<?, ?> arcMapping (Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
			Map<String, Map<String, List<String>>> worksetVariabili, Map<String, String> parametriMap)
			throws Exception {

		final Map<String, Map<?, ?>> returnOut = new HashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new HashMap<>();

		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();

		System.out.println("ARC MAPPING");

		System.out.println(idelaborazione);

		System.out.println(ruoliVariabileNome);
		System.out.println(worksetVariabili);

		System.out.println(parametriMap);
		System.out.println(parametriMap.get("MAPPING_PARAMETERS"));

		System.out.println("********");


		send.setId(idelaborazione);

		// database build
		send.sendEnvSynchronize();

		// send the load rules to arc
		send.setRulesForLoad(new JSONArray(parametriMap.get("MAPPING_PARAMETERS")));

		send.sendExecuteService(new ExecuteParameterPojo(send.getSandbox(), TraitementPhase.NORMAGE));

		List<ExecuteQueryPojo> ep = new ArrayList<ExecuteQueryPojo>();
		for (String dataset : ruoliVariabileNome.keySet()) {
			
			System.out.println(dataset);
			if (dataset.startsWith(DATASET_IDENTIFIER)) {

				int datasetId;
				datasetId = Integer.parseInt(dataset.replace(DATASET_IDENTIFIER, ""));

				ep.add(new ExecuteQueryPojo(datasetId + "", "q" + datasetId,
						"select * from " + send.getHashFilename(TraitementPhase.FILTRAGE, "OK", datasetId), null));
			}
		}

		JSONObject j;
		j = send.sendExecuteService(new ExecuteParameterPojo(send.getSandbox(), TraitementPhase.FILTRAGE, ep));
		
		for (String dataset : ruoliVariabileNome.keySet()) {
			if (dataset.startsWith(DATASET_IDENTIFIER)) {

				int datasetId;
				datasetId = Integer.parseInt(dataset.replace(DATASET_IDENTIFIER, ""));

				ReturnView r = new ObjectMapper().readValue(j.toString(), ReturnView.class);

				Map<String, ArrayList<String>> tableOut = new LinkedHashMap<>();

				r.getDataSetView().get(datasetId-1).getContent().keySet().forEach(
						k -> tableOut.put(k, (ArrayList<String>) r.getDataSetView().get(datasetId-1).getContent().get(k).data));

				rolesOut.put(FILTER_OUTPUT_CODE + datasetId, new ArrayList<String>(tableOut.keySet()));
				returnOut.put(EngineService.ROLES_OUT, rolesOut);

				rolesOut.keySet().forEach(code -> {
					rolesGroupOut.put(code, code);
				});
				returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

				worksetOut.put(FILTER_OUTPUT_CODE + datasetId, tableOut);

				returnOut.put(EngineService.WORKSET_OUT, worksetOut);
			}
		}

		return returnOut;
	}

}
