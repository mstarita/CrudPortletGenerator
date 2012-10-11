package thecat.model.businessobject;

import java.io.Serializable;

public class Vehicle implements Serializable {

	private static final long serialVersionUID = 1L;

	private String code;
	private String manifacturer;
	private String model;
	private String traction;
	private Long nWheels;
	private Long maxOccupants;
	private String spare;

	public Vehicle() { }
	
	public Vehicle(String code) {
		this.code = code;
	}
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getManifacturer() {
		return manifacturer;
	}
	public void setManifacturer(String manifacturer) {
		this.manifacturer = manifacturer;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getTraction() {
		return traction;
	}
	public void setTraction(String traction) {
		this.traction = traction;
	}
	public Long getNWheels() {
		return nWheels;
	}
	public void setNWheels(Long nWheels) {
		this.nWheels = nWheels;
	}
	public Long getMaxOccupants() {
		return maxOccupants;
	}
	public void setMaxOccupants(Long maxOccupants) {
		this.maxOccupants = maxOccupants;
	}
	public String getSpare() {
		return spare;
	}
	public void setSpare(String spare) {
		this.spare = spare;
	}
	
}
