<#noparse><?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:ui="http://java.sun.com/jsf/facelets"
	xmlns:ice="http://www.icesoft.com/icefaces/component" 
	xmlns:ace="http://www.icefaces.org/icefaces/components" >
	
	<h:head/>
	
	<h:body>
		
		<link href="#{request.contextPath}/xmlhttp/css/rime/rime-portlet.css" rel="stylesheet" type="text/css"/>
		
		<ice:form>
			<c:set var="bundleHeaderPropName" value="</#noparse>${entityName}<#noparse>.registry.#{registry</#noparse>${className}<#noparse>ModelBean.formOperation.lowerCase}.header" />
			<ace:panel header="#{i18n[bundleHeaderPropName]}">
			
				<ice:panelGrid columns="#{edit</#noparse>${className}ModelBean.nColsRegistry}" width="100%">
<#list fieldList as field>
					<#noparse><ice:panelGroup rendered="#{edit</#noparse>${className}ModelBean.registryFieldMap['${field.fieldName}']}">
	<#if keyField == field.fieldName><#noparse>
						<ice:outputLabel value="#{i18n['</#noparse>${entityName}.field.${field.fieldName}']}:" id="lbl${field.fieldName?cap_first}" />
						<ice:inputText id="txt${field.fieldName?cap_first}"
							<#noparse>value="#{registry</#noparse>${className}ModelBean.${entityName}.${field.fieldName}}" disabled="true"/>
	<#else>
						<ice:outputLabel value="<#noparse>#{i18n['</#noparse>${entityName}.field.${field.fieldName}']}:" id="lbl${field.fieldName?cap_first}" />
						<ice:inputText id="txt${field.fieldName?cap_first}"
							<#noparse>disabled="#{registry</#noparse>${className}ModelBean.formOperation == 'SHOW'}"
							<#noparse>value="#{registry</#noparse>${className}ModelBean.${entityName}.${field.fieldName}}" />
						<ice:message id="msg${field.fieldName?cap_first}" for="txt${field.fieldName?cap_first}" />
	</#if>
					</ice:panelGroup>
</#list>
				</ice:panelGrid>
<#noparse>
				<p/>	
				<ice:commandButton
					style="margin-right: 10px"
					value="#{i18n['button.print']}"
					rendered="#{registry</#noparse>${className}ModelBean.formOperation == 'SHOW'}"<#noparse>
					action="#{registry</#noparse>${className}<#noparse>BackingBean.actionPrint}" 
					update="printing" />
				<ice:commandButton
					value="#{i18n['button.confirm']}"
					action="#{registry</#noparse>${className}<#noparse>BackingBean.actionConfirm}" />
				<ice:commandButton
					value="#{i18n['button.cancel']}"
					rendered="#{registry</#noparse>${className}<#noparse>ModelBean.formOperation != 'SHOW'}"
					action="cancel" immediate="true"/>	
			</ace:panel>
		
			<ui:fragment id="printing" rendered="#{registry</#noparse>${className}<#noparse>BackingBean.printing}">
				<script>window.open('#{registry</#noparse>${className}<#noparse>BackingBean.printUrl}', 'file', 'scrollbars=yes,toolbar=no,location=no')</script>
			</ui:fragment>
			
		</ice:form>
	</h:body>
</html>
</#noparse>
