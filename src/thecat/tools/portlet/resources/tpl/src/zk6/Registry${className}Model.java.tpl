package ${packageName};

import java.io.Serializable;

import ${viewUtilPackage}.FormOperation;

<#list importList as import>
import ${import};
</#list>

public class Registry${className}Model implements Serializable {

	private static final long serialVersionUID = 1L;
	
	public static final String REGISTRY_MODEL_KEY_ATTR = "registry${className}Model";
	
	private FormOperation formOperation = FormOperation.NEW;
	private ${className} ${entityName} = new ${className}();
	
	public void setFormOperation(FormOperation formOperation) {
		this.formOperation = formOperation;
	}

	public FormOperation getFormOperation() {
		return formOperation;
	}
	
	public void set${className}(${className} ${entityName}) {
		this.${entityName} = ${entityName};
	}

	public ${className} get${className}() {
		return ${entityName};
	}

}
