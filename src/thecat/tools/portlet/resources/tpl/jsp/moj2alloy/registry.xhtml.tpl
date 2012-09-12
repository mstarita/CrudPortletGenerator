<#noparse><?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:ui="http://java.sun.com/jsf/facelets"
	xmlns:aui="http://liferay.com/faces/aui" >
	
	<h:head/>
	
	<h:body>
	
		<aui:layout>
			<h:form>
				<h3>
					<span>
						<c:set var="bundleHeaderPropName" value="</#noparse>${entityName}<#noparse>.registry.#{registry</#noparse>${className}<#noparse>ModelBean.formOperation.lowerCase}.header" />
						<h:outputLabel id="lblHeader" value="#{i18n[bundleHeaderPropName]}"/>
					</span>
				</h3>
	
				<aui:fieldset>
					<h:panelGrid columns="#{edit</#noparse>${className}ModelBean.nColsRegistry}" width="100%">
<#list fieldList as field>
						<#noparse><h:panelGroup rendered="#{edit</#noparse>${className}ModelBean.registryFieldMap['${field.fieldName}']}">
	<#if keyField == field.fieldName>
							<aui:field id="lbl${field.fieldName?cap_first}" label="<#noparse>#{i18n['</#noparse>${entityName}.field.${field.fieldName}']}">
								<h:inputText id="txt${field.fieldName?cap_first}"
									<#noparse>value="#{registry</#noparse>${className}ModelBean.${entityName}.${field.fieldName}}" disabled="true"/>
							</aui:field>
	<#else>	
							<aui:field id="lbl${field.fieldName?cap_first}" label="<#noparse>#{i18n['</#noparse>${entityName}.field.${field.fieldName}']}">
								<h:inputText id="txt${field.fieldName?cap_first}"
									<#noparse>disabled="#{registry</#noparse>${className}ModelBean.formOperation == 'SHOW'}"
									<#noparse>value="#{registry</#noparse>${className}ModelBean.${entityName}.${field.fieldName}}" />
								<h:message id="msg${field.fieldName?cap_first}" for="txt${field.fieldName?cap_first}" />
							</aui:field>
	</#if>
						</h:panelGroup>
</#list>
					</h:panelGrid>
				</aui:fieldset>
<#noparse>
				<p/>
				<hr/>
						
				<p>
					<h:commandButton
						style="margin-right: 10px"
						value="#{i18n['button.print']}"
						rendered="#{registry</#noparse>${className}ModelBean.formOperation == 'SHOW'}"<#noparse>
						action="#{registry</#noparse>${className}<#noparse>BackingBean.actionPrint}" 
						update="printing" />
					<h:commandButton
						value="#{i18n['button.confirm']}"
						action="#{registry</#noparse>${className}<#noparse>BackingBean.actionConfirm}" />
					<h:commandButton
						value="#{i18n['button.cancel']}"
						rendered="#{registry</#noparse>${className}<#noparse>ModelBean.formOperation != 'SHOW'}"
						action="cancel" immediate="true"/>
				</p>	
				
				<ui:fragment id="printing" rendered="#{registry</#noparse>${className}<#noparse>BackingBean.printing}">
					<script>window.open('#{registry</#noparse>${className}<#noparse>BackingBean.printUrl}', 'file', 'scrollbars=yes,toolbar=no,location=no')</script>
				</ui:fragment>
			
			</h:form>
		</aui:layout>
		
	</h:body>
</html>
</#noparse>
