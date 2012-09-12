package ${packageName};

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.portlet.PortletPreferences;

import ${viewUtilPackage}.BeanUtil;
import ${viewUtilPackage}.PortletUtil;

<#list importList as import>
import ${import};
</#list>

public class Edit${className}ModelBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private List<String> fieldList;
	private Map<String, Boolean> searchFieldMap = new HashMap<String, Boolean>();
	private Map<String, Boolean> resultFieldMap = new HashMap<String, Boolean>();
	private Map<String, Boolean> registryFieldMap = new HashMap<String, Boolean>();
	private Long rowsPerPage;
	private Long nColsSearch;
	private Long nColsRegistry;
	
	@PostConstruct
	public void init() {
		System.out.println("Edit${className}ModelBean.init()");
		
		fieldList = BeanUtil.getFieldList(${className}.class.getCanonicalName());
		
		for (String field : fieldList) {
			searchFieldMap.put(field, false);
			resultFieldMap.put(field, false);
			registryFieldMap.put(field, false);
		}
		
		PortletPreferences portletPrefs = PortletUtil.getPortletPreferences();

		String[] curSearchFields = portletPrefs.getValues("searchFields", null);
		for (String field : curSearchFields) {
			searchFieldMap.put(field, true);
		}
		
		String[] curResultFields = (String[]) portletPrefs.getValues("resultFields", null);
		for (String field : curResultFields) {
			resultFieldMap.put(field, true);
		}
		
		String[] curRegistryFields = (String[]) portletPrefs.getValues("registryFields", null);
		for (String field : curRegistryFields) {
			registryFieldMap.put(field, true);
		}
		
		rowsPerPage = new Long(portletPrefs.getValue("rowsPerPage", "10"));
		nColsSearch = new Long(portletPrefs.getValue("nColsSearch", "1"));
		nColsRegistry = new Long(portletPrefs.getValue("nColsRegistry", "1"));
	}
	
	public List<String> getFieldList() {
		return fieldList;
	}

	public Map<String, Boolean> getSearchFieldMap() {
		return searchFieldMap;
	}

	public Map<String, Boolean> getResultFieldMap() {
		return resultFieldMap;
	}

	public Map<String, Boolean> getRegistryFieldMap() {
		return registryFieldMap;
	}

	public void setRowsPerPage(Long rowsPerPage) {
		this.rowsPerPage = rowsPerPage;
	}

	public Long getRowsPerPage() {
		return rowsPerPage;
	}

	public void setnColsSearch(Long nColsSearch) {
		this.nColsSearch = nColsSearch;
	}

	public Long getnColsSearch() {
		return nColsSearch;
	}

	public void setnColsRegistry(Long nColsRegistry) {
		this.nColsRegistry = nColsRegistry;
	}

	public Long getnColsRegistry() {
		return nColsRegistry;
	}
	
}
