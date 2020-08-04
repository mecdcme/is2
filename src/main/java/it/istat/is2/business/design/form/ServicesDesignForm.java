package it.istat.is2.business.design.form;

import lombok.Data;

@Data
public class ServicesDesignForm {


    private String nameb;
    private String decriptionb;
    private Long gsbpmidparent;
    private Long gsbpmid;
    private String namea;
    private String decriptiona;
    private String language;
    private String engine;
    private String soucepath;
    private String sourcecode;
    private String author;
    private String licence;
    private String contact;
    private Long idbservice;
    private String method;
    private String descriptions;
    private String label;
    private Long appserviceid;


    public String toString() {
        return "Nome bs: " + this.nameb + ", nome desc bs: " + this.decriptionb + ", gsbpm parent: " + this.gsbpmidparent + ", gsbpm process: " + this.gsbpmid;
    }
}