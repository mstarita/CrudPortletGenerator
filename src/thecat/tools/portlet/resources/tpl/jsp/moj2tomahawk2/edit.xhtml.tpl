<#noparse><?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:ui="http://java.sun.com/jsf/facelets"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:t="http://myfaces.apache.org/tomahawk" >
	
	<h:head/>
	
	<h:body>
		<h:form id="</#noparse>${entityName}<#noparse>Form" >
		
			<h2><span><t:outputLabel value="#{i18n['</#noparse>${entityName}<#noparse>.edit.header']}"/></span></h2>
	
			<fieldset>
				<h3><t:outputLabel value="#{i18n['searchFields']}" /></h3>
				<t:panelGrid columns="4" style="width:100%" >
					<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" >
						<c:set var="bundlePropName" value="${entityName}<#noparse>.field.#{field}" />
						<t:outputLabel id="lblSearch#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
						<t:selectBooleanCheckbox id="chkSearch#{field}" value="#{edit</#noparse>${className}ModelBean.searchFieldMap[field]}" /><#noparse>
					</c:forEach>							
				</t:panelGrid>
				
				<p>
					<t:commandButton
						value="#{i18n['button.selectAll']}"
						actionListener="#{edit</#noparse>${className}BackingBean.actionSearchFieldSelectAll}" /><#noparse>
					<t:commandButton
						value="#{i18n['button.deselectAll']}"
						actionListener="#{edit</#noparse>${className}BackingBean.actionSearchFieldDeselectAll}" /><#noparse>
				</p>
			</fieldset>
				
			<p/>
			
			<fieldset>	
				<h3><t:outputLabel value="#{i18n['searchFieldsOptions']}"/></h3>
				<t:panelGrid columns="2" cellpadding="5" >
					<t:outputLabel value="#{i18n['columnNumber']}:" id="lblSearchColumns" />
					<t:selectOneMenu id="txtSearchColumnsN" value="#{edit</#noparse>${className}ModelBean.nColsSearch}"><#noparse>
						<f:selectItem itemLabel="1" itemValue="1"/>
						<f:selectItem itemLabel="2" itemValue="2"/>
						<f:selectItem itemLabel="3" itemValue="3"/>
					</t:selectOneMenu>
				</t:panelGrid>
			</fieldset>	
			
			<p/>
			
			<fieldset>
				<h3><t:outputLabel value="#{i18n['resultFields']}"/></h3>
				<t:panelGrid columns="4" style="width:100%" >
					<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" ><#noparse>
						<c:set var="bundlePropName" value="</#noparse>${entityName}<#noparse>.field.#{field}" />
						<t:outputLabel id="lblResult#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
						<t:selectBooleanCheckbox id="chkResult#{field}" value="#{edit</#noparse>${className}<#noparse>ModelBean.resultFieldMap[field]}" />
					</c:forEach>							
				</t:panelGrid>
				
				<p>
					<t:commandButton
						value="#{i18n['button.selectAll']}"
						actionListener="#{edit</#noparse>${className}BackingBean.actionResultFieldSelectAll}" /><#noparse>
					<t:commandButton
						value="#{i18n['button.deselectAll']}"
						actionListener="#{edit</#noparse>${className}BackingBean.actionResultFieldDeselectAll}" /><#noparse>
				</p>
			</fieldset>
				
			<p/>
			
			<fieldset>
				<h3><t:outputLabel value="#{i18n['resultOptions']}"/></h3>
				<t:panelGrid columns="2" cellpadding="5" >
					<t:outputLabel value="#{i18n['rowsPerPage']}:" id="lblRowsPerPage" />
					<t:selectOneMenu id="cmbRowsPerPage" value="#{edit</#noparse>${className}ModelBean.rowsPerPage}"><#noparse>
						<f:selectItem itemLabel="5" itemValue="5"/>
						<f:selectItem itemLabel="10" itemValue="10"/>
						<f:selectItem itemLabel="15" itemValue="15"/>
						<f:selectItem itemLabel="20" itemValue="20"/>
						<f:selectItem itemLabel="30" itemValue="30"/>
					</t:selectOneMenu>
				</t:panelGrid>
			</fieldset>
				
			<p/>
			
			<fieldset>
				<h3><t:outputLabel value="#{i18n['registryFields']}"/></h3>
				<t:panelGrid columns="4" style="width:100%" >
					<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" ><#noparse>
						<c:set var="bundlePropName" value="</#noparse>${entityName}<#noparse>.field.#{field}" />
						<t:outputLabel id="lblRegistry#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
						<t:selectBooleanCheckbox id="chkRegistry#{field}" value="#{edit</#noparse>${className}ModelBean.registryFieldMap[field]}" /><#noparse>
					</c:forEach>							
				</t:panelGrid>
				
				<p>
					<t:commandButton
						value="#{i18n['button.selectAll']}"
						actionListener="#{edit</#noparse>${className}BackingBean.actionRegistryFieldSelectAll}" /><#noparse>
					<t:commandButton
						value="#{i18n['button.deselectAll']}"
						actionListener="#{edit</#noparse>${className}BackingBean.actionRegistryFieldDeselectAll}" /><#noparse>
				</p>
			</fieldset>
				
			<p/>
				
			<fieldset>
				<h3><t:outputLabel value="#{i18n['registryOptions']}"/></h3>
				<t:panelGrid columns="2" cellpadding="5" >
					<t:outputLabel value="#{i18n['columnNumber']}:" id="lblRegistryColumns" />
					<t:selectOneMenu id="txtRegistryColumns" value="#{edit</#noparse>${className}ModelBean.nColsRegistry}"><#noparse>
						<f:selectItem itemLabel="1" itemValue="1"/>
						<f:selectItem itemLabel="2" itemValue="2"/>
						<f:selectItem itemLabel="3" itemValue="3"/>
					</t:selectOneMenu>
				</t:panelGrid>
			</fieldset>
				
			<p/>
				
			<p>
				<t:commandButton
					value="#{i18n['button.reset']}"
					actionListener="#{edit</#noparse>${className}BackingBean.actionReset}" /><#noparse>
				<t:commandButton
					value="#{i18n['button.save']}"
					actionListener="#{edit</#noparse>${className}BackingBean.actionSave}" /><#noparse>
			</p>
			
			<p/>
				
			<t:messages globalOnly="true" layout="table" />
			
		</h:form>
	</h:body>
</html>
</#noparse>
