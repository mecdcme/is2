package it.istat.is2.catalogue.relais.metrics.utility;

public interface InterfaceAffineGapCost {

    public String getShortDescriptionString();

    public float getCost(String stringToGap, int stringIndexStartGap, int stringIndexEndGap);

    public float getMaxCost();

    public float getMinCost();
}

