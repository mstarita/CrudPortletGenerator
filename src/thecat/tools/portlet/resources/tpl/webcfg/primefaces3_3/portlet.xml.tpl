<?xml version="1.0"?>
<portlet-app xmlns="http://java.sun.com/xml/ns/portlet/portlet-app_2_0.xsd" version="2.0"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://java.sun.com/xml/ns/portlet/portlet-app_2_0.xsd http://java.sun.com/xml/ns/portlet/portlet-app_2_0.xsd">
        <portlet>
                <portlet-name>1</portlet-name>
                <display-name>PrimeFaces ${className} CRUD Portlet</display-name>
                <portlet-class>javax.portlet.faces.GenericFacesPortlet</portlet-class>
                
                <init-param>
                        <name>javax.portlet.faces.defaultViewId.view</name>
                        <value>/${entityName}/search.xhtml</value>
                </init-param>
                
                <init-param>
                        <name>javax.portlet.faces.defaultViewId.edit</name>
                        <value>/${entityName}/edit.xhtml</value>
                </init-param>
                
                <init-param>
                        <name>javax.portlet.faces.preserveActionParams</name>
                        <value>true</value>
                </init-param>
                
                <supports>
                        <mime-type>text/html</mime-type>
                        <portlet-mode>view</portlet-mode>
                        <portlet-mode>edit</portlet-mode>
                </supports>
                
                <portlet-info>
                        <title>PrimeFaces ${className} CRUD Portlet</title>
                        <short-title>prime${className}Crud</short-title>
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
