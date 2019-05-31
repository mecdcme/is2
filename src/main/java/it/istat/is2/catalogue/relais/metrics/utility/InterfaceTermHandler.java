package it.istat.is2.catalogue.relais.metrics.utility;

import java.io.Serializable;

public interface InterfaceTermHandler extends Serializable {

    public void addWord(String termToAdd);

    public void removeWord(String termToRemove);

    public String getShortDescriptionString();

    public int getNumberOfWords();

    public boolean isWord(final String termToTest);

    public StringBuffer getWordsAsBuffer();

}
