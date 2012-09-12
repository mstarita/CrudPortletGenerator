<#noparse><?xml version="1.0" encoding="UTF-8"?>
<f:view 
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:ui="http://java.sun.com/jsf/facelets"
	xmlns:c="http://java.sun.com/jstl/core"
	xmlns:ice="http://www.icesoft.com/icefaces/component">
	
	<ice:portlet>
		
		<ice:outputStyle href="/xmlhttp/css/rime/rime-portlet.css"/>
		<ice:outputStyle href="/css/form.css"/>
	
		<ice:form id="</#noparse>${entityName}<#noparse>Form" styleClass="form" >
		
			<h3><span><h:outputLabel value="#{i18n['</#noparse>${entityName}<#noparse>.edit.header']}"/></span></h3>

			<fieldset>
				<ice:panelGroup styleClass="pnlClpsblWrapper panelCollapsible" >
					<ice:panelCollapsible expanded="true">
						<f:facet name="header">
							<h:outputText value="#{i18n['searchFields']}" />
						</f:facet>
						
						<ice:panelGrid columns="4" width="100%" >
							<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" >
								<c:set var="bundlePropName" value="${entityName}<#noparse>.field.#{field}" />
								<ice:outputLabel id="lblSearch#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
								<ice:selectBooleanCheckbox id="chkSearch#{field}" value="#{edit</#noparse>${className}ModelBean.searchFieldMap[field]}" /><#noparse>
							</c:forEach>							
						</ice:panelGrid>
						
						<p class="submit">
							<ice:commandButton
								value="#{i18n['button.selectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionSearchFieldSelectAll}" /><#noparse>
							<ice:commandButton
								value="#{i18n['button.deselectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionSearchFieldDeselectAll}" /><#noparse>
						</p>
					</ice:panelCollapsible>
					
					<ice:panelCollapsible expanded="false">
						<f:facet name="header">
							<h:outputText value="#{i18n['searchFieldsOptions']}" />
						</f:facet>
	
						<ice:outputLabel value="#{i18n['columnNumber']}:" id="lblSearchColumns" />
						<ice:selectOneMenu id="txtSearchColumnsN" value="#{edit</#noparse>${className}ModelBean.nColsSearch}"><#noparse>
							<f:selectItem itemLabel="1" itemValue="1"/>
							<f:selectItem itemLabel="2" itemValue="2"/>
							<f:selectItem itemLabel="3" itemValue="3"/>
						</ice:selectOneMenu>
					</ice:panelCollapsible>
					
					<ice:panelCollapsible expanded="false">
						<f:facet name="header">
							<h:outputText value="#{i18n['resultFields']}" />
						</f:facet>
	
						<ice:panelGrid columns="4" width="100%" >
							<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" ><#noparse>
								<c:set var="bundlePropName" value="</#noparse>${entityName}<#noparse>.field.#{field}" />
								<ice:outputLabel id="lblResult#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
								<ice:selectBooleanCheckbox id="chkResult#{field}" value="#{edit</#noparse>${className}<#noparse>ModelBean.resultFieldMap[field]}" />
							</c:forEach>							
						</ice:panelGrid>
						
						<p class="submit">
							<ice:commandButton
								value="#{i18n['button.selectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionResultFieldSelectAll}" /><#noparse>
							<ice:commandButton
								value="#{i18n['button.deselectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionResultFieldDeselectAll}" /><#noparse>
						</p>
					</ice:panelCollapsible>
			
					<ice:panelCollapsible expanded="false">
						<f:facet name="header">
							<h:outputText value="#{i18n['resultOptions']}" />
						</f:facet>
	
						<ice:outputLabel value="#{i18n['rowsPerPage']}:" id="lblRowsPerPage" />
						<ice:selectOneMenu id="cmbRowsPerPage" value="#{edit</#noparse>${className}ModelBean.rowsPerPage}"><#noparse>
							<f:selectItem itemLabel="5" itemValue="5"/>
							<f:selectItem itemLabel="10" itemValue="10"/>
							<f:selectItem itemLabel="15" itemValue="15"/>
							<f:selectItem itemLabel="20" itemValue="20"/>
							<f:selectItem itemLabel="30" itemValue="30"/>
						</ice:selectOneMenu>
					</ice:panelCollapsible>
					
					<ice:panelCollapsible expanded="false">
						<f:facet name="header">
							<h:outputText value="#{i18n['registryFields']}" />
						</f:facet>
	
						<ice:panelGrid columns="4" width="100%" >
							<c:forEach items="#{edit</#noparse>${className}ModelBean.fieldList}" var="field" ><#noparse>
								<c:set var="bundlePropName" value="</#noparse>${entityName}<#noparse>.field.#{field}" />
								<ice:outputLabel id="lblRegistry#{field}" value="#{i18n[bundlePropName]}" style="width: 10px"/>
								<ice:selectBooleanCheckbox id="chkRegistry#{field}" value="#{edit</#noparse>${className}ModelBean.registryFieldMap[field]}" /><#noparse>
							</c:forEach>							
						</ice:panelGrid>
						
						<p class="submit">
							<ice:commandButton
								value="#{i18n['button.selectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionRegistryFieldSelectAll}" /><#noparse>
							<ice:commandButton
								value="#{i18n['button.deselectAll']}"
								actionListener="#{edit</#noparse>${className}BackingBean.actionRegistryFieldDeselectAll}" /><#noparse>
						</p>
					</ice:panelCollapsible>
					
					<ice:panelCollapsible expanded="false">
						<f:facet name="header">
							<h:outputText value="#{i18n['registryOptions']}" />
						</f:facet>
	
						<ice:outputLabel value="#{i18n['columnNumber']}:" id="lblRegistryColumns" />
						<ice:selectOneMenu id="txtRegistryColumns" value="#{edit</#noparse>${className}ModelBean.nColsRegistry}"><#noparse>
							<f:selectItem itemLabel="1" itemValue="1"/>
							<f:selectItem itemLabel="2" itemValue="2"/>
							<f:selectItem itemLabel="3" itemValue="3"/>
						</ice:selectOneMenu>
					</ice:panelCollapsible>
					
				</ice:panelGroup>
			
				<p/>
				
				<p class="submit">
					<ice:commandButton
						value="#{i18n['button.reset']}"
						actionListener="#{edit</#noparse>${className}BackingBean.actionReset}" /><#noparse>
					<ice:commandButton
						value="#{i18n['button.save']}"
						actionListener="#{edit</#noparse>${className}BackingBean.actionSave}" /><#noparse>
				</p>
			
			</fieldset>
			
			<p/>
				
			<ice:messages globalOnly="true" layout="table" />
			
		</ice:form>
		
	</ice:portlet>
</f:view>
</#noparse>
