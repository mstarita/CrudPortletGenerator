<?xml version="1.0" encoding="UTF-8" standalone="no"?>

<web-app 
	id="WebApp_ID" version="2.4" xmlns="http://java.sun.com/xml/ns/j2ee" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd">
    
    <display-name>IceFaces 3.1 ${className} CRUD Portlet</display-name>

    <description>IceFaces 3.1 ${className} CRUD Portlet</description>

    <context-param>
        <param-name>javax.faces.STATE_SAVING_METHOD</param-name>
        <param-value>server</param-value>
    </context-param>
	
	<context-param>
		<param-name>org.icefaces.uniqueResourceURLs</param-name>
		<param-value>false</param-value>
	</context-param>
	
    <servlet>
        <servlet-name>Faces Servlet</servlet-name>
        <servlet-class>javax.faces.webapp.FacesServlet</servlet-class>
        <load-on-startup>1</load-on-startup>
    </servlet>

	<servlet>
        <servlet-name>Resource Servlet</servlet-name>
        <servlet-class>com.icesoft.faces.webapp.CompatResourceServlet</servlet-class>
        <load-on-startup>1</load-on-startup>
    </servlet>
    
    <servlet-mapping>
        <servlet-name>Resource Servlet</servlet-name>
        <url-pattern>/xmlhttp/*</url-pattern>
    </servlet-mapping>
    
    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

</web-app>

