package it.istat.is2.catalogue.relais.metrics.utility;

public interface InterfaceSubstitutionCost {

    public String getShortDescriptionString();

    public float getCost(String str1, int string1Index, String str2, int string2Index);

    public float getMaxCost();

    public float getMinCost();
}
