package it.istat.is2.app.dto;

public class UserRoleDTO {

	private Long id;
	private String role;

	public String getRole() {
		return role.replace("ROLE_", "");
	}

	public void setRole(String role) {
		this.role = role;
	}

	@Override
	public String toString() {
		return role.replace("ROLE_", "");
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
