package it.istat.is2.catalogue.arc.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
public class WsSender extends Constants {
		

    @Value("${arc.webservice.uri}")
    private String arcWsUri;
	
	private Long id;
	
	private String namespace;

	private String sandbox;
    
	
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
		rules.content.put("id_norme", new Record("text", duplicateValueJsonSize(j,this.namespace)));
		rules.content.put("periodicite", new Record("text", duplicateValueJsonSize(j,"A")));
		rules.content.put("validite_inf", new Record("date", duplicateValueJsonSize(j,"2021-01-01")));
		rules.content.put("validite_sup", new Record("date", duplicateValueJsonSize(j,"2100-01-01")));
		rules.content.put("version", new Record("text",  duplicateValueJsonSize(j,this.namespace)));
		rules.content.put("type_fichier", new Record("text", extractJson(j,"FileType")));
		rules.content.put("delimiter", new Record("text", new ArrayList<String>( Arrays.asList(CSV_DELIMITER))));		
		rules.content.put("format", new Record("text", extractJson(j,"Format")));		

		sendSetRules(this.id, rules);
	}
	
	public void setRulesForControl(JSONArray j)
	{

		SetRulesPojo rules=new SetRulesPojo();
		
		rules.targetRule="control";

		rules.content= new HashMap<String, Record>();
		rules.content.put("id_norme", new Record("text", duplicateValueJsonSize(j,this.namespace)));
		rules.content.put("periodicite", new Record("text", duplicateValueJsonSize(j,"A")));
		rules.content.put("validite_inf", new Record("date", duplicateValueJsonSize(j,"2021-01-01")));
		rules.content.put("validite_sup", new Record("date", duplicateValueJsonSize(j,"2100-01-01")));
		rules.content.put("version", new Record("text",  duplicateValueJsonSize(j,this.namespace)));
		rules.content.put("id_classe", new Record("text",  extractJson(j,"ControlType")));
		rules.content.put("rubrique_pere", new Record("text",  extractJson(j,"TargetColumnMain")));
		rules.content.put("rubrique_fils", new Record("text",  extractJson(j,"TargetColumnChild")));
		rules.content.put("borne_inf", new Record("text",  extractJson(j,"MinValue")));
		rules.content.put("borne_sup", new Record("text",  extractJson(j,"MaxValue")));
		rules.content.put("condition", new Record("text",  extractJson(j,"SQLCheck")));
		rules.content.put("pre_action", new Record("text",  extractJson(j,"SQLUpdateBeforeCheck")));
		rules.content.put("commentaire", new Record("text",  extractJson(j,"Comments")));
		sendSetRules(this.id, rules);
	}
	
	public void setRulesForFilter(JSONArray j)
	{

		SetRulesPojo rules=new SetRulesPojo();
		
		rules.targetRule="filter";

		rules.content= new HashMap<String, Record>();
		rules.content.put("id_norme", new Record("text", duplicateValueJsonSize(j,this.namespace)));
		rules.content.put("periodicite", new Record("text", duplicateValueJsonSize(j,"A")));
		rules.content.put("validite_inf", new Record("date", duplicateValueJsonSize(j,"2021-01-01")));
		rules.content.put("validite_sup", new Record("date", duplicateValueJsonSize(j,"2100-01-01")));
		rules.content.put("version", new Record("text",  duplicateValueJsonSize(j,this.namespace)));
		rules.content.put("expr_regle_filtre", new Record("text",  extractJson(j,"sqlExpression")));
		rules.content.put("commentaire", new Record("text",  extractJson(j,"Comments")));
		sendSetRules(this.id, rules);
	}
	
	public JSONArray explodeJsonForMapping(JSONArray j)
	{
		JSONArray jNew=new JSONArray();
		
		
		for (int i=0;i<j.length();i++)
		{
			for (String t : j.getJSONObject(i).getString("targetTables").split(","))
			{
				JSONObject jj=new JSONObject();
				jj.put("targetVariableName",j.getJSONObject(i).getString("targetVariableName"));
				jj.put("targetVariableType",j.getJSONObject(i).getString("targetVariableType"));
				jj.put("sqlExpression",j.getJSONObject(i).getString("sqlExpression"));
				jj.put("targetTables",t);
				jNew.put(jj);
			}
		}
		return jNew;
	}
	
	public JSONArray reworkJsonForMapping(JSONArray j)
	{
		for (int i=0;i<j.length();i++)
		{
			if (j.getJSONObject(i).getString("sqlExpression").startsWith("{:pk"))
			{
				j.getJSONObject(i).put("sqlExpression", j.getJSONObject(i).getString("sqlExpression").replace("{pk:","{pk:mapping_"+this.namespace+"_").replace("}","_ok}"));
			}
			j.getJSONObject(i).put("targetTables", "mapping_"+this.namespace+"_"+j.getJSONObject(i).getString("targetTables")+"_ok");
		}
		return j;
	}
	
	public void setRulesForMapping(JSONArray j)
	{
	
		SetRulesPojo rules=new SetRulesPojo();
		
		rules.targetRule="map";

		rules.content= new HashMap<String, Record>();
		rules.content.put("id_norme", new Record("text", duplicateValueJsonSize(j,this.namespace)));
		rules.content.put("periodicite", new Record("text", duplicateValueJsonSize(j,"A")));
		rules.content.put("validite_inf", new Record("date", duplicateValueJsonSize(j,"2021-01-01")));
		rules.content.put("validite_sup", new Record("date", duplicateValueJsonSize(j,"2100-01-01")));
		rules.content.put("version", new Record("text",  duplicateValueJsonSize(j,this.namespace)));
		rules.content.put("variable_sortie", new Record("text", extractJson(j,"targetVariableName")));
		rules.content.put("expr_regle_col", new Record("text", extractJson(j,"sqlExpression")));
		sendSetRules(this.id, rules);
	}

	public void setRulesForModelTables(JSONArray j)
	{

		SetRulesPojo rules=new SetRulesPojo();
		
		rules.targetRule="model_tables";

		rules.content= new HashMap<String, Record>();
		rules.content.put("id_famille", new Record("text", duplicateValueJsonSize(j,this.namespace)));
		rules.content.put("nom_table_metier", new Record("text",  extractJson(j,"targetTables") ));
		sendSetRules(this.id, rules);
	}

	public void setRulesForModelVariables(JSONArray j)
	{

		SetRulesPojo rules=new SetRulesPojo();
		
		rules.targetRule="model_variables";

		rules.content= new HashMap<String, Record>();
		rules.content.put("id_famille", new Record("text", duplicateValueJsonSize(j,this.namespace)));
		rules.content.put("nom_table_metier", new Record("text", extractJson(j,"targetTables")));
		rules.content.put("nom_variable_metier", new Record("text", extractJson(j,"targetVariableName")));
		rules.content.put("type_variable_metier", new Record("text", extractJson(j,"targetVariableType")));

		sendSetRules(this.id, rules);
	}

	
    public static String tableOfIdSource(String tableName, String idSource)
    {
    	String hashText="";
        MessageDigest m;
		try {
			m = MessageDigest.getInstance("SHA1");
			m.update(idSource.getBytes(),0,idSource.length());
			hashText=String.format("%1$032x",new BigInteger(1,m.digest()));
		} catch (NoSuchAlgorithmException e) {
			return null;
		}
        return tableName + "_"+CHILD_TABLE_TOKEN+"_" + hashText;
    }
	
	public List<String> extractJson(JSONArray j,String key)
	{
		return IntStream.range(0,j.length()).mapToObj(i->j.getJSONObject(i).has(key)?j.getJSONObject(i).getString(key):null).collect(Collectors.toList());
	}
	
	public List<String> duplicateValueJsonSize(JSONArray j,String value)
	{
		return IntStream.range(0,j.length()).mapToObj(i->value).collect(Collectors.toList());
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
			csv.append(k.replaceFirst("^"+dataSet+"_", ""));
			System.out.println(k.replaceFirst("^"+dataSet+"_", ""));
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
		return send("execute/service/build/"+this.sandbox+"/",null);
	}
	
	public JSONObject sendEnvSynchronize()
	{
		System.out.println(this.sandbox);
		return send("execute/service/synchonize/"+this.sandbox+"/",null);
	}

	public JSONObject sendExecuteService(ExecuteParameterPojo parameters)
	{
	
		return send("execute/service",parameters);
	}
	
	public JSONObject sendResetService(ExecuteParameterPojo parameters)
	{
	
		return send("reset/service",parameters);
	}
	
	
	
	public JSONObject sendSetRules(Long idelaborazione, SetRulesPojo rules)
	{
		return send("setRules",rules);
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
		this.namespace= NAMESPACE_PREFIX + this.id;
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

	public String getFilename(int datasetId) {
		return getNamespace()+"-ds"+datasetId+".csv";
	}
	
	public String getFilenameInWareHouse(int datasetId) {
		return "DEFAULT_"+getNamespace()+"-ds"+datasetId+".csv";
	}

	public String getHashFilename(String parentTable, int datasetId) {
		return tableOfIdSource(parentTable, getFilenameInWareHouse(datasetId));
	}
	
	public String getHashFilename(TraitementPhase phase, String state, int datasetId) {
		return tableOfIdSource(phase.toString().toLowerCase()+"_"+state, getFilenameInWareHouse(datasetId));
	}
	
	/**
	 * complex query as we are not sure the target table exists
	 * @return
	 */
	public String buildReturnQuery(TraitementPhase phase, String state, int datasetId)
	{
		return buildReturnQuery(getHashFilename(phase, state, datasetId));
	}
	
	public String buildReturnQuery(String tablename)
	{
		return "do $$ begin create temporary table temp_is2 as select * from " + tablename +" ; exception when others then create temporary table temp_is2 as select ; end; $$; select * from temp_is2; drop table temp_is2;";
	}
	
}
