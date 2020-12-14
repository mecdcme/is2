package it.istat.is2.catalogue.relais.metrics.utility;

public abstract class AbstractSubstitutionCost implements InterfaceSubstitutionCost {

    public abstract String getShortDescriptionString();

    public abstract float getCost(StringBuilder str1, int string1Index, StringBuilder str2, int string2Index);

    public abstract float getMaxCost();

    public abstract float getMinCost();
}
