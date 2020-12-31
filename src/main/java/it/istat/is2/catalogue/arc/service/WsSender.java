package it.istat.is2.catalogue.arc.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.apache.commons.text.StringEscapeUtils;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import it.istat.is2.catalogue.arc.service.pojo.ExecuteParameterPojo;
import it.istat.is2.catalogue.arc.service.pojo.Record;
import it.istat.is2.catalogue.arc.service.pojo.SetRulesPojo;

@Component
public class WsSender {

	
	public static final String prefixNamespace="is2@";
		

    @Value("${arc.webservice.uri}")
    private String arcWsUri;
	
	private Long id;
	
	private String namespace;

	private String sandbox;

    /** Comma character. */
    private static final String CSV_DELIMITER = ",";
	
	public WsSender()
	{
		super();
	}
	
	public void setRulesForModel()
	{

		SetRulesPojo rules=new SetRulesPojo();
		
		rules.targetRule="model";

		rules.content= new HashMap<String, Record>();
		rules.content.put("id_famille", new Record("text",  new ArrayList<String>( Arrays.asList(this.namespace))));
		
		sendSetRules(this.id, rules);
	}
	
	public void setRulesForNorm ()
	{

		
		SetRulesPojo rules=new SetRulesPojo();

		rules.targetRule="norm";

		rules.content= new HashMap<String, Record>();
		rules.content.put("id_norme", new Record("text",  new ArrayList<String>( Arrays.asList(this.namespace))));
		rules.content.put("periodicite", new Record("text",  new ArrayList<String>( Arrays.asList("A"))));
		rules.content.put("def_norme", new Record("text",  new ArrayList<String>( Arrays.asList("SELECT 1 FROM alias_table WHERE id_source LIKE 'DEFAULT_"+namespace+"%'"))));
		rules.content.put("def_validite", new Record("text",  new ArrayList<String>( Arrays.asList("SELECT '2021-01-01'"))));
		rules.content.put("etat", new Record("text",  new ArrayList<String>( Arrays.asList("1"))));
		rules.content.put("id_famille", new Record("text",  new ArrayList<String>( Arrays.asList(this.namespace))));
		
		sendSetRules(this.id, rules);
	}
	
	public void setRulesForCalendar()
	{

		SetRulesPojo rules=new SetRulesPojo();

		rules.targetRule="calendar";

		rules.content= new HashMap<String, Record>();
		rules.content.put("id_norme", new Record("text",  new ArrayList<String>( Arrays.asList(this.namespace))));
		rules.content.put("periodicite", new Record("text",  new ArrayList<String>( Arrays.asList("A"))));
		rules.content.put("validite_inf", new Record("date",  new ArrayList<String>( Arrays.asList("2021-01-01"))));
		rules.content.put("validite_sup", new Record("date",  new ArrayList<String>( Arrays.asList("2100-01-01"))));
		rules.content.put("etat", new Record("text",  new ArrayList<String>( Arrays.asList("1"))));		
		sendSetRules(this.id, rules);
	}

	public void setRulesForSandbox()
	{

		SetRulesPojo rules=new SetRulesPojo();

		rules.targetRule="sandbox";

		rules.content= new HashMap<String, Record>();
		rules.content.put("id", new Record("text",  new ArrayList<String>( Arrays.asList(this.sandbox))));
		rules.content.put("val", new Record("text",  new ArrayList<String>( Arrays.asList(this.sandbox))));
		rules.content.put("isenv", new Record("boolean",  new ArrayList<String>( Arrays.asList("true"))));
		rules.content.put("mise_a_jour_immediate", new Record("boolean",  new ArrayList<String>( Arrays.asList("true"))));	
		sendSetRules(this.id, rules);
	}
	
	
	public void setRulesForRuleset()
	{

		SetRulesPojo rules=new SetRulesPojo();

		rules.targetRule="ruleset";

		rules.content= new HashMap<String, Record>();
		rules.content.put("id_norme", new Record("text",  new ArrayList<String>( Arrays.asList(this.namespace))));
		rules.content.put("periodicite", new Record("text",  new ArrayList<String>( Arrays.asList("A"))));
		rules.content.put("validite_inf", new Record("date",  new ArrayList<String>( Arrays.asList("2021-01-01"))));
		rules.content.put("validite_sup", new Record("date",  new ArrayList<String>( Arrays.asList("2100-01-01"))));
		rules.content.put("version", new Record("text",  new ArrayList<String>( Arrays.asList(this.namespace))));
		rules.content.put("etat", new Record("text",  new ArrayList<String>( Arrays.asList(this.sandbox))));		
		sendSetRules(this.id, rules);
	}
	
	
	public void setRulesForLoad(JSONArray j)
	{

		SetRulesPojo rules=new SetRulesPojo();
		
		rules.targetRule="load";

		rules.content= new HashMap<String, Record>();
		rules.content.put("id_norme", new Record("text",  new ArrayList<String>( Arrays.asList(this.namespace))));
		rules.content.put("periodicite", new Record("text",  new ArrayList<String>( Arrays.asList("A"))));
		rules.content.put("validite_inf", new Record("date",  new ArrayList<String>( Arrays.asList("2021-01-01"))));
		rules.content.put("validite_sup", new Record("date",  new ArrayList<String>( Arrays.asList("2100-01-01"))));
		rules.content.put("version", new Record("text",  new ArrayList<String>( Arrays.asList(this.namespace))));
		rules.content.put("type_fichier", new Record("text", extractJson(j,"FileType")));
		rules.content.put("delimiter", new Record("text", new ArrayList<String>( Arrays.asList(CSV_DELIMITER))));		
		rules.content.put("format", new Record("text", extractJson(j,"Format")));		

		sendSetRules(this.id, rules);
	}
	
