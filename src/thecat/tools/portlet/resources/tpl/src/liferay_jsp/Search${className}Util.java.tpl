package ${packageName};

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletSession;

import com.liferay.portal.kernel.dao.search.SearchContainer;
import com.liferay.portal.kernel.util.Validator;

public class Search${className}Util {

	private Search${className}Util() { }
	
	public static void setCurPageResult(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		String curResultPageAttrKey = 
			(String) actionRequest.getPortletSession().getAttribute(
					${className}CrudPortlet.CUR_RESULT_PAGE_ATTR_KEY, 
					PortletSession.APPLICATION_SCOPE);
		
		if (Validator.isNotNull(curResultPageAttrKey)) {
			actionResponse.setRenderParameter(
				SearchContainer.DEFAULT_CUR_PARAM, 
				curResultPageAttrKey);
		}
		
	}
	
	public static void setSortPageResult(ActionRequest actionRequest, ActionResponse actionResponse) {
		
		actionResponse.setRenderParameter(
				SearchContainer.DEFAULT_ORDER_BY_COL_PARAM, 
				(String) actionRequest.getPortletSession().getAttribute(${className}CrudPortlet.ORDER_BY_COL_RESULT_PAGE_ATTR_KEY, 
				PortletSession.APPLICATION_SCOPE));
		actionResponse.setRenderParameter(
				SearchContainer.DEFAULT_ORDER_BY_TYPE_PARAM, 
				(String) actionRequest.getPortletSession().getAttribute(${className}CrudPortlet.ORDER_BY_TYPE_RESULT_PAGE_ATTR_KEY, 
				PortletSession.APPLICATION_SCOPE));
		
	}
	
}
