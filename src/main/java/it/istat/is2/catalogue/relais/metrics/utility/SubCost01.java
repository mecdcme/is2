package it.istat.is2.catalogue.relais.metrics.utility;

import java.io.Serializable;

final public class SubCost01 extends AbstractSubstitutionCost implements Serializable {

    private static final long serialVersionUID = 1L;

    public final String getShortDescriptionString() {
        return "SubCost01";
    }

    public final float getCost(final StringBuilder str1, final int string1Index, final StringBuilder str2, final int string2Index) {
        if (str1.charAt(string1Index) == str2.charAt(string2Index)) {
            return 0.0f;
        } else {
            return 1.0f;
        }
    }

    public final float getMaxCost() {
        return 1.0f;
    }

    public final float getMinCost() {
        return 0.0f;
    }
}
