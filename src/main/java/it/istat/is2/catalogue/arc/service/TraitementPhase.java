package it.istat.is2.catalogue.arc.service;

import java.util.ArrayList;
import java.util.List;

public enum TraitementPhase {
    DUMMY(-1, 1), INITIALISATION(0, 1000000), RECEPTION(1, 1000000), CHARGEMENT(2, 1000000), NORMAGE(3, 1000000)
    , CONTROLE(4, 1000000), FILTRAGE(5, 1000000), MAPPING(6, 1000000);
    private TraitementPhase(int anOrdre, int aNbLigneATraiter) {
        this.ordre = anOrdre;
        this.nbLigneATraiter = aNbLigneATraiter;
    }

    private int ordre;
    private int nbLigneATraiter;

    public int getOrdre() {
        return this.ordre;
    }

    public int getNbLigneATraiter() {
        return this.nbLigneATraiter;
    }

    /**
     * Renvoie la phase en fonction de l'ordre
     * 
     * @param ordre
     *            , numéro d'ordre dans l'énumération (premier=1)
     * @return
     */
    public static TraitementPhase getPhase(int ordre) {
        for (TraitementPhase phase : TraitementPhase.values()) {
            if (phase.getOrdre() == ordre) {
                return phase;
            }
        }
        return null;
    }
    
    
	
	public static TraitementPhase getPhase(String s)
	{
		try {
			int p=Integer.parseInt(s);
			return getPhase(p);
		}
		catch(Exception e)
		{
			return TraitementPhase.valueOf(s);
		}
	}
	

    /**
     * Renvoie une liste des phases qui sont postérieures à une phase donnée
     * 
     * @return
     */
    public ArrayList<TraitementPhase> nextPhases() {
        ArrayList<TraitementPhase> listPhase = new ArrayList<>();
        for (TraitementPhase phase : TraitementPhase.values()) {
            if (phase.getOrdre() > ordre) {
                listPhase.add(phase);
            }
        }
        return listPhase;
    }

    /**
     * Renvoie la phase précédente ou null
     * 
     * @return
     */
    public TraitementPhase previousPhase() {
        TraitementPhase phase = null;
        int i = this.getOrdre();
        phase = getPhase(i - 1);
        return phase;
    }
    
    /**
     * Renvoie la phase précédente ou null
     * 
     * @return
     */
    public TraitementPhase nextPhase() {
        TraitementPhase phase = null;
        int i = this.getOrdre();
        phase = getPhase(i + 1);
        return phase;
    }

	
	public static List<TraitementPhase> getListPhaseC() {
		List<TraitementPhase> listePhaseC = new ArrayList<>();
		for (TraitementPhase t : values()) {
			if (t.getOrdre()>=0) {
				listePhaseC.add(t);
			}
		}
		return listePhaseC;
	}

}
