<#noparse><?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core" 
	xmlns:ui="http://java.sun.com/jsf/facelets"
	xmlns:aui="http://liferay.com/faces/aui" >

	<h:head/>
	
	<h:body>
	
		<aui:layout>
			<h:form>
				<h3><span><h:outputText value="#{i18n['</#noparse>${entityName}.search.header']}" /></span></h3><#noparse>
				
					<aui:fieldset>
						<h:panelGrid columns="#{edit</#noparse>${className}ModelBean.nColsSearch}" style="width:100%">
<#list fieldList as field><#noparse>
					
							<h:panelGroup rendered="#{edit</#noparse>${className}ModelBean.searchFieldMap['${field.fieldName}']}">
								<aui:field id="lbl${field.fieldName?cap_first}" label="<#noparse>#{i18n['</#noparse>${entityName}.field.${field.fieldName}']}">
									<h:inputText id="txt${field.fieldName?cap_first}"
										<#noparse>value="#{search</#noparse>${className}ModelBean.search${className}.${field.fieldName}}" />
									<h:message id="msg${field.fieldName?cap_first}" for="txt${field.fieldName?cap_first}" />
								</aui:field>
							</h:panelGroup>			
</#list>

						</h:panelGrid>
					</aui:fieldset>
<#noparse>					
					<p/>
				
					<aui:fieldset>
						<h:dataTable id="</#noparse>${entityName}Table"
							<#noparse>value="#{search</#noparse>${className}ModelBean.${entityName}List}"
							var="${entityName}" rows="<#noparse>#{edit</#noparse>${className}ModelBean.rowsPerPage}" 
							width="100%" >

<#list gridFields as field>
							<h:column id="${field}" <#noparse>rendered="#{edit</#noparse>${className}ModelBean.resultFieldMap['${field}']}" >
								<f:facet name="header"><#noparse>#{i18n['</#noparse>${entityName}.field.${field}']}</f:facet>
								<#noparse><h:outputText value="#{</#noparse>${entityName}.${field}}"/>
							</h:column>
</#list>
<#noparse>
							<h:column id="ops">
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
								<h:commandLink
									action="#{search</#noparse>${className}BackingBean.actionDelete}" 
									onclick="return <#noparse>confirm('#{i18n['deletion-confirm.message']}')" ></#noparse>
									<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
									<#noparse><h:graphicImage value="/images/delete.png" alt="#{i18n['button.delete']}" />
								</h:commandLink>
								<h:commandLink
									actionListener="#{search</#noparse>${className}BackingBean.actionPrintDetail}" 
									update="printing" >
									<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
									<#noparse><h:graphicImage value="/images/print.png" alt="#{i18n['button.print']}" />
								</h:commandLink>
							</h:column>
							
						</h:dataTable>
					</aui:fieldset>
					 
					<p/>
				
					<p>
						<h:commandButton
							style="margin-right: 10px"
							value="#{i18n['button.new']}"
							action="#{search</#noparse>${className}<#noparse>BackingBean.actionNew}" />
						<h:commandButton
							style="margin-right: 10px"
							value="#{i18n['button.print']}"
							rendered="#{! empty search</#noparse>${className}ModelBean.${entityName}List}"<#noparse> 
							actionListener="#{search</#noparse>${className}<#noparse>BackingBean.actionPrintResult}" 
							update="printing" />
						<h:commandButton
							value="#{i18n['button.reset']}"
							type="reset" />
						<h:commandButton
							value="#{i18n['button.search']}"
							action="#{search</#noparse>${className}<#noparse>BackingBean.actionSearch}" 
							update="</#noparse>${entityName}Table<#noparse>"/>
					</p>
			
					<p/>
				
					<h:messages globalOnly="true" layout="table" />
				
					<ui:fragment id="printing" rendered="#{search</#noparse>${className}<#noparse>BackingBean.printing}">
						<script>window.open('#{search</#noparse>${className}<#noparse>BackingBean.printUrl}', 'file', 'scrollbars=yes,toolbar=no,location=no')</script>
					</ui:fragment>
				
			</h:form>
		</aui:layout>
		
	</h:body>
	
</html>
</#noparse>