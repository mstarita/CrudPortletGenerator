<%@include file="/${entityName}/init.jsp" %>

<%

Edit${className}ModelBean editModelBean = (Edit${className}ModelBean) 
	request.getAttribute(${className}CrudPortlet.EDIT_MODEL_BEAN_ATTR_KEY);

String infoMessage = (String) request.getAttribute(${className}CrudPortlet.INFO_MESSAGE_ATTR_KEY);
String errorMessage = (String) request.getAttribute(${className}CrudPortlet.ERROR_MESSAGE_ATTR_KEY);

%>

<portlet:actionURL name="selectAllSearchFieldAction" var="selectAllSearchFieldActionURL"/>
<portlet:actionURL name="deselectAllSearchFieldAction" var="deselectAllSearchFieldActionURL"/>
<portlet:actionURL name="selectAllResultFieldAction" var="selectAllResultFieldActionURL"/>
<portlet:actionURL name="deselectAllResultFieldAction" var="deselectAllResultFieldActionURL"/>
<portlet:actionURL name="selectAllRegistryFieldAction" var="selectAllRegistryFieldActionURL"/>
<portlet:actionURL name="deselectAllRegistryFieldAction" var="deselectAllRegistryFieldActionURL"/>

<portlet:actionURL name="savePrefsAction" var="savePrefsActionURL"/>
<portlet:actionURL name="resetPrefsAction" var="resetPrefsActionURL"/>

