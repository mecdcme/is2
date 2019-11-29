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
package it.istat.is2.dataset.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import it.istat.is2.app.bean.DataTableBean;
import it.istat.is2.app.dao.SqlGenericDao;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.dataset.dao.DatasetColumnDao;
import it.istat.is2.dataset.dao.DatasetFileDao;
import it.istat.is2.dataset.dao.StatisticalVariableClsDao;
import it.istat.is2.dataset.domain.DatasetColumn;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.dataset.domain.StatisticalVariableCls;
import it.istat.is2.workflow.domain.DataTypeCls;
import it.istat.is2.worksession.dao.WorkSessionDao;
import it.istat.is2.worksession.domain.WorkSession;

@Service
public class DatasetService {

	@Autowired
	private DatasetFileDao datasetFileDao;
	@Autowired
	private DatasetColumnDao datasetColumnDao;
	@Autowired
	private SqlGenericDao sqlgenericDao;
	@Autowired
	private WorkSessionDao sessioneLavoroDao;
	@Autowired
	private StatisticalVariableClsDao variabileSumDao;
	

	public DatasetFile save(HashMap<String, ArrayList<String>> campi, HashMap<Integer, String> valoriHeaderNum,
			String labelFile, Integer tipoDato, String separatore, String desc, String idsessione) throws Exception {

		DatasetFile dFile = new DatasetFile();

		dFile.setFileLabel(labelFile);
		DataTypeCls tipoD = new DataTypeCls();
		tipoD.setId(tipoDato);
		dFile.setDataType(tipoD);
		dFile.setWorkSession(sessioneLavoroDao.findById(Long.parseLong(idsessione)).get());
		dFile.setFileName(desc);
		dFile.setFileFormat("CSV");
		dFile.setFieldSeparator(separatore);
		dFile.setLastUpdate(new Date());
		dFile.setTotalRows(campi.get(valoriHeaderNum.get(0)).size());
		List<DatasetColumn> colonne = new ArrayList<DatasetColumn>();
		short ord = 0;

		for (int i = 0; i < valoriHeaderNum.size(); i++) {
			String kCampi = valoriHeaderNum.get(i);
			ArrayList<String> vals = campi.get(kCampi);
			DatasetColumn dc = new DatasetColumn();
			dc.setDatasetFile(dFile);
			dc.setName(kCampi.replaceAll("\\.", "_"));
			dc.setOrderCode(new Short(ord));
			dc.setContentSize(vals.size());
			ord += 1;
			dc.setContents(vals);
			colonne.add(dc);
		}
		dFile.setColumns(colonne);
		dFile = datasetFileDao.save(dFile);

		return dFile;
	}

	public DatasetColumn salvaColonna(DatasetColumn dcol) throws Exception {

		DatasetColumn dC;
		try {
			dC = datasetColumnDao.save(dcol);
		} catch (Exception e) {
			return null;
		}

		return dC;
	}

	public List<DatasetFile> findAllDatasetFile() {
		List<DatasetFile> datain = (List<DatasetFile>) datasetFileDao.findAll();
		return datain;
	}

	public DatasetFile findDataSetFile(Long id) {
		return datasetFileDao.findById(id).orElse(null);
	}

	public List<DatasetFile> findDatasetFilesByIdWorkSession(Long id) {
		return datasetFileDao.findDatasetFilesByWorkSession(new WorkSession(id));
	}

	public DatasetFile findDataSetFileSQL(Long id) {
		DatasetFile df = sqlgenericDao.findGenericDatasetFileOne(id);
		return df;
	}

	public List<DatasetFile> findAllDatasetFileSQL() {
		List<DatasetFile> dataList = sqlgenericDao.findGenericDatasetFileAll();
		return dataList;
	}

	public List<DatasetColumn> findAllDatasetColumnSQL(Long dFile, Integer rigaInf, Integer rigaSup) {
		List<DatasetColumn> dataList = datasetColumnDao.findDatasetColumnbyQuery(dFile, rigaInf, rigaSup);
		return dataList;
	}

	public List<DatasetColumn> findAllNameColum(Long dFile) {
		return datasetColumnDao.findNamebyFile(new DatasetFile(dFile));
	}

