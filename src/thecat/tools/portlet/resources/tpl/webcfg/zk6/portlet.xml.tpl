<?xml version="1.0" encoding="UTF-8"?>
<portlet-app xmlns="http://java.sun.com/xml/ns/portlet/portlet-app_2_0.xsd" version="2.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://java.sun.com/xml/ns/portlet/portlet-app_2_0.xsd http://java.sun.com/xml/ns/portlet/portlet-app_2_0.xsd">
	<portlet>
		<portlet-name>1</portlet-name>
		<display-name>ZK ${className} Crud Portlet</display-name>
		<portlet-class>org.zkoss.zk.ui.http.FullDHtmlLayoutPortlet</portlet-class>
		<expiration-cache>0</expiration-cache>
		<supports>
			<mime-type>text/html</mime-type>
			<portlet-mode>view</portlet-mode>
		</supports>
		<supports>
			<mime-type>text/html</mime-type>
			<portlet-mode>edit</portlet-mode>
		</supports>
		<portlet-info>
			<title>ZK ${className} Crud Portlet</title>
			<short-title>zk${className}CrudPortlet</short-title>
		</portlet-info>
		
		<portlet-preferences>
			 <preference>
				<name>zk_view_page</name>
				<value>/${entityName}/view.zul</value>
			</preference>
			<preference>
				<name>zk_edit_page</name>
				<value>/${entityName}/edit.zul</value>
			</preference>
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
		
		<security-role-ref>
			<role-name>administrator</role-name>
		</security-role-ref>
		<security-role-ref>
			<role-name>guest</role-name>
		</security-role-ref>
		<security-role-ref>
			<role-name>power-user</role-name>
		</security-role-ref>
		<security-role-ref>
			<role-name>user</role-name>
		</security-role-ref>
		
	</portlet>
</portlet-app>