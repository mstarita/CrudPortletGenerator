package ${packageName};

import java.io.Serializable;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.faces.event.ActionEvent;
import javax.faces.application.FacesMessage;
import javax.portlet.PortletPreferences;

import org.edorasframework.extfaces.el.I18N;

import ${viewUtilPackage}.FacesUtil;
import ${viewUtilPackage}.PortletUtil;

public class Edit${className}BackingBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Edit${className}ModelBean modelBean;
	private transient I18N i18n;
	
	public void setModelBean(final Edit${className}ModelBean modelBean) {
		this.modelBean = modelBean;
	}

	public Edit${className}ModelBean getModelBean() {
		return modelBean;
	}

	public void setI18n(I18N i18n) {
		this.i18n = i18n;
	}

	public I18N getI18n() {
		return i18n;
	}
	
	private void syncFieldMapPrefs(Map<String, Boolean> source, String prefName) throws Exception {
		List<String> curFields = new ArrayList<String>();
		for (Entry<String, Boolean> entry : source.entrySet()) {
			if (entry.getValue()) {
				curFields.add(entry.getKey());
			}
		}
		
		String[] curFieldArr = new String[curFields.size()];
		curFields.toArray(curFieldArr);
		
		PortletPreferences portletPrefs = PortletUtil.getPortletPreferences();
		portletPrefs.setValues(prefName, curFieldArr);
	}
	
	public void actionSave(ActionEvent actionEvent) {
		System.out.println("Saving ${className} portlet preferences...");
		
		PortletPreferences portletPrefs = PortletUtil.getPortletPreferences();
		
		try {
			syncFieldMapPrefs(modelBean.getSearchFieldMap(), "searchFields");
			syncFieldMapPrefs(modelBean.getResultFieldMap(), "resultFields");
			syncFieldMapPrefs(modelBean.getRegistryFieldMap(), "registryFields");
			
			portletPrefs.setValue("rowsPerPage", modelBean.getRowsPerPage().toString());
			portletPrefs.setValue("nColsSearch", modelBean.getnColsSearch().toString());
			portletPrefs.setValue("nColsRegistry", modelBean.getnColsRegistry().toString());
		
			portletPrefs.store();

			FacesUtil.addMessage(FacesMessage.SEVERITY_INFO, i18n.getString("edit.save.msg.success"), null);
		} catch (Exception ex) {
			FacesUtil.addMessage(FacesMessage.SEVERITY_ERROR, i18n.getString("edit.save.msg.fail"), ex.getMessage());
			ex.printStackTrace();
		}
	}
	
	public void actionReset(ActionEvent actionEvent) {
		System.out.println("Reset ${className} portlet preferences...");

		PortletPreferences portletPrefs = PortletUtil.getPortletPreferences();
		
		try {
			portletPrefs.reset("searchFields");
			portletPrefs.reset("resultFields");
			portletPrefs.reset("registryFields");
			portletPrefs.reset("rowsPerPage");
			portletPrefs.reset("nColsSearch");
			portletPrefs.reset("nColsRegistry");
			
			modelBean.init();
		} catch (Exception ex) {
			FacesUtil.addMessage(FacesMessage.SEVERITY_ERROR, i18n.getString("edit.reset.msg.fail"), ex.getMessage());
		}
	}

	private void setupFieldMap(Map<String, Boolean> fieldMap, Boolean value) {
		for (String field: fieldMap.keySet()) {
			fieldMap.put(field, value);
		}
	}
	
	public void actionSearchFieldSelectAll(ActionEvent actionEvent) throws Exception {
		System.out.println("Select all the search fields...");
		
		setupFieldMap(modelBean.getSearchFieldMap(), true);
	}
	
	public void actionSearchFieldDeselectAll(ActionEvent actionEvent) throws Exception {
		System.out.println("Deselect all the search fields...");
		
		setupFieldMap(modelBean.getSearchFieldMap(), false);
	}
	
	public void actionResultFieldSelectAll(ActionEvent actionEvent) throws Exception {
		System.out.println("Select all the result fields...");

		setupFieldMap(modelBean.getResultFieldMap(), true);
	}
	
	public void actionResultFieldDeselectAll(ActionEvent actionEvent) throws Exception {
		System.out.println("Deselect all the result fields...");

		setupFieldMap(modelBean.getResultFieldMap(), false);
	}
	
	public void actionRegistryFieldSelectAll(ActionEvent actionEvent) throws Exception {
		System.out.println("Select all the registry fields...");

		setupFieldMap(modelBean.getRegistryFieldMap(), true);
	}
	
	public void actionRegistryFieldDeselectAll(ActionEvent actionEvent) throws Exception {
		System.out.println("Deselect all the registry fields...");

		setupFieldMap(modelBean.getRegistryFieldMap(), false);
	}

}
