package ${packageName};

import java.io.IOException;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import ${daoPackage}.${className}Dao;
import ${daoPackage}.${className}DaoImpl;

import com.liferay.util.bridges.mvc.MVCPortlet;

public class ${className}CrudPortlet extends MVCPortlet 
	implements Edit${className}ActionBean, Registry${className}ActionBean, Search${className}ActionBean {
	
	public static final String EDIT_MODEL_BEAN_ATTR_KEY = "editModelBean";
	public static final String SEARCH_MODEL_BEAN_ATTR_KEY = "searchModelBean";
	public static final String REGISTRY_MODEL_BEAN_ATTR_KEY = "registryModelBean";
	
	public static final String INFO_MESSAGE_ATTR_KEY = "infoMessage";
	public static final String ERROR_MESSAGE_ATTR_KEY = "errorMessage";

	public static final String PRINT_URL_ATTR_KEY = "printUrl";

	public static final String CUR_RESULT_PAGE_ATTR_KEY = "curResultPage";
	public static final String ORDER_BY_COL_RESULT_PAGE_ATTR_KEY = "orderByColResultPage";
	public static final String ORDER_BY_TYPE_RESULT_PAGE_ATTR_KEY = "orderByTypeResultPage";
	
	private static final String SEARCH_JSP  = "/${entityName}/search.jsp";
	private static final String REGISTRY_JSP  = "/${entityName}/registry.jsp";
	
	private ${className}CrudPortletModelBean modelBean;
	
	private ${className}Dao ${entityName}Dao = new ${className}DaoImpl();

	public void setViewToSearchJSP() {
		this.viewJSP = SEARCH_JSP;
	}
	
	public void setViewToRegistryJSP() {
		this.viewJSP = REGISTRY_JSP;
	}
	
	@Override
	public void doView(RenderRequest request, RenderResponse response) throws IOException, PortletException {
		
		if (modelBean == null) {
			init(request);
		}
		
		request.setAttribute(EDIT_MODEL_BEAN_ATTR_KEY, modelBean.getEditModelBean());
		request.setAttribute(SEARCH_MODEL_BEAN_ATTR_KEY, modelBean.getSearchModelBean());
		request.setAttribute(REGISTRY_MODEL_BEAN_ATTR_KEY, modelBean.getRegistryModelBean());
		
		super.doView(request, response);
		
	}
	
	@Override
	public void doEdit(RenderRequest request, RenderResponse response) throws IOException, PortletException {
		
		if (modelBean == null) {
			init(request);
		}
		
		request.setAttribute(EDIT_MODEL_BEAN_ATTR_KEY, modelBean.getEditModelBean());
		
		super.doEdit(request, response);
		
	}

	///////////////////////////////////////////////////////////////////////////
	// Edit Actions - start
	@Override
	public void selectAllSearchFieldAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		modelBean.getEditActionBean().selectAllSearchFieldAction(actionRequest, actionResponse);
		
	}

	@Override
	public void deselectAllSearchFieldAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		modelBean.getEditActionBean().deselectAllSearchFieldAction(actionRequest, actionResponse);
		
	}

	@Override
	public void selectAllResultFieldAction(ActionRequest actionRequest, ActionResponse actionResponse) {
	
		modelBean.getEditActionBean().deselectAllResultFieldAction(actionRequest, actionResponse);
		
	}

	@Override
	public void deselectAllResultFieldAction(ActionRequest actionRequest, ActionResponse actionResponse) {
	
		modelBean.getEditActionBean().deselectAllResultFieldAction(actionRequest, actionResponse);
		
	}
	
	@Override
	public void selectAllRegistryFieldAction(ActionRequest actionRequest, ActionResponse actionResponse) {
	
		modelBean.getEditActionBean().selectAllResultFieldAction(actionRequest, actionResponse);
		
	}

	@Override
	public void deselectAllRegistryFieldAction(ActionRequest actionRequest, ActionResponse actionResponse) {
	
		modelBean.getEditActionBean().deselectAllRegistryFieldAction(actionRequest, actionResponse);
		
	}
	
	@Override
	public void savePrefsAction(ActionRequest actionRequest, ActionResponse actionResponse) {
			
		modelBean.getEditActionBean().savePrefsAction(actionRequest, actionResponse);

	}
	
	@Override
	public void resetPrefsAction(ActionRequest actionRequest, ActionResponse actionResponse) {
			
		modelBean.getEditActionBean().resetPrefsAction(actionRequest, actionResponse);
		
	}
	// Edit Actions - end
	///////////////////////////////////////////////////////////////////////////
	
	///////////////////////////////////////////////////////////////////////////
	// Search Actions - start
	@Override
	public void newAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		modelBean.getSearchActionBean().newAction(actionRequest, actionResponse);
		
	}
	
	@Override
	public void printResultAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		modelBean.getSearchActionBean().printResultAction(actionRequest, actionResponse);
		
	}

	@Override
	public void resetSearchFieldsAction(ActionRequest actionRequest, ActionResponse actionResponse) {

		modelBean.getSearchActionBean().resetSearchFieldsAction(actionRequest, actionResponse);
		
	}

	@Override
	public void searchAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		modelBean.getSearchActionBean().searchAction(actionRequest, actionResponse);
		
	}

	@Override
	public void printDetailAction(ActionRequest actionRequest, ActionResponse actionResponse) {

		modelBean.getSearchActionBean().printDetailAction(actionRequest, actionResponse);
		
	}

	@Override
	public void showAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		modelBean.getSearchActionBean().showAction(actionRequest, actionResponse);
		
	}
	
	@Override
	public void editAction(ActionRequest actionRequest, ActionResponse actionResponse) {

		modelBean.getSearchActionBean().editAction(actionRequest, actionResponse);
		
	}

	@Override
	public void deleteAction(ActionRequest actionRequest, ActionResponse actionResponse) {

		modelBean.getSearchActionBean().deleteAction(actionRequest, actionResponse);
		
	}
	// Search Actions - end
	///////////////////////////////////////////////////////////////////////////
	
	///////////////////////////////////////////////////////////////////////////	
	// Registry Actions - start
	@Override
	public void printRegistryAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		modelBean.getRegistryActionBean().printRegistryAction(actionRequest, actionResponse);
		
	}
	
	@Override
	public void confirmRegistryAction(ActionRequest actionRequest, ActionResponse actionResponse) {
	
		modelBean.getRegistryActionBean().confirmRegistryAction(actionRequest, actionResponse);
		
	}

	@Override
	public void cancelRegistryAction(ActionRequest actionRequest, ActionResponse actionResponse) {
	
		modelBean.getRegistryActionBean().cancelRegistryAction(actionRequest, actionResponse);
		
	}
	// Registry Actions - end
	///////////////////////////////////////////////////////////////////////////	
	
	private void init(RenderRequest request) {
		
		System.out.println("init portlet beans...");
	
		modelBean = new ${className}CrudPortletModelBean();
		
		modelBean.setEditModelBean(new Edit${className}ModelBean(request.getPreferences()));
		modelBean.setEditActionBean(new Edit${className}ActionBeanImpl(modelBean.getEditModelBean()));
	
		modelBean.setRegistryModelBean(new Registry${className}ModelBean());
		modelBean.setRegistryActionBean(new Registry${className}ActionBeanImpl(modelBean.getRegistryModelBean(), this, ${entityName}Dao));
		
		modelBean.setSearchModelBean(new Search${className}ModelBean());
		modelBean.setSearchActionBean(new Search${className}ActionBeanImpl(
				modelBean.getSearchModelBean(), modelBean.getRegistryModelBean(), this, ${entityName}Dao));
		
	}
	
}
