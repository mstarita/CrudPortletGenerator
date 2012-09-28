package ${packageName};

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletSession;

import ${viewUtilPackage}.FormOperation;
import ${fqClassName};

import ${daoPackage}.${className}Dao;

import com.liferay.portal.kernel.util.ParamUtil;

public class Registry${className}ActionBeanImpl implements Registry${className}ActionBean {

	private Registry${className}ModelBean modelBean;
	private ${className}CrudPortlet crudPortlet;
	private ${className}Dao ${entityName}Dao;
	
	public Registry${className}ActionBeanImpl(Registry${className}ModelBean modelBean, ${className}CrudPortlet crudPortlet, ${className}Dao ${entityName}Dao) {
		this.modelBean = modelBean;
		this.crudPortlet = crudPortlet;
		this.${entityName}Dao = ${entityName}Dao;
	}

	@Override
	public void printRegistryAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		System.out.println("printRegistryAction fired!!!");
		 
		${className} selected${className} = modelBean.get${className}();
		
		PortletSession portletSession = (PortletSession) actionRequest.getPortletSession(false);
		portletSession.setAttribute("sourceBean", "selected${className}", PortletSession.APPLICATION_SCOPE);
		portletSession.setAttribute("selected${className}", selected${className}, PortletSession.APPLICATION_SCOPE);
		
		String baseURL =  actionRequest.getContextPath();
		String printUrl = baseURL + "/DocumentGeneratorServlet?templateName=dettaglio${className}.ftl";
		
		actionRequest.setAttribute(${className}CrudPortlet.PRINT_URL_ATTR_KEY, printUrl);
		
	}
	
	@Override
	public void confirmRegistryAction(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		System.out.println("confirmRegistryAction fired!!!");
		
		if (!modelBean.getFormOperation().equals(FormOperation.SHOW)) {

<#list fieldList as field>
	<#if field.fieldName != keyField>
		<#if field.fieldType == "String" >		
			modelBean.get${className}().set${field.fieldName?cap_first}((${field.fieldType}) actionRequest.getParameter(Registry${className}ModelBean.REGISTRY_FIELD_${field.fieldName?upper_case}));
		<#else>
			modelBean.get${className}().set${field.fieldName?cap_first}(new ${field.fieldType}(actionRequest.getParameter(Registry${className}ModelBean.REGISTRY_FIELD_${field.fieldName?upper_case})));
		</#if>
	</#if>
</#list>
			
			if (modelBean.getFormOperation().equals(FormOperation.EDIT)) {
				try {
					
					update${className}(modelBean.get${className}());
					actionRequest.setAttribute(${className}CrudPortlet.INFO_MESSAGE_ATTR_KEY, "update.msg.success");
					
				} catch (Exception ex) {
					
					actionRequest.setAttribute(${className}CrudPortlet.ERROR_MESSAGE_ATTR_KEY, "update.msg.fail");
					ex.printStackTrace();
					return;
				}
			} else if (modelBean.getFormOperation().equals(FormOperation.NEW)) {
				try {
					
					create${className}(modelBean.get${className}());
					actionRequest.setAttribute(${className}CrudPortlet.INFO_MESSAGE_ATTR_KEY, "new.msg.success");
					
				} catch (Exception ex) {
					
					actionRequest.setAttribute(${className}CrudPortlet.ERROR_MESSAGE_ATTR_KEY, "new.msg.fail");
					ex.printStackTrace();
					return;
				}
			}
		}
		
		Search${className}Util.setCurPageResult(actionRequest, actionResponse);
		Search${className}Util.setSortPageResult(actionRequest, actionResponse);
		
		crudPortlet.setViewToSearchJSP();

	}

	@Override
	public void cancelRegistryAction(ActionRequest actionRequest, ActionResponse actionResponse) {
	
		System.out.println("cancelRegistryAction fired!!!");
		
		Search${className}Util.setCurPageResult(actionRequest, actionResponse);
		Search${className}Util.setSortPageResult(actionRequest, actionResponse);
		
		crudPortlet.setViewToSearchJSP();
		
	}

	private void update${className}(final ${className} ${entityName}) {
		${entityName}Dao.update(${entityName});
	}
	
	private void create${className}(final ${className} ${entityName}) {
		${entityName}Dao.create(${entityName});
	}
}
