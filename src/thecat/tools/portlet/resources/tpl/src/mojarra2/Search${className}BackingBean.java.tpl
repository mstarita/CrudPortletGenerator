package ${packageName};

import java.io.Serializable;
import java.util.List;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.portlet.PortletSession;

import com.liferay.faces.portal.el.I18N;

import ${viewUtilPackage}.FormOperation;
import ${viewUtilPackage}.FacesUtil;
import ${daoPackage}.${className}Dao;
import ${daoPackage}.${className}DaoImpl;

<#list importList as import>
import ${import};
</#list>

public class Search${className}BackingBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Search${className}ModelBean searchModelBean;
	private Registry${className}ModelBean registryModelBean;
	private transient I18N i18n;
	private Long idSelected;

	private boolean printing = false;
	private String printUrl = null;
	
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

	public void setIdSelected(final Long reqId) {
		System.out.println("setIdSelected(Long) [" + reqId + "]");
		
		idSelected = reqId;
	}

	public boolean isPrinting() { 
		return printing;
	}
	
	public String getPrintUrl() {
		return printUrl;
	}
	
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
		
		if (idSelected != null) {
			List<${className}> ${entityName}List = searchModelBean.get${className}List();
			${className} ${entityName} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(idSelected)));
			
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
				
		return null;
	}
	
	public String actionShow() {
		System.out.println("actionShow invoked!!!");
		
		if (idSelected != null) {
<#if osivCrud >
			${className}Dao ${entityName}Dao = new ${className}DaoImpl();
			${className} ${entityName} = ${entityName}Dao.findBy${keyField?cap_first}(idSelected);
<#else>
			List<${className}> ${entityName}List = searchModelBean.get${className}List();
			${className} ${entityName} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(idSelected)));
</#if>
			
			if (${entityName} != null) {
				registryModelBean.set${className}(${entityName});
				registryModelBean.setFormOperation(FormOperation.SHOW);
				
				return "show";
			}
			
		}
		
		return null;
	}
	
	public String actionEdit() {
		System.out.println("actionEdit invoked!!!");

		if (idSelected != null) {
<#if osivCrud >
			${className}Dao ${entityName}Dao = new ${className}DaoImpl();
			${className} ${entityName} = ${entityName}Dao.findBy${keyField?cap_first}(idSelected);
<#else>
			List<${className}> ${entityName}List = searchModelBean.get${className}List();
			${className} ${entityName} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(idSelected)));
</#if>
			
			if (${entityName} != null) {
				registryModelBean.set${className}(${entityName});
				registryModelBean.setFormOperation(FormOperation.EDIT);
				
				return "edit";
			}			
		}

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
 
			PortletSession portletSession = (PortletSession) fc.getExternalContext().getSession(false);
			portletSession.setAttribute("sourceBean", "search${className}ModelBean", PortletSession.APPLICATION_SCOPE);
			portletSession.setAttribute("search${className}ModelBean", searchModelBean, PortletSession.APPLICATION_SCOPE);
			
			String baseURL =  fc.getExternalContext().getRequestContextPath();
			printUrl = baseURL + "/DocumentGeneratorServlet?templateName=lista${className}.ftl";
			printing = true;
		}
	}
	
	public void actionPrintDetail(ActionEvent actionEvent) {
		System.out.println("actionPrintDetail invoked!!!");

		if (idSelected != null) {
			// print the specified record
			if (searchModelBean.get${className}List() != null && 
					!searchModelBean.get${className}List().isEmpty()) {
				
				FacesContext fc = FacesContext.getCurrentInstance();

<#if osivCrud >
				${className}Dao ${entityName}Dao = new ${className}DaoImpl();
				${className} selected${className} = ${entityName}Dao.findBy${keyField?cap_first}(idSelected);
<#else>
				List<${className}> ${entityName}List = searchModelBean.get${className}List();
				${className} selected${className} = ${entityName}List.get(${entityName}List.indexOf(new ${className}(idSelected)));
</#if>
	 
				PortletSession portletSession = (PortletSession) fc.getExternalContext().getSession(false);
				portletSession.setAttribute("sourceBean", "selected${className}", PortletSession.APPLICATION_SCOPE);
				portletSession.setAttribute("selected${className}", selected${className}, PortletSession.APPLICATION_SCOPE);

<#if osivCrud >				
				// Extend the "life" of hibernate session 4 Lazy entity relations
				portletSession.setAttribute(HibernateOsivFilter.EXTEND_CONVERSATION_FLAG, "", PortletSession.APPLICATION_SCOPE);
</#if>
			
				String baseURL =  fc.getExternalContext().getRequestContextPath();
				printUrl = baseURL + "/DocumentGeneratorServlet?templateName=dettaglio${className}.ftl";				
				printing = true;
			}
		}
	}
	
	public void search() {
		${className}Dao ${entityName}Dao = new ${className}DaoImpl();
		searchModelBean.set${className}List(${entityName}Dao.findBy(searchModelBean.getSearch${className}()));	
	}

}
