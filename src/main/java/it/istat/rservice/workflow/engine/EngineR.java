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
 * @author Paolo Francescangeli  <pafrance @ istat.it>
 * @author Renzo Iannacone <iannacone @ istat.it>
 * @author Stefano Macone <macone @ istat.it>
 * @version 1.0
 */
package it.istat.rservice.workflow.engine;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.REngineException;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import it.istat.rservice.app.domain.Elaborazione;
import it.istat.rservice.app.util.IS2Const;
import it.istat.rservice.app.util.Utility;
import it.istat.rservice.workflow.dao.RuoloDao;
import it.istat.rservice.workflow.dao.StepVariableDao;
import it.istat.rservice.workflow.domain.SXTipoCampo;
import it.istat.rservice.workflow.domain.SxRuoli;
import it.istat.rservice.workflow.domain.SxStepInstance;
import it.istat.rservice.workflow.domain.SxStepPattern;
import it.istat.rservice.workflow.domain.SxStepVariable;
import it.istat.rservice.workflow.domain.SxTipoVar;
import it.istat.rservice.workflow.domain.SxWorkset;

/**
 * @author framato
 *
 */
@Service
public class EngineR implements EngineService {

	public static final String SELEMIX_RESULTSET = "sel_out";
	public static final String SELEMIX_WORKSET = "workset";
	public static final String SELEMIX_RUOLI_VAR = "role_var";
	public static final String SELEMIX_RUOLI_VAR_OUTPUT = "role_var_out";
	public static final String SELEMIX_RUOLI_INPUT = "role_in";
	public static final String SELEMIX_RUOLI_OUTPUT = "ruol_out";
	public static final String SELEMIX_PARAMETRI = "params";
	public static final String SELEMIX_MODELLO = "model";
	public static final String SELEMIX_RUOLO_SKIP_N = "N";
	public static final String SELEMIX_RESULT_RUOLI = "roles";
	public static final String SELEMIX_RESULT_OUTPUT = "out";
	public static final String SELEMIX_RESULT_PARAM = "mod";
	public static final String SELEMIX_RESULT_REPORT = "report"; // aggiunto componente dei parametri di uscita

	@Autowired
	RuoloDao ruoloDao;
	@Autowired
	StepVariableDao stepVariableDao;

	@Value("${serverR.host}")
	private String serverRHost;
	@Value("${serverR.port}")
	private Integer serverRPort;

	@Value("${path.R}")
	private String pathR;
	@Value("${file.script.R}")
	private String fileScriptR;

	private RConnection connection;

	private String istruzione;
	
	private Elaborazione elaborazione;
	private SxStepInstance stepInstance;
	private Map<String, SxStepVariable> dataMap;
	private Map<String, SxRuoli> ruoliAllMap ;
	private HashMap<String, ArrayList<String>> worksetVariabili;
	private HashMap<String, ArrayList<String>> parametriMap;
	private HashMap<String, ArrayList<String>> modelloMap;
	private HashMap<String, ArrayList<String>> worksetOut;
	private HashMap<String, ArrayList<String>> ruoliVariabileNome;
	
	private HashMap<String, ArrayList<String>> ruoliOutputStep; 
	private HashMap<String, ArrayList<String>> parametriOutput = new HashMap<>();

	public EngineR(String serverRHost, int serverRPort, String pathR, String fileScriptR) {
		super();
		this.serverRHost = serverRHost;
		this.serverRPort = serverRPort;
		this.pathR = pathR;
		this.fileScriptR = fileScriptR;
		connection = null;
		istruzione = "";
	}

	public EngineR() {
		super();
		connection = null;
		istruzione = "";
	}

	@Override
	public void init(Elaborazione elaborazione, SxStepInstance stepInstance) throws Exception {
		// Create a connection to Rserve instance running on default port 6311
		this.elaborazione=elaborazione;
		this.stepInstance=stepInstance;
		prepareEnv();
		createConnection(serverRHost, serverRPort);
		bindInputColumns(worksetVariabili, EngineR.SELEMIX_WORKSET);
		bindInputParams(parametriMap);
		bindInputParams(modelloMap);
		setRuoli(ruoliVariabileNome);

	}

