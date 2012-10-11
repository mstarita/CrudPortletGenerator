package ${packageName};

import java.util.Locale;

import javax.portlet.PortletPreferences;

import org.zkoss.bind.annotation.BindingParam;
import org.zkoss.bind.annotation.Command;
import org.zkoss.bind.annotation.ContextParam;
import org.zkoss.bind.annotation.ContextType;
import org.zkoss.bind.annotation.Init;
import org.zkoss.bind.annotation.NotifyChange;
import org.zkoss.util.resource.impl.LabelLoader;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Session;
import org.zkoss.zk.ui.http.FullDHtmlLayoutPortlet;

<#list importList as import>
import ${import};
</#list>

import com.liferay.portal.kernel.util.Validator;

public class View${className}ViewModel implements Search${className}Action, Registry${className}Action {

	private Search${className}Model searchModel;
	private Registry${className}Model registryModel;
	private Edit${className}Model editModel;
	
	private Search${className}Action searchAction;
	private Registry${className}Action registryAction;
	
	private PortletPreferences portletPrefs;
	private LabelLoader labelLoader;
	private Locale locale;
	
	public Search${className}Model getSearchModel() {
		return searchModel;
	}

	public Registry${className}Model getRegistryModel() {
		return registryModel;
	}

	public Edit${className}Model getEditModel() {
		return editModel;
	}

	@Init
	public void init(@ContextParam(ContextType.DESKTOP) Desktop desktop) {
	
		portletPrefs = 
			(PortletPreferences) Executions.getCurrent().getAttribute(FullDHtmlLayoutPortlet.PORTLET_PREFS_ATTR_KEY);
		labelLoader = (LabelLoader) Executions.getCurrent().getAttribute(FullDHtmlLayoutPortlet.LABEL_LOADER_ATTR_KEY);
		locale = (Locale) Executions.getCurrent().getAttribute(FullDHtmlLayoutPortlet.LOCALE_ATTR_KEY);
		
		if (Validator.isNull(desktop.getAttribute(Registry${className}Model.REGISTRY_MODEL_KEY_ATTR))) {	
			registryModel = new Registry${className}Model();
			desktop.setAttribute(Registry${className}Model.REGISTRY_MODEL_KEY_ATTR, registryModel);
		} else {
			registryModel = (Registry${className}Model) desktop.getAttribute(Registry${className}Model.REGISTRY_MODEL_KEY_ATTR);
		}
		
		searchModel = new Search${className}Model();
		editModel = new Edit${className}Model(portletPrefs);
		
		searchAction = new Search${className}ActionImpl(searchModel, registryModel, labelLoader, locale);
		registryAction = new Registry${className}ActionImpl(registryModel, searchModel, labelLoader, locale);
		
	}

	///////////////////////////////////////////////////////////////////////////
	// Search actions - start
	@Override
	@Command
	@NotifyChange("searchModel")
	public void actionConfirmDelete(@BindingParam("${entityName}") ${className} ${entityName}) {
		
		searchAction.actionConfirmDelete(${entityName});
	}

	@Override
	@Command
	@NotifyChange("searchModel")
	public void actionDeleteCancel() {
		
		searchAction.actionDeleteCancel();
		
	}

	@Override
	@Command
	@NotifyChange("searchModel")
	public void actionDeleteConfirm() {

		searchAction.actionDeleteConfirm();
		
	}

	@Override
	@Command
	@NotifyChange({"searchModel", "registryModel"})
	public void actionEdit(@BindingParam("${entityName}") ${className} ${entityName}) {
		
		searchAction.actionEdit(${entityName});
		
	}

	@Override
	@Command
	public void actionNew() {

		searchAction.actionNew();
		
	}

	@Override
	@Command
	@NotifyChange("searchModel")
	public void actionPrintDetail(@ContextParam(ContextType.SESSION) Session session, @BindingParam("${entityName}") ${className} ${entityName}) {
		
		searchAction.actionPrintDetail(session, ${entityName});
		
	}

	@Override
	@Command
	@NotifyChange("searchModel")
	public void actionPrintResult(@ContextParam(ContextType.SESSION) Session session) {
		
		searchAction.actionPrintResult(session);
		
	}

	@Override
	@Command
	@NotifyChange("searchModel")
	public void actionReset() {
		
		searchAction.actionReset();
		
	}

	@Override
	@Command
	@NotifyChange("searchModel")
	public void actionSearch() {
		
		searchAction.actionSearch();
		
	}

	@Override
	@Command
	@NotifyChange({"searchModel", "registryModel.${entityName}", "registryModel.formOperation"})
	public void actionShow(@BindingParam("${entityName}") ${className} ${entityName}) {
		
		searchAction.actionShow(${entityName});
		
	}
	// Search actions - end
	///////////////////////////////////////////////////////////////////////////
	
	///////////////////////////////////////////////////////////////////////////
	// Registry actions - start
	@Override
	@Command
	public void actionRegistryCancel() {
		
		registryAction.actionRegistryCancel();
		
	}

	@Override
	@Command
	public void actionRegistryConfirm() {
		
		registryAction.actionRegistryConfirm();
		
	}

	@Override
	@Command
	public void actionRegistryPrint(@ContextParam(ContextType.SESSION) Session session) {
		
		registryAction.actionRegistryPrint(session);
		
	}
	// Registry actions - end
	///////////////////////////////////////////////////////////////////////////
}
