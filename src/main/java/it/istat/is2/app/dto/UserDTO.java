package it.istat.is2.app.dto;

import lombok.Data;

@Data
public class UserDTO {

	private Long id;
	private String email;
	private String name;
	private String surname;
	private UserRoleDTO role;

}
