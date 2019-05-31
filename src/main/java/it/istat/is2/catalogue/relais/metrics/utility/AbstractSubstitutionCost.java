package it.istat.is2.catalogue.relais.metrics.utility;

public abstract class AbstractSubstitutionCost implements InterfaceSubstitutionCost {

    public abstract String getShortDescriptionString();

    public abstract float getCost(String str1, int string1Index, String str2, int string2Index);

    public abstract float getMaxCost();

    public abstract float getMinCost();
}
