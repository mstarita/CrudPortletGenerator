package ${packageName};

import java.util.Locale;

import org.zkoss.bind.annotation.Command;
import org.zkoss.bind.annotation.ContextParam;
import org.zkoss.bind.annotation.ContextType;
import org.zkoss.util.resource.impl.LabelLoader;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Session;

import thecat.common.view.util.FormOperation;

import ${daoPackage}.${className}Dao;
import ${daoPackage}.${className}DaoImpl;

<#list importList as import>
import ${import};
</#list>

public class Registry${className}ActionImpl implements Registry${className}Action {

	private static final long serialVersionUID = 1L;
	
	private Registry${className}Model registryModel;
	private Search${className}Model searchModel;

	private ${className}Dao ${entityName}Dao = new ${className}DaoImpl();
	
	private LabelLoader labelLoader;
	private Locale locale;
	
	public Registry${className}ActionImpl(Registry${className}Model registryModel, Search${className}Model searchModel,
		LabelLoader labelLoader, Locale locale) {
		
		this.registryModel = registryModel;
		this.searchModel = searchModel;
		
		this.labelLoader = labelLoader;
		this.locale = locale;
	}
	
	@Override
	@Command
	public void actionRegistryConfirm() {
		System.out.println("actionConfirm invoked!!! [" + registryModel.getFormOperation() + "]");
		
		if (! registryModel.getFormOperation().equals(FormOperation.SHOW)) {
			
			if (registryModel.getFormOperation().equals(FormOperation.EDIT)) {
				try {
					update${className}(registryModel.get${className}());
					
					searchModel.setInfoMessage(labelLoader.getLabel(locale, "update.msg.success"));
					searchModel.setErrorMessage(null);
				} catch (Exception ex) {
					searchModel.setInfoMessage(null);
					searchModel.setErrorMessage(labelLoader.getLabel(locale, "update.msg.fail"));
					
					ex.printStackTrace();
				}
			} else if (registryModel.getFormOperation().equals(FormOperation.NEW)) {				
				try {
					create${className}(registryModel.get${className}());
					
					searchModel.setInfoMessage(labelLoader.getLabel(locale, "new.msg.success"));
					searchModel.setErrorMessage(null);
				} catch (Exception ex) {
					searchModel.setInfoMessage(null);
					searchModel.setErrorMessage(labelLoader.getLabel(locale, "new.msg.fail"));
					
					ex.printStackTrace();
				}
			}
		}
		
		View${className}Util.showSearch();
	}

	@Override
	@Command
	public void actionRegistryCancel() {
		
		View${className}Util.showSearch();
		
	}
	
	@Override
	@Command
	public void actionRegistryPrint(@ContextParam(ContextType.SESSION) Session session) {
		session.setAttribute("sourceBean", "selected${className}");
		session.setAttribute("selected${className}", registryModel.get${className}());

		String printUrl = "/DocumentGeneratorServlet?templateName=dettaglio${className}.ftl";				
		Executions.getCurrent().sendRedirect(printUrl, "_blank");
	}
	
	private void create${className}(final ${className} ${entityName}) {		
		${entityName}Dao.create(${entityName});
	}
	
	private void update${className}(final ${className} ${entityName}) {
		${entityName}Dao.update(${entityName});
	}
}
