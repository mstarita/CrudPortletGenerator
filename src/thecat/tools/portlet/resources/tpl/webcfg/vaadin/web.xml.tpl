<?xml version="1.0" encoding="UTF-8"?>
<web-app id="WebApp_ID" version="2.4" xmlns="http://java.sun.com/xml/ns/j2ee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd">
	<display-name>Vaadin ${className} crud portlet</display-name>
	<context-param>
		<description>Vaadin production mode</description>
		<param-name>productionMode</param-name>
		<param-value>false</param-value>
	</context-param>
	
	<context-param>
		<param-name>resourceCacheTime</param-name>
		<param-value>3600</param-value>
	</context-param>
	
	<servlet>
		<servlet-name>${className} Crud Application</servlet-name>
		<servlet-class>
			com.vaadin.terminal.gwt.server.ApplicationServlet</servlet-class>
		<init-param>
			<description>Vaadin application class to start</description>
			<param-name>application</param-name>
			<param-value>${packageName}.${className}CrudApplication</param-value>
		</init-param>
	</servlet>
	<servlet-mapping>
		<servlet-name>${className} Crud Application</servlet-name>
		<url-pattern>/*</url-pattern>
	</servlet-mapping>
	
	<!--
	<servlet>
        <servlet-name>DocumentGeneratorServlet</servlet-name>
        <servlet-class>thecat.common.document.DocumentGeneratorServlet</servlet-class>
    </servlet>

    <servlet-mapping>
        <servlet-name>DocumentGeneratorServlet</servlet-name>
        <url-pattern>/DocumentGeneratorServlet</url-pattern>
    </servlet-mapping>
    -->
    
	<welcome-file-list>
		<welcome-file>index.html</welcome-file>
		<welcome-file>index.htm</welcome-file>
		<welcome-file>index.jsp</welcome-file>
		<welcome-file>default.html</welcome-file>
		<welcome-file>default.htm</welcome-file>
		<welcome-file>default.jsp</welcome-file>
	</welcome-file-list>
</web-app>
