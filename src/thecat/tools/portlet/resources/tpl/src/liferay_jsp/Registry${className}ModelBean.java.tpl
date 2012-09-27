package ${packageName};

import java.io.Serializable;

import ${viewUtilPackage}.FormOperation;

import ${fqClassName};

public class Registry${className}ModelBean implements Serializable {

	private static final long serialVersionUID = 1L;

<#list fieldList as field>
	public static final String REGISTRY_FIELD_${field.fieldName?upper_case} = "registry${field.fieldName?cap_first}";
</#list>
	
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
