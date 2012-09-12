package ${viewUtilPackage};

import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.portlet.PortletPreferences;
import javax.portlet.PortletRequest;

public class PortletUtil {

	public static PortletPreferences getPortletPreferences() {
		FacesContext facesContext = FacesContext.getCurrentInstance();
		ExternalContext externalContext = facesContext.getExternalContext();
		PortletRequest portletRequest = (PortletRequest) externalContext.getRequest();
		return portletRequest.getPreferences();
	}
}
