package it.istat.is2.catalogue.relais.metrics.dataStructure;

import lombok.Data;

@Data
public class MetricMatchingVariable {
	private String matchingVariable;
	private String matchingVariableNameVariableA;
	private String matchingVariableNameVariableB;
	private String comparisonFunction;
	private double metricThreshold;
    private int windowSize;
	
	public MetricMatchingVariable(){
		this.metricThreshold = 1.0;
         this.windowSize=0;
	}
	
	public MetricMatchingVariable(String matchingVariable,String matchingVariableNameVariableA,String matchingVariableNameVariableB, String comparisonFunction, double metricThreshold){
		this.matchingVariable = matchingVariable;
		this.matchingVariableNameVariableA = matchingVariableNameVariableA;
		this.matchingVariableNameVariableB = matchingVariableNameVariableB;
		this.comparisonFunction = comparisonFunction;
		this.metricThreshold = metricThreshold;
        this.windowSize = 0;
	}

	 
}
