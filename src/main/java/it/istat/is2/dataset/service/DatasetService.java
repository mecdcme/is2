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
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;

import org.hibernate.Session;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Autowired
	protected EntityManager em;

	@Transactional
	public DatasetFile save(final Map<String, ArrayList<String>> campi, final Map<Integer, String> valoriHeaderNum,
			final String labelFile, final Long tipoDato, final String separatore, final String desc,
			final String idsessione) throws Exception {

		Session session = em.unwrap(Session.class);

		DatasetFile dFile = new DatasetFile();

		dFile.setFileLabel(labelFile);
		DataTypeCls tipoD = new DataTypeCls();
		tipoD.setId(tipoDato);
		dFile.setDataType(tipoD);
		dFile.setWorkSession(sessioneLavoroDao.findById(Long.parseLong(idsessione)).orElse(null));
		dFile.setFileName(desc);
		dFile.setFileFormat("CSV");
		dFile.setFieldSeparator(separatore);
		dFile.setLastUpdate(new Date());
		dFile.setTotalRows(campi.get(valoriHeaderNum.get(0)).size());

		dFile = datasetFileDao.save(dFile);
		short ord = 0;

		for (int i = 0; i < valoriHeaderNum.size(); i++) {
			String kCampi = valoriHeaderNum.get(i);
			final DatasetColumn dc = new DatasetColumn();
			dc.setDatasetFile(dFile);
			dc.setName(kCampi.replaceAll("\\.|\\s", "_"));
			dc.setOrderCode(Short.valueOf(ord));
			dc.setContentSize(campi.get(kCampi).size());
			ord += 1;
			dc.setContents(campi.get(kCampi));

			dc.setDatasetFile(dFile);
			datasetColumnDao.save(dc);
			session.flush();
			session.clear();
			dc.getContents().clear();
			campi.get(kCampi).clear();

		}

		return dFile;
	}

	public DatasetColumn salvaColonna(DatasetColumn dcol) {

		return datasetColumnDao.save(dcol);

	}

	public List<DatasetFile> findAllDatasetFile() {
		return datasetFileDao.findAll();

	}

	public DatasetFile findDataSetFile(Long id) {
		return datasetFileDao.findById(id).orElse(null);
	}

	public List<DatasetFile> findDatasetFilesByIdWorkSession(Long id) {
		return datasetFileDao.findDatasetFilesByWorkSession(new WorkSession(id));
	}

	public DatasetFile findDataSetFileSQL(Long id) {
		return sqlgenericDao.findGenericDatasetFileOne(id);

	}

	public List<DatasetFile> findAllDatasetFileSQL() {
		return sqlgenericDao.findGenericDatasetFileAll();

	}

	public List<DatasetColumn> findAllDatasetColumnSQL(Long dFile, Integer rigaInf, Integer rigaSup) {
		return datasetColumnDao.findDatasetColumnbyQuery(dFile, rigaInf, rigaSup);

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

	public String loadDatasetValori(Long dfile, Integer length, Integer start, Integer draw,
			HashMap<String, String> parametri, String nameColumnToOrder, String dirColumnOrder) throws JSONException {

		int offset = 2;
		List<Object[]> resulFieldstList = sqlgenericDao.findDatasetIdColAndName(dfile);
		List<Object[]> dataList = sqlgenericDao.findDatasetDataViewParamsbyQuery(resulFieldstList, dfile, start, length,
				parametri, nameColumnToOrder, dirColumnOrder);

		Integer numRighe = 0;
		JSONArray data = new JSONArray();
		JSONObject obj = new JSONObject();
		if (dataList.size() > 0) {
			String rows = dataList.get(0)[resulFieldstList.size() + offset].toString();
			numRighe = Integer.valueOf(rows);
			for (Object[] row : dataList) {
				JSONObject obji = new JSONObject();
				for (int j = 0; j < resulFieldstList.size(); j++) {
					obji.put((String) resulFieldstList.get(j)[1], row[j + offset]);
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
		return datasetColumnDao.findDatasetColumnbyQueryFilter(dFile, rigaInf, rigaSup, filterFieldName,
				filterFieldValue, fieldSelect);

	}

	public List<StatisticalVariableCls> findAllVariabiliSum() {
		return variabileSumDao.findAllVariables();

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

	@Transactional
	public Boolean deleteDataset(Long idFile) {
		DatasetFile datasetFile = findDataSetFile(idFile);
		datasetColumnDao.deleteByDatasetFile(datasetFile);
		datasetFileDao.deleteDatasetFile(datasetFile.getId());
		return true;
	}

	public List<String> findTablesDB(String db) {

		return sqlgenericDao.findTablesDB(db);
	}

	public List<String> findFieldsTableDB(String db, String table) {

		return sqlgenericDao.findFieldsTableDB(db, table);
	}

	public DatasetFile loadDatasetFromTable(String idsessione, String dbschema, String tablename, String[] fields) {

		DatasetFile dFile = new DatasetFile();
		dFile.setFileLabel(dbschema);
		DataTypeCls tipoD = new DataTypeCls(IS2Const.DATA_TYPE_DATASET);
		dFile.setDataType(tipoD);
		dFile.setWorkSession(new WorkSession(Long.valueOf(idsessione)));
		dFile.setFileName(tablename);
		dFile.setFileFormat("DB");
		dFile.setFieldSeparator("");
		dFile.setLastUpdate(new Date());
		List<DatasetColumn> colonne = new ArrayList<>();
		for (short i = 0; i < fields.length; i++) {
			String field = fields[i];
			List<String> vals = sqlgenericDao.loadFieldValuesTable(dbschema, tablename, field);
			DatasetColumn dc = new DatasetColumn();
			dc.setDatasetFile(dFile);
			dc.setName(field.replaceAll("\\.", "_").toUpperCase());
			dc.setOrderCode(Short.valueOf(i));
			dc.setContentSize(vals.size());
			dc.setContents(vals);
			colonne.add(dc);

			dFile.setTotalRows(vals.size());
		}
		dFile.setColumns(colonne);
		dFile = datasetFileDao.save(dFile);
		return dFile;
	}

	public List<Object[]> getDataset(Long idfile) {

		DatasetFile datasetFile = this.findDataSetFile(idfile);

		List<Object[]> dataList = null;
		List<Object[]> resultFieldstList;
		if (datasetFile != null) {
			resultFieldstList = sqlgenericDao.findDatasetIdColAndName(idfile);
			dataList = sqlgenericDao.findDatasetDataViewParamsbyQuery(resultFieldstList, idfile, 0,
					datasetFile.getTotalRows(), null, null, null);
		}
		return dataList;
	}

	public List<String> getDatasetColumns(Long idfile) {

		List<String> columnList = new ArrayList<>();
		List<Object[]> resulFieldstList = sqlgenericDao.findDatasetIdColAndName(idfile);
		if (resulFieldstList != null) {
			for (Object[] result : resulFieldstList) {
				columnList.add((String) result[1]);
			}
		}
		return columnList;
	}
}
