package ${packageName};

import org.zkoss.zk.ui.Session;

<#list importList as import>
import ${import};
</#list>

public interface Search${className}Action {
	
	void actionSearch();
	
	void actionConfirmDelete(${className} ${entityName});
	
	void actionDeleteConfirm();
	
	void actionDeleteCancel();
	
	void actionShow(${className} ${entityName});
	
	void actionEdit(${className} ${entityName});

	void actionPrintDetail(Session session, ${className} ${entityName});
	
	void actionNew();
	
	void actionPrintResult(Session session);

	void actionReset();
	
}
