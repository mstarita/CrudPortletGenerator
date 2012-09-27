package ${packageName};

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;

public class Edit${className}ActionBeanImpl implements Edit${className}ActionBean {

	private Edit${className}ModelBean modelBean;
	
	public Edit${className}ActionBeanImpl(Edit${className}ModelBean modelBean) {
		this.modelBean = modelBean;
	}
	
	@Override
	public void selectAllSearchFieldAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		System.out.println("selectAllSearchFieldAction fired!!!");
		
		modelBean.setAllFieldMap(modelBean.getSearchFieldMap(), true);
		
	}
	
	@Override
	public void deselectAllSearchFieldAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		System.out.println("deselectAllSearchFieldAction fired!!!");
		
		modelBean.setAllFieldMap(modelBean.getSearchFieldMap(), false);
		
	}

	@Override
	public void selectAllResultFieldAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		System.out.println("selectAllResultFieldAction fired!!!");
	
		modelBean.setAllFieldMap(modelBean.getResultFieldMap(), true);
	}

	@Override
	public void deselectAllResultFieldAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		System.out.println("deselectAllResultFieldAction fired!!!");
	
		modelBean.setAllFieldMap(modelBean.getResultFieldMap(), false);
		
	}

	@Override
	public void selectAllRegistryFieldAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		System.out.println("selectAllRegistryFieldAction fired!!!");
	
		modelBean.setAllFieldMap(modelBean.getRegistryFieldMap(), true);
	}

	@Override
	public void deselectAllRegistryFieldAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		System.out.println("deselectAllRegistryFieldAction fired!!!");
	
		modelBean.setAllFieldMap(modelBean.getRegistryFieldMap(), false);
		
	}
	
	@Override
	public void savePrefsAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		System.out.println("savePrefsAction fired!!!");
		
		try {
			
			syncReqParamsFieldListPrefs(actionRequest, Edit${className}ModelBean.PREFS_SEARCH_FIELDS, Edit${className}ModelBean.PREFS_SEARCH_FIELDS);
			syncReqParamsFieldListPrefs(actionRequest, Edit${className}ModelBean.PREFS_RESULT_FIELDS, Edit${className}ModelBean.PREFS_RESULT_FIELDS);
			syncReqParamsFieldListPrefs(actionRequest, Edit${className}ModelBean.PREFS_REGISTRY_FIELDS, Edit${className}ModelBean.PREFS_REGISTRY_FIELDS);
			
			String nColsSearch = actionRequest.getParameter(Edit${className}ModelBean.PREFS_N_COLS_SEARCH);
			String nColsRegistry = actionRequest.getParameter(Edit${className}ModelBean.PREFS_N_COLS_REGISTRY);
			String rowsPerPage = actionRequest.getParameter(Edit${className}ModelBean.PREFS_ROWS_PER_PAGE);
			
			actionRequest.getPreferences().setValue(Edit${className}ModelBean.PREFS_N_COLS_SEARCH, 
				nColsSearch);
			actionRequest.getPreferences().setValue(Edit${className}ModelBean.PREFS_N_COLS_REGISTRY, 
					nColsRegistry);
			actionRequest.getPreferences().setValue(Edit${className}ModelBean.PREFS_ROWS_PER_PAGE, 
					rowsPerPage);
			
			actionRequest.getPreferences().store();
			
			syncReqParamsFieldMap(actionRequest, Edit${className}ModelBean.PREFS_SEARCH_FIELDS, modelBean.getSearchFieldMap());
			syncReqParamsFieldMap(actionRequest, Edit${className}ModelBean.PREFS_RESULT_FIELDS, modelBean.getResultFieldMap());
			syncReqParamsFieldMap(actionRequest, Edit${className}ModelBean.PREFS_REGISTRY_FIELDS, modelBean.getRegistryFieldMap());
			modelBean.setnColsSearch(Long.valueOf(nColsSearch));
			modelBean.setnColsRegistry(Long.valueOf(nColsRegistry));
			modelBean.setRowsPerPage(Long.valueOf(rowsPerPage));
			
			actionRequest.setAttribute(${className}CrudPortlet.INFO_MESSAGE_ATTR_KEY, "edit.save.msg.success");
			
		} catch (Exception ex) {
			actionRequest.setAttribute(${className}CrudPortlet.ERROR_MESSAGE_ATTR_KEY, "edit.save.msg.fail");
			ex.printStackTrace();
		}
	}
	
	@Override
	public void resetPrefsAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		System.out.println("resetPrefsAction fired!!!");
		
		try {
			
			actionRequest.getPreferences().reset(Edit${className}ModelBean.PREFS_SEARCH_FIELDS);
			actionRequest.getPreferences().reset(Edit${className}ModelBean.PREFS_RESULT_FIELDS);
			actionRequest.getPreferences().reset(Edit${className}ModelBean.PREFS_REGISTRY_FIELDS);
			actionRequest.getPreferences().reset(Edit${className}ModelBean.PREFS_N_COLS_SEARCH);
			actionRequest.getPreferences().reset(Edit${className}ModelBean.PREFS_N_COLS_REGISTRY);
			actionRequest.getPreferences().reset(Edit${className}ModelBean.PREFS_ROWS_PER_PAGE);
			
			modelBean.init(actionRequest.getPreferences());
			
		} catch (Exception ex) {
			actionRequest.setAttribute(${className}CrudPortlet.ERROR_MESSAGE_ATTR_KEY, "edit.reset.msg.fail");
			ex.printStackTrace();
		}
		
	}
	
	private void syncReqParamsFieldListPrefs(ActionRequest request, String paramPrefix, String prefName) throws Exception {
		List<String> curFields = new ArrayList<String>();
		for (String field : modelBean.getFieldList()) {
			if (Boolean.valueOf(request.getParameter(paramPrefix + field))) {
				curFields.add(field);
			}
		}
		
		String[] curFieldArr = new String[curFields.size()];
		curFields.toArray(curFieldArr);
		
		request.getPreferences().setValues(prefName, curFieldArr);
	}

	private void syncReqParamsFieldMap(ActionRequest request, String paramPrefix, Map<String, Boolean> fieldMap) throws Exception {

		for (Entry<String, Boolean> entry : fieldMap.entrySet()) {
			entry.setValue(Boolean.valueOf(request.getParameter(paramPrefix + entry.getKey())));
		}
		
	}
}