	public List<DatasetColumn> findAllNameColum(DatasetFile dFile) {
		return datasetColumnDao.findNamebyFile(dFile);
	}

	public DatasetColumn findOneColonna(Long dFile) {
		return datasetColumnDao.findById(dFile).orElse(null);
	}

	public Integer findNumeroRighe(Long dFile) {
		return datasetFileDao.findTotalRows(dFile);
	}

	public DataTableBean loadDatasetValoriTest(Long dfile, Integer length, Integer start, Integer draw,
			HashMap<String, String> parametri, String nameColumnToOrder, String dirColumnOrder) {
		List<DatasetColumn> dataList = sqlgenericDao.findDatasetColumnParamsbyQuery(dfile, start, start + length,
				parametri, nameColumnToOrder, dirColumnOrder);
		Integer numRighe = 1;

		DataTableBean db = new DataTableBean();
		db.setDraw(draw);
		db.setRecordsFiltered(numRighe);
		db.setRecordsTotal(numRighe);
		List<Collection<HashMap<String, String>>> tabella = new ArrayList<Collection<HashMap<String, String>>>();

		for (int i = 0; i < dataList.get(0).getContents().size(); i++) {
			List<HashMap<String, String>> riga = new ArrayList<HashMap<String, String>>();
			for (int j = 0; j < dataList.size(); j++) {
				HashMap<String, String> dato = new HashMap<>();
				dato.put(dataList.get(j).getName(), dataList.get(j).getContents().get(i));
				riga.add(dato);
			}
			tabella.add(riga);
		}
		db.setData(tabella);
		return db;
	}

	public String loadDatasetValori(Long dfile, Integer length, Integer start, Integer draw,
			HashMap<String, String> parametri, String nameColumnToOrder, String dirColumnOrder) throws JSONException {
		
		int offset=2;
		List<Object[]> resulFieldstList = sqlgenericDao.findDatasetIdColAndName(dfile);
		List<Object[]> dataList = sqlgenericDao.findDatasetDataViewParamsbyQuery(resulFieldstList, dfile, start,
				start + length, parametri, nameColumnToOrder, dirColumnOrder);

		Integer numRighe = 0;
		JSONArray data = new JSONArray();
		JSONObject obj = new JSONObject();
		if (dataList.size() > 0) {
			String rows=dataList.get(0)[resulFieldstList.size()+offset].toString();
			numRighe = new Integer(rows);
			for (Object[] row : dataList) {
				JSONObject obji = new JSONObject();
				for (int j = 0; j < resulFieldstList.size(); j++) {
					obji.put((String) resulFieldstList.get(j)[1], row[j+offset]);
				}
				data.put(obji);
			}
		}
		obj.put("data", data);
		obj.put("draw", draw);
		obj.put("recordsTotal", numRighe);
		obj.put("recordsFiltered", numRighe);

		return obj.toString();
	}

	public List<DatasetColumn> findAllDatasetColumnQueryFilter(Long dFile, Integer rigaInf, Integer rigaSup,
			String filterFieldName, String filterFieldValue, List<String> fieldSelect) {
		List<DatasetColumn> dataList = datasetColumnDao.findDatasetColumnbyQueryFilter(dFile, rigaInf, rigaSup,
				filterFieldName, filterFieldValue, fieldSelect);
		return dataList;
	}

	public List<StatisticalVariableCls> findAllVariabiliSum() {
		Iterable<StatisticalVariableCls> variabileSum = variabileSumDao.findAllVariables();
		return (List<StatisticalVariableCls>) variabileSum;
	}

	public List<DatasetColumn> findByDatasetFile(DatasetFile idfile) {
		return datasetColumnDao.findNamebyFile(idfile);

	}

	public Map<String, List<String>> loadDatasetValori(Long idfile) {
		DatasetFile datasetFile = findDataSetFile(idfile);

		Map<String, List<String>> ret = new LinkedHashMap<>();
		for (Iterator<?> iterator = datasetFile.getColumns().iterator(); iterator.hasNext();) {
			DatasetColumn dc = (DatasetColumn) iterator.next();
			ret.put(dc.getName(), dc.getContents());
		}
		return ret;
	}

