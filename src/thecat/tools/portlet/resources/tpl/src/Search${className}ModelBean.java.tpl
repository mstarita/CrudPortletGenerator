package ${packageName};

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.portlet.PortletPreferences;

import org.josql.Query;
import org.josql.QueryResults;

import ${viewUtilPackage}.FacesUtil;
import ${viewUtilPackage}.PortletUtil;

<#list importList as import>
import ${import};
</#list>

public class Search${className}ModelBean implements Serializable {

	private static final long serialVersionUID = 1L;

	private ${className} search${className} = new ${className}();
	private List<${className}> ${entityName}List = new ArrayList<${className}>();
	
	private String sortField = "${keyField}";
	private boolean ascending = false;
	
	@PostConstruct
	public void init() {
		PortletPreferences portletPrefs = PortletUtil.getPortletPreferences();
		setSortField(portletPrefs.getValue("sortField", "id"));
	}
	
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
	
	public String getSortField() {
		return sortField;
	}

	public void setSortField(final String sortField) {
		this.sortField = sortField;
		sort();
	}

	public void setAscending(final boolean ascending) {
		this.ascending = ascending;
		sort();
	}

	public boolean isAscending() {
		return ascending;
	}
	
	private void sort() {
		System.out.println("sorting ${entityName}List by " + sortField);
		
		String sqlSort = 
	        "SELECT * from ${fqClassName} " +
	        "ORDER BY " + sortField + " " + 
	        (ascending ? "ASC" : "DESC");
		
		Query query = new Query();
		try {
	        query.parse(sqlSort);
	        QueryResults queryResults = query.execute(${entityName}List);
	        ${entityName}List = queryResults.getResults();
		} catch (Exception ex) {
			FacesUtil.addMessage(FacesMessage.SEVERITY_ERROR, "Error on sorting", ex.getMessage());
		}
	}
	
}
