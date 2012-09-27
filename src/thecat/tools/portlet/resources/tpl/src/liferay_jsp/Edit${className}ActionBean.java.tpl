package ${packageName};

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;

public interface Edit${className}ActionBean {

	void selectAllSearchFieldAction(ActionRequest actionRequest, ActionResponse actionResponse);
		
	void deselectAllSearchFieldAction(ActionRequest actionRequest, ActionResponse actionResponse);
		
	void selectAllResultFieldAction(ActionRequest actionRequest, ActionResponse actionResponse);
		
	void deselectAllResultFieldAction(ActionRequest actionRequest, ActionResponse actionResponse);
		
	void selectAllRegistryFieldAction(ActionRequest actionRequest, ActionResponse actionResponse);
		
	void deselectAllRegistryFieldAction(ActionRequest actionRequest, ActionResponse actionResponse);
		
	void savePrefsAction(ActionRequest actionRequest, ActionResponse actionResponse);
		
	void resetPrefsAction(ActionRequest actionRequest, ActionResponse actionResponse);
		
}
