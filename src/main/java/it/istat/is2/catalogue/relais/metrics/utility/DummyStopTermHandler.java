package it.istat.is2.catalogue.relais.metrics.utility;

public final class DummyStopTermHandler implements InterfaceTermHandler {

    private static final long serialVersionUID = 1L;

    public void addWord(final String termToAdd) {
    }

    public final String getShortDescriptionString() {
        return "DummyStopTermHandler";
    }

    public void removeWord(final String termToRemove) {
    }

    public int getNumberOfWords() {
        return 0;
    }

    public boolean isWord(final String termToTest) {
        return false;
    }

    public StringBuffer getWordsAsBuffer() {
        return new StringBuffer();
    }
}