	public DatasetFile createField(String idfile, String idColonna, String commandField, String charOrString,
			String upperLower, String newField, String columnOrder, String numRows) {

		DatasetColumn nuovaColonna = new DatasetColumn();
		DatasetColumn colum = findOneColonna(Long.parseLong(idColonna));
		List<String> datiColonna = colum.getContents();
		// cambia i valori della colum
		List<String> datiColonnaTemp = new ArrayList();
		// cambia i valori della colum
		switch (commandField) {
		case "0001":
			if (upperLower.equals("low")) {
				datiColonna.forEach((item) -> datiColonnaTemp.add(item.toLowerCase()));
			} else {
				datiColonna.forEach((item) -> datiColonnaTemp.add(item.toUpperCase()));
			}
			break;
		case "0010":
			if (!charOrString.equals("")) {
				datiColonna.forEach((item) -> datiColonnaTemp.add(item.replaceAll(charOrString, "")));
			}
			break;
		case "0100":
			datiColonna.forEach((item) -> datiColonnaTemp.add(item.replaceAll("[^a-zA-Z0-9]", "")));
			break;
		case "1000":
			datiColonna.forEach((item) -> datiColonnaTemp.add(item.replaceAll(" ", "")));
			break;
		case "0011":
			if (upperLower.equals("low")) {
				datiColonna.forEach((item) -> datiColonnaTemp.add(item.replaceAll(charOrString, "").toLowerCase()));
			} else {
				datiColonna.forEach((item) -> datiColonnaTemp.add(item.replaceAll(charOrString, "").toUpperCase()));
			}
			break;
		case "0101":
			if (upperLower.equals("low")) {
				datiColonna.forEach((item) -> datiColonnaTemp.add(item.toLowerCase().replaceAll("[^a-zA-Z0-9]", "")));
			} else {
				datiColonna.forEach((item) -> datiColonnaTemp.add(item.toUpperCase().replaceAll("[^a-zA-Z0-9]", "")));
			}
			break;
		case "1001":
			if (upperLower.equals("low")) {
				datiColonna.forEach((item) -> datiColonnaTemp.add(item.toLowerCase().replaceAll(" ", "")));
			} else {
				datiColonna.forEach((item) -> datiColonnaTemp.add(item.toUpperCase().replaceAll(" ", "")));
			}
			break;
		case "0111":
			if (!charOrString.equals("")) {
				if (upperLower.equals("low")) {
					datiColonna.forEach((item) -> datiColonnaTemp
							.add(item.replaceAll(charOrString, "").toLowerCase().replaceAll("[^a-zA-Z0-9]", "")));
				} else {
					datiColonna.forEach((item) -> datiColonnaTemp
							.add(item.replaceAll(charOrString, "").toUpperCase().replaceAll(charOrString, "")));
				}
			}
			break;
		case "1011":
			if (!charOrString.equals("")) {
				if (upperLower.equals("low")) {
					datiColonna.forEach((item) -> datiColonnaTemp
							.add(item.replaceAll(charOrString, "").toLowerCase().replaceAll(" ", "")));
				} else {
					datiColonna.forEach((item) -> datiColonnaTemp
							.add(item.replaceAll(charOrString, "").toUpperCase().replaceAll(" ", "")));
				}
			}
			break;
		case "0110":
			if (!charOrString.equals("")) {
				datiColonna.forEach((item) -> datiColonnaTemp
						.add(item.replaceAll(charOrString, "").replaceAll("[^a-zA-Z0-9]", "")));
			}
			break;
		case "1010":
			if (!charOrString.equals("")) {
				datiColonna
						.forEach((item) -> datiColonnaTemp.add(item.replaceAll(charOrString, "").replaceAll(" ", "")));
			}
			break;
		case "1100":
			datiColonna.forEach((item) -> datiColonnaTemp.add(item.replaceAll(" ", "").replaceAll("[^a-zA-Z0-9]", "")));
			break;
		case "1101":
			if (upperLower.equals("low")) {
				datiColonna.forEach((item) -> datiColonnaTemp
						.add(item.toLowerCase().replaceAll(" ", "").replaceAll("[^a-zA-Z0-9]", "")));
			} else {
				datiColonna.forEach((item) -> datiColonnaTemp
						.add(item.toUpperCase().replaceAll(" ", "").replaceAll("[^a-zA-Z0-9]", "")));
			}
			break;
		case "1111":
			if (!charOrString.equals("")) {
				if (upperLower.equals("low")) {
					datiColonna.forEach((item) -> datiColonnaTemp.add(item.replaceAll(charOrString, "").toLowerCase()
							.replaceAll(" ", "").replaceAll("[^a-zA-Z0-9]", "")));
				} else {
					datiColonna.forEach((item) -> datiColonnaTemp.add(item.replaceAll(charOrString, "").toUpperCase()
							.replaceAll(" ", "").replaceAll("[^a-zA-Z0-9]", "")));
				}
			}
			break;
		case "1110":
			if (!charOrString.equals("")) {
				datiColonna.forEach((item) -> datiColonnaTemp
						.add(item.replaceAll(charOrString, "").replaceAll(" ", "").replaceAll("[^a-zA-Z0-9]", "")));
			}
			break;
		case "0000":
			datiColonna.forEach((item) -> datiColonnaTemp.add(item));
			break;
		default:
			datiColonna.forEach((item) -> datiColonnaTemp.add(item));
		}
		;

		// DatasetFile dFile = datasetService.findDataSetFile(idfile);
		DatasetFile dFile = new DatasetFile();
		dFile.setId(Long.parseLong(idfile));
		nuovaColonna.setDatasetFile(dFile);
		nuovaColonna.setName(newField);
		nuovaColonna.setOrderCode((short) Integer.parseInt(columnOrder));
		nuovaColonna.setContentSize(datiColonna.size());

		nuovaColonna.setContents(datiColonnaTemp);
		datasetColumnDao.save(nuovaColonna);

		return dFile;
	}

