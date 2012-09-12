<?xml version="1.0" encoding="UTF-8" standalone="no"?>

<web-app 
	id="WebApp_ID" version="2.4" xmlns="http://java.sun.com/xml/ns/j2ee" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd">
    
    <display-name>Mojarra 2 + Tomahawk 2 ${className} CRUD Portlet</display-name>

    <description>Mojarra 2 + Tomahawk 2 ${className} CRUD Portlet</description>
	
	<context-param>
    	<param-name>javax.faces.STATE_SAVING_METHOD</param-name>
    	<param-value>server</param-value>
	</context-param>
	<context-param>
    	<param-name>org.apache.myfaces.NUMBER_OF_VIEWS_IN_SESSION</param-name>
    	<param-value>20</param-value>
	</context-param>
	<context-param>
    	<param-name>org.apache.myfaces.SERIALIZE_STATE_IN_SESSION</param-name>
    	<param-value>true</param-value>
	</context-param>
	<context-param>
    	<param-name>org.apache.myfaces.COMPRESS_STATE_IN_SESSION</param-name>
    	<param-value>true</param-value>
	</context-param>
	<context-param>
    	<param-name>org.apache.myfaces.ALLOW_JAVASCRIPT</param-name>
    	<param-value>true</param-value>
  	</context-param>
  	<context-param>
    	<param-name>org.apache.myfaces.DETECT_JAVASCRIPT</param-name>
    	<param-value>false</param-value>
  	</context-param>
  	<context-param>
    	<param-name>org.apache.myfaces.PRETTY_HTML</param-name>
    	<param-value>true</param-value>
  	</context-param>
  	<context-param>
    	<param-name>org.apache.myfaces.AUTO_SCROLL</param-name>
    	<param-value>true</param-value>
  	</context-param>

    <context-param>
       	<param-name>org.apache.myfaces.VALIDATE</param-name>
       	<param-value>false</param-value>
    </context-param>

  	<context-param>
    	<param-name>org.apache.myfaces.ADD_RESOURCE_CLASS</param-name>
    	<!-- param-value>org.apache.myfaces.renderkit.html.util.DefaultAddResource</param-value -->
    	<param-value>org.apache.myfaces.renderkit.html.util.NonBufferingAddResource</param-value>
    	<!--param-value>org.apache.myfaces.component.html.util.StreamingAddResource</param-value -->
	</context-param>

	<!-- 
	<context-param>
	  <param-name>org.apache.myfaces.DISABLE_TOMAHAWK_FACES_CONTEXT_WRAPPER</param-name>
	  <param-value>false</param-value>
	</context-param>
	-->
	
	<!-- 
	<context-param>
	  <description>
	      A very common problem in configuring MyFaces-web-applications
	      is that the Extensions-Filter is not configured at all
	      or improperly configured. This parameter will check for a properly
	      configured Extensions-Filter if it is needed by the web-app.
	      In most cases this check will work just fine, there might be cases
	      where an internal forward will bypass the Extensions-Filter and the check
	      will not work. If this is the case, you can disable the check by setting
	      this parameter to false.
	  </description>
	  <param-name>org.apache.myfaces.CHECK_EXTENSIONS_FILTER</param-name>
	  <param-value>true</param-value>
	</context-param>
	 -->

	<!-- 
	<context-param>
	  <description>
	      Change the url-pattern from the ExtensionsFilter
	      Default is "/faces/myFacesExtensionResource"
	      Note: The filter-mapping for ExtensionsFilter, the url-pattern is
	      this value + "/*", else there comes a exception
	  </description>
	  <param-name>org.apache.myfaces.RESOURCE_VIRTUAL_PATH</param-name>
	  <param-value>/faces/extensionResource</param-value>
	</context-param>
	 -->

     <!-- 
    <context-param>
        <param-name>javax.faces.PARTIAL_STATE_SAVING</param-name>
        <param-value>true</param-value>
    </context-param>
     -->

    <!-- 
    <context-param>
        <param-name>org.apache.myfaces.REFRESH_TRANSIENT_BUILD_ON_PSS</param-name>
        <param-value>true</param-value>
    </context-param>
     -->
     
	<context-param>
    	<param-name>javax.faces.PROJECT_STAGE</param-name>
    	<param-value>Development</param-value>
  	</context-param>
  
	<context-param>
    	<param-name>org.apache.myfaces.USE_MULTIPLE_JS_FILES_FOR_JSF_UNCOMPRESSED_JS</param-name>
    	<param-value>true</param-value>
  	</context-param>

  	<filter>
    	<filter-name>extensionsFilter</filter-name>
    	<filter-class>org.apache.myfaces.webapp.filter.ExtensionsFilter</filter-class>
    	<init-param>
      		<description>Set the size limit for uploaded files.
                Format: 10 - 10 bytes
                        10k - 10 KB
                        10m - 10 MB
                        1g - 1 GB</description>
      	<param-name>uploadMaxFileSize</param-name>
      	<param-value>100m</param-value>
    	</init-param>
    	<init-param>
      		<description>Set the threshold size - files
                    below this limit are stored in memory, files above
                    this limit are stored on disk.

                Format: 10 - 10 bytes
                        10k - 10 KB
                        10m - 10 MB
                        1g - 1 GB</description>
      		<param-name>uploadThresholdSize</param-name>
      		<param-value>100k</param-value>
    	</init-param>
	</filter>
  	<filter-mapping>
    	<filter-name>extensionsFilter</filter-name>
    	<url-pattern>*.jsf</url-pattern>
  	</filter-mapping>
  	<filter-mapping>
    	<filter-name>extensionsFilter</filter-name>
    	<url-pattern>/faces/*</url-pattern>
  	</filter-mapping>

	<servlet>
    	<servlet-name>Faces Servlet</servlet-name>
    	<servlet-class>javax.faces.webapp.FacesServlet</servlet-class>
    	<load-on-startup>1</load-on-startup>
  	</servlet>
  
	<servlet-mapping>
    	<servlet-name>Faces Servlet</servlet-name>
    	<url-pattern>*.jsf</url-pattern>
  	</servlet-mapping>
	<servlet-mapping>
    	<servlet-name>Faces Servlet</servlet-name>
    	<url-pattern>/faces/*</url-pattern>
  	</servlet-mapping>

    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

</web-app>

