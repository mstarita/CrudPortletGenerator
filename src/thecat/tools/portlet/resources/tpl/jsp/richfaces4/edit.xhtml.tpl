<#noparse><?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:ui="http://java.sun.com/jsf/facelets"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:a4j="http://richfaces.org/a4j"
	xmlns:rich="http://richfaces.org/rich" >
	
	<h:head/>
	
	<h:body>
		<h:form id="</#noparse>${entityName}<#noparse>Form" >
		
			<rich:panel header="#{i18n['</#noparse>${entityName}<#noparse>.edit.header']}">
			
				<rich:accordion switchType="client">
				
					<rich:accordionItem header="#{i18n['searchFields']}">
						<h:panelGrid columns="4" style="width:100%" >
							<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" >
								<c:set var="bundlePropName" value="${entityName}<#noparse>.field.#{field}" />
								<h:outputLabel id="lblSearch#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
								<h:selectBooleanCheckbox id="chkSearch#{field}" value="#{edit</#noparse>${className}ModelBean.searchFieldMap[field]}" /><#noparse>
							</c:forEach>							
						</h:panelGrid>
				
						<p>
							<a4j:commandButton
								value="#{i18n['button.selectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionSearchFieldSelectAll}" 
								render="@form" /><#noparse>
							<a4j:commandButton
								value="#{i18n['button.deselectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionSearchFieldDeselectAll}" 
								render="@form" /><#noparse>
						</p>
					</rich:accordionItem>
					
					<rich:accordionItem header="#{i18n['searchFieldsOptions']}">
						<h:panelGrid columns="2" cellpadding="5" >
							<h:outputLabel value="#{i18n['columnNumber']}:" id="lblSearchColumns" />
							<h:selectOneMenu id="txtSearchColumnsN" value="#{edit</#noparse>${className}ModelBean.nColsSearch}"><#noparse>
								<f:selectItem itemLabel="1" itemValue="1"/>
								<f:selectItem itemLabel="2" itemValue="2"/>
								<f:selectItem itemLabel="3" itemValue="3"/>
							</h:selectOneMenu>
						</h:panelGrid>
					</rich:accordionItem>
			
					<rich:accordionItem header="#{i18n['resultFields']}">
						<h:panelGrid columns="4" style="width:100%" >
							<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" ><#noparse>
								<c:set var="bundlePropName" value="</#noparse>${entityName}<#noparse>.field.#{field}" />
								<h:outputLabel id="lblResult#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
								<h:selectBooleanCheckbox id="chkResult#{field}" value="#{edit</#noparse>${className}<#noparse>ModelBean.resultFieldMap[field]}" />
							</c:forEach>							
						</h:panelGrid>
						
						<p>
							<a4j:commandButton
								value="#{i18n['button.selectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionResultFieldSelectAll}" 
								render="@form" /><#noparse>
							<a4j:commandButton
								value="#{i18n['button.deselectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionResultFieldDeselectAll}" 
								render="@form" /><#noparse>
						</p>
					</rich:accordionItem>
					
					<rich:accordionItem header="#{i18n['resultOptions']}">
						<h:panelGrid columns="2" cellpadding="5" >
							<h:outputLabel value="#{i18n['rowsPerPage']}:" id="lblRowsPerPage" />
							<h:selectOneMenu id="cmbRowsPerPage" value="#{edit</#noparse>${className}ModelBean.rowsPerPage}"><#noparse>
								<f:selectItem itemLabel="5" itemValue="5"/>
								<f:selectItem itemLabel="10" itemValue="10"/>
								<f:selectItem itemLabel="15" itemValue="15"/>
								<f:selectItem itemLabel="20" itemValue="20"/>
								<f:selectItem itemLabel="30" itemValue="30"/>
							</h:selectOneMenu>
						</h:panelGrid>
					</rich:accordionItem>
					
					<rich:accordionItem header="#{i18n['registryFields']}">
						<h:panelGrid columns="4" style="width:100%" >
							<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" ><#noparse>
								<c:set var="bundlePropName" value="</#noparse>${entityName}<#noparse>.field.#{field}" />
								<h:outputLabel id="lblRegistry#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
								<h:selectBooleanCheckbox id="chkRegistry#{field}" value="#{edit</#noparse>${className}ModelBean.registryFieldMap[field]}" /><#noparse>
							</c:forEach>							
						</h:panelGrid>
						
						<p>
							<a4j:commandButton
								value="#{i18n['button.selectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionRegistryFieldSelectAll}" 
								render="@form" /><#noparse>
							<a4j:commandButton
								value="#{i18n['button.deselectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionRegistryFieldDeselectAll}" 
								render="@form" /><#noparse>
						</p>
					</rich:accordionItem>
					
					<rich:accordionItem header="#{i18n['registryOptions']}">
						<h:panelGrid columns="2" cellpadding="5" >
							<h:outputLabel value="#{i18n['columnNumber']}:" id="lblRegistryColumns" />
							<h:selectOneMenu id="txtRegistryColumns" value="#{edit</#noparse>${className}ModelBean.nColsRegistry}"><#noparse>
								<f:selectItem itemLabel="1" itemValue="1"/>
								<f:selectItem itemLabel="2" itemValue="2"/>
								<f:selectItem itemLabel="3" itemValue="3"/>
							</h:selectOneMenu>
						</h:panelGrid>
					</rich:accordionItem>
					
				</rich:accordion>
			</rich:panel>
			
			<p>
				<a4j:commandButton
					value="#{i18n['button.reset']}"
					actionListener="#{edit</#noparse>${className}BackingBean.actionReset}" 
					render="@form" /><#noparse>
				<a4j:commandButton
					value="#{i18n['button.save']}"
					actionListener="#{edit</#noparse>${className}BackingBean.actionSave}" 
					render="@form" /><#noparse>
			</p>
			
			<p/>
			
			<rich:messages globalOnly="true" layout="table" />
			
		</h:form>
	</h:body>
</html>
</#noparse>
