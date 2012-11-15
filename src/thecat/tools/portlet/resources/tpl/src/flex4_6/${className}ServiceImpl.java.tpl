package ${packageName}.service;

import java.util.List;

import org.granite.context.GraniteContext;
import org.granite.messaging.webapp.HttpGraniteContext;

<#list importList as import>
import ${import};
</#list>

public class ${className}ServiceImpl implements PersonService {

	private ${className}Dao ${entityName}Dao = new ${className}DaoImpl();
	
	@Override
	public void deleteAction(${className} ${entityName}) throws Exception {
		
		System.out.println("deleteAction fired!!!");
		
		${entityName}Dao.delete(${entityName});
		
	}

	@Override
	public void updateAction(${className} ${entityName}) throws Exception {
		
		System.out.println("updateAction fired!!!");
		
		${entityName}Dao.update(${entityName});
		
	}

	@Override
	public ${className} newAction(${className} ${entityName}) throws Exception {
		
		System.out.println("newAction fired!!!");
		
		${entityName}Dao.create(${entityName});
		return ${entityName};
		
	}

	@Override
	public String printDetailAction(${className} ${entityName}) throws Exception {
		
		System.out.println("printDetailAction fired!!!");

		GraniteContext.getCurrentInstance().getSessionMap().put("sourceBean", "selected${className}");
		GraniteContext.getCurrentInstance().getSessionMap().put("selected${className}", ${entityName});

		String baseURL =  ((HttpGraniteContext) GraniteContext.getCurrentInstance()).getRequest().getContextPath();
		String printUrl = baseURL + "/DocumentGeneratorServlet?templateName=dettaglio${className}.ftl";				
		
		return printUrl;
	}

	@Override
	public String printListAction(List<${className}> ${entityName}List) throws Exception {
		
		System.out.println("printListAction fired!!!");
		
		GraniteContext.getCurrentInstance().getSessionMap().put("sourceList", "${entityName}List");
		GraniteContext.getCurrentInstance().getSessionMap().put("${entityName}List", ${entityName}List);

		String baseURL =  ((HttpGraniteContext) GraniteContext.getCurrentInstance()).getRequest().getContextPath();
		String printUrl = baseURL + "/DocumentGeneratorServlet?templateName=lista${className}.ftl";
		
		return printUrl;
	}

	@Override
	public List<${className}> searchAction(${className} ${entityName}) throws Exception {
		
		System.out.println("searchAction fired!!! [" + ${entityName}.toString() + "]");
		
		return ${entityName}Dao.findBy(${entityName});
		
	}

}
