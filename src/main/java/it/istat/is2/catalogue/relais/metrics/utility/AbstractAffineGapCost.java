package it.istat.is2.catalogue.relais.metrics.utility;

public abstract class AbstractAffineGapCost implements InterfaceAffineGapCost {

    public abstract String getShortDescriptionString();

    public abstract float getCost(String stringToGap, int stringIndexStartGap, int stringIndexEndGap);

    public abstract float getMaxCost();

    public abstract float getMinCost();
}

