package ${packageName}.service;

import java.util.List;

import ${fqClassName};

public interface ${className}Service {

	List<${className}> searchAction(${className} ${entityName}) throws Exception;
	
	${className} newAction(${className} ${entityName}) throws Exception;
	void updateAction(${className} ${entityName}) throws Exception;
	void deleteAction(${className} ${entityName}) throws Exception;
	
	String printDetailAction(${className} ${entityName}) throws Exception;
	String printListAction(List<${className}> ${entityName}) throws Exception;
	
}
