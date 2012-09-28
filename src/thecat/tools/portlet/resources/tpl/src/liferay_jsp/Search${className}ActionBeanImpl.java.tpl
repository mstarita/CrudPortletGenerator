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

<#list fieldList as field>			
		modelBean.getSearch${className}().set${field.fieldName?cap_first}(null);
</#list>

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
		
		${keyFieldType} selected${keyField?cap_first} = new ${keyFieldType}(actionRequest.getParameter("id"));
		
		List<${className}> ${entityName}List = modelBean.get${className}List();
		${className} selected${className} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(selected${keyField?cap_first})));

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
		
		${keyFieldType} selected${keyField?cap_first} = new ${keyFieldType}(actionRequest.getParameter("id"));

		List<${className}> ${entityName}List = modelBean.get${className}List();
		
		${className} selected${className} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(selected${keyField?cap_first})));
		
		if (selected${className} != null) {
			registryModelBean.set${className}(selected${className});
			registryModelBean.setFormOperation(FormOperation.SHOW);
			
			crudPortlet.setViewToRegistryJSP();
		}
			
	}
	
	@Override
	public void editAction(ActionRequest actionRequest, ActionResponse actionResponse) {

		System.out.println("editAction fired!!!");

		${keyFieldType} selected${keyField?cap_first} = new ${keyFieldType}(actionRequest.getParameter("id"));
		
		List<${className}> ${entityName}List = modelBean.get${className}List();
		${className} selected${className} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(selected${keyField?cap_first})));
		
		if (selected${className} != null) {
			registryModelBean.set${className}(selected${className});
			registryModelBean.setFormOperation(FormOperation.EDIT);

			crudPortlet.setViewToRegistryJSP();
		}
		
	}

	@Override
	public void deleteAction(ActionRequest actionRequest, ActionResponse actionResponse) {

		System.out.println("deleteAction fired!!!");

		${keyFieldType} selected${keyField?cap_first} = new ${keyFieldType}(actionRequest.getParameter("id"));
		
		List<${className}> ${entityName}List = modelBean.get${className}List();
		${className} selected${className} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(selected${keyField?cap_first})));
		
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
		
		if (ParamUtil.getString(request, Search${className}ModelBean.SEARCH_FIELD_${keyField?upper_case}).isEmpty()) {
			modelBean.getSearch${className}().set${keyField?cap_first}(null);
		} else {
<#if keyFieldType == "String" >
			modelBean.getSearch${className}().set${keyField?cap_first}(request.getParameter(Search${className}ModelBean.SEARCH_FIELD_${keyField?upper_case}));
<#else>
			modelBean.getSearch${className}().set${keyField?cap_first}(new ${keyFieldType}(request.getParameter(Search${className}ModelBean.SEARCH_FIELD_${keyField?upper_case})));
</#if>
		}

<#list fieldList as field>
	<#if field.fieldName != keyField>
		<#if field.fieldType == "String" >			
		modelBean.getSearch${className}().set${field.fieldName?cap_first}(request.getParameter(Search${className}ModelBean.SEARCH_FIELD_${field.fieldName?upper_case}));
		<#else>
		modelBean.getSearch${className}().set${field.fieldName?cap_first}(new ${field.fieldType}(request.getParameter(Search${className}ModelBean.SEARCH_FIELD_${field.fieldName?upper_case})));
		</#if>
	</#if>
</#list>
		
	}
}
