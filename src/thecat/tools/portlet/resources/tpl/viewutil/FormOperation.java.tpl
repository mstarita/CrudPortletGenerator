package ${viewUtilPackage};

import java.io.Serializable;

public enum FormOperation implements Serializable {
	UNDEFINED("undefined"), 
	NEW("new"), 
	EDIT("edit"), 
	SHOW("show");
	
	private static final long serialVersionUID = 1L;
	
	private final String lowerCase;
	
	FormOperation(final String lowerCase) {
		this.lowerCase = lowerCase;
	}
	
	public String getLowerCase() {
		return lowerCase;
	}
}
