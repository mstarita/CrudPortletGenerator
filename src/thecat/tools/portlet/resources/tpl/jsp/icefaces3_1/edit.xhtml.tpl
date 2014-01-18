<#noparse><?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:ui="http://java.sun.com/jsf/facelets"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:ice="http://www.icesoft.com/icefaces/component" 
	xmlns:ace="http://www.icefaces.org/icefaces/components" >
	
	<h:head/>
	
	<h:body>
	
		<link href="#{request.contextPath}/xmlhttp/css/rime/rime-portlet.css" rel="stylesheet" type="text/css"/>
		
		<ice:form id="</#noparse>${entityName}<#noparse>Form" >
		
			<ace:panel header="#{i18n['</#noparse>${entityName}<#noparse>.edit.header']}">
	
				<ace:accordion id="accordion" collapsible="true" autoHeight="false">
					
					<ace:accordionPane title="#{i18n['searchFields']}">
						<ice:panelGrid columns="4" style="width:100%" >
							<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" >
								<c:set var="bundlePropName" value="${entityName}<#noparse>.field.#{field}" />
								<ice:outputLabel id="lblSearch#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
								<ice:selectBooleanCheckbox id="chkSearch#{field}" value="#{edit</#noparse>${className}ModelBean.searchFieldMap[field]}" /><#noparse>
							</c:forEach>							
						</ice:panelGrid>
						
						<p/>
						
						<ice:commandButton
							value="#{i18n['button.selectAll']}"
							actionListener="#{edit</#noparse>${className}BackingBean.actionSearchFieldSelectAll}" /><#noparse>
						<ice:commandButton
							value="#{i18n['button.deselectAll']}"
							actionListener="#{edit</#noparse>${className}BackingBean.actionSearchFieldDeselectAll}" /><#noparse>
					</ace:accordionPane>
								
					<ace:accordionPane title="#{i18n['searchFieldsOptions']}">	
						<ice:panelGrid columns="2" cellpadding="5" >
							<ice:outputLabel value="#{i18n['columnNumber']}:" id="lblSearchColumns" />
							<ice:selectOneMenu id="txtSearchColumnsN" value="#{edit</#noparse>${className}ModelBean.nColsSearch}"><#noparse>
								<f:selectItem itemLabel="1" itemValue="1"/>
								<f:selectItem itemLabel="2" itemValue="2"/>
								<f:selectItem itemLabel="3" itemValue="3"/>
							</ice:selectOneMenu>
						</ice:panelGrid>
					</ace:accordionPane>
				
					<ace:accordionPane title="#{i18n['resultFields']}">
						<ice:panelGrid columns="4" style="width:100%" >
							<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" ><#noparse>
								<c:set var="bundlePropName" value="</#noparse>${entityName}<#noparse>.field.#{field}" />
								<ice:outputLabel id="lblResult#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
								<ice:selectBooleanCheckbox id="chkResult#{field}" value="#{edit</#noparse>${className}<#noparse>ModelBean.resultFieldMap[field]}" />
							</c:forEach>							
						</ice:panelGrid>
						
						<p/>
						
						<ice:commandButton
							value="#{i18n['button.selectAll']}"
							actionListener="#{edit</#noparse>${className}BackingBean.actionResultFieldSelectAll}" /><#noparse>
						<ice:commandButton
							value="#{i18n['button.deselectAll']}"
							actionListener="#{edit</#noparse>${className}BackingBean.actionResultFieldDeselectAll}" /><#noparse>
					</ace:accordionPane>
				
					<ace:accordionPane title="#{i18n['resultOptions']}">
						<ice:panelGrid columns="2" cellpadding="5" >
							<ice:outputLabel value="#{i18n['rowsPerPage']}:" id="lblRowsPerPage" />
							<ice:selectOneMenu id="cmbRowsPerPage" value="#{edit</#noparse>${className}ModelBean.rowsPerPage}"><#noparse>
								<f:selectItem itemLabel="5" itemValue="5"/>
								<f:selectItem itemLabel="10" itemValue="10"/>
								<f:selectItem itemLabel="15" itemValue="15"/>
								<f:selectItem itemLabel="20" itemValue="20"/>
								<f:selectItem itemLabel="30" itemValue="30"/>
							</ice:selectOneMenu>
						</ice:panelGrid>
					</ace:accordionPane>
				
					<ace:accordionPane title="#{i18n['registryFields']}">
						<ice:panelGrid columns="4" style="width:100%" >
							<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" ><#noparse>
								<c:set var="bundlePropName" value="</#noparse>${entityName}<#noparse>.field.#{field}" />
								<ice:outputLabel id="lblRegistry#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
								<ice:selectBooleanCheckbox id="chkRegistry#{field}" value="#{edit</#noparse>${className}ModelBean.registryFieldMap[field]}" /><#noparse>
							</c:forEach>							
						</ice:panelGrid>
					
						<p/>
						
						<ice:commandButton
							value="#{i18n['button.selectAll']}"
							actionListener="#{edit</#noparse>${className}BackingBean.actionRegistryFieldSelectAll}" /><#noparse>
						<ice:commandButton
							value="#{i18n['button.deselectAll']}"
							actionListener="#{edit</#noparse>${className}BackingBean.actionRegistryFieldDeselectAll}" /><#noparse>
						<p/>
					</ace:accordionPane>
					
					<ace:accordionPane title="#{i18n['registryOptions']}">
						<ice:panelGrid columns="2" cellpadding="5" >
							<ice:outputLabel value="#{i18n['columnNumber']}:" id="lblRegistryColumns" />
							<ice:selectOneMenu id="txtRegistryColumns" value="#{edit</#noparse>${className}ModelBean.nColsRegistry}"><#noparse>
								<f:selectItem itemLabel="1" itemValue="1"/>
								<f:selectItem itemLabel="2" itemValue="2"/>
								<f:selectItem itemLabel="3" itemValue="3"/>
							</ice:selectOneMenu>
						</ice:panelGrid>
					</ace:accordionPane>
				</ace:accordion>
		
			</ace:panel>
			
			<p/>
					
			<ice:commandButton
				value="#{i18n['button.reset']}"
				actionListener="#{edit</#noparse>${className}BackingBean.actionReset}" /><#noparse>
			<ice:commandButton
				value="#{i18n['button.save']}"
				actionListener="#{edit</#noparse>${className}BackingBean.actionSave}" /><#noparse>
			
			<p/>
				
			<ice:messages globalOnly="true" layout="table" />
			
		</ice:form>
	</h:body>
</html>
</#noparse>
