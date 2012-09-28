package ${packageName};

import java.io.Serializable;
import java.util.List;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.portlet.PortletSession;

import org.edorasframework.extfaces.el.I18N;

import ${viewUtilPackage}.FormOperation;
import ${viewUtilPackage}.FacesUtil;
import ${daoPackage}.${className}Dao;
import ${daoPackage}.${className}DaoImpl;

<#list importList as import>
import ${import};
</#list>

import org.edorasframework.portletfaces.component.util.JavaScriptContextUtil;

public class Search${className}BackingBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Search${className}ModelBean searchModelBean;
	private Registry${className}ModelBean registryModelBean;
	private transient I18N i18n;
<#if ! icefacesExtReq>
	private ${keyFieldType} ${keyField}Selected;
</#if>

	public void setSearchModelBean(final Search${className}ModelBean searchModelBean) {
		this.searchModelBean = searchModelBean;
	}

	public Search${className}ModelBean getSearchModelBean() {
		return searchModelBean;
	}	

	public void setRegistryModelBean(final Registry${className}ModelBean registryModelBean) {
		this.registryModelBean = registryModelBean;
	}

	public Registry${className}ModelBean getRegistryModelBean() {
		return registryModelBean;
	}

	public void setI18n(I18N i18n) {
		this.i18n = i18n;
	}

	public I18N getI18n() {
		return i18n;
	}

<#if ! icefacesExtReq>
	public void set${keyField?cap_first}Selected(final ${keyFieldType} req${keyField?cap_first}) {
		System.out.println("set${keyField?cap_first}Selected(${keyFieldType}) [" + req${keyField?cap_first} + "]");
		
		${keyField}Selected = req${keyField?cap_first};
	}
</#if>

	public String actionSearch() {
		System.out.println("actionSearch invoked!!!");
		
		try {
			search();
		} catch (Exception ex) {
			FacesUtil.addMessage(FacesMessage.SEVERITY_ERROR, i18n.getString("search.msg.fail"), ex.getMessage());
			ex.printStackTrace();
		}
		
		return null;
	}
	
	public String actionDelete() {
		System.out.println("actionDelete invoked!!!");
		
<#if icefacesExtReq>
		String ${keyField} = FacesUtil.getRequestParameter("${keyField}");
		if (${keyField} != null) {
	<#if keyFieldType == "String" >
			${keyFieldType} ${keyField}Selected = ${keyField};
	<#else>
			${keyFieldType} ${keyField}Selected = new ${keyFieldType}(${keyField});
	</#if>
			if (${keyField}Selected != null) {
				System.out.println("${keyField}Selected: " + ${keyField}Selected);
<#else>
		if (${keyField}Selected != null) {
</#if>
			List<${className}> ${entityName}List = searchModelBean.get${className}List();
			${className} ${entityName} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(${keyField}Selected)));
			
			if (${entityName} != null) {
				// delete the specified record
				try {
					${className}Dao ${entityName}Dao = new ${className}DaoImpl();
					${entityName}Dao.delete(${entityName});
				} catch (Exception ex) {
					FacesUtil.addMessage(FacesMessage.SEVERITY_ERROR, i18n.getString("delete.msg.fail"), ex.getMessage());
					ex.printStackTrace();
				}
			}
			
			// update the search
			try  {
				search();
			} catch (Exception ex) {
				FacesUtil.addMessage(FacesMessage.SEVERITY_ERROR, i18n.getString("search-after-delete.msg.fail"), ex.getMessage());
				ex.printStackTrace();
			}
		}
<#if icefacesExtReq>
		} else {
			System.out.println("${keyField}Selected is NULL!!!");
		}
</#if>
		
		return null;
	}
	
	public String actionShow() {
		System.out.println("actionShow invoked!!!");
		
<#if icefacesExtReq>
		String ${keyField} = FacesUtil.getRequestParameter("${keyField}");
		if (${keyField} != null) {
	<#if keyFieldType == "String" >
			${keyFieldType} ${keyField}Selected = ${keyField};
	<#else>
			${keyFieldType} ${keyField}Selected = new ${keyFieldType}(${keyField});
	</#if>
			if (${keyField}Selected != null) {
				System.out.println("${keyField}Selected: " + ${keyField}Selected);
<#else>
		if (${keyField}Selected != null) {
</#if>
<#if osivCrud >
			${className}Dao ${entityName}Dao = new ${className}DaoImpl();
			${className} ${entityName} = ${entityName}Dao.findBy${keyField?cap_first}(${keyField}Selected);
<#else>
			List<${className}> ${entityName}List = searchModelBean.get${className}List();
			${className} ${entityName} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(${keyField}Selected)));
</#if>
			
			if (${entityName} != null) {
				registryModelBean.set${className}(${entityName});
				registryModelBean.setFormOperation(FormOperation.SHOW);
				
				return "show";
			}
			
			return null;
		}

<#if icefacesExtReq>		
		} else {
			System.out.println("${keyField}Selected is NULL!!!");
		}