	private void createConnection(String server, int port) throws RserveException {
		// Create a connection to Rserve instance running on default port 6311
		if (port == 0) {
			port = 6311;
		}

		if (server == null) {
			connection = new RConnection();
		} else {
			connection = new RConnection(server, port);
		}
		connection.eval("setwd('" + pathR + "')");
		connection.eval("source('" + fileScriptR + "')");
		Logger.getRootLogger().debug("Script Loaded");
	}

	public void closeConnection() {
		if (connection != null) {
			connection.close();
		}
	}

	
	public void bindInputColumns(HashMap<String, ArrayList<String>> workset, String varR) throws REngineException {

		List<String> keys = new ArrayList<String>(workset.keySet());
		String listaCampi = "";

		int size = keys.size();
		String chiave0 = keys.get(0);
		listaCampi += "'" + chiave0 + "',";
		String key = "";
		// arrX = workset.get(chiave0).toArray(arrX);
		String[] arrX = workset.get(chiave0).toArray(new String[workset.get(chiave0).size()]);

		connection.assign(varR, arrX);

		for (int i = 1; i < size; i++) {
			key = keys.get(i);
			arrX = workset.get(key).toArray(new String[workset.get(key).size()]);
			listaCampi += "'" + key + "',";
			connection.assign("tmp", arrX);
			String evalstringa = varR + " <- cbind(" + varR + ",tmp)";
			System.out.println(evalstringa);
			connection.eval(evalstringa);
		}

		listaCampi = listaCampi.substring(0, listaCampi.length() - 1);
		// assegnazione nome dei campi alle colonne
		String exec = ((size > 1) ? "col" : "") + "names(" + varR + ") = c(" + listaCampi + ")";
		// String exec = "colnames(" + varR + ") = c(" + listaCampi + ")";
		Logger.getRootLogger().debug("Bind input columns names " + exec);
		if ((size == 1)) {
			connection.eval(varR + " <- data.frame(" + varR + ")");
		}
		connection.eval(exec);
	}

	@Override
	public void doAction()
			throws RserveException {
		
		
		String fname=stepInstance.getFname();
		// mlest <- ml.est (workset, y=Y,";
		// Aggiunto il workset nella lista degli argomenti della funzione (by paolinux)
		istruzione = SELEMIX_RESULTSET + "  <- " + fname + "( " + SELEMIX_WORKSET + ",";

		for (Map.Entry<String, ArrayList<String>> entry : ruoliVariabileNome.entrySet()) {
			String codiceRuolo = entry.getKey();
			// X <- as.numeric(workset[,c('X1','X2') ];
			istruzione += codiceRuolo.toLowerCase() + "=" + codiceRuolo.toUpperCase() + ",";
		}

		istruzione = istruzione.substring(0, istruzione.length() - 1);
		istruzione += ")";
		Logger.getRootLogger().debug("Eseguo " + istruzione);
		System.out.println("Eseguo " + istruzione);
		connection.eval(istruzione);
	}

	// Assegna il ruolo selemix alle variabili del workset
	
