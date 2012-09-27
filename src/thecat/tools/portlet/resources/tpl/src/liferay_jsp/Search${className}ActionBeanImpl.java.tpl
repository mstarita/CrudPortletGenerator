package ${packageName};

import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletSession;

import org.apache.commons.lang3.math.NumberUtils;

import thecat.common.view.util.FormOperation;
import ${fqClassName};

import ${daoPackage}.${className}Dao;

import com.liferay.portal.kernel.util.ParamUtil;

public class Search${className}ActionBeanImpl implements Search${className}ActionBean {

	private Search${className}ModelBean modelBean;
	private Registry${className}ModelBean registryModelBean;
	private ${className}CrudPortlet crudPortlet;
	private ${className}Dao ${entityName}Dao;
	
	public Search${className}ActionBeanImpl(Search${className}ModelBean modelBean, Registry${className}ModelBean registryModelBean, 
			${className}CrudPortlet crudPortlet, ${className}Dao ${entityName}Dao) {
		this.modelBean = modelBean;
		this.registryModelBean = registryModelBean;
		this.crudPortlet = crudPortlet;
		this.${entityName}Dao = ${entityName}Dao;
	}

	@Override
	public void newAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		System.out.println("newAction fired!!!");
		
		registryModelBean.set${className}(new ${className}());
		registryModelBean.setFormOperation(FormOperation.NEW);
		
		syncSearch${className}Field(actionRequest);

