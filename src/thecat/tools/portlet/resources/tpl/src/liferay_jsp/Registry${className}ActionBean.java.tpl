package ${packageName};

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;

public interface Registry${className}ActionBean {

	void printRegistryAction(ActionRequest actionRequest, ActionResponse actionResponse);
	
	void confirmRegistryAction(ActionRequest actionRequest, ActionResponse actionResponse);

	void cancelRegistryAction(ActionRequest actionRequest, ActionResponse actionResponse);
		
}
