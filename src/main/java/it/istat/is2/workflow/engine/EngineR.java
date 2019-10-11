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
package it.istat.is2.workflow.engine;

import static it.istat.is2.app.util.IS2Const.OUTPUT_R;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
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

import it.istat.is2.app.service.LogService;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.app.util.Utility;
import it.istat.is2.workflow.dao.RuoloDao;
import it.istat.is2.workflow.dao.StepVariableDao;
import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.TipoCampo;
import it.istat.is2.workflow.domain.AppRole;
import it.istat.is2.workflow.domain.StepInstance;
import it.istat.is2.workflow.domain.StepInstanceAppRole;
import it.istat.is2.workflow.domain.StepVariable;
import it.istat.is2.workflow.domain.SxTipoVar;
import it.istat.is2.workflow.domain.Workset;

/**
 * @author framato
 *
 */
@Service
public class EngineR implements EngineService {

	public static final String IS2_RULESET = "ruleset";
	public static final String IS2_RESULTSET = "sel_out";
	public static final String IS2_WORKSET = "workset";
	public static final String IS2_RUOLI_VAR = "role_var";
	public static final String IS2_RUOLI_VAR_OUTPUT = "role_var_out";
	public static final String IS2_RUOLI_INPUT = "role_in";
	public static final String IS2_RUOLI_OUTPUT = "ruol_out";
	public static final String IS2_PARAMETRI = "params";
	public static final String IS2_MODELLO = "model";
	public static final String IS2_RUOLO_SKIP_N = "N";
	public static final String IS2_RESULT_RUOLI = "roles";
	public static final String IS2_RESULT_ROLES_GROUPS = "rolesgroup";
	public static final String IS2_RESULT_OUTPUT = "out";
	public static final String IS2_RESULT_PARAM = "mod";
	public static final String IS2_RESULT_REPORT = "report"; // aggiunto componente dei parametri di uscita
	public static final String IS2_R_NA_VALUE = "NA"; //

	@Autowired
	RuoloDao ruoloDao;
	@Autowired
	StepVariableDao stepVariableDao;
	@Autowired
	LogService logService;

	@Value("${serverR.host}")
	private String serverRHost;
	@Value("${serverR.port}")
	private Integer serverRPort;

	@Value("${path.script.R}")
	private String pathR;

	private String fileScriptR;

	private RConnection connection;

	private String istruzione;

	private Elaborazione elaborazione;
	private StepInstance stepInstance;
	private LinkedHashMap<String, ArrayList<StepVariable>> dataMap;
	private Map<String, AppRole> ruoliAllMap;
	private LinkedHashMap<String, ArrayList<String>> worksetVariabili;
	private LinkedHashMap<String, ArrayList<String>> parametriMap;
	private LinkedHashMap<String, ArrayList<String>> modelloMap;
	private LinkedHashMap<String, ArrayList<String>> ruleset;
	private LinkedHashMap<String, ArrayList<String>> worksetOut;
	private HashMap<String, ArrayList<String>> ruoliVariabileNome;

