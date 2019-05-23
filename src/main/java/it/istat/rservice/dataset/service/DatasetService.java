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
package it.istat.rservice.dataset.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.transaction.Transactional;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

import it.istat.rservice.app.bean.DataTableBean;
import it.istat.rservice.app.dao.SessioneDao;
import it.istat.rservice.app.dao.SqlGenericDao;
import it.istat.rservice.app.domain.SessioneLavoro;
import it.istat.rservice.dataset.dao.DatasetColonnaDao;
import it.istat.rservice.dataset.dao.DatasetFileDao;
import it.istat.rservice.dataset.dao.TipoVariabileSumDao;
import it.istat.rservice.dataset.domain.DatasetColonna;
import it.istat.rservice.dataset.domain.DatasetFile;
import it.istat.rservice.dataset.domain.TipoVariabileSum;
import it.istat.rservice.workflow.domain.SxTipoDato;

@Service
public class DatasetService {
	
    @Autowired
    private DatasetFileDao datasetFileDao;
    @Autowired
    private DatasetColonnaDao datasetColonnaDao;
    @Autowired
    private SqlGenericDao sqlgenericDao;
    @Autowired
    private SessioneDao sessioneLavoroDao;
    @Autowired
    private TipoVariabileSumDao variabileSumDao;
    @Autowired
    private DatasetColonnaDao datasetColonna;

    public DatasetFile salva(HashMap<String, ArrayList<String>> campi, HashMap<Integer, String> valoriHeaderNum, String labelFile, Integer tipoDato, String separatore, String desc, String idsessione) throws Exception {

        DatasetFile dFile = new DatasetFile();

        dFile.setLabelFile(labelFile);
        SxTipoDato tipoD = new SxTipoDato();
        tipoD.setId(tipoDato);
        dFile.setTipoDato(tipoD);
        dFile.setSessioneLavoro(sessioneLavoroDao.findById(Long.parseLong(idsessione)).get());
        dFile.setNomeFile(desc);
        dFile.setFormatoFile("CSV");
        dFile.setSeparatore(separatore);
        dFile.setDataCaricamento(new Date());
        dFile.setNumerorighe(campi.get(valoriHeaderNum.get(0)).size());
        List<DatasetColonna> colonne = new ArrayList<DatasetColonna>();
        short ord = 0;

        for (int i = 0; i < valoriHeaderNum.size(); i++) {
            String kCampi = valoriHeaderNum.get(i);
            ArrayList<String> vals = campi.get(kCampi);
            DatasetColonna dc = new DatasetColonna();
            dc.setDatasetFile(dFile);
            dc.setNome(kCampi.replaceAll("\\.", "_"));
            dc.setOrdine(new Short(ord));
            dc.setValoriSize(vals.size());
            ord += 1;
            dc.setDatiColonna(vals);
            colonne.add(dc);
        }
        dFile.setColonne(colonne);
        dFile = datasetFileDao.save(dFile);

        return dFile;
    }

