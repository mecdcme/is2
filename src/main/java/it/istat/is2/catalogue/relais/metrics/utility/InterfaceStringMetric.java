package it.istat.is2.catalogue.relais.metrics.utility;

public interface InterfaceStringMetric {

    public String getShortDescriptionString();

    public String getLongDescriptionString();

    public long getSimilarityTimingActual(String string1, String string2);

    public float getSimilarityTimingEstimated(String string1, String string2);

    public float getSimilarity(String string1, String string2);

    public String getSimilarityExplained(String string1, String string2);
}
