package ${packageName};

import java.util.Locale;

import javax.portlet.PortletRequest;

import ${viewUtilPackage}.ResourceBundleProperty;

import com.vaadin.data.util.ObjectProperty;

<#list importList as import>
import ${import};
</#list>

public class ${className}CrudApplicationModelBean {

	public static final int SEARCH_VIEW_STATE = 0;
	public static final int REGISTRY_VIEW_STATE = 1;

	public static final String RESOURCE_PATH_IMG = "/VAADIN/images/";
	
	private ObjectProperty<Integer> currentViewState = new ObjectProperty<Integer>(SEARCH_VIEW_STATE);

	private Edit${className}ModelBean editModelBean;
	private Edit${className}Layout editContent;
	
	private Search${className}Layout searchContent;
	private Search${className}ModelBean searchModelBean;
	
	private Registry${className}Layout registryContent;
	private Registry${className}ModelBean registryModelBean;
	
	// TODO externalize into a CDI or spring container
	private ${className}Dao ${entityName}Dao = new ${className}DaoImpl();

	private ResourceBundleProperty resourceBundleProperty = 
			new ResourceBundleProperty(Locale.ITALY);
	
	private PortletRequest portletRequest;
	
	
	public ObjectProperty<Integer> getCurrentViewState() {
		return currentViewState;
	}
	
	public void setCurrentViewState(int viewState) {
		this.currentViewState.setValue(viewState);
	}

	public Edit${className}ModelBean getEditModelBean() {
		return editModelBean;
	}

	public void setEditModelBean(Edit${className}ModelBean editModelBean) {
		this.editModelBean = editModelBean;
	}

	public Edit${className}Layout getEditContent() {
		return editContent;
	}

	public void setEditContent(Edit${className}Layout editContent) {
		this.editContent = editContent;
	}

	public Search${className}Layout getSearchContent() {
		return searchContent;
	}

	public void setSearchContent(Search${className}Layout searchContent) {
		this.searchContent = searchContent;
	}

	public Search${className}ModelBean getSearchModelBean() {
		return searchModelBean;
	}

	public void setSearchModelBean(Search${className}ModelBean searchModelBean) {
		this.searchModelBean = searchModelBean;
	}

	public RegistryPersonLayout getRegistryContent() {
		return registryContent;
	}

	public void setRegistryContent(Registry${className}Layout registryContent) {
		this.registryContent = registryContent;
	}

	public Registry${className}ModelBean getRegistryModelBean() {
		return registryModelBean;
	}

	public void setRegistryModelBean(Registry${className}ModelBean registryModelBean) {
		this.registryModelBean = registryModelBean;
	}

	public ${className}Dao get${className}Dao() {
		return ${entityName}Dao;
	}

	public ResourceBundleProperty getResourceBundleProperty() {
		return resourceBundleProperty;
	}

	public void setResourceBundleProperty(
			ResourceBundleProperty resourceBundleProperty) {
		this.resourceBundleProperty = resourceBundleProperty;
	}
	
	public PortletRequest getPortletRequest() {
		return portletRequest;
	}

	public void setPortletRequest(PortletRequest portletRequest) {
		this.portletRequest = portletRequest;
	}
}
