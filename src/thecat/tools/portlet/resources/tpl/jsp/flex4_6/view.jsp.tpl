<%@page session="false" contentType="text/html" pageEncoding="UTF-8" 
	import="${packageName}.Edit${className}ModelBean,
		${packageName}.${className}CrudPortlet,
		java.util.Locale,
		javax.portlet.RenderResponse, 
		org.apache.commons.lang3.StringUtils"
%>
<%
String flexFileName = request.getContextPath() + "/${entityName}/view.swf";
String flashWidth = "100%";
String flashHeight = "100%";

Edit${className}ModelBean modelBean = (Edit${className}ModelBean) request.getAttribute(${className}CrudPortlet.EDIT_MODEL_KEY);
Locale locale = (Locale) request.getAttribute(${className}CrudPortlet.LOCALE_KEY);

String flashVars = 
	Edit${className}ModelBean.PREFS_SEARCH_FIELDS + "=" + modelBean.getSearchFieldMapAsString() + 
	"&" + Edit${className}ModelBean.PREFS_RESULT_FIELDS + "=" + modelBean.getResultFieldMapAsString() + 
	"&" + Edit${className}ModelBean.PREFS_REGISTRY_FIELDS + "=" + modelBean.getRegistryFieldMapAsString() + 
	"&" + Edit${className}ModelBean.PREFS_N_COLS_SEARCH + "=" + modelBean.getnColsSearch() +
	"&" + Edit${className}ModelBean.PREFS_N_COLS_REGISTRY + "=" + modelBean.getnColsRegistry() +
	"&" + Edit${className}ModelBean.PREFS_ROWS_PER_PAGE + "=" + modelBean.getRowsPerPage() +
	"&locale=" + locale.toString();
%>

<script language="javascript" >
	function resizeContainer(height) {
		var div = document.getElementById("${entityName}ViewSwfWrapper");
		div.style.height = height + "px";
	}
</script>

<div id="${entityName}ViewSwfWrapper" style="overflow: auto; overflow-y:hidden">
	<object
		border="none"
		classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" 
		codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab" 
		width="<%= flashWidth %>" height="<%= flashHeight %>" > 
		<param name="movie" value="<%= flexFileName %>"/> 
		<param name="play" value="true"/>
		<param name="loop" value="false"/>
		<param name="quality" value="high"/>
		<param name="menu" value="false"/>
		<param name="wmode" value="window"/>
		<param name="allowScriptAccess" value="sameDomain" />
		<param name="flashVars" value="<%= flashVars %>"/>
		<embed 
			src="<%= flexFileName %>" 
			play="true" loop="false" quality="high" 
			menu="false" type="application/x-shockwave-flash" wmode="window" 
			pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?p1_prod_version=shockwaveflash" 
			width="<%= flashWidth %>" height="<%= flashHeight %>"
			allowScriptAccess="sameDomain"
			flashVars="<%= flashVars %>" />
	</object>
</div>
