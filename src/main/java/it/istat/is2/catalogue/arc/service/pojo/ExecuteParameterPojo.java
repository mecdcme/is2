package it.istat.is2.catalogue.arc.service.pojo;

import java.util.Arrays;
import java.util.List;

import com.kenai.jffi.Array;

import it.istat.is2.catalogue.arc.service.TraitementPhase;

/**
 * Parameters for ARC steps execution
 * @author MS
 *
 */
public class ExecuteParameterPojo {

	// nom du fichier
	public String fileName;
	
	// contenu du fichier
	public String fileContent;

	// environnement d'execution
	public String sandbox;
	
	// repertoire de dépot de fichier
	public String warehouse;
	
	// n° de la phase à atteindre
	public String targetPhase;

	// Type d'invoquation : SERVICE ou ENGINE
	public String serviceType;
	
	// norme (~version)
	public String norme;
	
	// validite
	public String validite;
	
	// periodicite
	public String periodicite;
	
	// liste des requete à exécuter
	public List<ExecuteQueryPojo> queries;


	
	public ExecuteParameterPojo() {
		super();
	}
	
	
	public ExecuteParameterPojo(String sandbox, TraitementPhase targetPhase) {
		super();
		this.sandbox = sandbox;
		this.targetPhase = targetPhase.toString();
	}
	
	public ExecuteParameterPojo(String sandbox, TraitementPhase targetPhase, ExecuteQueryPojo...queries) {
		super();
		this.sandbox = sandbox;
		this.targetPhase = targetPhase.toString();
		this.queries=Arrays.asList(queries);
	}

	public ExecuteParameterPojo(String sandbox, TraitementPhase targetPhase, List<ExecuteQueryPojo> queries) {
		super();
		this.sandbox = sandbox;
		this.targetPhase = targetPhase.toString();
		this.queries=queries;
	}

	public ExecuteParameterPojo(String sandbox, TraitementPhase targetPhase, String fileName, String fileContent) {
		super();
		this.fileName = fileName;
		this.fileContent = fileContent;
		this.sandbox = sandbox;
		this.targetPhase = targetPhase.toString();
	}




	public String getSandbox() {
		return sandbox;
	}
	public void setSandbox(String sandbox) {
		this.sandbox = sandbox;
	}
	public String getTargetPhase() {
		return targetPhase;
	}
	public void setTargetPhase(String targetPhase) {
		this.targetPhase = targetPhase;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getVersion() {
		return norme;
	}
	public void setVersion(String version) {
		this.norme = version;
	}
	public String getValidite() {
		return validite;
	}
	public void setValidite(String validite) {
		this.validite = validite;
	}
	public String getPeriodicite() {
		return periodicite;
	}
	public void setPeriodicite(String periodicite) {
		this.periodicite = periodicite;
	}
	public List<ExecuteQueryPojo> getQueries() {
		return queries;
	}
	public void setQueries(List<ExecuteQueryPojo> queries) {
		this.queries = queries;
	}
	public String getFileContent() {
		return fileContent;
	}
	public void setFileContent(String fileContent) {
		this.fileContent = fileContent;
	}
	public String getServiceType() {
		return serviceType;
	}
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	public String getWarehouse() {
		return warehouse;
	}
	public void setWarehouse(String warehouse) {
		this.warehouse = warehouse;
	}
	public String getNorme() {
		return norme;
	}
	public void setNorme(String norme) {
		this.norme = norme;
	}

}
