<%@include file="/${entityName}/init.jsp" %>

<%
	Edit${className}ModelBean editModelBean = (Edit${className}ModelBean) 
		request.getAttribute(${className}CrudPortlet.EDIT_MODEL_BEAN_ATTR_KEY);
	Registry${className}ModelBean registryModelBean = (Registry${className}ModelBean)
		request.getAttribute(${className}CrudPortlet.REGISTRY_MODEL_BEAN_ATTR_KEY);
%>

<portlet:actionURL name="printRegistryAction" var="printRegistryActionURL"/>
<portlet:actionURL name="confirmRegistryAction" var="confirmRegistryActionURL"/>
<portlet:actionURL name="cancelRegistryAction" var="cancelRegistryActionURL"/>

<aui:form action="" method="post">

	<h3 class="header"><span><%= LanguageUtil.get(pageContext, "${entityName}.registry." + registryModelBean.getFormOperation().toString().toLowerCase() + ".header") %></span></h3>
	
	<aui:fieldset>
		<aui:layout>
	
<#list fieldList as field>	
			<c:if test="<%= editModelBean.getRegistryFieldMap().get("${field.fieldName}")%>">
				<aui:column columnWidth="<%= (int) (100 / editModelBean.getnColsRegistry()) %>" >
					<aui:input name="<%= registryModelBean.REGISTRY_FIELD_${field.fieldName?upper_case} %>" 
						label="<%= LanguageUtil.get(pageContext, "${entityName}.field.${field.fieldName}") %>" type="text" 
						value="<%= registryModelBean.get${className}().get${field.fieldName?cap_first}() %>" 
						<#if keyField == field.fieldName>disabled="true"<#else>disabled="<%= registryModelBean.getFormOperation() == FormOperation.SHOW %>"</#if> />
				</aui:column>
			</c:if>
</#list>

		</aui:layout>
	</aui:fieldset>

	<aui:button-row>
		<c:if test="<%= registryModelBean.getFormOperation() == FormOperation.SHOW %>">
			<aui:button type="submit" name="printAction" value="<%= LanguageUtil.get(pageContext, "button.print") %>" 
				onClick='<%= "this.form.action = '" + printRegistryActionURL.toString() + "'"%>' />
		</c:if>
		<aui:button type="submit" name="confirmAction" value="<%= LanguageUtil.get(pageContext, "button.confirm") %>" 
			onClick='<%= "this.form.action = '" + confirmRegistryActionURL.toString() + "'"%>' />
		<c:if test="<%= registryModelBean.getFormOperation() != FormOperation.SHOW %>">
			<aui:button type="submit" name="cancelAction" value="<%= LanguageUtil.get(pageContext, "button.cancel") %>" 
				onClick='<%= "this.form.action = '" + cancelRegistryActionURL.toString() + "'"%>' />
		</c:if>
	</aui:button-row>
	
	<c:if test="<%= request.getAttribute(${className}CrudPortlet.PRINT_URL_ATTR_KEY) != null %>">
		<script>window.open('<%= request.getAttribute(${className}CrudPortlet.PRINT_URL_ATTR_KEY) %>', 'file', 'scrollbars=yes,toolbar=no,location=no')</script>
	</c:if>
</aui:form>
