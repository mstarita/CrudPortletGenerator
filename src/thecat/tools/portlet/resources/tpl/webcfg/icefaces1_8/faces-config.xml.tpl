<#noparse><?xml version="1.0" encoding="UTF-8"?>
<faces-config version="1.2" xmlns="http://java.sun.com/xml/ns/javaee"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-facesconfig_1_2.xsd">

	<application>
	  <view-handler>
	      com.icesoft.faces.facelets.D2DFaceletViewHandler
	  </view-handler>
	</application>
	
	<managed-bean>
		</#noparse><managed-bean-name>search${className}ModelBean</managed-bean-name>
		<managed-bean-class>${packageName}.Search${className}ModelBean</managed-bean-class><#noparse>
		<managed-bean-scope>session</managed-bean-scope>
	</managed-bean>
	
	<managed-bean>
		<managed-bean-name>search</#noparse>${className}BackingBean</managed-bean-name>
		<managed-bean-class>${packageName}.Search${className}BackingBean</managed-bean-class><#noparse>
		<managed-bean-scope>request</managed-bean-scope>
		<managed-property>
			<property-name>searchModelBean</property-name>
			<value>#{search</#noparse>${className}ModelBean}</value><#noparse>
		</managed-property>
		<managed-property>
			<property-name>registryModelBean</property-name>
			<value>#{registry</#noparse>${className}ModelBean}</value><#noparse>
		</managed-property>
		<managed-property>
			<property-name>i18n</property-name>
			<value>#{i18n}</value>
		</managed-property>
		</#noparse><#if ! icefacesExtReq><#noparse>
		<managed-property>
			<property-name></#noparse>${keyField}Selected</property-name><#noparse>
			<value>#{param.</#noparse>${keyField}<#noparse>}</value>
		</#noparse></managed-property>
		</#if><#noparse>
	</managed-bean>
	
	<managed-bean>
		<managed-bean-name>registry</#noparse>${className}ModelBean</managed-bean-name>
		<managed-bean-class>${packageName}.Registry${className}ModelBean</managed-bean-class><#noparse>
		<managed-bean-scope>session</managed-bean-scope>
	</managed-bean>
	
	<managed-bean>
		<managed-bean-name>registry</#noparse>${className}BackingBean</managed-bean-name>
		<managed-bean-class>${packageName}.Registry${className}BackingBean</managed-bean-class>
		<managed-bean-scope>request</managed-bean-scope><#noparse>
		<managed-property>
			<property-name>modelBean</property-name>
			<value>#{registry</#noparse>${className}ModelBean}</value><#noparse>
		</managed-property>
		<managed-property>
			<property-name>i18n</property-name>
			<value>#{i18n}</value>
		</managed-property>
	</managed-bean>

	<managed-bean>
		</#noparse><managed-bean-name>edit${className}ModelBean</managed-bean-name>
		<managed-bean-class>${packageName}.Edit${className}ModelBean</managed-bean-class>
		<managed-bean-scope>session</managed-bean-scope>
	</managed-bean><#noparse>	
	
	<managed-bean>
		<managed-bean-name>edit</#noparse>${className}BackingBean</managed-bean-name>
		<managed-bean-class>${packageName}.Edit${className}BackingBean</managed-bean-class>
		<managed-bean-scope>request</managed-bean-scope>
		<managed-property><#noparse>
			<property-name>modelBean</property-name>
			<value>#{edit</#noparse>${className}ModelBean}</value><#noparse>
		</managed-property>
		<managed-property>
			<property-name>i18n</property-name>
			<value>#{i18n}</value>
		</managed-property>
	</managed-bean>
</#noparse>
	
	<navigation-rule>
		<from-view-id>/${entityName}/search.jspx</from-view-id>
		<navigation-case>
			<from-outcome>new</from-outcome>
			<to-view-id>/${entityName}/registry</to-view-id>			
		</navigation-case>
		<navigation-case>
			<from-outcome>edit</from-outcome>
			<to-view-id>/${entityName}/registry</to-view-id>			
		</navigation-case>
		<navigation-case>
			<from-outcome>show</from-outcome>
			<to-view-id>/${entityName}/registry</to-view-id>			
		</navigation-case>
	</navigation-rule>
	
	<navigation-rule>
		<from-view-id>/${entityName}/registry.jspx</from-view-id>
		<navigation-case>
			<from-outcome>confirm</from-outcome>
			<to-view-id>/${entityName}/search</to-view-id>			
		</navigation-case>
		<navigation-case>
			<from-outcome>cancel</from-outcome>
			<to-view-id>/${entityName}/search</to-view-id>			
		</navigation-case>
	</navigation-rule>
	
</faces-config>
