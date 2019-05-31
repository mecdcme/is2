package it.istat.is2.catalogue.relais.metrics.utility;

import java.util.Set;
import java.util.ArrayList;

public interface InterfaceTokeniser {

    public String getShortDescriptionString();

    public String getDelimiters();

    public InterfaceTermHandler getStopWordHandler();

    public void setStopWordHandler(InterfaceTermHandler stopWordHandler);

    public ArrayList<String> tokenizeToArrayList(String input);

    public Set<String> tokenizeToSet(String input);
}

