package it.istat.is2.catalogue.relais.metrics.utility;

import java.io.Serializable;

public final class AffineGap5_1 extends AbstractAffineGapCost implements Serializable {

	private static final long serialVersionUID = 1L;

    public final String getShortDescriptionString() {
        return "AffineGap5_1";
    }

    public final float getCost(final String stringToGap, final int stringIndexStartGap, final int stringIndexEndGap) {
        if (stringIndexStartGap >= stringIndexEndGap) {
            return 0.0f;
        } else {
            return 5.0f + ((stringIndexEndGap - 1) - stringIndexStartGap);
        }
    }

    public final float getMaxCost() {
        return 5.0f;
    }

    public final float getMinCost() {
        return 0.0f;
    }
}


