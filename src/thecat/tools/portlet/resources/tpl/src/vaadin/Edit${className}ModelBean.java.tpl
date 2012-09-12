package ${packageName};

import java.io.Serializable;
import java.util.List;

import javax.portlet.PortletPreferences;
import javax.portlet.PortletRequest;

import ${viewUtilPackage}.BeanUtil;

import com.vaadin.data.util.ObjectProperty;
import com.vaadin.data.util.PropertysetItem;

<#list importList as import>
import ${import};
</#list>

public class Edit${className}ModelBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private List<String> fieldList;

	private PropertysetItem propSearchFieldMap = new PropertysetItem();
	private PropertysetItem propResultFieldMap = new PropertysetItem();
	private PropertysetItem propRegistryFieldMap = new PropertysetItem();
	
	private ObjectProperty<Long> propRowsPerPage = new ObjectProperty<Long>(new Long(1));
	private ObjectProperty<Long> propNColsSearch = new ObjectProperty<Long>(new Long(1));
	private ObjectProperty<Long> propNColsRegistry = new ObjectProperty<Long>(new Long(1));
	
	public Edit${className}ModelBean(PortletRequest portletRequest) {
		
		init(portletRequest);
		
	}
	
	public void init(PortletRequest portletRequest) {
		System.out.println("Edit${className}ModelBean.init()");
		
		fieldList = BeanUtil.getFieldList(${className}.class.getCanonicalName());
		
		for (String field : fieldList) {
			propSearchFieldMap.addItemProperty(field, new ObjectProperty<Boolean>(false));
			propResultFieldMap.addItemProperty(field, new ObjectProperty<Boolean>(false));
			propRegistryFieldMap.addItemProperty(field, new ObjectProperty<Boolean>(false));
		}
		
		PortletPreferences portletPrefs = portletRequest.getPreferences();
		
		String[] curSearchFields = portletPrefs.getValues("searchFields", null);
		for (String field : curSearchFields) {
			propSearchFieldMap.getItemProperty(field).setValue(true);
		}
		
		String[] curResultFields = (String[]) portletPrefs.getValues("resultFields", null);
		for (String field : curResultFields) {
			propResultFieldMap.getItemProperty(field).setValue(true);
		}
		
		String[] curRegistryFields = (String[]) portletPrefs.getValues("registryFields", null);
		for (String field : curRegistryFields) {
			propRegistryFieldMap.getItemProperty(field).setValue(true);
		}
		
		propRowsPerPage.setValue(new Long(portletPrefs.getValue("rowsPerPage", "10")));
		propNColsSearch.setValue(new Long(portletPrefs.getValue("nColsSearch", "1")));
		propNColsRegistry.setValue(new Long(portletPrefs.getValue("nColsRegistry", "1")));
	}
	
	public List<String> getFieldList() {
		return fieldList;
	}
	
	public PropertysetItem getPropSearchFieldMap() {
		return propSearchFieldMap;
	}
	
	public PropertysetItem getPropResultFieldMap() {
		return propResultFieldMap;
	}
	
	public PropertysetItem getPropRegistryFieldMap() {
		return propRegistryFieldMap;
	}
	
	public ObjectProperty<Long> getPropRowsPerPage() {
		return propRowsPerPage;
	}
	
	public ObjectProperty<Long> getPropNColsSearch() {
		return propNColsSearch;
	}
	
	public ObjectProperty<Long> getPropNColsRegistry() {
		return propNColsRegistry;
	}	
	
}
