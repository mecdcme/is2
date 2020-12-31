package it.istat.is2.catalogue.arc.service.view;

import java.util.Map;

public class DataSetView {

	private int datasetId;
	
	private String datasetName;

	private Map<String,Record> content;
	
	
	public DataSetView(int datasetId, String datasetName, Map<String, Record> content) {
		super();
		this.datasetId = datasetId;
		this.datasetName = datasetName;
		this.content = content;
	}

	public DataSetView()
	{
		super();
	}
	
	public int getDatasetId() {
		return datasetId;
	}

	public void setDatasetId(int datasetId) {
		this.datasetId = datasetId;
	}

	public String getDatasetName() {
		return datasetName;
	}

	public void setDatasetName(String datasetName) {
		this.datasetName = datasetName;
	}

	public Map<String, Record> getContent() {
		return content;
	}

	public void setContent(Map<String, Record> content) {
		this.content = content;
	}

	
   
   
   
}