		crudPortlet.setViewToRegistryJSP();
		
	}
	
	@Override
	public void printResultAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		System.out.println("printResultAction fired!!!");
		
		PortletSession portletSession = (PortletSession) actionRequest.getPortletSession(false);
		portletSession.setAttribute("sourceBean", "search${className}ModelBean", PortletSession.APPLICATION_SCOPE);
		portletSession.setAttribute("search${className}ModelBean", modelBean, PortletSession.APPLICATION_SCOPE);
	
		String baseURL =  actionRequest.getContextPath();
		String printUrl = baseURL + "/DocumentGeneratorServlet?templateName=lista${className}.ftl";
		
		actionRequest.setAttribute(${className}CrudPortlet.PRINT_URL_ATTR_KEY, printUrl);
		
		Search${className}Util.setCurPageResult(actionRequest, actionResponse);
		Search${className}Util.setSortPageResult(actionRequest, actionResponse);
		
		syncSearch${className}Field(actionRequest);
		
	}

	@Override
	public void resetSearchFieldsAction(ActionRequest actionRequest, ActionResponse actionResponse) {

		System.out.println("resetSearchFieldAction fired!!!");
		
		modelBean.getSearch${className}().setId(null);
		modelBean.getSearch${className}().setFirstname(null);
		modelBean.getSearch${className}().setLastname(null);
		modelBean.getSearch${className}().setAddress(null);

		Search${className}Util.setCurPageResult(actionRequest, actionResponse);
		Search${className}Util.setSortPageResult(actionRequest, actionResponse);
		
	}

	@Override
	public void searchAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		System.out.println("searchAction fired!!!");
		
		try {
			
			syncSearch${className}Field(actionRequest);
			
			search();
			
		} catch (Exception ex) {
			actionRequest.setAttribute(${className}CrudPortlet.ERROR_MESSAGE_ATTR_KEY, "search.msg.fail");
			ex.printStackTrace();
		}
		
	}

	@Override
	public void printDetailAction(ActionRequest actionRequest, ActionResponse actionResponse) {

		System.out.println("printDetailAction fired!!!");
		
		${keyFieldType} idSelected = ParamUtil.get${keyFieldType}(actionRequest, "id");
		
		List<${className}> ${entityName}List = modelBean.get${className}List();
		${className} selected${className} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(idSelected)));

		PortletSession portletSession = actionRequest.getPortletSession(false);
		portletSession.setAttribute("sourceBean", "selected${className}", PortletSession.APPLICATION_SCOPE);
		portletSession.setAttribute("selected${className}", selected${className}, PortletSession.APPLICATION_SCOPE);

		String baseURL =  actionRequest.getContextPath();
		String printUrl = baseURL + "/DocumentGeneratorServlet?templateName=dettaglio${className}.ftl";				
		
		actionRequest.setAttribute(${className}CrudPortlet.PRINT_URL_ATTR_KEY, printUrl);
		
		Search${className}Util.setCurPageResult(actionRequest, actionResponse);
		Search${className}Util.setSortPageResult(actionRequest, actionResponse);
		
		syncSearch${className}Field(actionRequest);
	}

	@Override
	public void showAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		System.out.println("showAction fired!!!");
		
		${keyFieldType} selectedId = ParamUtil.get${keyFieldType}(actionRequest, "id");
		List<${className}> ${entityName}List = modelBean.get${className}List();
		
		${className} selected${className} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(selectedId)));
		
		if (selected${className} != null) {
			registryModelBean.set${className}(selected${className});
			registryModelBean.setFormOperation(FormOperation.SHOW);
			
			crudPortlet.setViewToRegistryJSP();
		}
			
	}
	
	@Override
	public void editAction(ActionRequest actionRequest, ActionResponse actionResponse) {

		System.out.println("editAction fired!!!");

		${keyFieldType} idSelected = ParamUtil.get${keyFieldType}(actionRequest, "id");
		List<${className}> ${entityName}List = modelBean.get${className}List();
		${className} selected${className} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(idSelected)));
		
		if (selected${className} != null) {
			registryModelBean.set${className}(selected${className});
			registryModelBean.setFormOperation(FormOperation.EDIT);

			crudPortlet.setViewToRegistryJSP();
		}
		
	}

	@Override
	public void deleteAction(ActionRequest actionRequest, ActionResponse actionResponse) {

		System.out.println("deleteAction fired!!! [" + ParamUtil.getLong(actionRequest, "id") + "]");

		${keyFieldType} idSelected = ParamUtil.get${keyFieldType}(actionRequest, "id");
		List<${className}> ${entityName}List = modelBean.get${className}List();
		${className} selected${className} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(idSelected)));
		
		if (selected${className} != null) {
			// delete the specified record
			try {
				
				${entityName}Dao.delete(selected${className});
				
			} catch (Exception ex) {
				actionRequest.setAttribute(${className}CrudPortlet.ERROR_MESSAGE_ATTR_KEY, "delete.msg.fail");
				ex.printStackTrace();
			}
		}
		
		// update the search
		try  {
			
			search();
			
		} catch (Exception ex) {
			actionRequest.setAttribute(${className}CrudPortlet.ERROR_MESSAGE_ATTR_KEY, "search-after-delete.msg.fail");
			ex.printStackTrace();
		}
		
		Search${className}Util.setCurPageResult(actionRequest, actionResponse);
		Search${className}Util.setSortPageResult(actionRequest, actionResponse);
		
	}
	
	private void search() {
		modelBean.set${className}List(${entityName}Dao.findBy(modelBean.getSearch${className}()));	
	}
	
	private void syncSearch${className}Field(ActionRequest request) {
		
		if (ParamUtil.getString(request, Search${className}ModelBean.SEARCH_FIELD_ID).isEmpty() ||
				!NumberUtils.isNumber(ParamUtil.getString(request, Search${className}ModelBean.SEARCH_FIELD_ID))) {
			modelBean.getSearch${className}().setId(null);
		} else {
			modelBean.getSearch${className}().setId(ParamUtil.getLong(request, Search${className}ModelBean.SEARCH_FIELD_ID));
		}
		
		modelBean.getSearch${className}().setFirstname(ParamUtil.getString(request, Search${className}ModelBean.SEARCH_FIELD_FIRSTNAME));
		modelBean.getSearch${className}().setLastname(ParamUtil.getString(request, Search${className}ModelBean.SEARCH_FIELD_LASTNAME));
		modelBean.getSearch${className}().setAddress(ParamUtil.getString(request, Search${className}ModelBean.SEARCH_FIELD_ADDRESS));
		
	}
}
