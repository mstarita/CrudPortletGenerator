package ${packageName};

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.Map.Entry;

import javax.portlet.PortletException;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.portlet.ResourceURL;

import com.liferay.util.bridges.mvc.MVCPortlet;

public class ${className}CrudPortlet extends MVCPortlet {
	
	public static final String EDIT_MODEL_KEY = "editModel";
	public static final String LOCALE_KEY = "locale";
	public static final String SAVE_ACTION_KEY = "saveAction";
	public static final String RESET_ACTION_KEY = "resetAction";
	
	public static final String RESOURCE_ID_SAVE_ACTION = "saveAction";
	public static final String RESOURCE_ID_RESET_ACTION = "resetAction";
	
	@Override
	public void doView(RenderRequest request, RenderResponse response) throws IOException, PortletException {

		request.setAttribute(EDIT_MODEL_KEY, loadPrefs(request.getPreferences()));
		request.setAttribute(LOCALE_KEY, request.getLocale());
				
		super.doView(request, response);
		
	}
	
	@Override
	public void doEdit(RenderRequest request, RenderResponse response) throws IOException, PortletException {
		
		ResourceURL saveActionURL = response.createResourceURL();
		saveActionURL.setResourceID(RESOURCE_ID_SAVE_ACTION);
		
		ResourceURL resetActionURL = response.createResourceURL();
		resetActionURL.setResourceID(RESOURCE_ID_RESET_ACTION);
		
		request.setAttribute(EDIT_MODEL_KEY, loadPrefs(request.getPreferences()));
		request.setAttribute(LOCALE_KEY, request.getLocale());
		request.setAttribute(SAVE_ACTION_KEY, saveActionURL);
		request.setAttribute(RESET_ACTION_KEY, resetActionURL);
		
		super.doEdit(request, response);
		
	}

	@Override
	public void serveResource(ResourceRequest request, ResourceResponse response) throws IOException, PortletException {
		
		PortletPreferences prefs = request.getPreferences();
		
		if (request.getResourceID().equals(RESOURCE_ID_SAVE_ACTION)) {
			
			System.out.println("Saving prefs...");
			
			try {
				setPrefsValues(Edit${className}ModelBean.PREFS_SEARCH_FIELDS, request.getParameter(Edit${className}ModelBean.PREFS_SEARCH_FIELDS), prefs);
				setPrefsValues(Edit${className}ModelBean.PREFS_RESULT_FIELDS, request.getParameter(Edit${className}ModelBean.PREFS_RESULT_FIELDS), prefs);
				setPrefsValues(Edit${className}ModelBean.PREFS_REGISTRY_FIELDS, request.getParameter(Edit${className}ModelBean.PREFS_REGISTRY_FIELDS), prefs);
				
				prefs.setValue(Edit${className}ModelBean.PREFS_N_COLS_SEARCH, request.getParameter(Edit${className}ModelBean.PREFS_N_COLS_SEARCH));
				prefs.setValue(Edit${className}ModelBean.PREFS_N_COLS_REGISTRY, request.getParameter(Edit${className}ModelBean.PREFS_N_COLS_REGISTRY));
				prefs.setValue(Edit${className}ModelBean.PREFS_ROWS_PER_PAGE, request.getParameter(Edit${className}ModelBean.PREFS_ROWS_PER_PAGE));
				
				prefs.store(); 
			} catch (Exception ex) {
				ex.printStackTrace();
				throw new RuntimeException(ex.getMessage());
			}
			
			
		} else if (request.getResourceID().equals(RESOURCE_ID_RESET_ACTION)) {
			
			System.out.println("Resetting prefs...");
			
			prefs.reset(Edit${className}ModelBean.PREFS_SEARCH_FIELDS);
			prefs.reset(Edit${className}ModelBean.PREFS_RESULT_FIELDS);
			prefs.reset(Edit${className}ModelBean.PREFS_REGISTRY_FIELDS);
			prefs.reset(Edit${className}ModelBean.PREFS_N_COLS_SEARCH);
			prefs.reset(Edit${className}ModelBean.PREFS_N_COLS_REGISTRY);
			prefs.reset(Edit${className}ModelBean.PREFS_ROWS_PER_PAGE);
			
			Edit${className}ModelBean modelBean = loadPrefs(prefs);
			
			response.setContentType("text/xml");
			
			String xmlPrefs = "<" + Edit${className}ModelBean.PREFS_SEARCH_FIELDS + ">" + 
				getPrefsValue(modelBean.getSearchFieldMap()) + 
				"</" + Edit${className}ModelBean.PREFS_SEARCH_FIELDS + ">";
			xmlPrefs += "<" + Edit${className}ModelBean.PREFS_RESULT_FIELDS + ">" + 
				getPrefsValue(modelBean.getResultFieldMap()) + 
				"</" + Edit${className}ModelBean.PREFS_RESULT_FIELDS + ">";
			xmlPrefs += "<" + Edit${className}ModelBean.PREFS_REGISTRY_FIELDS + ">" + 
				getPrefsValue(modelBean.getRegistryFieldMap()) + 
				"</" + Edit${className}ModelBean.PREFS_REGISTRY_FIELDS + ">";
			xmlPrefs += "<" + Edit${className}ModelBean.PREFS_N_COLS_SEARCH + ">" + 
				modelBean.getnColsSearch() + 
				"</" + Edit${className}ModelBean.PREFS_N_COLS_SEARCH + ">";
			xmlPrefs += "<" + Edit${className}ModelBean.PREFS_N_COLS_REGISTRY + ">" + 
				modelBean.getnColsRegistry() + 
				"</" + Edit${className}ModelBean.PREFS_N_COLS_REGISTRY + ">";
			xmlPrefs += "<" + Edit${className}ModelBean.PREFS_ROWS_PER_PAGE + ">" + 
				modelBean.getRowsPerPage() + 
				"</" + Edit${className}ModelBean.PREFS_ROWS_PER_PAGE + ">";
			
			PrintWriter out = response.getWriter();
			out.print(xmlPrefs);
			
		}
	}
	
	private Edit${className}ModelBean loadPrefs(PortletPreferences portletPrefs) {
		
		Edit${className}ModelBean editModel = new Edit${className}ModelBean(portletPrefs);
		
		return editModel;
	}
	
	private void setPrefsValues(String prefName, String fieldList, PortletPreferences prefs) throws Exception {
		
		prefs.setValues(prefName, fieldList.split("[,]"));
		
	}
	
	private String getPrefsValue(Map<String, Boolean> fieldMap) {
		String result = "";
		
		for (Entry<String, Boolean> entry : fieldMap.entrySet()) {
			if (entry.getValue()) {
				result += entry.getKey() + ",";
			}
		}
		
		return result;
	}
}
