package it.istat.is2.catalogue.relais.metrics.utility;

import java.util.List;

public abstract class AbstractStringMetric implements InterfaceStringMetric {

    public abstract String getShortDescriptionString();

    public abstract String getLongDescriptionString();

    public abstract String getSimilarityExplained(final StringBuilder string1, final StringBuilder string2);
    
    public void prepareMap(List<String> stringList) {
    }

    public final long getSimilarityTimingActual(final StringBuilder string1, final StringBuilder string2) {
        final long timeBefore = System.currentTimeMillis();
        getSimilarity(string1, string2);
        final long timeAfter = System.currentTimeMillis();
        return timeAfter - timeBefore;
    }

    public final float[] batchCompareSet(final StringBuilder[] set, final StringBuilder comparator) {
        final float[] results = new float[set.length];
        for (int strNum = 0; strNum < set.length; strNum++) {
            results[strNum] = getSimilarity(set[strNum], comparator);
        }
        return results;
    }

    public final float[] batchCompareSets(final StringBuilder[] firstSet, final StringBuilder[] secondSet) {
        final float[] results;
        if (firstSet.length <= secondSet.length) {
            results = new float[firstSet.length];
        } else {
            results = new float[secondSet.length];
        }
        for (int strNum = 0; strNum < results.length; strNum++) {
            results[strNum] = getSimilarity(firstSet[strNum], secondSet[strNum]);
        }
        return results;
    }

    public abstract float getSimilarityTimingEstimated(final StringBuilder string1, final StringBuilder string2);

    public abstract float getSimilarity(final StringBuilder string1, final StringBuilder string2);

    public abstract float getUnNormalisedSimilarity(final StringBuilder string1, final StringBuilder string2);
}