	public void setRuoli(HashMap<String, ArrayList<String>> ruoliVariabileNome) throws RserveException {
		// {X=[X1], Y=[Y1]}
		Logger.getRootLogger().debug("Eseguo SetRuoli>");
		for (Map.Entry<String, ArrayList<String>> entry : ruoliVariabileNome.entrySet()) {
			String codiceRuolo = entry.getKey();
			ArrayList<String> nomeVariabiliList = entry.getValue();
			// X <- as.numeric(workset[,c('X1','X2') ];
			// String comando = codiceRuolo+ " <- as.numeric("+selemixRuoliVar+"[,"
			// +Utility.combineList2String4R(nomeVariabiliList) + "])";
			// X <- c('X1','X2');
			String comando = codiceRuolo + " <- " + Utility.combineList2String4R(nomeVariabiliList);
			connection.eval(comando);
		}
	}

	
	public void bindOutputColumns(HashMap<String, ArrayList<String>> workset, String varR)
			throws RserveException, REXPMismatchException {
		// scrittura matrice di output
		RList lista = connection.eval(varR + "$out").asList();
		// RList lista = connection.eval(varR).asList();
		Logger.getRootLogger().debug("Campi OUT " + workset.keySet().toString());
		Logger.getRootLogger().debug("Numero di campi del workset " + lista.size());
		String name = "";
		for (int i = 0; i < lista.size(); i++) {
			String ts[] = lista.at(i).asStrings();
			name = lista.names.get(i).toString();
			workset.put(name, new ArrayList<String>(Arrays.asList(ts)));
		}
	}

	
	public void getRuoli(HashMap<String, ArrayList<String>> ruoliOutputStep, String varR)
			throws RserveException, REXPMismatchException {
		RList lista = connection.eval(varR + "$roles").asList();
		String name = "";
		for (int i = 0; i < lista.size(); i++) {
			String ts[] = lista.at(i).asStrings();
			name = lista.names.get(i).toString();
			ruoliOutputStep.put(name, new ArrayList<String>(Arrays.asList(ts)));
		}
		Logger.getRootLogger().debug("Campi dei ruoli IMPOSTATI (speriamo)");
	}

	
	public void getGenericoOutput(HashMap<String, ArrayList<String>> genericHashMap, String varR, String tipoOutput)
			throws RserveException, REXPMismatchException {
		Logger.getRootLogger().debug("Eseguo Get " + tipoOutput);
		try {
			RList lista = connection.eval(varR + "$" + tipoOutput).asList();
			if (lista != null) {
				genericHashMap.clear();
				getGenericoOutput(genericHashMap, lista);
				Logger.getRootLogger()
						.debug("Impostati campi di " + tipoOutput + "= " + genericHashMap.values().toString());
			}
		} catch (Exception e) {
			Logger.getRootLogger().info("No such list:" + tipoOutput);
			Logger.getRootLogger().debug(connection.eval("print(str(" + varR + "$" + tipoOutput + "))").toString());
			return;
		}
	}

