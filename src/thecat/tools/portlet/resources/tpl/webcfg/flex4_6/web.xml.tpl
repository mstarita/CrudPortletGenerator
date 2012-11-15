<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns="http://java.sun.com/xml/ns/javaee" 
	xmlns:web="http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" 
	xsi:schemaLocation="http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" id="WebApp_ID" version="2.5">
  
	<display-name>Flex 4.x ${className} Crud Portlet</display-name>
	
	<!-- Granite config context listener -->
    <listener>
        <listener-class>org.granite.config.GraniteConfigListener</listener-class>
    </listener>

    <filter>
        <filter-name>AMFMessageFilter</filter-name>
        <filter-class>org.granite.messaging.webapp.AMFMessageFilter</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>AMFMessageFilter</filter-name>
        <url-pattern>/graniteamf/*</url-pattern>
    </filter-mapping>

    <servlet>
        <servlet-name>AMFMessageServlet</servlet-name>
        <servlet-class>org.granite.messaging.webapp.AMFMessageServlet</servlet-class>
        <load-on-startup>1</load-on-startup>
    </servlet>
    <servlet-mapping>
        <servlet-name>AMFMessageServlet</servlet-name>
        <url-pattern>/graniteamf/*</url-pattern>
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
    
</web-app>