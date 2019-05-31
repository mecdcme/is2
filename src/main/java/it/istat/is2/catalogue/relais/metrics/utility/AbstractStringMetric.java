package it.istat.is2.catalogue.relais.metrics.utility;

public abstract class AbstractStringMetric implements InterfaceStringMetric {

    public abstract String getShortDescriptionString();

    public abstract String getLongDescriptionString();

    public abstract String getSimilarityExplained(String string1, String string2);

    public final long getSimilarityTimingActual(final String string1, final String string2) {
        final long timeBefore = System.currentTimeMillis();
        getSimilarity(string1, string2);
        final long timeAfter = System.currentTimeMillis();
        return timeAfter - timeBefore;
    }

    public final float[] batchCompareSet(final String[] set, final String comparator) {
        final float[] results = new float[set.length];
        for(int strNum=0; strNum<set.length; strNum++) {
            results[strNum] = getSimilarity(set[strNum],comparator);
        }
        return results;
    }

    public final float[] batchCompareSets(final String[] firstSet, final String[] secondSet) {
        final float[] results;
        if(firstSet.length <= secondSet.length) {
            results = new float[firstSet.length];
        } else {
            results = new float[secondSet.length];
        }
        for(int strNum=0; strNum<results.length; strNum++) {
            results[strNum] = getSimilarity(firstSet[strNum],secondSet[strNum]);
        }
        return results;
    }

    public abstract float getSimilarityTimingEstimated(final String string1, final String string2);

    public abstract float getSimilarity(String string1, String string2);

    public abstract float getUnNormalisedSimilarity(String string1, String string2);
}