<aui:form name="${entityName}Form" method="post" >

	<h3 class="header"><span><%= LanguageUtil.get(pageContext, "${entityName}.edit.header") %></span></h3>
	
	<liferay-ui:panel-container id="paramsPanel" extended="true" persistState="true">
	
		<liferay-ui:panel id="searchFieldsPanel" title="<%= LanguageUtil.get(pageContext, "searchFields") %>" collapsible="true" persistState="true">
			<aui:fieldset>
				<aui:layout>
					<c:forEach items="<%= new int[] {0, 1} %>" var="colCount" >
						<aui:column columnWidth="50">
							<c:set var="fieldCount" value="0" />
							<c:forEach items="<%= editModelBean.getFieldList() %>" var="field" >
								<c:set var="fieldCount" value="<#noparse>${fieldCount + 1}" />
								<c:if test="${fieldCount % 2 == colCount}</#noparse>" >
									<c:set var="bundlePropName" value="${entityName}.field.<#noparse>${field}</#noparse>" />
									<aui:input label="<%= LanguageUtil.get(pageContext, (String) pageContext.getAttribute("bundlePropName")) %>" type="checkbox" 
										name="<%= editModelBean.PREFS_SEARCH_FIELDS + pageContext.getAttribute("field") %>" value="<%= editModelBean.getSearchFieldMap().get(pageContext.getAttribute("field")) %>" />
								</c:if>
							</c:forEach>
						</aui:column>
					</c:forEach>
				</aui:layout>
				<p/>
				<aui:button-row>
					<aui:button type="submit" name="selectAllSearchFieldAction" value="<%= LanguageUtil.get(pageContext, "button.selectAll") %>" 
						onClick='<%= "this.form.action = '" + selectAllSearchFieldActionURL.toString() + "'"%>' />
					<aui:button type="submit" name="deselectAllSearchFieldAction" value="<%= LanguageUtil.get(pageContext, "button.deselectAll") %>" 
						onClick='<%= "this.form.action = '" + deselectAllSearchFieldActionURL.toString() + "'"%>' />
				</aui:button-row>
			</aui:fieldset>
		</liferay-ui:panel>
		
		<liferay-ui:panel id="searchFieldsOptionsPanel" title="<%= LanguageUtil.get(pageContext, "searchFieldsOptions") %>" collapsible="true" defaultState="close" persistState="true">
			<aui:fieldset>
				<aui:select label="<%= LanguageUtil.get(pageContext, "columnNumber") %>" name="<%= editModelBean.PREFS_N_COLS_SEARCH %>">
					<aui:option value="1" selected="<%= editModelBean.getnColsSearch() == 1%>">1</aui:option>
					<aui:option value="2" selected="<%= editModelBean.getnColsSearch() == 2%>">2</aui:option>
					<aui:option value="3" selected="<%= editModelBean.getnColsSearch() == 3%>">3</aui:option>
				</aui:select>
			</aui:fieldset>
		</liferay-ui:panel>
		
		<liferay-ui:panel id="resultFieldsPanel" title="<%= LanguageUtil.get(pageContext, "resultFields") %>" collapsible="true" defaultState="close" persistState="true">
			<aui:fieldset>
				<aui:layout>
					<c:forEach items="<%= new int[] {0, 1} %>" var="colCount" >
						<aui:column columnWidth="50">
							<c:set var="fieldCount" value="0" />
							<c:forEach items="<%= editModelBean.getFieldList() %>" var="field" >
								<c:set var="fieldCount" value="<#noparse>${fieldCount + 1}" />
								<c:if test="${fieldCount % 2 == colCount}</#noparse>" >
									<c:set var="bundlePropName" value="${entityName}.field.<#noparse>${field}</#noparse>" />
									<aui:input label="<%= LanguageUtil.get(pageContext, (String) pageContext.getAttribute("bundlePropName")) %>" type="checkbox" 
										name="<%= editModelBean.PREFS_RESULT_FIELDS + pageContext.getAttribute("field") %>" value="<%= editModelBean.getResultFieldMap().get(pageContext.getAttribute("field")) %>" />
								</c:if>
							</c:forEach>
						</aui:column>
					</c:forEach>					
				</aui:layout>
				<p/>		
				<aui:button-row>
					<aui:button type="submit" name="selectAllResultFieldAction" value="<%= LanguageUtil.get(pageContext, "button.selectAll") %>" 
						onClick='<%= "this.form.action = '" + selectAllResultFieldActionURL.toString() + "'"%>' />
					<aui:button type="submit" name="deselectAllResultFieldAction" value="<%= LanguageUtil.get(pageContext, "button.deselectAll") %>" 
						onClick='<%= "this.form.action = '" + deselectAllResultFieldActionURL.toString() + "'"%>' />
				</aui:button-row>
			</aui:fieldset>
		</liferay-ui:panel>
		
		<liferay-ui:panel id="resultOptionsPanel" title="<%= LanguageUtil.get(pageContext, "resultOptions") %>" collapsible="true" defaultState="close" persistState="true">
			<aui:fieldset>
				<aui:select label="<%= LanguageUtil.get(pageContext, "rowsPerPage") %>" name="<%= editModelBean.PREFS_ROWS_PER_PAGE %>">
					<aui:option value="5" selected="<%= editModelBean.getRowsPerPage() == 5%>">5</aui:option>
					<aui:option value="10" selected="<%= editModelBean.getRowsPerPage() == 10%>">10</aui:option>
					<aui:option value="15" selected="<%= editModelBean.getRowsPerPage() == 15%>">15</aui:option>
					<aui:option value="20" selected="<%= editModelBean.getRowsPerPage() == 20%>">20</aui:option>
					<aui:option value="30" selected="<%= editModelBean.getRowsPerPage() == 30%>">30</aui:option>
				</aui:select>
			</aui:fieldset>
		</liferay-ui:panel>
		
		<liferay-ui:panel id="registryFieldsPanel" title="<%= LanguageUtil.get(pageContext, "registryFields") %>" collapsible="true" defaultState="close" persistState="true">
			<aui:fieldset>
				<aui:layout>
					<c:forEach items="<%= new int[] {0, 1} %>" var="colCount" >
						<aui:column columnWidth="50">
							<c:set var="fieldCount" value="0" />
							<c:forEach items="<%= editModelBean.getFieldList() %>" var="field" >
								<c:set var="fieldCount" value="<#noparse>${fieldCount + 1}" />
								<c:if test="${fieldCount % 2 == colCount}</#noparse>" >
									<c:set var="bundlePropName" value="${entityName}.field.<#noparse>${field}</#noparse>" />
									<aui:input label="<%= LanguageUtil.get(pageContext, (String) pageContext.getAttribute("bundlePropName")) %>" type="checkbox" 
										name="<%= editModelBean.PREFS_REGISTRY_FIELDS + pageContext.getAttribute("field") %>" value="<%= editModelBean.getRegistryFieldMap().get(pageContext.getAttribute("field")) %>" />
								</c:if>
							</c:forEach>
						</aui:column>
					</c:forEach>
				</aui:layout>
				<p/>				
				<aui:button-row>
					<aui:button type="submit" name="selectAllRegistryFieldAction" value="<%= LanguageUtil.get(pageContext, "button.selectAll") %>" 
						onClick='<%= "this.form.action = '" + selectAllRegistryFieldActionURL.toString() + "'"%>' />
					<aui:button type="submit" name="deselectAllRegistryFieldAction" value="<%= LanguageUtil.get(pageContext, "button.deselectAll") %>" 
						onClick='<%= "this.form.action = '" + deselectAllRegistryFieldActionURL.toString() + "'"%>' />
				</aui:button-row>
			</aui:fieldset>
		</liferay-ui:panel>
		
		<liferay-ui:panel id="registryOptionsPanel" title="<%= LanguageUtil.get(pageContext, "registryOptions") %>" collapsible="true" defaultState="close" persistState="true">
			<aui:fieldset>
				<aui:select label="<%= LanguageUtil.get(pageContext, "columnNumber") %>" name="<%= editModelBean.PREFS_N_COLS_REGISTRY %>">
					<aui:option value="1" selected="<%= editModelBean.getnColsRegistry() == 1%>">1</aui:option>
					<aui:option value="2" selected="<%= editModelBean.getnColsRegistry() == 2%>">2</aui:option>
					<aui:option value="3" selected="<%= editModelBean.getnColsRegistry() == 3%>">3</aui:option>
				</aui:select>
			</aui:fieldset>
		</liferay-ui:panel>
		
	</liferay-ui:panel-container>
	
	<aui:button-row>
		<aui:button type="submit" name="resetPrefsAction" value="<%= LanguageUtil.get(pageContext, "button.reset") %>" 
			onClick='<%= "this.form.action = '" + resetPrefsActionURL.toString() + "'"%>' />
		<aui:button type="submit" name="savePrefsAction" value="<%= LanguageUtil.get(pageContext, "button.save") %>" 
			onClick='<%= "this.form.action = '" + savePrefsActionURL.toString() + "'"%>' />
	</aui:button-row>
	
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

