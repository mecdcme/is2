package it.istat.is2.catalogue.relais.metrics.utility;

import java.io.Serializable;

public final class SubCost1_Minus2 extends AbstractSubstitutionCost implements Serializable {

	private static final long serialVersionUID = 1L;

    public final String getShortDescriptionString() {
        return "SubCost1_Minus2";
    }

    public final float getCost(final String str1, final int string1Index, final String str2, final int string2Index) {
        if (str1.length() <= string1Index || string1Index < 0) {
            return 0;
        }
        if (str2.length() <= string2Index || string2Index < 0) {
            return 0;
        }

        if (str1.charAt(string1Index) == str2.charAt(string2Index)) {
            return 1.0f;
        } else {
            return -2.0f;
        }
    }

    public final float getMaxCost() {
        return 1.0f;
    }

    public final float getMinCost() {
        return -2.0f;
    }
}

