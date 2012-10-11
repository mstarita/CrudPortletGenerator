package ${packageName};

import org.zkoss.zk.ui.Executions;

public class View${className}Util {

	public static final String INCLUDE_ID_SEARCH = "search";
	public static final String INCLUDE_ID_REGISTRY = "registry";
	
	public static void showSearch() {
		
		Executions.getCurrent().getDesktop().getFirstPage().getFellow("viewWin").getFellow(INCLUDE_ID_SEARCH).setVisible(true);
		Executions.getCurrent().getDesktop().getFirstPage().getFellow("viewWin").getFellow(INCLUDE_ID_REGISTRY).setVisible(false);

	}
	
	public static void showRegistry() {
		
		Executions.getCurrent().getDesktop().getFirstPage().getFellow("viewWin").getFellow(INCLUDE_ID_SEARCH).setVisible(false);
		Executions.getCurrent().getDesktop().getFirstPage().getFellow("viewWin").getFellow(INCLUDE_ID_REGISTRY).setVisible(true);
		
	}
	
}
