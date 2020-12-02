package it.istat.is2.catalogue.relais.metrics.utility;

public interface InterfaceSubstitutionCost {

    public String getShortDescriptionString();

    public float getCost(StringBuilder str1, int string1Index, StringBuilder str2, int string2Index);

    public float getMaxCost();

    public float getMinCost();
}
