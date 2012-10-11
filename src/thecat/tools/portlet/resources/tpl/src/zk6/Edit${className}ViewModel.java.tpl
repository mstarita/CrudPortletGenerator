package ${packageName};

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import javax.portlet.PortletPreferences;

import org.zkoss.bind.annotation.Command;
import org.zkoss.bind.annotation.ContextParam;
import org.zkoss.bind.annotation.ContextType;
import org.zkoss.bind.annotation.Init;
import org.zkoss.bind.annotation.NotifyChange;
import org.zkoss.util.resource.impl.LabelLoader;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.http.FullDHtmlLayoutPortlet;

import com.liferay.portal.kernel.util.Validator;

public class Edit${className}ViewModel {

	private static final long serialVersionUID = 1L;

	private Edit${className}Model editModel;
	
	private PortletPreferences portletPrefs;
	private LabelLoader labelLoader;
	private Locale locale;
	
	private String infoMessage;
	private String errorMessage;
	
	@Init
	public void init(@ContextParam(ContextType.DESKTOP) Desktop desktop) {
		
		portletPrefs = 
			(PortletPreferences) Executions.getCurrent().getAttribute(FullDHtmlLayoutPortlet.PORTLET_PREFS_ATTR_KEY);
		labelLoader = (LabelLoader) Executions.getCurrent().getAttribute(FullDHtmlLayoutPortlet.LABEL_LOADER_ATTR_KEY);
		locale = (Locale) Executions.getCurrent().getAttribute(FullDHtmlLayoutPortlet.LOCALE_ATTR_KEY);
		
		if (Validator.isNull(desktop.getAttribute(Edit${className}Model.EDIT_MODEL_KEY_ATTR))) {
			editModel = new Edit${className}Model(portletPrefs);
			desktop.setAttribute(Edit${className}Model.EDIT_MODEL_KEY_ATTR, editModel);
		} else {
			editModel = (Edit${className}Model) desktop.getAttribute(Edit${className}Model.EDIT_MODEL_KEY_ATTR);
		}

	}
	
	public Edit${className}Model getEditModel() {
		return editModel;
	}
	
	public String getInfoMessage() {
		return infoMessage;
	}

	public void setInfoMessage(String infoMessage) {
		this.infoMessage = infoMessage;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	
	@Command
	@NotifyChange("editModel")
	public void actionSelectAllSearchField(@ContextParam(ContextType.PAGE) Page page) {
		
		System.out.println("actionSelectAllSearchField fired!!!");
		
		editModel.setAllFieldMap(editModel.getSearchFieldMap(), true);
		
	}
	
	@Command
	@NotifyChange("editModel")
	public void actionDeselectAllSearchField() {
		
		System.out.println("actionDeselectAllSearchField fired!!!");
		
		editModel.setAllFieldMap(editModel.getSearchFieldMap(), false);
		
	}

	@Command
	@NotifyChange("editModel")
	public void actionSelectAllResultField() {
		
		System.out.println("actionSelectAllResultField fired!!!");
	
		editModel.setAllFieldMap(editModel.getResultFieldMap(), true);
	}

	@Command
	@NotifyChange("editModel")
	public void actionDeselectAllResultField() {
		
		System.out.println("actionDeselectAllResultField fired!!!");
	
		editModel.setAllFieldMap(editModel.getResultFieldMap(), false);
		
	}

	@Command
	@NotifyChange("editModel")
	public void actionSelectAllRegistryField() {
		
		System.out.println("actionSelectAllRegistryField fired!!!");
	
		editModel.setAllFieldMap(editModel.getRegistryFieldMap(), true);
	}

	@Command
	@NotifyChange("editModel")
	public void actionDeselectAllRegistryField() {
		
		System.out.println("actionDeselectAllRegistryField fired!!!");
	
		editModel.setAllFieldMap(editModel.getRegistryFieldMap(), false);
		
	}
	
	@Command
	@NotifyChange({"editModel", "infoMessage", "errorMessage"})
	public void actionSave() {
		
		System.out.println("actionSave invoked!!!");
		
		try {
			syncFieldMapPrefs(portletPrefs, editModel.getSearchFieldMap(), "searchFields");
			syncFieldMapPrefs(portletPrefs, editModel.getResultFieldMap(), "resultFields");
			syncFieldMapPrefs(portletPrefs, editModel.getRegistryFieldMap(), "registryFields");
			
			portletPrefs.setValue("rowsPerPage", editModel.getRowsPerPage().toString());
			portletPrefs.setValue("nColsSearch", editModel.getnColsSearch().toString());
			portletPrefs.setValue("nColsRegistry", editModel.getnColsRegistry().toString());
		
			portletPrefs.store();
			
			infoMessage = labelLoader.getLabel(locale, "edit.save.msg.success");
			errorMessage = null;
			
		} catch (Exception ex) {
			errorMessage = labelLoader.getLabel(locale, "edit.save.msg.fail");
			infoMessage = null;
			
			ex.printStackTrace();
		}
	}
	
	@Command
	@NotifyChange({"editModel", "infoMessage", "errorMessage"})
	public void actionReset() {
		
		System.out.println("actionReset fired!!!");
		
		try {
			
			portletPrefs.reset(Edit${className}Model.PREFS_SEARCH_FIELDS);
			portletPrefs.reset(Edit${className}Model.PREFS_RESULT_FIELDS);
			portletPrefs.reset(Edit${className}Model.PREFS_REGISTRY_FIELDS);
			portletPrefs.reset(Edit${className}Model.PREFS_N_COLS_SEARCH);
			portletPrefs.reset(Edit${className}Model.PREFS_N_COLS_REGISTRY);
			portletPrefs.reset(Edit${className}Model.PREFS_ROWS_PER_PAGE);
			
			editModel.init(portletPrefs);
			
			errorMessage = null;
			infoMessage = null;
			
		} catch (Exception ex) {
			errorMessage = labelLoader.getLabel(locale, "edit.reset.msg.fail");
			infoMessage = null;
			
			ex.printStackTrace();
		}
		
	}
	
	private void syncFieldMapPrefs(PortletPreferences portletPrefs, Map<String, Boolean> source, String prefName) throws Exception {
		List<String> curFields = new ArrayList<String>();
		for (Entry<String, Boolean> entry : source.entrySet()) {
			if (entry.getValue()) {
				curFields.add(entry.getKey());
			}
		}
		
		String[] curFieldArr = new String[curFields.size()];
		curFields.toArray(curFieldArr);
		
		portletPrefs.setValues(prefName, curFieldArr);
	}
	
}
