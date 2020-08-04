package it.istat.is2.app.bean;

import java.io.Serializable;

import lombok.Data;

@Data
public class Variable implements Serializable {

    private static final long serialVersionUID = -6635854952805663441L;

    private long idVar;

    private String name;
}
