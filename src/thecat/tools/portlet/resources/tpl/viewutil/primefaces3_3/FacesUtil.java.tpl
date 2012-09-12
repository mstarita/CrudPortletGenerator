package ${viewUtilPackage};

import java.util.Map;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;

public class FacesUtil {

	public static void addMessage(FacesMessage.Severity severity, String message, String detail) {
		FacesMessage facesMessage = new FacesMessage(severity, message, detail);
		FacesContext.getCurrentInstance().addMessage(null, facesMessage);
	}
	
	public static String getRequestParameter(String param) {
		String value = null;
		
		Map<String, String> requestParamMap = FacesContext.getCurrentInstance().getExternalContext().getRequestParameterMap();
		value = requestParamMap.get(param);
		
		return value;
	}
	
	public String getBaseUrl() {
		return FacesContext.getCurrentInstance().getExternalContext().getRequestContextPath();
	}
}
