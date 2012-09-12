package ${packageName};

import java.io.Serializable;

import ${viewUtilPackage}.FormOperation;

import com.vaadin.data.util.BeanItem;
import com.vaadin.data.util.ObjectProperty;

<#list importList as import>
import ${import};
</#list>

public class Registry${className}ModelBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private BeanItem<${className}> ${entityName};
	
	private ObjectProperty<FormOperation> formOperation;
	
	public Registry${className}ModelBean() {
		${entityName} = new BeanItem<${className}>(new ${className}());
		formOperation = new ObjectProperty<FormOperation>(FormOperation.SHOW);
	}
	
	public void set${className}(${className} ${entityName}) {
<#list fieldList as field>	
		this.person.getItemProperty("${field.fieldName}").setValue(person.get${field.fieldName?cap_first}());
</#list>
	}
	
	public BeanItem<${className}> get${className}() {
		return ${entityName};
	}
	
	public void reset${className}() {
<#list fieldList as field>	
		${entityName}.getItemProperty("${field.fieldName}").setValue(null);
</#list>
	}
	
	public ObjectProperty<FormOperation> getFormOperation() {
		return formOperation;
	}
	
	public void setFormOperation(FormOperation formOperation) {
		this.formOperation.setValue(formOperation);
	}
	
}
