<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<web-app 
	id="WebApp_ID" version="2.4" xmlns="http://java.sun.com/xml/ns/j2ee" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd">
    
    <display-name>RichFaces 4 ${className} CRUD Portlet</display-name>

    <description>RichFaces 4 ${className} CRUD Portlet</description>

    <context-param>
		<param-name>javax.faces.PROJECT_STAGE</param-name>
		<param-value>Development</param-value>
	</context-param>
	
	<context-param>
		<param-name>com.sun.faces.expressionFactory</param-name>
		<param-value>org.jboss.el.ExpressionFactoryImpl</param-value>
	</context-param>
	
	<context-param>
		<param-name>org.richfaces.resourceMapping.enabled</param-name>
		<param-value>true</param-value>
	</context-param>
	
    <servlet>
        <servlet-name>Faces Servlet</servlet-name>
        <servlet-class>javax.faces.webapp.FacesServlet</servlet-class>
        <load-on-startup>1</load-on-startup>
    </servlet>
	
	<servlet>
        <servlet-name>Resource Servlet</servlet-name>
        <servlet-class>org.richfaces.webapp.ResourceServlet</servlet-class>
        <load-on-startup>1</load-on-startup>
    </servlet>
    <servlet-mapping>
        <servlet-name>Resource Servlet</servlet-name>
        <url-pattern>/org.richfaces.resources/*</url-pattern>
    </servlet-mapping>

    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

</web-app>

