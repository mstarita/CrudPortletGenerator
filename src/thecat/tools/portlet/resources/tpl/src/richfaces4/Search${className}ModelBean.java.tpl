package ${packageName};

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.richfaces.component.SortOrder;

import com.liferay.faces.portal.el.I18N;

<#list importList as import>
import ${import};
</#list>

public class Search${className}ModelBean implements Serializable {

	private static final long serialVersionUID = 1L;

	private ${className} search${className} = new ${className}();
	private List<${className}> ${entityName}List = new ArrayList<${className}>();
	
	private transient I18N i18n;
	
<#list fieldList as field>
	private SortOrder ${field.fieldName}Order = SortOrder.unsorted;
</#list>
		
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

<#list fieldList as field>	
	public SortOrder get${field.fieldName?cap_first}Order() {
		return ${field.fieldName}Order;
	}

	public void set${field.fieldName?cap_first}Order(SortOrder ${field.fieldName}Order) {
		this.${field.fieldName}Order = ${field.fieldName}Order;
	}
	
</#list>
	
	public void setI18n(I18N i18n) {
		this.i18n = i18n;
	}

	public I18N getI18n() {
		return i18n;
	}
}
