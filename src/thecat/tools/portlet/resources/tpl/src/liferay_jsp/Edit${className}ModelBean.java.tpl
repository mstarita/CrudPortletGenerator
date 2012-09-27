package ${packageName};

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.portlet.PortletPreferences;

import ${viewUtilPackage}.BeanUtil;
import ${fqClassName};

public class Edit${className}ModelBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	public static final String PREFS_SEARCH_FIELDS = "searchFields";
	public static final String PREFS_RESULT_FIELDS = "resultFields";
	public static final String PREFS_REGISTRY_FIELDS = "registryFields";
	public static final String PREFS_ROWS_PER_PAGE = "rowsPerPage";
	public static final String PREFS_N_COLS_SEARCH = "nColsSearch";
	public static final String PREFS_N_COLS_REGISTRY = "nColsRegistry";
	
	private List<String> fieldList;
	private Map<String, Boolean> searchFieldMap = new HashMap<String, Boolean>();
	private Map<String, Boolean> resultFieldMap = new HashMap<String, Boolean>();
	private Map<String, Boolean> registryFieldMap = new HashMap<String, Boolean>();
	private Long rowsPerPage;
	private Long nColsSearch;
	private Long nColsRegistry;
	
	public Edit${className}ModelBean(PortletPreferences portletPreferences) {
		init(portletPreferences);
	}
	
	public void init(PortletPreferences portletPrefs) {
		System.out.println("Edit${className}ModelBean.init()");
		
		fieldList = BeanUtil.getFieldList(${className}.class.getCanonicalName());
		
		for (String field : fieldList) {
			searchFieldMap.put(field, false);
			resultFieldMap.put(field, false);
			registryFieldMap.put(field, false);
		}

		String[] curSearchFields = portletPrefs.getValues(PREFS_SEARCH_FIELDS, null);
		for (String field : curSearchFields) {
			searchFieldMap.put(field, true);
		}
		
		String[] curResultFields = (String[]) portletPrefs.getValues(PREFS_RESULT_FIELDS, null);
		for (String field : curResultFields) {
			resultFieldMap.put(field, true);
		}
		
		String[] curRegistryFields = (String[]) portletPrefs.getValues(PREFS_REGISTRY_FIELDS, null);
		for (String field : curRegistryFields) {
			registryFieldMap.put(field, true);
		}
		
		rowsPerPage = new Long(portletPrefs.getValue(PREFS_ROWS_PER_PAGE, "10"));
		nColsSearch = new Long(portletPrefs.getValue(PREFS_N_COLS_SEARCH, "1"));
		nColsRegistry = new Long(portletPrefs.getValue(PREFS_N_COLS_REGISTRY, "1"));
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

	public Long getnColsSearch() {
		return nColsSearch;
	}

	public void setnColsSearch(Long nColsSearch) {
		this.nColsSearch = nColsSearch;
	}

	public Long getnColsRegistry() {
		return nColsRegistry;
	}

	public void setnColsRegistry(Long nColsRegistry) {
		this.nColsRegistry = nColsRegistry;
	}
	
	public void setAllFieldMap(Map<String, Boolean> fieldMap, boolean value) {
		for (Entry<String, Boolean> entry : fieldMap.entrySet()) {
			entry.setValue(value);
		}
	}
	
}
