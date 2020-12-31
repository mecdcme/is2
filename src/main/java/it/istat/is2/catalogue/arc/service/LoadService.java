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
import com.google.gson.JsonObject;

import it.istat.is2.catalogue.arc.service.pojo.ExecuteParameterPojo;
import it.istat.is2.catalogue.arc.service.pojo.ExecuteQueryPojo;
import it.istat.is2.catalogue.arc.service.view.ReturnView;
import it.istat.is2.workflow.engine.EngineService;


/**
 * @author framato
 *
 */
@Component
public class LoadService {

	
    final int stepService = 250;
    final int sizeFlushed = 20;

    final String params_LP="LP";
    final String params_DATA="DATA";
    
    @Autowired
    private WsSender send;


    public Map<?, ?> arcLoader(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
    		Map<String, Map<String, List<String>>> worksetVariabili, Map<String, String> parametriMap) throws Exception {
    	
		final Map<String, Map<?, ?>> returnOut = new HashMap<>();
		final Map<String, Map<?, ?>> worksetOut = new HashMap<>();
		
		

		final Map<String, ArrayList<String>> contingencyTableOut = new LinkedHashMap<>();
		final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
		final Map<String, String> rolesGroupOut = new HashMap<>();
		
		
		
    	System.out.println(idelaborazione);
    	
    	
    	
    	System.out.println(ruoliVariabileNome);
    	System.out.println(worksetVariabili);
    	
    	
    	

    	System.out.println(parametriMap.get("LOADER_PARAMETERS"));
    	
    	System.out.println("********");
    	System.out.println(worksetVariabili.get("DS1").get("DS"));


    	send.setId(idelaborazione);

    	send.setRulesForSandbox();
    	
    	send.setRulesForModel();
    	send.setRulesForNorm();
    	send.setRulesForCalendar();
    	send.setRulesForRuleset();
    	send.setRulesForLoad(new JSONArray(parametriMap.get("LOADER_PARAMETERS")));

    	
    	send.sendEnvBuilder();

    	
    	ExecuteParameterPojo e;
    	
    	e=new ExecuteParameterPojo();
    	e.sandbox=send.getSandbox();
    	e.targetPhase="0";
    	
    	send.sendExecuteService(idelaborazione, e);
    	send.sendResetService(idelaborazione, e);

    	
    	e=new ExecuteParameterPojo();
    	e.sandbox=send.getSandbox();
    	e.targetPhase="1";
    	e.fileName=send.getNamespace()+"-ds1.csv";
    	e.fileContent=send.datasetToCsv(worksetVariabili, "DS1");
    	send.sendExecuteService(idelaborazione, e);

    	
    	e=new ExecuteParameterPojo();
    	e.sandbox=send.getSandbox();
    	e.targetPhase="2";
    	
    	e.queries=new ArrayList<ExecuteQueryPojo>();
    	
    	ExecuteQueryPojo query=new ExecuteQueryPojo("1", "q1", "select * from chargement_ok_child_cfd5d19739b29b0515f05d84ac93bf5ef6c46de3", null);
    	e.queries.add(query);
    	
    	JSONObject j=send.sendExecuteService(idelaborazione, e);

    	ReturnView r= new ObjectMapper().readValue(j.toString(), ReturnView.class);
    	
    	r.getDataSetView().get(0).getContent().keySet().forEach(k->contingencyTableOut.put(k,(ArrayList<String>) r.getDataSetView().get(0).getContent().get(k).data));
    	
//    	contingencyTableOut.put("COL1",
//		new ArrayList<String>(Arrays.asList("a","b","c"))
//		);
    	
    	rolesOut.put("LOK1",new ArrayList<String>(contingencyTableOut.keySet()));
    	returnOut.put(EngineService.ROLES_OUT, rolesOut);
    	
    	rolesOut.keySet().forEach(code -> {
			rolesGroupOut.put(code, code);
		});
		returnOut.put(EngineService.ROLES_GROUP_OUT, rolesGroupOut);

    	worksetOut.put("LOK1", contingencyTableOut);
		returnOut.put(EngineService.WORKSET_OUT, worksetOut);


		
    	
//    	
//    	System.out.println(send.datasetToCsv(worksetVariabili, "DS1"));
//    	
//
//    	  Map<String, Map<?, ?>> returnOut = new HashMap<>();
//          Map<String, Map<?, ?>> worksetOut = new HashMap<>();
//          Map<String, ArrayList<String>> contengencyTableOut = new LinkedHashMap<>();
//          Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();
//          Map<String, String> rolesGroupOut = new HashMap<>();
//          
//        System.out.println("idelaborazione > "+idelaborazione);
//       
//        System.out.println("ruoliVariabileNome > "+ruoliVariabileNome);
//
//        System.out.println("parametriMap > "+parametriMap);
//        
//        System.out.println("worksetVariabili > "+worksetVariabili);
//
//        
//        System.out.println("parametriMap >> ");
//        parametriMap.forEach((key, value) -> {
//        	System.out.println("key : "+key);
//        	System.out.println("value : "+value);
//            
//        });
//        
//        // Preparing webservices call
//        JSONObject json;
//        RequestArcClient reqArc;
//        Request req;
//        
//        // Call 1 : update rules
//        json = new JSONObject("{\"type\":\"jsonwsp/request\", \"environnement\":\"arc_bas2\", \"phase\":\"CHARGEMENT_RULES\", \"service\":\"run\", \"file\":\""+Base64.getEncoder().encodeToString(parametriMap.get("LOADER_PARAMETERS").getBytes())+"\"}");
//        reqArc = new RequestArcClient();
//		reqArc.setJson(json);	
//		req=new Request(reqArc);
//
//		System.out.println("Response > "+req.send().traiterReponseShort());
//
//		
//		// Call 2 : register file
//        // input file
//        String fileXml=worksetVariabili.get("FILE").stream().collect(Collectors.joining("\r\n"));
//  		// encoded string
//        String encodedString = Base64.getEncoder().encodeToString(fileXml.getBytes());
//		
//        json = new JSONObject("{\"type\":\"jsonwsp/request\", \"environnement\":\"arc_bas2\", \"phase\":\"RECEPTION\", \"service\":\"run\", \"file\":\""+encodedString+"\"}");
//		reqArc = new RequestArcClient();
//		reqArc.setJson(json);
//		req=new Request(reqArc);
//
//		System.out.println("Response > "+req.send().traiterReponseShort());
//		
//
//		// Call 3 : load File
//        json = new JSONObject("{\"type\":\"jsonwsp/request\", \"environnement\":\"arc_bas2\", \"phase\":\"CHARGEMENT\", \"service\":\"run\", \"file\":\""+""+"\"}");
//		reqArc = new RequestArcClient();
//		reqArc.setJson(json);
//		req=new Request(reqArc);
//
//		System.out.println("Response > "+req.send().traiterReponseShort());
//		
//		// Call 4 : structurize File
//        json = new JSONObject("{\"type\":\"jsonwsp/request\", \"environnement\":\"arc_bas2\", \"phase\":\"NORMAGE\", \"service\":\"run\", \"file\":\""+""+"\"}");
//		reqArc = new RequestArcClient();
//		reqArc.setJson(json);
//		req=new Request(reqArc);
//
//		System.out.println("Response > "+req.send().traiterReponseShort());
//				
//		
//        contengencyTableOut.put("COL1",
//        		new ArrayList<String>(Arrays.asList("a","b","c"))
//        		);
//        
//        rolesOut.put("LOV",new ArrayList<String>(contengencyTableOut.keySet()));
//        returnOut.put(IS2Const.WF_OUTPUT_ROLES, rolesOut);
//        
//        rolesOut.keySet().forEach(code -> {
//            rolesGroupOut.put(code, "LOV");
//        });
//        
//        returnOut.put(IS2Const.WF_OUTPUT_ROLES_GROUP, rolesGroupOut);
//
//        worksetOut.put("LOV", contengencyTableOut);
//        returnOut.put(IS2Const.WF_OUTPUT_WORKSET, worksetOut);
//                
//		returnOut.put(EngineService.ROLES_GROUP_OUT, new HashMap<String,String>());
//
//		returnOut.put(EngineService.WORKSET_OUT, new HashMap<String,String>());

		
		return returnOut;
    }


}
