<#noparse><?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:p="http://primefaces.org/ui">
	
	<h:head/>
	
	<h:body>
		<h:form>
			<c:set var="bundleHeaderPropName" value="</#noparse>${entityName}<#noparse>.registry.#{registry</#noparse>${className}<#noparse>ModelBean.formOperation.lowerCase}.header" />
			<p:panel header="#{i18n[bundleHeaderPropName]}">
				
				<p:panelGrid columns="#{edit</#noparse>${className}ModelBean.nColsRegistry}" style="width:100%">
<#list fieldList as field>
					<#noparse><h:panelGroup rendered="#{edit</#noparse>${className}ModelBean.registryFieldMap['${field.fieldName}']}">
	<#if keyField == field.fieldName><#noparse>
						<h:outputLabel value="#{i18n['</#noparse>${entityName}.field.${field.fieldName}']}:" id="lbl${field.fieldName?cap_first}" />
						<p:inputText id="txt${field.fieldName?cap_first}"
							<#noparse>value="#{registry</#noparse>${className}ModelBean.${entityName}.${field.fieldName}}" disabled="true"/>
	<#else>
						<h:outputLabel value="<#noparse>#{i18n['</#noparse>${entityName}.field.${field.fieldName}']}:" id="lbl${field.fieldName?cap_first}" />
						<p:inputText id="txt${field.fieldName?cap_first}"
							<#noparse>disabled="#{registry</#noparse>${className}ModelBean.formOperation == 'SHOW'}"
							<#noparse>value="#{registry</#noparse>${className}ModelBean.${entityName}.${field.fieldName}}" />
						<p:message id="msg${field.fieldName?cap_first}" for="txt${field.fieldName?cap_first}" />
	</#if>
					</h:panelGroup>
</#list>
				</p:panelGrid>
			</p:panel>
<#noparse>

			<p/>
						
			<p>
				<p:commandButton
					onclick="print()"
					style="margin-right: 10px"
					value="#{i18n['button.print']}"
					rendered="#{registry</#noparse>${className}ModelBean.formOperation == 'SHOW'}"<#noparse> />
				<p:commandButton
					value="#{i18n['button.confirm']}"
					action="#{registry</#noparse>${className}<#noparse>BackingBean.actionConfirm}" />
				<p:commandButton
					value="#{i18n['button.cancel']}"
					rendered="#{registry</#noparse>${className}<#noparse>ModelBean.formOperation != 'SHOW'}"
					action="cancel" immediate="true"/>
					
				<p:remoteCommand
					name="print" 
					action="#{registry</#noparse>${className}<#noparse>BackingBean.actionPrint}"
					onsuccess="window.open('#{facesUtil.baseUrl}/DocumentGeneratorServlet?templateName=dettaglio</#noparse>${className}<#noparse>.ftl', 'file', 'scrollbars=yes,toolbar=no,location=no')" />
			</p>	
			
		</h:form>
	</h:body>
</html>
</#noparse>
