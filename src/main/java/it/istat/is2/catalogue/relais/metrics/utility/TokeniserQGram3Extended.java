package it.istat.is2.catalogue.relais.metrics.utility;

import java.util.HashSet;
import java.util.Set;
import java.util.ArrayList;
import java.io.Serializable;

public final class TokeniserQGram3Extended implements InterfaceTokeniser, Serializable {

    private static final long serialVersionUID = 1L;

    private InterfaceTermHandler stopWordHandler = new DummyStopTermHandler();

    private final char QGRAMSTARTPADDING = '#';

    private final char QGRAMENDPADDING = '#';

    public final String getShortDescriptionString() {
        return "TokeniserQGram3Extended";
    }

    public final String getDelimiters() {
        return "";
    }

    public final ArrayList<String> tokenizeToArrayList(final String input) {
        final ArrayList<String> returnVect = new ArrayList<String>();
        final StringBuffer adjustedString = new StringBuffer();
        adjustedString.append(QGRAMSTARTPADDING);
        adjustedString.append(QGRAMSTARTPADDING);
        adjustedString.append(input);
        adjustedString.append(QGRAMENDPADDING);
        adjustedString.append(QGRAMENDPADDING);
        int curPos = 0;
        final int length = adjustedString.length() - 2;
        while (curPos < length) {
            final String term = adjustedString.substring(curPos, curPos + 3);
            if (!stopWordHandler.isWord(term)) {
                returnVect.add(term);
            }
            curPos++;
        }

        return returnVect;
    }

    public InterfaceTermHandler getStopWordHandler() {
        return stopWordHandler;
    }

    public void setStopWordHandler(final InterfaceTermHandler stopWordHandler) {
        this.stopWordHandler = stopWordHandler;
    }

    public Set<String> tokenizeToSet(final String input) {
        final Set<String> returnSet = new HashSet<String>();
        returnSet.addAll(tokenizeToArrayList(input));
        return returnSet;
    }
}

