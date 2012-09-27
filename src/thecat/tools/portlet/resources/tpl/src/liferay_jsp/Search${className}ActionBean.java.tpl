package ${packageName};

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;

public interface Search${className}ActionBean {

	void newAction(ActionRequest actionRequest, ActionResponse actionResponse);

	void printResultAction(ActionRequest actionRequest, ActionResponse actionResponse);

	void resetSearchFieldsAction(ActionRequest actionRequest, ActionResponse actionResponse);

	void searchAction(ActionRequest actionRequest, ActionResponse actionResponse);

	void printDetailAction(ActionRequest actionRequest, ActionResponse actionResponse);
	
	void showAction(ActionRequest actionRequest, ActionResponse actionResponse);
	
	void editAction(ActionRequest actionRequest, ActionResponse actionResponse);

	void deleteAction(ActionRequest actionRequest, ActionResponse actionResponse);
		
}
