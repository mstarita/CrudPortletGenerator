package ${packageName};

import java.io.Serializable;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.portlet.PortletSession;

import com.liferay.faces.portal.el.I18N;

import ${viewUtilPackage}.FormOperation;
import ${viewUtilPackage}.FacesUtil;

import ${daoPackage}.${className}Dao;
import ${daoPackage}.${className}DaoImpl;

<#list importList as import>
import ${import};
</#list>

public class Registry${className}BackingBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Registry${className}ModelBean modelBean;
	private transient I18N i18n;
	
	public void setModelBean(final Registry${className}ModelBean modelBean) {
		this.modelBean = modelBean;
	}

	public Registry${className}ModelBean getModelBean() {
		return modelBean;
	}
	
	public void setFormOperation(final String operation) {
		modelBean.setFormOperation(FormOperation.valueOf(operation));
	}
	
	public FormOperation getFormOperation() {
		return modelBean.getFormOperation();
	}
	
	public I18N getI18n() {
		return i18n;
	}

	public void setI18n(I18N i18n) {
		this.i18n = i18n;
	}
	
	private void create${className}(final ${className} ${entityName}) {
		${className}Dao ${entityName}Dao = new ${className}DaoImpl();
		${entityName}Dao.create(${entityName});
	}
	
	private void update${className}(final ${className} ${entityName}) {
		${className}Dao ${entityName}Dao = new ${className}DaoImpl();
		${entityName}Dao.update(${entityName});
	}
	
	public String actionConfirm() {
		System.out.println("actionConfirm invoked!!!");
		
		if (! modelBean.getFormOperation().equals(FormOperation.SHOW)) {
			if (modelBean.getFormOperation().equals(FormOperation.EDIT)) {
				try {
					update${className}(modelBean.get${className}());
					FacesUtil.addMessage(FacesMessage.SEVERITY_INFO, i18n.getString("update.msg.success"), null);
				} catch (Exception ex) {
					FacesUtil.addMessage(FacesMessage.SEVERITY_ERROR, i18n.getString("update.msg.fail"), ex.getMessage());
					ex.printStackTrace();
				}
			} else if (modelBean.getFormOperation().equals(FormOperation.NEW)) {
				try {
					create${className}(modelBean.get${className}());
					FacesUtil.addMessage(FacesMessage.SEVERITY_INFO, i18n.getString("new.msg.success"), null);
				} catch (Exception ex) {
					FacesUtil.addMessage(FacesMessage.SEVERITY_ERROR, i18n.getString("new.msg.fail"), ex.getMessage());
					ex.printStackTrace();
				}
			}
		}
		
		return "confirm";
	}
	
	public String actionPrint() {
		System.out.println("actionPrint invoked!!!");
	
		// print the specified record
		if (modelBean.get${className}() != null && modelBean.get${className}().get${keyField?cap_first}() != null) {
				
			FacesContext fc = FacesContext.getCurrentInstance();
			
			String baseURL =  fc.getExternalContext().getRequestContextPath();
			String url = baseURL + "/DocumentGeneratorServlet?templateName=dettaglio${className}.ftl";
 
 <#if osivCrud >
 			${className}Dao ${entityName}Dao = new ${className}DaoImpl();
			${className} selected${className} = ${entityName}Dao.findBy${keyField?cap_first}(modelBean.get${className}().get${keyField?cap_first}());
<#else>
			${className} selected${className} = modelBean.get${className}();
</#if>
			
			PortletSession portletSession = (PortletSession) fc.getExternalContext().getSession(false);
			portletSession.setAttribute("sourceBean", "selected${className}", PortletSession.APPLICATION_SCOPE);
			portletSession.setAttribute("selected${className}", selected${className}, PortletSession.APPLICATION_SCOPE);
			
<#if osivCrud >
			// extend the hibernate session life
			portletSession.setAttribute(HibernateOsivFilter.EXTEND_CONVERSATION_FLAG, "", PortletSession.APPLICATION_SCOPE);
</#if>
						
		}
			
		return null;
	}
}
