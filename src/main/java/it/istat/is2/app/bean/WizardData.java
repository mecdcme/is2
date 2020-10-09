package it.istat.is2.app.bean;

import java.io.Serializable;

import lombok.Data;

@Data
public class WizardData implements Serializable {

    private static final long serialVersionUID = 1L;

    private String idfunction;
    private String namefunction;
    private String descfunction;
    private String labelfunction;
    private String idproc;
    private String nameproc;
    private String descproc;
    private String labelproc;
    private String idsubproc;
    private String namesubproc;
    private String descsubproc;
    private String labelsubproc;
    private String namestep;
    private String descstep;
    private String idservice;


}
