package it.istat.is2.catalogue.arc.service.pojo;

public enum SetRulesActionEnum {

	// add or update some rules with the provided ones
	U("UPDATE")
	
	// replace all the rules with the provided ones
	, R("REPLACE")
	
	// delete the rules provided
	, D("DELETE")
	
	// delete all the rules. Clear the table
	, C("CLEAR")
	
	;
	
	private String action;

	SetRulesActionEnum(String action) {
		this.action=action;
	}

	public String getAction() {
		return action;
	}

	
}
