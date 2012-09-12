<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<ui:composition 
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:ui="http://java.sun.com/jsf/facelets"
	xmlns:c="http://java.sun.com/jstl/core"
	xmlns:p="http://primefaces.org/ui">

<#noparse>
	<c:forEach items="#{searchFieldSet.fieldList}" var="field" >
		<c:set var="bundlePropName" value="</#noparse>${entityName}<#noparse>.field.#{field}" />
		<ice:panelSeries >
			<h:outputText id="lbl#{field}" value="#{i18n[bundlePropName]}" />
			<h:selectBooleanCheckbox id="chk#{field}" value="true" />
		</ice:panelSeries>
	</c:forEach>
</#noparse>
	
</ui:composition>

