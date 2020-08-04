package it.istat.is2.app.bean;

import java.io.Serializable;

import lombok.Data;

@Data
public class AssociazioneVarRoleBean implements Serializable {

    private static final long serialVersionUID = -2958429959646099157L;

    private long idElaborazione;
    private Ruolo ruolo;
    private boolean prefixDataset;

}
