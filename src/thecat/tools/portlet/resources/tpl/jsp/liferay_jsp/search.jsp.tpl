<%@include file="/${entityName}/init.jsp" %>

<%
	Edit${className}ModelBean editModelBean = (Edit${className}ModelBean) 
		request.getAttribute(${className}CrudPortlet.EDIT_MODEL_BEAN_ATTR_KEY);
	Search${className}ModelBean searchModelBean = (Search${className}ModelBean)
		request.getAttribute(${className}CrudPortlet.SEARCH_MODEL_BEAN_ATTR_KEY);
	
	String infoMessage = (String) request.getAttribute(${className}CrudPortlet.INFO_MESSAGE_ATTR_KEY);
	String errorMessage = (String) request.getAttribute(${className}CrudPortlet.ERROR_MESSAGE_ATTR_KEY);
	
	if (Validator.isNotNull(request.getParameter(SearchContainer.DEFAULT_CUR_PARAM))) {
		request.getSession().setAttribute(
				${className}CrudPortlet.CUR_RESULT_PAGE_ATTR_KEY, 
				request.getParameter(SearchContainer.DEFAULT_CUR_PARAM));
	}
	
	String orderByCol = ParamUtil.getString(request, SearchContainer.DEFAULT_ORDER_BY_COL_PARAM);
	String orderByType = ParamUtil.getString(request, SearchContainer.DEFAULT_ORDER_BY_TYPE_PARAM); 
	
	if (Validator.isNull(orderByCol)) {
		orderByCol = "id";
	}
	
	if (Validator.isNull(orderByType)) {
		orderByType = "asc";
	}
	
	request.getSession().setAttribute(
			${className}CrudPortlet.ORDER_BY_COL_RESULT_PAGE_ATTR_KEY, 
			orderByCol);
	request.getSession().setAttribute(
			${className}CrudPortlet.ORDER_BY_TYPE_RESULT_PAGE_ATTR_KEY, 
			orderByType);
%>

<portlet:actionURL name="newAction" var="newActionURL"/>
<portlet:actionURL name="printResultAction" var="printResultActionURL"/>
<portlet:actionURL name="resetSearchFieldsAction" var="resetSearchFieldsActionURL"/>
<portlet:actionURL name="searchAction" var="searchActionURL"/>

<aui:form action="" method="post">

	<h3 class="header"><span><%= LanguageUtil.get(pageContext, "${entityName}.search.header") %></span></h3>
	
	<aui:fieldset>
		<aui:layout>

<#list fieldList as field>
		<c:if test="<%= editModelBean.getSearchFieldMap().get("${field.fieldName}")%>">
			<aui:column columnWidth="<%= (int) (100 / editModelBean.getnColsSearch()) %>" >
				<aui:input name="<%= searchModelBean.SEARCH_FIELD_${field.fieldName?upper_case} %>" 
					label="<%= LanguageUtil.get(pageContext, "${entityName}.field.${field.fieldName}") %>" type="text" 
					value="<%= searchModelBean.getSearch${className}().get${field.fieldName?cap_first}() %>" />
			</aui:column>
		</c:if>
</#list>
		
		</aui:layout>
	</aui:fieldset>

	<liferay-ui:search-container delta="<%= editModelBean.getRowsPerPage().intValue() %>" 
		emptyResultsMessage="<%= LanguageUtil.get(pageContext, "grid.no.record.found") %>" 
		orderByCol="<%= orderByCol %>" orderByType="<%= orderByType %>" >
		<liferay-ui:search-container-results 
			results="<%= searchModelBean.get${className}List(request, searchContainer.getStart(), searchContainer.getEnd()) %>" 
			total="<%= searchModelBean.get${className}List().size() %>" />
			
			<liferay-ui:search-container-row className="${fqClassName}" keyProperty="${keyField}" modelVar="${entityName}" >
<#list fieldList as field>
				<c:if test="<%= editModelBean.getResultFieldMap().get("${field.fieldName}")%>">
					<liferay-ui:search-container-column-text name="<%= LanguageUtil.get(pageContext, "${entityName}.field.${field.fieldName}") %>" 
						value="<%= ${entityName}.get${field.fieldName?cap_first}().toString() %>" orderable="true" orderableProperty="${field.fieldName}" property="${field.fieldName}" />
				</c:if>
</#list>
				
				<liferay-ui:search-container-column-jsp path="/${entityName}/resultAction.jsp" />
				
			</liferay-ui:search-container-row>
			
			<liferay-ui:search-iterator />

	</liferay-ui:search-container>
	
	<hr/>
	
	<aui:button-row>
		<aui:button type="submit" name="newAction" value="<%= LanguageUtil.get(pageContext, "button.new") %>" 
			onClick='<%= "this.form.action = '" + newActionURL.toString() + "'"%>' />
		<c:if test="<%= searchModelBean.get${className}List().size() > 0 %>">
			<aui:button type="submit" name="printResultAction" value="<%= LanguageUtil.get(pageContext, "button.print") %>" 
				onClick='<%= "this.form.action = '" + printResultActionURL.toString() + "'"%>' />
		</c:if>
		<aui:button type="submit" name="resetSearchFieldsAction" value="<%= LanguageUtil.get(pageContext, "button.reset") %>" 
			onClick='<%= "this.form.action = '" + resetSearchFieldsActionURL.toString() + "'"%>' />
		<aui:button type="submit" name="searchAction" value="<%= LanguageUtil.get(pageContext, "button.search") %>" 
			onClick='<%= "this.form.action = '" + searchActionURL.toString() + "'"%>' />
	</aui:button-row>
	
	<c:if test="<%= request.getAttribute(${className}CrudPortlet.PRINT_URL_ATTR_KEY) != null %>">
		<script>window.open('<%= request.getAttribute(${className}CrudPortlet.PRINT_URL_ATTR_KEY) %>', 'file', 'scrollbars=yes,toolbar=no,location=no')</script>
	</c:if>
	
	<c:if test="<%= infoMessage != null %>">
		<span class="portlet-msg-success"> 
			<liferay-ui:message key="<%= infoMessage %>" />
		</span> 
	</c:if>
	
	<c:if test="<%= errorMessage != null %>">
		<span class="portlet-msg-error"> 
			<liferay-ui:message key="<%= errorMessage %>" />
		</span>
	</c:if>
	
</aui:form>
