package it.istat.is2.catalogue.relais.metrics;

import java.io.Serializable;

import it.istat.is2.catalogue.relais.metrics.utility.InterfaceTokeniser;
import it.istat.is2.catalogue.relais.metrics.utility.MongeElkan;

public final class ChapmanMatchingSoundex extends MongeElkan implements Serializable {

	private static final long serialVersionUID = 1L;
   public ChapmanMatchingSoundex() {
        super(new Soundex());
    }

    public ChapmanMatchingSoundex(final InterfaceTokeniser tokeniserToUse) {
        super(tokeniserToUse, new Soundex());
    }

    public String getShortDescriptionString() {
        return "ChapmanMatchingSoundex";
    }

    public String getLongDescriptionString() {
        return "Implements the Chapman Matching Soundex algorithm whereby terms are matched and tested against the standard soundex algorithm - this is intended to provide a better rating for lists of proper names.";
    }

    public String getSimilarityExplained(String string1, String string2) {
        return null;  
    }

}