	private LinkedHashMap<String, ArrayList<String>> ruoliOutputStep;
	private LinkedHashMap<String, String> ruoliGruppoOutputStep;
	private LinkedHashMap<String, ArrayList<String>> parametriOutput = new LinkedHashMap<>();

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
	public void init(Elaborazione elaborazione, StepInstance stepInstance) throws Exception {
		// Create a connection to Rserve instance running on default port 6311
		this.elaborazione = elaborazione;
		this.stepInstance = stepInstance;
		this.fileScriptR = stepInstance.getAppService().getScript();
		prepareEnv();
		createConnection(serverRHost, serverRPort);
		bindInputColumns(worksetVariabili, EngineR.IS2_WORKSET);
		// bindInputParams(parametriMap);
		// bindInputParams(modelloMap);
		// bindInputParams(ruleset,eng);
		bindInputColumns(ruleset, EngineR.IS2_RULESET);
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
			connection = new RConnection();
			// connection = new RConnection(server,port);
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

	public void bindInputColumns(LinkedHashMap<String, ArrayList<String>> workset, String varR)
			throws REngineException {

		if (!workset.isEmpty()) {
			List<String> keys = new ArrayList<String>(workset.keySet());
			String listaCampi = "";
			String listaCampiLabel = "";
			int size = keys.size();
			// String chiave0 = keys.get(0);
			// listaCampi += "'" + chiave0 + "',";
			String key = "";
			// arrX = workset.get(chiave0).toArray(arrX);
			// String[] arrX = workset.get(chiave0).toArray(new
			// String[workset.get(chiave0).size()]);
			// connection.assign(varR, arrX);

			for (int i = 0; i < size; i++) {
				key = keys.get(i);
				
				String[] arrX = workset.get(key).toArray(new String[workset.get(key).size()]);
				listaCampi += key + ",";
				listaCampiLabel += "'" + key + "',";
				connection.assign(key, arrX);
				try {
					if(isNumeric(arrX)) {
						connection.eval(key + " <- as.numeric(" + key + ")");
					} 
               		} catch (Exception e) {
					Logger.getRootLogger().error(e.getMessage());
				}
				// String evalstringa = varR + " <- cbind(" + varR + ",tmp)";
				// System.out.println(evalstringa);
				// connection.eval(evalstringa);
			}
			listaCampi = listaCampi.substring(0, listaCampi.length() - 1);
			listaCampiLabel = listaCampiLabel.substring(0, listaCampiLabel.length() - 1);
			connection.eval(varR + " <- data.frame(" + listaCampi + ")");

			// assegnazione nome dei campi alle colonne

			String namecols = ((size > 1) ? "col" : "") + "names(" + varR + ") = c(" + listaCampiLabel + ")";
			// String exec = "colnames(" + varR + ") = c(" + listaCampi + ")";
			Logger.getRootLogger().debug("Bind input columns names " + namecols);
			connection.eval(namecols);

		}
	}

	 
	private boolean isNumeric(String[] arrX) {
		// TODO Auto-generated method stub
		for (String elem : arrX) {
			if (elem.isEmpty() || IS2_R_NA_VALUE.equalsIgnoreCase(elem))
				continue;
			try {
				Double.parseDouble(elem);
			} catch (NumberFormatException | NullPointerException nfe) {
				return false;
			}
		}
		return true;
	}

	public void bindInputColumns_old(LinkedHashMap<String, ArrayList<String>> workset, String varR)
			throws REngineException {

		if (!workset.isEmpty()) {
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
	}

	@Override
	public void doAction() throws RserveException {

		String fname = stepInstance.getFname();
		// mlest <- ml.est (workset, y=Y,";
		// Aggiunto il workset nella lista degli argomenti della funzione (by paolinux)
		istruzione = IS2_RESULTSET + "  <- " + fname + "( " + IS2_WORKSET + ",";
		if (!ruleset.isEmpty())
			istruzione += IS2_RULESET + ", ";

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

	public void getGenericoOutput(LinkedHashMap<String, ArrayList<String>> genericHashMap, String varR,
			String tipoOutput) throws RserveException, REXPMismatchException {
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

	public void getRolesGroup(LinkedHashMap<String, String> genericHashMap, String varR, String tipoOutput)
			throws RserveException, REXPMismatchException {
		Logger.getRootLogger().debug("Eseguo Get " + tipoOutput);
		try {
			RList lista = connection.eval(varR + "$" + tipoOutput).asList();
			String ts[] = lista.at(0).asStrings();
			String name = lista.names.get(0).toString();
			for (int i = 0; i < ts.length; i++) {
				genericHashMap.put(ts[i], name);
			}

		} catch (Exception e) {
			Logger.getRootLogger().info("No such list:" + tipoOutput);
			Logger.getRootLogger().debug(connection.eval("print(str(" + varR + "$" + tipoOutput + "))").toString());
			return;
		}
	}

	public void writeLogScriptR() throws RserveException, REXPMismatchException {
		Logger.getRootLogger().debug("Eseguo getLogScriptR ");

		String rlog[];

		rlog = connection.eval("sel_out" + "$log").asStrings();
		for (int i = 0; i < rlog.length; i++) {
			// logService.save(rlog[i],OUTPUT_R);
			logService.save(rlog[i], OUTPUT_R);
		}

		logService.save("Script completed!");

	}

	public void getGenericoOutput(LinkedHashMap<String, ArrayList<String>> genericHashMap, RList lista)
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
	 * @see it.istat.is2.workflow.engine.EngineService#prepareEnv()
	 */
	public void prepareEnv() {

		// get all roles by service
		ruoliAllMap = ruoloDao.findByServiceAsCodMap(stepInstance.getAppService());

		// REcupero dei ruoli di INPUT e OUTUPT e dalle istanze
		// {S=[S], X=[X], Y=[Y], Z=[Z]}
		HashMap<String, ArrayList<String>> ruoliInputStep = new HashMap<>();
		// {P=[P], M=[M], O=[O]}
		ruoliOutputStep = new LinkedHashMap();
		ruoliGruppoOutputStep = new LinkedHashMap<>();

		for (Iterator<?> iterator = stepInstance.getSxStepPatterns().iterator(); iterator.hasNext();) {
			StepInstanceAppRole sxStepPattern = (StepInstanceAppRole) iterator.next();
			if (sxStepPattern.getTipoIO().getId().intValue() == IS2Const.VARIABILE_TIPO_INPUT) {
				ArrayList<String> listv = ruoliInputStep.get(sxStepPattern.getAppRole().getCod());
				if (listv == null) {
					listv = new ArrayList<>();
				}
				listv.add(sxStepPattern.getAppRole().getCod());
				ruoliInputStep.put(sxStepPattern.getAppRole().getCod(), listv);
			} else if (sxStepPattern.getTipoIO().getId().intValue() == IS2Const.VARIABILE_TIPO_OUTPUT) {
				ArrayList<String> listv = ruoliOutputStep.get(sxStepPattern.getAppRole().getCod());
				if (listv == null) {
					listv = new ArrayList<>();
				}
				listv.add(sxStepPattern.getAppRole().getCod());
				ruoliOutputStep.put(sxStepPattern.getAppRole().getCod(), listv);
			}
		}

		// Recupero workset di input
		List<StepVariable> dataList = stepVariableDao.findByElaborazione(elaborazione);
		// mappa delle colonne workset <nome campo, oggetto stepv>
		dataMap = Utility.getMapNameWorkSetStep(dataList);
		// mappa delle colonne workset <nome campo, oggetto stepv>
		Map<String, ArrayList<StepVariable>> dataRuoliStepVarMap = Utility.getMapCodiceRuoloStepVariabili(dataList);
		// List<AppRole> ruoliAll = ruoloDao.findAll();
		// Utility.getMapRuoliByCod(ruoliAll)

		// mappa delle colonne workset <nome,lista valori>
		worksetVariabili = Utility.getMapWorkSetValuesInRoles(dataMap, new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE),
				ruoliInputStep.keySet());
		// PARAMETRI
		parametriMap = Utility.getMapWorkSetValues(dataMap, new SxTipoVar(IS2Const.WORKSET_TIPO_PARAMETRO));
		modelloMap = Utility.getMapWorkSetValues(dataMap, new SxTipoVar(IS2Const.WORKSET_TIPO_MODELLO));
		ruleset = Utility.getMapWorkSetValues(dataMap, new SxTipoVar(IS2Const.WORKSET_TIPO_RULESET));
		worksetOut = new LinkedHashMap<>();

		// associo il codice ruolo alla variabile
		// codiceRuolo, lista nome variabili {X=[X1], Y=[Y1]}
		ruoliVariabileNome = new HashMap<>();
		parametriOutput = new LinkedHashMap<>();

		for (Map.Entry<String, ArrayList<StepVariable>> entry : dataRuoliStepVarMap.entrySet()) {
			String codR = entry.getKey();
			ArrayList<StepVariable> listSVariable = entry.getValue();
			for (Iterator<StepVariable> iterator = listSVariable.iterator(); iterator.hasNext();) {
				StepVariable stepVariable = (StepVariable) iterator.next();
				ArrayList<String> listv = ruoliVariabileNome.get(codR);
				if (listv == null) {
					listv = new ArrayList<>();
				}
				listv.add(stepVariable.getWorkset().getNome());
				ruoliVariabileNome.put(codR, listv);
			}
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see it.istat.is2.workflow.engine.EngineService#processOutput()
	 */
	@Override
	public void processOutput() throws Exception {
		// TODO Auto-generated method stub

		getGenericoOutput(worksetOut, EngineR.IS2_RESULTSET, EngineR.IS2_RESULT_OUTPUT);
		getGenericoOutput(ruoliOutputStep, EngineR.IS2_RESULTSET, EngineR.IS2_RESULT_RUOLI);
		getGenericoOutput(parametriOutput, EngineR.IS2_RESULTSET, EngineR.IS2_RESULT_PARAM);
		getGenericoOutput(parametriOutput, EngineR.IS2_RESULTSET, EngineR.IS2_RESULT_REPORT);
		getRolesGroup(ruoliGruppoOutputStep, EngineR.IS2_RESULTSET, EngineR.IS2_RESULT_ROLES_GROUPS);
		writeLogScriptR();
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
			StepVariable stepVariable;
			String ruolo = ruoliOutputStepInversa.get(nomeW);
			String ruoloGruppo = ruoliGruppoOutputStep.get(ruolo);
			if (ruolo == null) {
				ruolo = EngineR.IS2_RUOLO_SKIP_N;
			}
			if (ruoloGruppo == null) {
				ruoloGruppo = RUOLO_SKIP_N;
			}
			AppRole sxRuolo = ruoliAllMap.get(ruolo);
			AppRole sxRuoloGruppo = ruoliAllMap.get(ruoloGruppo);

			stepVariable = Utility.retrieveStepVariable(dataMap, nomeW, sxRuolo);

			if (stepVariable != null) { // update

				stepVariable.getWorkset().setValori(value);
				stepVariable.setTipoCampo(new TipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));
			} else {
				stepVariable = new StepVariable();
				stepVariable.setElaborazione(elaborazione);
				stepVariable.setTipoCampo(new TipoCampo(IS2Const.TIPO_CAMPO_ELABORATO));

				stepVariable.setAppRole(sxRuolo);
				stepVariable.setSxRuoloGruppo(sxRuoloGruppo);
				stepVariable.setOrdine(sxRuolo.getOrdine());
				Workset workset = new Workset();
				workset.setNome(nomeW.replaceAll("\\.", "_"));
				workset.setSxTipoVar(new SxTipoVar(IS2Const.WORKSET_TIPO_VARIABILE));
				ArrayList<StepVariable> l = new ArrayList<>();
				l.add(stepVariable);
				workset.setStepVariables(l);
				workset.setValori(value);
				workset.setValoriSize(workset.getValori().size());
				stepVariable.setWorkset(workset);
			}

			stepVariableDao.save(stepVariable);
		}

		 
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see it.istat.is2.workflow.engine.EngineService#destroy()
	 */
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		closeConnection();

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see it.istat.is2.workflow.engine.EngineService#init()
	 */
	@Override
	public void init() throws Exception {
		// TODO Auto-generated method stub

	}
}
