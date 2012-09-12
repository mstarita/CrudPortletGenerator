package thecat.model.businessobject;

import java.io.Serializable;

public class Person implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id;
	private String firstname;
	private String lastname;
	private String address;

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress() {
		return address;
	}
	
}
