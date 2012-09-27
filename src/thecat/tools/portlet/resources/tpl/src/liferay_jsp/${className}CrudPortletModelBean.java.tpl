package ${packageName};

public class ${className}CrudPortletModelBean {
	
	public static final String EDIT_MODEL_BEAN_ATTR_KEY = "editModelBean";
	public static final String SEARCH_MODEL_BEAN_ATTR_KEY = "searchModelBean";
	public static final String REGISTRY_MODEL_BEAN_ATTR_KEY = "registryModelBean";
	
	public static final String INFO_MESSAGE_ATTR_KEY = "infoMessage";
	public static final String ERROR_MESSAGE_ATTR_KEY = "errorMessage";

	public static final String PRINT_URL_ATTR_KEY = "printUrl";

	public static final String CUR_RESULT_PAGE_ATTR_KEY = "curResultPage";
	public static final String ORDER_BY_COL_RESULT_PAGE_ATTR_KEY = "orderByColResultPage";
	public static final String ORDER_BY_TYPE_RESULT_PAGE_ATTR_KEY = "orderByTypeResultPage";
	
	public static final String SEARCH_JSP  = "/${entityName}/search.jsp";
	public static final String REGISTRY_JSP  = "/${entityName}/registry.jsp";
	
	private Edit${className}ModelBean editModelBean = null;
	private Edit${className}ActionBean editActionBean = null;
	
	private Search${className}ModelBean searchModelBean = null;
	private Search${className}ActionBean searchActionBean = null;
	
	private Registry${className}ModelBean registryModelBean = null;
	private Registry${className}ActionBean registryActionBean = null;
	
	public Edit${className}ModelBean getEditModelBean() {
		return editModelBean;
	}
	public void setEditModelBean(Edit${className}ModelBean editModelBean) {
		this.editModelBean = editModelBean;
	}
	
	public Edit${className}ActionBean getEditActionBean() {
		return editActionBean;
	}
	public void setEditActionBean(Edit${className}ActionBean editActionBean) {
		this.editActionBean = editActionBean;
	}
	
	public Search${className}ModelBean getSearchModelBean() {
		return searchModelBean;
	}
	public void setSearchModelBean(Search${className}ModelBean searchModelBean) {
		this.searchModelBean = searchModelBean;
	}
	
	public Search${className}ActionBean getSearchActionBean() {
		return searchActionBean;
	}
	public void setSearchActionBean(Search${className}ActionBean searchActionBean) {
		this.searchActionBean = searchActionBean;
	}
	
	public Registry${className}ModelBean getRegistryModelBean() {
		return registryModelBean;
	}
	public void setRegistryModelBean(Registry${className}ModelBean registryModelBean) {
		this.registryModelBean = registryModelBean;
	}
	
	public Registry${className}ActionBean getRegistryActionBean() {
		return registryActionBean;
	}
	public void setRegistryActionBean(Registry${className}ActionBean registryActionBean) {
		this.registryActionBean = registryActionBean;
	}

}
