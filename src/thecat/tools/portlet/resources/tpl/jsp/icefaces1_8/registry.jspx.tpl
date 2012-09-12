<#noparse><?xml version="1.0" encoding="UTF-8"?>
<f:view 
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:c="http://java.sun.com/jstl/core"
	xmlns:ice="http://www.icesoft.com/icefaces/component">

	<ice:portlet>
		
		<ice:outputStyle href="/xmlhttp/css/rime/rime-portlet.css"/>
		<ice:outputStyle href="/css/form.css"/>
		
		<ice:form id="</#noparse>${entityName}<#noparse>Form" styleClass="form" >
			<h3>
				<span>
					<c:set var="bundleHeaderPropName" value="</#noparse>${entityName}<#noparse>.registry.#{registry</#noparse>${className}<#noparse>ModelBean.formOperation.lowerCase}.header" />
					<h:outputLabel id="lblHeader" value="#{i18n[bundleHeaderPropName]}"/>
				</span>
			</h3>
	
			<fieldset>
				<ice:panelGrid columns="#{edit</#noparse>${className}ModelBean.nColsRegistry}" width="100%">
<#list fieldList as field>
					<#noparse><ice:panelGroup rendered="#{edit</#noparse>${className}ModelBean.registryFieldMap['${field.fieldName}']}">
						<p>
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
						</p>
					</ice:panelGroup>
</#list>
				</ice:panelGrid>
<#noparse>				
				<p class="submit">
					<ice:commandButton
						style="margin-right: 10px"
						value="#{i18n['button.print']}"
						rendered="#{registry</#noparse>${className}ModelBean.formOperation == 'SHOW'}"<#noparse>
						action="#{registry</#noparse>${className}<#noparse>BackingBean.actionPrint}" />
					<ice:commandButton
						value="#{i18n['button.confirm']}"
						action="#{registry</#noparse>${className}<#noparse>BackingBean.actionConfirm}" />
					<ice:commandButton
						value="#{i18n['button.cancel']}"
						rendered="#{registry</#noparse>${className}<#noparse>ModelBean.formOperation != 'SHOW'}"
						action="cancel" immediate="true"/>
				</p>	
			</fieldset>
			
		</ice:form>
	</ice:portlet>
</f:view>
</#noparse>
