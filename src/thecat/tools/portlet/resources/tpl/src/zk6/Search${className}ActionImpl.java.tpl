package ${packageName};

import java.util.Locale;

import org.zkoss.util.resource.impl.LabelLoader;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Session;

import ${viewUtilPackage}.FormOperation;

import ${daoPackage}.${className}Dao;
import ${daoPackage}.${className}DaoImpl;

<#list importList as import>
import ${import};
</#list>

public class Search${className}ActionImpl implements Search${className}Action {

	private static final long serialVersionUID = 1L;
	
	private Search${className}Model searchModel;
	private Registry${className}Model registryModel;

	private ${className}Dao ${entityName}Dao = new ${className}DaoImpl();
	
	private LabelLoader labelLoader;
	private Locale locale;
	
	public Search${className}ActionImpl(Search${className}Model searchModel, Registry${className}Model registryModel,
		LabelLoader labelLoader, Locale locale) {
		
		this.searchModel = searchModel;
		this.registryModel = registryModel;
		
		this.labelLoader = labelLoader;
		this.locale = locale;
		
	}
	
	public void actionSearch() {
		System.out.println("actionSearch invoked!!!");
		
		try {
			
			search();
			
		} catch (Exception ex) {
			
			searchModel.setInfoMessage(null);
			searchModel.setErrorMessage(labelLoader.getLabel(locale, "search.msg.fail"));
			ex.printStackTrace();
			
		}
		
		resetMsgs();
	}
	
	public void actionConfirmDelete(${className} ${entityName}) {
		System.out.println("actionConfirmDelete invoked!!!");
			
		if (${entityName} != null) {
			searchModel.setShowConfirmDelete(true);
			searchModel.set${className}ToDelete(${entityName});
		}
		
		resetMsgs();
	}
	
	public void actionDeleteConfirm() {
		System.out.println("actionDeleteConfirm invoked!!!");
			
		if (searchModel.get${className}ToDelete() != null) {
			// delete the specified record
			try {
				
				${entityName}Dao.delete(searchModel.get${className}ToDelete());
				
				// update the search
				try  {
					search();
				} catch (Exception ex) {
					
					searchModel.setInfoMessage(null);
					searchModel.setErrorMessage(labelLoader.getLabel(locale, "search-after-delete.msg.fail"));
					ex.printStackTrace();
				}
				
			} catch (Exception ex) {
				
				searchModel.setInfoMessage(null);
				searchModel.setErrorMessage(labelLoader.getLabel(locale, "delete.msg.fail"));
				ex.printStackTrace();
				
			}
		}
		
		searchModel.setShowConfirmDelete(false);

	}
	
	public void actionDeleteCancel() {
		System.out.println("actionDeleteCancel invoked!!!");
			
		searchModel.setShowConfirmDelete(false);

	}
	
	public void actionShow(${className} ${entityName}) {
		System.out.println("actionShow invoked!!!");
		
		if (${entityName} != null) {
			
			registryModel.set${className}(${entityName});
			registryModel.setFormOperation(FormOperation.SHOW);
			
			View${className}Util.showRegistry();
			
		}
		
		resetMsgs();
	}
	
	public void actionEdit(${className} ${entityName}) {
		System.out.println("actionEdit invoked!!!");
			
		if (${entityName} != null) {
			${className} selected${className} = ${entityName}Dao.findBy${keyField?cap_first}(${entityName}.get${keyField?cap_first}());
			registryModel.set${className}(selected${className});
			registryModel.setFormOperation(FormOperation.EDIT);
			
			View${className}Util.showRegistry();
		}
		
		resetMsgs();
	}
	
	public void actionPrintDetail(Session session, ${className} ${entityName}) {
		System.out.println("actionPrintDetail invoked!!!");
		
		session.setAttribute("sourceBean", "selected${className}");
		session.setAttribute("selected${className}", ${entityName});

		String printUrl = "/DocumentGeneratorServlet?templateName=dettaglio${className}.ftl";				
		Executions.getCurrent().sendRedirect(printUrl, "_blank");
		
		resetMsgs();
	}
	
	public void actionNew() {
		System.out.println("actionNew invoked!!!");
		
		registryModel.set${className}(new ${className}());
		registryModel.setFormOperation(FormOperation.NEW);
		
		View${className}Util.showRegistry();

		resetMsgs();
	}
	
	public void actionPrintResult(Session session) {
		System.out.println("actionPrintResult invoked!!!");
		
		session.setAttribute("sourceBean", "search${className}ModelBean");
		session.setAttribute("search${className}ModelBean", searchModel);
		
		String printUrl = "/DocumentGeneratorServlet?templateName=lista${className}.ftl";				
		Executions.getCurrent().sendRedirect(printUrl, "_blank");
		
		resetMsgs();
	}
	
	public void actionReset() {
		System.out.println("actionReset invoked!!!");

<#list fieldList as field>			
		searchModel.getSearch${className}().set${field.fieldName?cap_first}(null);
</#list>

		resetMsgs();
	}
	
	public void search() {
		searchModel.set${className}List(${entityName}Dao.findBy(searchModel.getSearch${className}()));	
	}

	private void resetMsgs() {
		searchModel.setInfoMessage(null);
		searchModel.setErrorMessage(null);
	}
	
}
