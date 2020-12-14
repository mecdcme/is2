package it.istat.is2.catalogue.relais.metrics.utility;

public interface InterfaceStringMetric {

    public String getShortDescriptionString();

    public String getLongDescriptionString();

    public long getSimilarityTimingActual(final StringBuilder string1, final StringBuilder string2);

    public float getSimilarityTimingEstimated(final StringBuilder string1, final StringBuilder string2);

    public float getSimilarity(final StringBuilder string1, final StringBuilder string2);

    public String getSimilarityExplained(final StringBuilder string1, final StringBuilder string2);
}
