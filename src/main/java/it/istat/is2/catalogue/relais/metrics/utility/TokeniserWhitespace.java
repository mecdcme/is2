package it.istat.is2.catalogue.relais.metrics.utility;

import java.util.HashSet;
import java.util.Set;
import java.util.ArrayList;
import java.io.Serializable;

public final class TokeniserWhitespace implements InterfaceTokeniser, Serializable {

    private static final long serialVersionUID = 1L;

    private InterfaceTermHandler stopWordHandler = new DummyStopTermHandler();

    private final String delimiters = "\r\n\t \u00A0";

    public final String getShortDescriptionString() {
        return "TokeniserWhitespace";
    }

    public final String getDelimiters() {
        return delimiters;
    }

    public InterfaceTermHandler getStopWordHandler() {
        return stopWordHandler;
    }

    public void setStopWordHandler(final InterfaceTermHandler stopWordHandler) {
        this.stopWordHandler = stopWordHandler;
    }

    public final ArrayList<String> tokenizeToArrayList(final StringBuilder input) {
        final ArrayList<String> returnVect = new ArrayList<String>();
        int curPos = 0;
        while (curPos < input.length()) {
            final char ch = input.charAt(curPos);
            if (Character.isWhitespace(ch)) {
                curPos++;
            }
            int nextGapPos = input.length();
            for (int i = 0; i < delimiters.length(); i++) {
                final int testPos = input.indexOf(delimiters.substring(i,i+1), curPos);
                if (testPos < nextGapPos && testPos != -1) {
                    nextGapPos = testPos;
                }
            }
            final String term = input.substring(curPos, nextGapPos);
            if (!stopWordHandler.isWord(term) && !term.trim().equals("")) {
                returnVect.add(term);
            }
            curPos = nextGapPos;
        }

        return returnVect;
    }

    public Set<String> tokenizeToSet(final StringBuilder input) {
        final Set<String> returnSet = new HashSet<String>();
        returnSet.addAll(tokenizeToArrayList(input));
        return returnSet;
    }
}