</#if>
		return null;
	}
	
	public String actionEdit() {
		System.out.println("actionEdit invoked!!!");

<#if icefacesExtReq>
		String ${keyField} = FacesUtil.getRequestParameter("${keyField}");
		if (${keyField} != null) {
	<#if keyFieldType == "String" >
			${keyFieldType} ${keyField}Selected = ${keyField};
	<#else>
			${keyFieldType} ${keyField}Selected = new ${keyFieldType}(${keyField});
	</#if>
			if (${keyField}Selected != null) {
				System.out.println("${keyField}Selected: " + ${keyField}Selected);
<#else>
		if (${keyField}Selected != null) {
</#if>
<#if osivCrud >
			${className}Dao ${entityName}Dao = new ${className}DaoImpl();
			${className} ${entityName} = ${entityName}Dao.findBy${keyField?cap_first}(${keyField}Selected);
<#else>
			List<${className}> ${entityName}List = searchModelBean.get${className}List();
			${className} ${entityName} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(${keyField}Selected)));
</#if>
			
			if (${entityName} != null) {
				registryModelBean.set${className}(${entityName});
				registryModelBean.setFormOperation(FormOperation.EDIT);
				
				return "edit";
			}
			
			return null;
		}
<#if icefacesExtReq>		
		} else {
			System.out.println("${keyField}Selected is NULL!!!");
		}
</#if>

		return null;
	}
	
	public String actionNew() {
		System.out.println("actionNew invoked!!!");
		
		registryModelBean.set${className}(new ${className}());
		registryModelBean.setFormOperation(FormOperation.NEW);
		
		return "new";
	}
	
	public void actionPrintResult(ActionEvent actionEvent) {
		System.out.println("actionPrintResult invoked!!!");
		
		if (searchModelBean.get${className}List() != null && 
			!searchModelBean.get${className}List().isEmpty()) {
			
			FacesContext fc = FacesContext.getCurrentInstance();
			
			String baseURL =  fc.getExternalContext().getRequestContextPath();
			String url = baseURL + "/DocumentGeneratorServlet?templateName=lista${className}.ftl";
 
			PortletSession portletSession = (PortletSession) fc.getExternalContext().getSession(false);
			portletSession.setAttribute("sourceBean", "search${className}ModelBean", PortletSession.APPLICATION_SCOPE);
			portletSession.setAttribute("search${className}ModelBean", searchModelBean, PortletSession.APPLICATION_SCOPE);
						
			JavaScriptContextUtil.addFunction(fc, 
						"window.open('" + url + "', 'file', 'scrollbars=yes,toolbar=no,location=no')");
			
		}
	}
	
	public void actionPrintDetail(ActionEvent actionEvent) {
		System.out.println("actionPrintDetail invoked!!!");

<#if icefacesExtReq>
		String ${keyField} = FacesUtil.getRequestParameter("${keyField}");
		if (${keyField} != null) {
	<#if keyFieldType == "String" >
			${keyFieldType} ${keyField}Selected = ${keyField};
	<#else>
			${keyFieldType} ${keyField}Selected = new ${keyFieldType}(${keyField});
	</#if>
			if (${keyField}Selected != null) {
				System.out.println("${keyField}Selected: " + ${keyField}Selected);
<#else>
		if (${keyField}Selected != null) {
</#if>
			// print the specified record
			if (searchModelBean.get${className}List() != null && 
					!searchModelBean.get${className}List().isEmpty()) {
				
				FacesContext fc = FacesContext.getCurrentInstance();
				
				String baseURL =  fc.getExternalContext().getRequestContextPath();
				String url = baseURL + "/DocumentGeneratorServlet?templateName=dettaglio${className}.ftl";

<#if osivCrud >
				${className}Dao ${entityName}Dao = new ${className}DaoImpl();
				${className} selected${className} = ${entityName}Dao.findBy${keyField?cap_first}(${keyField}Selected);
<#else>
				List<${className}> ${entityName}List = searchModelBean.get${className}List();
				${className} selected${className} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(${keyField}Selected)));
</#if>
	 
				PortletSession portletSession = (PortletSession) fc.getExternalContext().getSession(false);
				portletSession.setAttribute("sourceBean", "selected${className}", PortletSession.APPLICATION_SCOPE);
				portletSession.setAttribute("selected${className}", selected${className}, PortletSession.APPLICATION_SCOPE);

<#if osivCrud >				
				// Extend the "life" of hibernate session 4 Lazy entity relations
				portletSession.setAttribute(HibernateOsivFilter.EXTEND_CONVERSATION_FLAG, "", PortletSession.APPLICATION_SCOPE);
</#if>
			
				JavaScriptContextUtil.addFunction(fc, 
							"window.open('" + url + "', 'file', 'scrollbars=yes,toolbar=no,location=no')");
				
			}
		}
<#if icefacesExtReq>
		} else {
			System.out.println("${keyField}Selected is NULL!!!");
		}
</#if>
	}
	
	public void search() {
		${className}Dao ${entityName}Dao = new ${className}DaoImpl();
		searchModelBean.set${className}List(${entityName}Dao.findBy(searchModelBean.getSearch${className}()));	
	}

}
