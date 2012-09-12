package ${packageName};

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.vaadin.data.util.BeanContainer;
import com.vaadin.data.util.BeanItem;

<#list importList as import>
import ${import};
</#list>

public class Search${className}ModelBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private BeanItem<${className}> ${entityName}Search;
	
	private BeanContainer<Long, ${className}> ${entityName}ListBC;
	
	public Search${className}ModelBean() {

		${entityName}Search = new BeanItem<${className}>(new ${className}());
		
		${entityName}ListBC = new BeanContainer<Long, ${className}>(${className}.class);
		${entityName}ListBC.setBeanIdProperty("${keyField}");
		
	}
	
	public void resetSearch${className}() {
<#list fieldList as field>		
		${entityName}Search.getItemProperty("${field.fieldName}").setValue(null);
</#list>

	}
	
	public void setSearch${className}(${className} ${entityName}) {
<#list fieldList as field>
		${entityName}Search.getItemProperty("${field.fieldName}").setValue(${entityName}.get${field.fieldName?cap_first}());
</#list>		
		
	}
	
	public void set${className}ListBC(List<${className}> ${entityName}List) {

		this.${entityName}ListBC.removeAllItems();
		this.${entityName}ListBC.addAll(${entityName}List);
		
	}
	
	public BeanItem<${className}> get${className}Search() {
		
		return ${entityName}Search;
		
	}
	
	public BeanContainer<Long, ${className}> get${className}ListBC() {
		
		return ${entityName}ListBC;
		
	}

	public List<${className}> get${className}List() {
		List<${className}> ${entityName}List = new ArrayList<${className}>();
		
		for (Long id : ${entityName}ListBC.getItemIds()) {
			${entityName}List.add(${entityName}ListBC.getItem(id).getBean());
		}
		
		return ${entityName}List;
	}
}