	public void getGenericoOutput(HashMap<String, ArrayList<String>> genericHashMap, RList lista)
			throws RserveException, REXPMismatchException {
		String name = "";
		if (lista != null) {
			Logger.getRootLogger().info("Campi:> " + lista.names.toString() + " Size(" + lista.size() + ")");
			for (int i = 0; i < lista.size(); i++) {
				if (lista.at(i).isList()) {
					getGenericoOutput(genericHashMap, lista.at(i).asList());
				} else {
					String ts[] = lista.at(i).asStrings();
					name = lista.names.get(i).toString();
					genericHashMap.put(name, new ArrayList<String>(Arrays.asList(ts)));
					Logger.getRootLogger().info(name + " (" + ts.length + "/" + genericHashMap.get(name).size() + "): "
							+ genericHashMap.get(name).toString());
				}
			}
		}
	}

	
	public void bindInputParams(HashMap<String, ArrayList<String>> parametriMap) throws RserveException {
		for (Map.Entry<String, ArrayList<String>> entry : parametriMap.entrySet()) {
			String nomep = entry.getKey();
			ArrayList<String> valore = entry.getValue();
			// X <- c('X1','X2');
			String comando = nomep + " <- " + Utility.combineList2String4R(valore);
			Logger.getRootLogger().info("Comando: " + comando);
			connection.eval(comando);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see it.istat.rservice.workflow.engine.EngineService#prepareEnv()
	 */
	 
	public void prepareEnv() {
		// TODO Auto-generated method stub
		// SxBusinessStep sxBusinessStep = sxBusinessStepDao.findOne(idStep);

		// SxStepInstance stepInstance =sxStepInstanceDao.findOne(idStepInstance);
		List<SxStepVariable> dataList = stepVariableDao.findByElaborazione(elaborazione);
		// mappa delle colonne workset <nome campo, oggetto stepv>
		  dataMap = Utility.getMapNameWorkSetStep(dataList);
		// mappa delle colonne workset <nome campo, oggetto stepv>
		Map<String, ArrayList<SxStepVariable>> dataRuoliStepVarMap = Utility.getMapCodiceRuoloStepVariabili(dataList);
//		List<SxRuoli> ruoliAll = ruoloDao.findAll();
		// Utility.getMapRuoliByCod(ruoliAll)
		ruoliAllMap =ruoloDao.findByServiceAsCodMap(stepInstance.getSxAppService());
		// mappa delle colonne workset <nome,lista valori>
		worksetVariabili = Utility.getMapWorkSetValues(dataMap, new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
		// PARAMETRI
		parametriMap = Utility.getMapWorkSetValues(dataMap, new SxTipoVar(IS2Const.WORKSET_TIPO_PARAMETRO));
		modelloMap = Utility.getMapWorkSetValues(dataMap, new SxTipoVar(IS2Const.WORKSET_TIPO_MODELLO));
		worksetOut = new HashMap<>();

		// REcupero dei ruoli di INPUT e OUTUPT e dalle istanze

		// {S=[S], X=[X], Y=[Y], Z=[Z]}
		HashMap<String, ArrayList<String>> ruoliInputStep = new HashMap<>();
		// {P=[P], M=[M], O=[O]}
		ruoliOutputStep = new HashMap<>();

		for (Iterator<?> iterator = stepInstance.getSxStepPatterns().iterator(); iterator.hasNext();) {
			SxStepPattern sxStepPattern = (SxStepPattern) iterator.next();
			if (sxStepPattern.getTipoIO().getId().intValue() == IS2Const.VARIABILE_TIPO_INPUT) {
				ArrayList<String> listv = ruoliInputStep.get(sxStepPattern.getSxRuoli().getCod());
				if (listv == null) {
					listv = new ArrayList<>();
				}
				listv.add(sxStepPattern.getSxRuoli().getCod());
				ruoliInputStep.put(sxStepPattern.getSxRuoli().getCod(), listv);
			} else if (sxStepPattern.getTipoIO().getId().intValue() == IS2Const.VARIABILE_TIPO_OUTPUT) {
				ArrayList<String> listv = ruoliOutputStep.get(sxStepPattern.getSxRuoli().getCod());
				if (listv == null) {
					listv = new ArrayList<>();
				}
				listv.add(sxStepPattern.getSxRuoli().getCod());
				ruoliOutputStep.put(sxStepPattern.getSxRuoli().getCod(), listv);
			}
		}
		// associo il codice ruolo alla variabile
		// codiceRuolo, lista nome variabili {X=[X1], Y=[Y1]}
		ruoliVariabileNome = new HashMap<>();
		parametriOutput = new HashMap<>();

		for (Map.Entry<String, ArrayList<SxStepVariable>> entry : dataRuoliStepVarMap.entrySet()) {
			String codR = entry.getKey();
			ArrayList<SxStepVariable> listSVariable = entry.getValue();
			for (Iterator<SxStepVariable> iterator = listSVariable.iterator(); iterator.hasNext();) {
				SxStepVariable sxStepVariable = (SxStepVariable) iterator.next();
				ArrayList<String> listv = ruoliVariabileNome.get(codR);
				if (listv == null) {
					listv = new ArrayList<>();
				}
				listv.add(sxStepVariable.getSxWorkset().getNome());
				ruoliVariabileNome.put(codR, listv);
			}
		}

	}

	/* (non-Javadoc)
	 * @see it.istat.rservice.workflow.engine.EngineService#processOutput()
	 */
	@Override
	public void processOutput() throws Exception {
		// TODO Auto-generated method stub
		
		  getGenericoOutput(worksetOut, EngineR.SELEMIX_RESULTSET, EngineR.SELEMIX_RESULT_OUTPUT);
          getGenericoOutput(ruoliOutputStep, EngineR.SELEMIX_RESULTSET, EngineR.SELEMIX_RESULT_RUOLI);
          getGenericoOutput(parametriOutput, EngineR.SELEMIX_RESULTSET, EngineR.SELEMIX_RESULT_PARAM);
          getGenericoOutput(parametriOutput, EngineR.SELEMIX_RESULTSET, EngineR.SELEMIX_RESULT_REPORT);
          
         saveOutputDB();
          
		
	}

	/**
	 * 
	 */
	private void saveOutputDB() {
		// TODO Auto-generated method stub
		
		   HashMap<String, String> ruoliOutputStepInversa = new HashMap<>();
	        for (Map.Entry<String, ArrayList<String>> entry : ruoliOutputStep.entrySet()) {
	            String nomeR = entry.getKey();
	            ArrayList<String> value = entry.getValue();
	            value.forEach((nomevar) -> ruoliOutputStepInversa.put(nomevar, nomeR));
	        }

	        // salva output su DB
	        for (Map.Entry<String, ArrayList<String>> entry : worksetOut.entrySet()) {
	            String nomeW = entry.getKey();
	            ArrayList<String> value = entry.getValue();
	            SxStepVariable sxStepVariable;

	            if (dataMap.keySet().contains(nomeW)) {
	                sxStepVariable = dataMap.get(nomeW);
	                sxStepVariable.getSxWorkset().setValori(value);
	                sxStepVariable.setTipoCampo(new SXTipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));
	            } else {
	                sxStepVariable = new SxStepVariable();
	                sxStepVariable.setElaborazione(elaborazione);
	                sxStepVariable.setTipoCampo(new SXTipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));

	                String ruolo = ruoliOutputStepInversa.get(nomeW);
	                if (ruolo == null) {
	                    ruolo = EngineR.SELEMIX_RUOLO_SKIP_N;
	                }
	                SxRuoli sxRuolo = ruoliAllMap.get(ruolo);
	                sxStepVariable.setSxRuoli(sxRuolo);
	                sxStepVariable.setOrdine(sxRuolo.getOrdine());
	                SxWorkset sxWorkset = new SxWorkset();
	                sxWorkset.setNome(nomeW.replaceAll("\\.", "_"));
	                sxWorkset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
	                ArrayList<SxStepVariable> l = new ArrayList<>();
	                l.add(sxStepVariable);
	                sxWorkset.setSxStepVariables(l);
	                sxWorkset.setValori(value);
	                sxWorkset.setValoriSize(sxWorkset.getValori().size());
	                sxStepVariable.setSxWorkset(sxWorkset);
	            }

	            stepVariableDao.save(sxStepVariable);
	        }

	        for (Map.Entry<String, ArrayList<String>> entry : parametriOutput.entrySet()) {
	            String nomeW = entry.getKey();
	            ArrayList<String> value = entry.getValue();
	            SxStepVariable sxStepVariable;

	            if (dataMap.keySet().contains(nomeW)) {
	                sxStepVariable = dataMap.get(nomeW);
	                sxStepVariable.getSxWorkset().setValori(value);
	                sxStepVariable.setTipoCampo(new SXTipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));

	            } else {
	                sxStepVariable = new SxStepVariable();
	                sxStepVariable.setElaborazione(elaborazione);
	                sxStepVariable.setTipoCampo(new SXTipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));
	                String ruolo = ruoliOutputStepInversa.get(nomeW);
	                if (ruolo == null) {
	                    ruolo = EngineR.SELEMIX_RUOLO_SKIP_N;
	                }
	                SxRuoli sxRuolo = ruoliAllMap.get(ruolo);
	                sxStepVariable.setSxRuoli(sxRuolo);
	                sxStepVariable.setOrdine(sxRuolo.getOrdine());
	                SxWorkset sxWorkset = new SxWorkset();
	                sxWorkset.setNome(nomeW.replaceAll("\\.", "_"));
	                sxWorkset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_PARAMETRO));
	                ArrayList<SxStepVariable> l = new ArrayList<>();
	                l.add(sxStepVariable);
	                sxWorkset.setSxStepVariables(l);
	                sxWorkset.setValori(value);
	                sxWorkset.setValoriSize(sxWorkset.getValori().size());
	                sxStepVariable.setSxWorkset(sxWorkset);
	            }

	            stepVariableDao.save(sxStepVariable);
	        }
		
	}

	/* (non-Javadoc)
	 * @see it.istat.rservice.workflow.engine.EngineService#destroy()
	 */
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		closeConnection();
		
	}
}