	public DatasetFile createMergedField(String idfile, String columnOrder, String numRows, String fieldsToMerge,
			String newField) {

		List<String> campiDaConcatenare = new ArrayList<String>();
		List<String> naturaDeiCampi = new ArrayList<String>();
		List<String> campoConcatenato = new ArrayList<String>();
		ArrayList<List<String>> originalFields = new ArrayList<List<String>>();

		int lastIndex = 0;
		int nextIndex = 0;

		while (lastIndex < fieldsToMerge.length()) {
			lastIndex = fieldsToMerge.indexOf("{...", lastIndex);
			if (lastIndex == -1)
				break;

			nextIndex = fieldsToMerge.indexOf("...}", lastIndex);
			String result = fieldsToMerge.substring(lastIndex + "{...".length() + 4, nextIndex);
			campiDaConcatenare.add(result);

			lastIndex += "{...".length();
		}
		;

		lastIndex = 0;
		nextIndex = 0;

		while (lastIndex < fieldsToMerge.length()) {
			lastIndex = fieldsToMerge.indexOf("{...(", lastIndex);
			if (lastIndex == -1)
				break;
			nextIndex = fieldsToMerge.indexOf(")", lastIndex);
			String result = fieldsToMerge.substring(lastIndex + "{...(".length(), nextIndex);
			naturaDeiCampi.add(result);

			lastIndex += "{...(".length();
		}

		for (int i = 0; i < naturaDeiCampi.size(); i++) {

			if (naturaDeiCampi.get(i).equals("id")) {
				DatasetColumn colum = findOneColonna(Long.parseLong(campiDaConcatenare.get(i)));
				originalFields.add(colum.getContents());

			}
			if (naturaDeiCampi.get(i).equals("se")) {
				List<String> separatore = Collections.nCopies(Integer.parseInt(numRows), campiDaConcatenare.get(i));
				originalFields.add(separatore);

			}
		}

		DatasetColumn nuovaColonna = new DatasetColumn();

		for (int i = 0; i < Integer.parseInt(numRows); i++) {
			String temp = "";
			for (int j = 0; j < naturaDeiCampi.size(); j++) {

				temp = temp + originalFields.get(j).get(i);
			}
			campoConcatenato.add(temp);
		}
		nuovaColonna.setContents(campoConcatenato);

		//

		// DatasetFile dFile = datasetService.findDataSetFile(idfile);
		DatasetFile dFile = new DatasetFile();
		dFile.setId(Long.parseLong(idfile));
		nuovaColonna.setDatasetFile(dFile);
		nuovaColonna.setName(newField);
		nuovaColonna.setOrderCode((short) Integer.parseInt(columnOrder));
		nuovaColonna.setContentSize(Integer.parseInt(numRows));

		// nuovaColonna.setDatiColonna(datiColonnaTemp);
		datasetColumnDao.save(nuovaColonna);

		return dFile;
	}

