package it.istat.is2.catalogue.relais.metrics.dataStructure;

import java.io.Serializable;

import lombok.Data;

@Data
public class MetricMatchingVariable implements Serializable {
    /**
     *
     */
    private static final long serialVersionUID = -3572357492452271885L;
    private String matchingVariable;
    private String matchingVariableNameVariableA;
    private String matchingVariableNameVariableB;
    private String comparisonFunction;
    private Float metricThreshold;
    private int windowSize;

    public MetricMatchingVariable() {
        this.metricThreshold = 1.0f;
        this.windowSize = 1;
    }

    public MetricMatchingVariable(String matchingVariable, String matchingVariableNameVariableA, String matchingVariableNameVariableB, String comparisonFunction, Float metricThreshold, Integer windowSize) {
        this.matchingVariable = matchingVariable;
        this.matchingVariableNameVariableA = matchingVariableNameVariableA;
        this.matchingVariableNameVariableB = matchingVariableNameVariableB;
        this.comparisonFunction = comparisonFunction;
        this.metricThreshold = metricThreshold != null ? metricThreshold : 1;
        this.windowSize = windowSize != null ? windowSize : 1;
    }


}
