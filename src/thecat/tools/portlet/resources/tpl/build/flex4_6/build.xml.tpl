<?xml version="1.0" encoding="UTF-8"?>
<project name="FlexCrudPortlet" default="war">

    <property file="env.properties"/>
    <property file="project.properties"/>
    <xmlproperty prefix="eclipse" file=".project"/>

    <echo message="Found in env.properties {"/>
    <#noparse><echo message="    FLEX_HOME=${FLEX_HOME}"/></#noparse>
    <#noparse><echo message="    FLEX_TASKS_JAR=${FLEX_TASKS_JAR}"/></#noparse>
    <echo message="}"/>

    <#noparse><taskdef resource="flexTasks.tasks" classpath="${FLEX_TASKS_JAR}" /></#noparse>

    <!--
     ! Update core GDS libs.
     !-->
    <#noparse><target name="update.libs" if="graniteds.path">
        <ant
            antfile="${GRANITEDS_PROJECT_PATH}/build.xml"
            dir="${GRANITEDS_PROJECT_PATH}"
            target="build.jar.swc" />
        <copy todir="WEB-INF/lib">
            <fileset dir="${GRANITEDS_PROJECT_PATH}/build">
                <include name="granite.jar"/>
            </fileset>
        </copy>
    </target></#noparse>

    <!--
     ! Build swf (if swf is out of date).
     !-->
    <target name="copy.mxml">
        <mkdir dir="build"/>
        <mkdir dir="build/swf"/>
        <copy todir="build/swf">
            <fileset dir="WebContent">
                <include name="**/*.mxml"/>
                <include name="**/*.css"/>
                <include name="**/*.png"/>
                <include name="**/*.as"/>
            	<include name="img/*.*"/>
            </fileset>
        </copy>
    </target>
    <#noparse><target name="check.swf" depends="copy.mxml">
        <uptodate property="skip.mxmlc" targetfile="build/swf/${APP_NAME}.swf">
            <srcfiles dir= "${FLEX_HOME}/frameworks" includes="**"/>
            <srcfiles dir= "build/swf" includes="**/*.mxml"/>
            <srcfiles dir= "WebContent" includes="WEB-INF/flex/services-config.xml"/>
        </uptodate>
    </target></#noparse>
    <target name="build.mxml" depends="check.swf" unless="skip.mxmlc">
    	<mxmlc
            file="WebContent/${entityName}/edit.mxml"
            output="build/swf/${entityName}/edit.swf"
            <#noparse>context-root="${WEBAPP_CONTEXT_ROOT}"</#noparse>
            use-network="true"
            keep-generated-actionscript="true"
            incremental="true"
        	debug="true"
        	locale="it_IT,en_US" 
    		services="WebContent/WEB-INF/flex/services-config.xml" >
    		
    		<arg line="-static-link-runtime-shared-libraries=true"/>

            <#noparse><load-config filename="${FLEX_HOME}/frameworks/flex-config.xml"/></#noparse>

            <#noparse><source-path path-element="${FLEX_HOME}/frameworks"/></#noparse>
            <source-path path-element="build/swf"/>
        	<source-path path-element="locale/{locale}"/>
    		<source-path path-element="src"/>
        </mxmlc>
    	<mxmlc
            file="WebContent/${entityName}/view.mxml"
            output="build/swf/${entityName}/view.swf"
            <#noparse>context-root="${WEBAPP_CONTEXT_ROOT}"</#noparse>
            use-network="true"
            keep-generated-actionscript="true"
            incremental="true"
        	debug="true"
        	locale="it_IT,en_US" 
        	services="WebContent/WEB-INF/flex/services-config.xml" >
        	
        	<arg line="-static-link-runtime-shared-libraries=true"/>

            <#noparse><load-config filename="${FLEX_HOME}/frameworks/flex-config.xml"/></#noparse>

            <#noparse><source-path path-element="${FLEX_HOME}/frameworks"/></#noparse>
            <source-path path-element="build/swf"/>
        	<source-path path-element="locale/{locale}"/>
        	<source-path path-element="src"/>
        </mxmlc>
    </target>

    <!--
     ! Compile Java sources (unless this script is launched from Eclipse).
     !-->
    <target name="build.javac" depends="update.libs" unless="eclipse.pdebuild.home">
        <mkdir dir="classes"/>

        <path id="gds.classpath">
            <fileset dir="WebContent/WEB-INF/lib" includes="**"/>
        </path>

        <javac destdir="classes" srcdir="src" classpathref="gds.classpath"
            target="1.6" source="1.6"/>
    </target>

    <!--
     ! Build war.
     !-->
    <target name="war" depends="build.javac,build.mxml">
        <mkdir dir="build"/>
        <mkdir dir="build/war"/>
        <#noparse><war destfile="build/war/${APP_NAME}.war" webxml="WebContent/WEB-INF/web.xml"></#noparse>
            <zipfileset dir="build/classes" prefix="WEB-INF/classes" />
            <fileset dir="build/swf" includes="person/*.swf"/>
        	<fileset dir="build/swf" includes="person/*.html"/>
            <fileset dir="WebContent">
                <include name="*.js"/>
                <include name="*.html"/>
                <include name="*.gif"/>
            	<include name="images/*.*"/>
            	<include name="docTemplate/*.*"/>
            	<include name="${entityName}/*.jsp"/>
            	<include name="WEB-INF/**"/>
            	<include name="WEB-INF/flex/**"/>
				<include name="WEB-INF/granite/**"/>
            </fileset>
            <lib dir="WebContent/WEB-INF/lib">
                <exclude name="javax.servlet.jar"/>
            </lib>
        </war>
    </target>
    
</project>