	public DatasetFile createParsedFields(String idfile, String idColonna, String columnOrder, String numRows,
			String executeCommand, String commandValue, String startTo, String field1, String field2) {

		List<String> campo1 = new ArrayList<String>();
		List<String> campo2 = new ArrayList<String>();

		DatasetColumn colum = findOneColonna(Long.parseLong(idColonna));
		List<String> temp = colum.getContents();
		String tempString = "";
		Integer indice;
		int firstIndex = 0;
		int lastIndex = 0;
		String sepValue = null;
		switch (executeCommand) {

		case "separatore":

			firstIndex = commandValue.indexOf("{...");
			lastIndex = commandValue.indexOf("...}");
			sepValue = commandValue.substring(firstIndex + "{...".length(), lastIndex);
			if (startTo.equals("start")) {

				for (int i = 0; i < temp.size(); i++) {
					tempString = temp.get(i);
					indice = tempString.indexOf(sepValue);
					if (indice < tempString.length() && indice != -1) {
						campo1.add(tempString.substring(0, indice));
						campo2.add(tempString.substring(indice + sepValue.length(), tempString.length()));
					} else {
						campo1.add(tempString);
						campo2.add("");
					}

				}

			} else {

				for (int i = 0; i < temp.size(); i++) {
					tempString = temp.get(i);
					indice = tempString.lastIndexOf(sepValue);
					if (indice < tempString.length() && indice != -1) {
						campo1.add(tempString.substring(0, indice));
						campo2.add(tempString.substring(indice + sepValue.length(), tempString.length()));
					} else {
						campo1.add("");
						campo2.add(tempString);
					}

				}
			}

			break;
		case "lunghezza":

			if (startTo.equals("start")) {

				for (int i = 0; i < temp.size(); i++) {
					tempString = temp.get(i);
					indice = Integer.parseInt(commandValue);
					if (indice < tempString.length()) {
						campo1.add(tempString.substring(0, indice - 1));
						campo2.add(tempString.substring(indice, tempString.length()));
					} else {
						campo1.add(tempString);
						campo2.add("");
					}

				}
			} else {

				for (int i = 0; i < temp.size(); i++) {
					tempString = temp.get(i);
					indice = Integer.parseInt(commandValue);
					if (indice < tempString.length()) {
						campo1.add(tempString.substring(0, (tempString.length() - indice) - 1));
						campo2.add(tempString.substring(tempString.length() - indice, tempString.length()));
					} else {
						campo1.add("");
						campo2.add(tempString);
					}

				}
			}

			break;

		}
		;

		DatasetColumn nuovaColonna1 = new DatasetColumn();
		DatasetColumn nuovaColonna2 = new DatasetColumn();

		nuovaColonna1.setContents(campo1);
		nuovaColonna2.setContents(campo2);

		DatasetFile dFile = new DatasetFile();
		dFile.setId(Long.parseLong(idfile));
		nuovaColonna1.setDatasetFile(dFile);
		nuovaColonna1.setName(field1);
		nuovaColonna1.setOrderCode((short) Integer.parseInt(columnOrder));
		nuovaColonna1.setContentSize(Integer.parseInt(numRows));
		nuovaColonna2.setDatasetFile(dFile);
		nuovaColonna2.setName(field2);
		nuovaColonna2.setOrderCode((short) (Integer.parseInt(columnOrder) + 1));
		nuovaColonna2.setContentSize(Integer.parseInt(numRows));

		datasetColumnDao.save(nuovaColonna1);
		datasetColumnDao.save(nuovaColonna2);

		return dFile;
	}

