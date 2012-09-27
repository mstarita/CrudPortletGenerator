<#noparse><?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core" 
	xmlns:ui="http://java.sun.com/jsf/facelets"
	xmlns:a4j="http://richfaces.org/a4j"
	xmlns:rich="http://richfaces.org/rich" >

	<h:head/>
	
	<h:body>
	
		<h:form>
			<rich:panel header="#{i18n['</#noparse>${entityName}.search.header']}" ><#noparse>
			
				
				<h:panelGrid columns="#{edit</#noparse>${className}ModelBean.nColsSearch}" style="width:100%">
<#list fieldList as field><#noparse>
					
					<h:panelGroup rendered="#{edit</#noparse>${className}ModelBean.searchFieldMap['${field.fieldName}']}"><#noparse>
						<h:outputLabel value="#{i18n['</#noparse>${entityName}.field.${field.fieldName}']}:" id="lbl${field.fieldName?cap_first}" />
						<h:inputText id="txt${field.fieldName?cap_first}"
							<#noparse>value="#{search</#noparse>${className}ModelBean.search${className}.${field.fieldName}}" />
						<h:message id="msg${field.fieldName?cap_first}" for="txt${field.fieldName?cap_first}" />
					</h:panelGroup>			
</#list>

				</h:panelGrid>
<#noparse>					
				<p/>
				
				<p>
					<h:panelGrid style="width:100%;text-align:center" >
						<rich:dataTable id="</#noparse>${entityName}Table"
							<#noparse>value="#{search</#noparse>${className}ModelBean.${entityName}List}"
							var="${entityName}" rows="<#noparse>#{edit</#noparse>${className}ModelBean.rowsPerPage}" 
							style="width:100%" >

<#list gridFields as field>
							<rich:column id="${field}" <#noparse>rendered="#{edit</#noparse>${className}ModelBean.resultFieldMap['${field}']}"
								<#noparse>sortBy="#{</#noparse>${entityName}.${field}}<#noparse>" sortOrder="#{search${className}ModelBean.</#noparse>${field}Order}" ><#noparse>
								<f:facet name="header">
									<a4j:commandLink value="#{i18n['</#noparse>${entityName}.field.${field}']}" render="${entityName}Table" 
										<#noparse>action="#{search</#noparse>${className}BackingBean.sortBy${field?cap_first}}" />
								</f:facet>
								<#noparse><h:outputText value="#{</#noparse>${entityName}.${field}}"/>
							</rich:column>
</#list>
<#noparse>
							<rich:column id="ops">
								<h:commandLink
									action="#{search</#noparse>${className}BackingBean.actionShow}">
									<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
									<#noparse><h:graphicImage value="/images/page.png" alt="#{i18n['button.show']}" />
								</h:commandLink>
								<h:commandLink
									action="#{search</#noparse>${className}BackingBean.actionEdit}">
									<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
									<#noparse><h:graphicImage value="/images/pencil.png" alt="#{i18n['button.edit']}" />
								</h:commandLink>
								<a4j:commandLink
									action="#{search</#noparse>${className}BackingBean.actionDelete}" 
									onclick="return <#noparse>confirm('#{i18n['deletion-confirm.message']}')" 
									render="@form" ></#noparse>
									<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
									<#noparse><h:graphicImage value="/images/delete.png" alt="#{i18n['button.delete']}" />
								</a4j:commandLink>
								<a4j:commandLink
									actionListener="#{search</#noparse>${className}BackingBean.actionPrintDetail}" 
									render="@form" >
									<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
									<#noparse><h:graphicImage value="/images/print.png" alt="#{i18n['button.print']}" />
								</a4j:commandLink>			
							</rich:column>
								
						</rich:dataTable>
						
						<rich:dataScroller for="</#noparse>${entityName}<#noparse>Table" maxPages="4" style="align:center"/>
					
					</h:panelGrid>
				</p>
			</rich:panel> 
					
			<p/>
				
			<p>
				<h:commandButton
					style="margin-right: 10px"
					value="#{i18n['button.new']}"
					action="#{search</#noparse>${className}<#noparse>BackingBean.actionNew}" />
				<a4j:commandButton
					style="margin-right: 10px"
					value="#{i18n['button.print']}"
					rendered="#{! empty search</#noparse>${className}ModelBean.${entityName}List}"<#noparse> 
					actionListener="#{search</#noparse>${className}<#noparse>BackingBean.actionPrintResult}" 
					render="@form" />
				<a4j:commandButton
					value="#{i18n['button.reset']}"
					actionListener="#{search</#noparse>${className}<#noparse>BackingBean.actionReset}" 
					immediate="true" execute="@this" render="@form"/>
				<a4j:commandButton
					value="#{i18n['button.search']}"
					action="#{search</#noparse>${className}<#noparse>BackingBean.actionSearch}" 
					render="@form"/>
			</p>

			<p/>
				
			<rich:messages globalOnly="true" layout="table" />
				
			<ui:fragment id="printing" rendered="#{search</#noparse>${className}<#noparse>BackingBean.printing}">
				<script>window.open('#{search</#noparse>${className}<#noparse>BackingBean.printUrl}', 'file', 'scrollbars=yes,toolbar=no,location=no')</script>
			</ui:fragment>
				
		</h:form>

	</h:body>
	
</html>
</#noparse>