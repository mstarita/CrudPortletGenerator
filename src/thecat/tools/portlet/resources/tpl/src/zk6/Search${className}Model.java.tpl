package ${packageName};

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

<#list importList as import>
import ${import};
</#list>

public class Search${className}Model implements Serializable {

	private static final long serialVersionUID = 1L;
	
	public static final String SEARCH_MODEL_KEY_ATTR = "search${className}Model";
	
	private ${className} search${className} = new ${className}();
	private List<${className}> ${entityName}List = new ArrayList<${className}>();
	
	private boolean showConfirmDelete = false;
	private ${className} ${entityName}ToDelete = null;
	
	private String infoMessage;
	private String errorMessage;
	
	public void setSearch${className}(final ${className} search${className}) {
		this.search${className} = search${className};
	}
	public ${className} getSearch${className}() {
		return search${className};
	}
	
	public void set${className}List(final List<${className}> ${entityName}List) {
		this.${entityName}List = ${entityName}List;
	}
	
	public List<${className}> get${className}List() {
		return ${entityName}List;
	}
	
	public String getInfoMessage() {
		return infoMessage;
	}

	public void setInfoMessage(String infoMessage) {
		this.infoMessage = infoMessage;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	
	public boolean isShowConfirmDelete() {
		return showConfirmDelete;
	}
	
	public void setShowConfirmDelete(boolean showConfirmDelete) {
		this.showConfirmDelete = showConfirmDelete;
	}
	
	public ${className} get${className}ToDelete() {
		return ${entityName}ToDelete;
	}
	
	public void set${className}ToDelete(${className} ${entityName}ToDelete) {
		this.${entityName}ToDelete = ${entityName}ToDelete;
	}
	
}
