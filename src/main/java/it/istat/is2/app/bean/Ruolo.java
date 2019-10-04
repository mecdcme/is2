package it.istat.is2.app.bean;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class Ruolo implements Serializable {

	private static final long serialVersionUID = -82732477292756353L;

	private  long idRole;
	
	private String name;
	
	private List<Variable> variables;
}
