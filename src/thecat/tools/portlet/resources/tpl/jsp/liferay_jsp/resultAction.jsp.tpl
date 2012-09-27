<%@include file="/${entityName}/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>

<%
ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

${className} ${entityName} = (${className}) row.getObject();
%>

<liferay-ui:icon-menu>
	<portlet:actionURL name="showAction" var="showActionURL">
		<portlet:param name="id" value="<%= ${entityName}.get${keyField?cap_first}().toString() %>" />
	</portlet:actionURL>
	<liferay-ui:icon image="view" message="<%= LanguageUtil.get(pageContext, "button.show") %>" url="<%= showActionURL.toString() %>" />
	
	<portlet:actionURL name="editAction" var="editActionURL">
		<portlet:param name="id" value="<%= ${entityName}.get${keyField?cap_first}().toString() %>" />
	</portlet:actionURL>
	<liferay-ui:icon image="edit" message="<%= LanguageUtil.get(pageContext, "button.edit") %>" url="<%= editActionURL.toString() %>"/>
	
	<portlet:actionURL name="deleteAction" var="deleteActionURL">
		<portlet:param name="id" value="<%= ${entityName}.get${keyField?cap_first}().toString() %>" />
	</portlet:actionURL>
	<liferay-ui:icon-delete url="<%= deleteActionURL.toString() %>" />
	
	<portlet:actionURL name="printDetailAction" var="printDetailActionURL" >
		<portlet:param name="id" value="<%= ${entityName}.get${keyField?cap_first}().toString() %>" />
	</portlet:actionURL>
	<liferay-ui:icon image="print" message="<%= LanguageUtil.get(pageContext, "button.print") %>" url="<%= printDetailActionURL.toString() %>"/>
</liferay-ui:icon-menu>