	public DatasetFile createFixedField(String idfile, String idColonna, HashMap<Integer, String> Header,
			HashMap<String, ArrayList<String>> Campi, String fieldName, String numColonne, String numRighe) {

		HashMap<String, String> ErrataCorridge = new HashMap<String, String>();

		if (Header.size() > 1 && Campi.size() > 1) {
			for (int i = 0; i < Campi.get(Header.get(0)).size(); i++) {
				ErrataCorridge.put(Campi.get(Header.get(0)).get(i), Campi.get(Header.get(1)).get(i));
			}
		}

		DatasetColumn colum = findOneColonna(Long.parseLong(idColonna));
		List<String> temp = colum.getContents();
		DatasetColumn nuovaColonna = new DatasetColumn();
		List<String> nuoviDatiColonna = new ArrayList<String>();

		for (int i = 0; i < temp.size(); i++) {
			if (ErrataCorridge.containsKey(temp.get(i))) {
				nuoviDatiColonna.add(ErrataCorridge.get(temp.get(i)));

			} else {

				nuoviDatiColonna.add(temp.get(i));
			}

		}
		DatasetFile dFile = new DatasetFile();
		dFile.setId(Long.parseLong(idfile));
		nuovaColonna.setContents(nuoviDatiColonna);
		nuovaColonna.setDatasetFile(dFile);
		nuovaColonna.setName(fieldName);
		nuovaColonna.setOrderCode((short) Integer.parseInt(numColonne));
		nuovaColonna.setContentSize(Integer.parseInt(numRighe));

		datasetColumnDao.save(nuovaColonna);

		return dFile;
	}

	public DatasetFile deleteField(String idfile, String idColonna) {
		DatasetColumn colum = findOneColonna(Long.parseLong(idColonna));
		datasetColumnDao.delete(colum);
		DatasetFile dFile = new DatasetFile();
		dFile.setId(Long.parseLong(idfile));
		return dFile;
	}

	@Transactional
	public Boolean deleteDataset(Long idFile) {
		DatasetFile datasetFile = findDataSetFile(idFile);
		datasetColumnDao.deleteByDatasetFile(datasetFile);
		datasetFileDao.deleteDatasetFile(datasetFile.getId());
		return true;
	}

	public List<String> findTablesDB(String db) {
		// TODO Auto-generated method stub
		return sqlgenericDao.findTablesDB(db);
	}

	public List<String> findFieldsTableDB(String db, String table) {
		// TODO Auto-generated method stub
		return sqlgenericDao.findFieldsTableDB(db, table);
	}

	public DatasetFile loadDatasetFromTable(String idsessione, String dbschema, String tablename, String[] fields) {
		// TODO Auto-generated method stub
		DatasetFile dFile = new DatasetFile();
		dFile.setFileLabel(dbschema);
		DataTypeCls tipoD = new DataTypeCls(IS2Const.DATA_TYPE_DATASET);
		dFile.setDataType(tipoD);
		dFile.setWorkSession(new WorkSession(Long.valueOf(idsessione)));
		dFile.setFileName(tablename);
		dFile.setFileFormat("DB");
		dFile.setFieldSeparator("");
		dFile.setLastUpdate(new Date());
		List<DatasetColumn> colonne = new ArrayList<DatasetColumn>();
		for (short i = 0; i < fields.length; i++) {
			String field = fields[i];
			List<String> vals = sqlgenericDao.loadFieldValuesTable(dbschema, tablename, field);
			DatasetColumn dc = new DatasetColumn();
			dc.setDatasetFile(dFile);
			dc.setName(field.replaceAll("\\.", "_").toUpperCase());
			dc.setOrderCode(new Short(i));
			dc.setContentSize(vals.size());
			dc.setContents(vals);
			colonne.add(dc);

			dFile.setTotalRows(vals.size());
		}
		dFile.setColumns(colonne);
		dFile = datasetFileDao.save(dFile);
		return dFile;
	}
}
