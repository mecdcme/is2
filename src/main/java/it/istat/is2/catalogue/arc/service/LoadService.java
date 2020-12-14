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

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import it.istat.is2.workflow.engine.EngineService;


/**
 * @author framato
 *
 */
@Component
public class LoadService {

    @Value("${arc.webservice.uri}")
    private String arcWsUri;
	
    final int stepService = 250;
    final int sizeFlushed = 20;

    final String params_LP="LP";
    final String params_DATA="DATA";


    public Map<?, ?> arcLoader(Long idelaborazione, Map<String, ArrayList<String>> ruoliVariabileNome,
            Map<String, ArrayList<String>> worksetVariabili, Map<String, String> parametriMap) throws Exception {
    	
    	final Map<String, Map<?, ?>> returnOut = new HashMap<>();
    	
    	System.out.println(arcWsUri);
    	
    	URL url = new URL(arcWsUri+"/hello");
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		String charset = "UTF-8";
		
		conn.setDoOutput(true);
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Accept-Charset", charset);
		conn.setRequestProperty("Content-Type", "application/json; utf-8"); 
		
		if (conn.getResponseCode() != 200) {
			
//			throw new RuntimeException("Failed : HTTP error code : "
//				+ conn.getResponseCode());
			
			return null;

		}

		BufferedReader br = new BufferedReader(new InputStreamReader(
				(conn.getInputStream())));

		String output;

		while ((output = br.readLine()) != null) {
			System.out.println(output);
		}

		conn.disconnect();
    	
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
		returnOut.put(EngineService.ROLES_GROUP_OUT, new HashMap<String,String>());

		returnOut.put(EngineService.WORKSET_OUT, new HashMap<String,String>());

		
		return returnOut;
    }


}