	public List<String> extractJson(JSONArray j,String key)
	{
		return IntStream.range(0,j.length()).mapToObj(i->j.getJSONObject(i).has(key)?j.getJSONObject(i).getString(key):null).collect(Collectors.toList());
	}

	public String datasetToCsv(Map<String, Map<String, List<String>>> j, String dataSet)
	{
		
		StringBuilder csv=new StringBuilder();

		ArrayList<String> keys=new ArrayList<String>(j.get(dataSet).keySet());

		// headers
		boolean first=true;
		for (String k : keys)
		{
			if (first)
			{
				first=false;
			}
			else
			{
				csv.append(CSV_DELIMITER);
			}
			csv.append(k);
		}
		
		// body
		for (int i=0;i<j.get(dataSet).get(keys.get(0)).size();i++)
		{
			csv.append(System.lineSeparator());

			first=true;
			for (String k : keys)
			{
				if (first)
				{
					first=false;
				}
				else
				{
					csv.append(CSV_DELIMITER);
				}
				csv.append(StringEscapeUtils
					    .escapeCsv(j.get(dataSet).get(k).get(i)));
			}
		}
		
		return csv.toString();
	}
	
	
	public JSONObject send(String serviceUri, Object objectBody)
	{
		try {
			URL url = new URL(arcWsUri+serviceUri);
			
			System.out.println(arcWsUri+serviceUri);
			
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			String charset = "UTF-8";
			
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Accept-Charset", charset);
			conn.setRequestProperty("Content-Type", "application/json; utf-8"); 
			
			if (objectBody!=null)
			{
				JSONObject body=new JSONObject(objectBody);
				
				Logger.getRootLogger().info(body);
	
				 
				try (OutputStream os = conn.getOutputStream())
				{
				os.write(body.toString().getBytes(charset));
				}
			}
			
			if (conn.getResponseCode() != 200) {
				throw new RuntimeException("Failed : HTTP error code : "
					+ conn.getResponseCode());
			}
		
			BufferedReader br = new BufferedReader(new InputStreamReader(
					(conn.getInputStream())));
		
			String output= br.lines().collect(Collectors.joining());
		
			conn.disconnect();
		
			return new JSONObject(output);
		}
		catch(IOException e)
		{
			 Logger.getRootLogger().error(e.getMessage());
			return null;
		}
		
		
	}
	
	public JSONObject sendEnvBuilder()
	{
		return send("execute/service/build/"+this.sandbox,null);
  }
	
	
	public JSONObject sendExecuteService(Long idelaborazione, ExecuteParameterPojo parameters)
	{
	
		return send("execute/service",parameters);
	}
	
	public JSONObject sendResetService(Long idelaborazione, ExecuteParameterPojo parameters)
	{
	
		return send("reset/service",parameters);
	}
	
	
	
	public JSONObject sendSetRules(Long idelaborazione, SetRulesPojo rules)
	{
		return send("setRules/arc_bas"+idelaborazione,rules);
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
		this.namespace= prefixNamespace + this.id;
		this.sandbox= "arc.bas" + (1000 + this.id);
	}

	public String getNamespace() {
		return namespace;
	}

	public void setNamespace(String namespace) {
		this.namespace = namespace;
	}

	public String getSandbox() {
		return sandbox;
	}

	public void setSandbox(String sandbox) {
		this.sandbox = sandbox;
	}
	
	
	
	
}
