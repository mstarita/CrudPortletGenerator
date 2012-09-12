package ${packageName};

import java.io.Serializable;

import ${viewUtilPackage}.FormOperation;

<#list importList as import>
import ${import};
</#list>

public class Registry${className}ModelBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private FormOperation formOperation;
	private ${className} ${entityName} = new ${className}();

	public void setFormOperation(final FormOperation formOperation) {
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
