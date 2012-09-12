<#noparse><?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:ui="http://java.sun.com/jsf/facelets"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:p="http://primefaces.org/ui">
	
	<h:head/>
	
	<h:body>
		<h:form id="</#noparse>${entityName}<#noparse>Form" >
		
			<p:panel header="#{i18n['</#noparse>${entityName}<#noparse>.edit.header']}">
			
				<p:accordionPanel>
					<p:tab title="#{i18n['searchFields']}">
						<p:panelGrid columns="4" style="width:100%" >
							<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" >
								<c:set var="bundlePropName" value="${entityName}<#noparse>.field.#{field}" />
								<h:outputLabel id="lblSearch#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
								<p:selectBooleanCheckbox id="chkSearch#{field}" value="#{edit</#noparse>${className}ModelBean.searchFieldMap[field]}" /><#noparse>
							</c:forEach>							
						</p:panelGrid>
						
						<p>
							<p:commandButton
								value="#{i18n['button.selectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionSearchFieldSelectAll}" 
								update="@(id^='chkSearch')" /><#noparse>
							<p:commandButton
								value="#{i18n['button.deselectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionSearchFieldDeselectAll}" 
								update="@(id^='chkSearch')" /><#noparse>
						</p>
					</p:tab>
					
					<p:tab title="#{i18n['searchFieldsOptions']}">
						<p:panelGrid columns="2" cellpadding="5" >
							<h:outputLabel value="#{i18n['columnNumber']}:" id="lblSearchColumns" />
							<p:selectOneMenu id="txtSearchColumnsN" value="#{edit</#noparse>${className}ModelBean.nColsSearch}"><#noparse>
								<f:selectItem itemLabel="1" itemValue="1"/>
								<f:selectItem itemLabel="2" itemValue="2"/>
								<f:selectItem itemLabel="3" itemValue="3"/>
							</p:selectOneMenu>
						</p:panelGrid>
					</p:tab>
					
					<p:tab title="#{i18n['resultFields']}">
						<p:panelGrid columns="4" style="width:100%" >
							<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" ><#noparse>
								<c:set var="bundlePropName" value="</#noparse>${entityName}<#noparse>.field.#{field}" />
								<h:outputLabel id="lblResult#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
								<p:selectBooleanCheckbox id="chkResult#{field}" value="#{edit</#noparse>${className}<#noparse>ModelBean.resultFieldMap[field]}" />
							</c:forEach>							
						</p:panelGrid>
						
						<p>
							<p:commandButton
								value="#{i18n['button.selectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionResultFieldSelectAll}" 
								update="@(id^='chkResult')" /><#noparse>
							<p:commandButton
								value="#{i18n['button.deselectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionResultFieldDeselectAll}" 
								update="@(id^='chkResult')" /><#noparse>
						</p>
					</p:tab>
					
					<p:tab title="#{i18n['resultOptions']}">
						<p:panelGrid columns="2" cellpadding="5" >
							<h:outputLabel value="#{i18n['rowsPerPage']}:" id="lblRowsPerPage" />
							<p:selectOneMenu id="cmbRowsPerPage" value="#{edit</#noparse>${className}ModelBean.rowsPerPage}"><#noparse>
								<f:selectItem itemLabel="5" itemValue="5"/>
								<f:selectItem itemLabel="10" itemValue="10"/>
								<f:selectItem itemLabel="15" itemValue="15"/>
								<f:selectItem itemLabel="20" itemValue="20"/>
								<f:selectItem itemLabel="30" itemValue="30"/>
							</p:selectOneMenu>
						</p:panelGrid>
					</p:tab>
					
					<p:tab title="#{i18n['registryFields']}">
						<p:panelGrid columns="4" style="width:100%" >
							<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" ><#noparse>
								<c:set var="bundlePropName" value="</#noparse>${entityName}<#noparse>.field.#{field}" />
								<h:outputLabel id="lblRegistry#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
								<p:selectBooleanCheckbox id="chkRegistry#{field}" value="#{edit</#noparse>${className}ModelBean.registryFieldMap[field]}" /><#noparse>
							</c:forEach>							
						</p:panelGrid>
						
						<p>
							<p:commandButton
								value="#{i18n['button.selectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionRegistryFieldSelectAll}" 
								update="@(id^='chkRegistry')" /><#noparse>
							<p:commandButton
								value="#{i18n['button.deselectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionRegistryFieldDeselectAll}" 
								update="@(id^='chkRegistry')" /><#noparse>
						</p>
					</p:tab>
					
					<p:tab title="#{i18n['registryOptions']}">
						<p:panelGrid columns="2" cellpadding="5" >
							<h:outputLabel value="#{i18n['columnNumber']}:" id="lblRegistryColumns" />
							<p:selectOneMenu id="txtRegistryColumns" value="#{edit</#noparse>${className}ModelBean.nColsRegistry}"><#noparse>
								<f:selectItem itemLabel="1" itemValue="1"/>
								<f:selectItem itemLabel="2" itemValue="2"/>
								<f:selectItem itemLabel="3" itemValue="3"/>
							</p:selectOneMenu>
						</p:panelGrid>
					</p:tab>
				</p:accordionPanel>
				
				<p/>
			</p:panel>
			
			<p>
				<p:commandButton
					value="#{i18n['button.reset']}"
					actionListener="#{edit</#noparse>${className}BackingBean.actionReset}" /><#noparse>
				<p:commandButton
					value="#{i18n['button.save']}"
					actionListener="#{edit</#noparse>${className}BackingBean.actionSave}" /><#noparse>
			</p>
			
			<p/>
				
			<p:messages globalOnly="true" layout="table" />
			
		</h:form>
	</h:body>
</html>
</#noparse>
