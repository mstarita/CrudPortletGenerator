<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<portlet-app xmlns="http://java.sun.com/xml/ns/portlet/portlet-app_2_0.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0" xsi:schemaLocation="http://java.sun.com/xml/ns/portlet/portlet-app_2_0.xsd http://java.sun.com/xml/ns/portlet/portlet-app_2_0.xsd">

    <portlet>
        <portlet-name>1</portlet-name>
        <display-name>Liferay Jsp ${className} Crud Portlet</display-name>
        <portlet-class>${packageName}.${className}CrudPortlet</portlet-class>
        <init-param>
			<name>view-jsp</name>
			<value>/${entityName}/search.jsp</value>
		</init-param>
		<init-param>
			<name>edit-jsp</name>
			<value>/${entityName}/edit.jsp</value>
		</init-param>
		<init-param>
	      <name>add-process-action-success-action</name>
	      <value>false</value>
	    </init-param>
		<expiration-cache>0</expiration-cache>
		<supports>
			<mime-type>text/html</mime-type>
			<portlet-mode>view</portlet-mode>
			<portlet-mode>edit</portlet-mode>
		</supports>
		<portlet-info>
			<title>Liferay Jsp ${className} CRUD Portlet</title>
			<short-title>liferayJspCrud${className}Portlet</short-title>
		</portlet-info>
        
       <portlet-preferences>
			<preference>
				<name>searchFields</name>
				<#list searchFields as field>
					<value>${field}</value>
				</#list>
			</preference>
			<preference>
				<name>resultFields</name>
				<#list searchFields as field>
					<value>${field}</value>
				</#list>
			</preference>
			<preference>
				<name>registryFields</name>
				<#list searchFields as field>
					<value>${field}</value>
				</#list>
			</preference>
			<preference>
				<name>rowsPerPage</name>
				<value>10</value>
			</preference>
			<preference>
				<name>nColsSearch</name>
				<value>2</value>
			</preference>
			<preference>
				<name>nColsRegistry</name>
				<value>2</value>
			</preference>
			
        </portlet-preferences>
		
    </portlet>
</portlet-app>