    public Optional<DatasetColonna> salvaColonna(Optional<DatasetColonna> dcol) throws Exception {

        Optional<DatasetColonna> dC;
        try {
            dC = datasetColonnaDao.save(dcol);
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
        return datasetFileDao.findById(id).get();
    }

    public  List<DatasetFile> findDatasetFilesByIdSessioneLavoro(Long id) {
        return datasetFileDao.findDatasetFilesBySessioneLavoro(new SessioneLavoro(id));
    }

    public DatasetFile findDataSetFileSQL(Long id) {
        DatasetFile df = sqlgenericDao.findGenericDatasetFileOne(id);
        return df;
    }

    public List<DatasetFile> findAllDatasetFileSQL() {
        List<DatasetFile> dataList = sqlgenericDao.findGenericDatasetFileAll();
        return dataList;
    }

    public List<DatasetColonna> findAllDatasetColonnaSQL(Long dFile, Integer rigaInf, Integer rigaSup) {
        List<DatasetColonna> dataList = datasetColonnaDao.findDatasetColonnabyQuery(dFile, rigaInf, rigaSup);
        return dataList;
    }

    public List<DatasetColonna> findAllNomeColonne(Long dFile) {
        return datasetColonnaDao.findNomebyfile(new DatasetFile(dFile));
    }

    public List<DatasetColonna> findAllNomeColonne(DatasetFile dFile) {
        return datasetColonnaDao.findNomebyfile(dFile);
    }

    public Optional<DatasetColonna> findOneColonna(Long dFile) {
        return datasetColonnaDao.findById(dFile);
    }

    public Integer findNumeroRighe(Long dFile) {
        return datasetFileDao.findNumeroRighe(dFile);
    }

    public DataTableBean loadDatasetValori(Long dfile, Integer length, Integer start, Integer draw, HashMap<String, String> parametri, String nameColumnToOrder, String dirColumnOrder) {
        List<DatasetColonna> dataList = sqlgenericDao.findDatasetColonnaParamsbyQuery(dfile, start, start + length, parametri, nameColumnToOrder, dirColumnOrder);
        Integer numRighe = 1;

        DataTableBean db = new DataTableBean();
        db.setDraw(draw);
        db.setRecordsFiltered(numRighe);
        db.setRecordsTotal(numRighe);
        List<Collection<HashMap<String, String>>> tabella = new ArrayList<Collection<HashMap<String, String>>>();

        for (int i = 0; i < dataList.get(0).getDatiColonna().size(); i++) {
            List<HashMap<String, String>> riga = new ArrayList<HashMap<String, String>>();
            for (int j = 0; j < dataList.size(); j++) {
                HashMap<String, String> dato = new HashMap<>();
                dato.put(dataList.get(j).getNome(), dataList.get(j).getDatiColonna().get(i));
                riga.add(dato);
            }
            tabella.add(riga);
        }
        db.setData(tabella);
        return db;
    }

    public String loadDatasetValori1(Long dfile, Integer length, Integer start, Integer draw, HashMap<String, String> parametri, String nameColumnToOrder, String dirColumnOrder) {
        List<DatasetColonna> dataList = sqlgenericDao.findDatasetColonnaParamsbyQuery(dfile, start, start + length, parametri, nameColumnToOrder, dirColumnOrder);

        Integer numRighe = 0;
        JSONArray data = new JSONArray();
        JSONObject obj = new JSONObject();
        if (dataList.size() > 0) {
            numRighe = dataList.get(0).getValoriSize();
            for (int i = 0; i < dataList.get(0).getDatiColonna().size(); i++) {
                JSONObject obji = new JSONObject();
                for (int j = 0; j < dataList.size(); j++) {
                    obji.put(dataList.get(j).getNome(), dataList.get(j).getDatiColonna().get(i));
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

    public List<DatasetColonna> findAllDatasetColonnaQueryFilter(Long dFile, Integer rigaInf, Integer rigaSup, String filterFieldName, String filterFieldValue, List<String> fieldSelect) {
        List<DatasetColonna> dataList = datasetColonnaDao.findDatasetColonnabyQueryFilter(dFile, rigaInf, rigaSup,filterFieldName, filterFieldValue, fieldSelect);
        return dataList;
    }

    public List<TipoVariabileSum> findAllVariabiliSum() {
        Iterable<TipoVariabileSum> variabileSum = variabileSumDao.findAllVariables();
        return (List<TipoVariabileSum>) variabileSum;
    }

    public List<DatasetColonna> findByDatasetFile(DatasetFile idfile) {
        return datasetColonnaDao.findNomebyfile(idfile);

    }

    public Map<String, List<String>> loadDatasetValori(Long idfile) {
        DatasetFile datasetFile = findDataSetFile(idfile);

        Map<String, List<String>> ret = new LinkedHashMap<>();
		for (Iterator<?> iterator = datasetFile.getColonne().iterator(); iterator.hasNext();) {
            DatasetColonna dc = (DatasetColonna) iterator.next();
            ret.put(dc.getNome(), dc.getDatiColonna());
        }
        return ret;
    }
    
    public DatasetFile createField(String idfile, String idColonna, String commandField, String charOrString,  String upperLower, String newField, String columnOrder) {
    	
    	
    	
    	DatasetColonna nuovaColonna = new DatasetColonna();
    	Optional<DatasetColonna> colonna = findOneColonna(Long.parseLong(idColonna));
    	List<String> datiColonna = colonna.get().getDatiColonna();
    	//cambia i valori della colonna
    	List<String> datiColonnaTemp = new ArrayList();
    	//cambia i valori della colonna
    	switch (commandField) 
    	{ 
    		case "0001":
    			if(upperLower.equals("low")){
    			     datiColonna.forEach((item)->datiColonnaTemp.add(item.toLowerCase())); 
    			}else{
    				datiColonna.forEach((item)->datiColonnaTemp.add(item.toUpperCase())); 
    			}
    				
    			

    		     break; 
    		case "0010": 
    			if(!charOrString.equals("")){
	   			     datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll(charOrString, ""))); 
	   			}
    		     break;
    		case "0100": 
    			
    				datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll("[^a-zA-Z0-9]", ""))); 
	   			
    		  	break; 
    		case "1000":  
    				datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll(" ","")));
 		     	break;
    		case "0011":
    			if(upperLower.equals("low")){
		   			datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll(charOrString, "").toLowerCase())); 
		   		}else{
		   			datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll(charOrString, "").toUpperCase())); 
		   		}
    			
   		     	break; 
    		case "0101":
    			
    				
    			if(upperLower.equals("low")){
       			   datiColonna.forEach((item)->datiColonnaTemp.add(item.toLowerCase().replaceAll("[^a-zA-Z0-9]", ""))); 
    			}else{
	       				datiColonna.forEach((item)->datiColonnaTemp.add(item.toUpperCase().replaceAll("[^a-zA-Z0-9]", ""))); 
	       		}
    				
	   			
   		     	break;
    		case "1001":
    			if(upperLower.equals("low")){
	   			     datiColonna.forEach((item)->datiColonnaTemp.add(item.toLowerCase().replaceAll(" ",""))); 
	   			}else{
	   				datiColonna.forEach((item)->datiColonnaTemp.add(item.toUpperCase().replaceAll(" ",""))); 
	   			}
    			
   		  		break; 
    		case "0111":
    			if(!charOrString.equals("")){
    				if(upperLower.equals("low")){
	       			     datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll(charOrString, "").toLowerCase().replaceAll("[^a-zA-Z0-9]", ""))); 
	       			}else{
	       				datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll(charOrString, "").toUpperCase().replaceAll(charOrString, ""))); 
	       			}
	   			    
	   			}
		     	break;
    		case "1011":
    			if(!charOrString.equals("")){
    				if(upperLower.equals("low")){
	       			     datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll(charOrString, "").toLowerCase().replaceAll(" ",""))); 
	       			}else{
	       				datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll(charOrString, "").toUpperCase().replaceAll(" ",""))); 
	       			}
	   			    
	   			}
		     	break;
    		case "0110":
    			if(!charOrString.equals("")){
	   			     datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll(charOrString, "").replaceAll("[^a-zA-Z0-9]", ""))); 
	   			}
		     	break;
    		case "1010":
    			if(!charOrString.equals("")){
	   			     datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll(charOrString, "").replaceAll(" ",""))); 
	   			}
		     	break;
    		case "1100":
    			datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll(" ","").replaceAll("[^a-zA-Z0-9]", "")));
		     	break;
    		case "1101": 
    			if(upperLower.equals("low")){
	   			     datiColonna.forEach((item)->datiColonnaTemp.add(item.toLowerCase().replaceAll(" ","").replaceAll("[^a-zA-Z0-9]", ""))); 
	   			}else{
	   				datiColonna.forEach((item)->datiColonnaTemp.add(item.toUpperCase().replaceAll(" ","").replaceAll("[^a-zA-Z0-9]", ""))); 
	   			}
		     	break;
    		case "1111":
    			if(!charOrString.equals("")){
    				if(upperLower.equals("low")){
	   	   			     datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll(charOrString, "").toLowerCase().replaceAll(" ","").replaceAll("[^a-zA-Z0-9]", ""))); 
	   	   			}else{
	   	   				datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll(charOrString, "").toUpperCase().replaceAll(" ","").replaceAll("[^a-zA-Z0-9]", ""))); 
	   	   			} 
	   			}
		     	break;
    		case "1110":
    			if(!charOrString.equals("")){
	   			     datiColonna.forEach((item)->datiColonnaTemp.add(item.replaceAll(charOrString, "").replaceAll(" ","").replaceAll("[^a-zA-Z0-9]", ""))); 
	   			}
		     	break;
    		case "0000":  
    			datiColonna.forEach((item)->datiColonnaTemp.add(item));
    			
    			break; 	
		     	
 		     
    	  default: 
    		   datiColonna.forEach((item)->datiColonnaTemp.add(item));
    	};
    	
    	//DatasetFile dFile = datasetService.findDataSetFile(idfile);
    	DatasetFile dFile = new DatasetFile();
    	dFile.setId(Long.parseLong(idfile));
    	nuovaColonna.setDatasetFile(dFile);
    	nuovaColonna.setNome(newField);
    	nuovaColonna.setOrdine( (short) Integer.parseInt(columnOrder) );
    	nuovaColonna.setValoriSize(datiColonna.size());
  
    	nuovaColonna.setDatiColonna(datiColonnaTemp);
    	datasetColonna.save(nuovaColonna);
    	
        return dFile;
    }
    
    
    
    
    
    
    @Transactional
    public Boolean deleteDataset(Long idFile) {
        DatasetFile datasetFile = findDataSetFile(idFile);
        datasetColonnaDao.deleteByDatasetFile(datasetFile);
        datasetFileDao.deleteDatasetFile(datasetFile.getId());
        return true;
    }
}
