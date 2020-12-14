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
import java.util.Map;
import org.springframework.stereotype.Component;
import it.istat.is2.workflow.engine.EngineService;

/**
 * @author framato
 *
 */
@Component
public class MapService {

    final int stepService = 250;
    final int sizeFlushed = 20;

    final String params_MP = "MP";
    final String params_DATA = "LOV";

    public Map<?, ?> arcMapping(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome, Map<String, ArrayList<String>> worksetVariabili,
            Map<String, String> parametriMap) throws Exception {

        Map<String, Map<?, ?>> returnOut = new HashMap<>();
        Map<String, Map<?, ?>> worksetOut = new HashMap<>();
        Map<String, ArrayList<String>> contengencyTableOut = new LinkedHashMap<>();
        Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
        Map<String, String> rolesGroupOut = new HashMap<>();

        System.out.println(idelaborazione);

        System.out.println(ruoliVariabileNome);

        System.out.println(worksetVariabili);

        System.out.println(parametriMap);
        // write to worksetout
        System.out.println("worksetVariabili");
        worksetVariabili.forEach((key, value) -> {
            System.out.println(key);
            System.out.println(value);

        });
        System.out.println(worksetVariabili.get(params_DATA));

        System.out.println(parametriMap.get(params_MP));

        contengencyTableOut.put("COL2", new ArrayList<String>(Arrays.asList("d", "e", "f")));

        rolesOut.put("MOV", new ArrayList<String>(contengencyTableOut.keySet()));
        returnOut.put(EngineService.ROLES_OUT, rolesOut);

        rolesOut.keySet().forEach(code -> {
            rolesGroupOut.put(code, "MOV");
        });

        returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

        worksetOut.put("MOV", contengencyTableOut);
        returnOut.put(EngineService.WORKSET_OUT, worksetOut);

        return returnOut;
    }

}
