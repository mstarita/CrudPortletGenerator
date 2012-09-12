<#noparse><?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core" 
	xmlns:ui="http://java.sun.com/jsf/facelets"
	xmlns:ice="http://www.icesoft.com/icefaces/component" 
	xmlns:ace="http://www.icefaces.org/icefaces/components" >

	<h:head/>
	
	<h:body>
	
		<link href="#{request.contextPath}/xmlhttp/css/rime/rime-portlet.css" rel="stylesheet" type="text/css"/>
	
		<ice:form>
			<ace:panel header="#{i18n['</#noparse>${entityName}.search.header']}"><#noparse>
			
				<ice:panelGrid columns="#{edit</#noparse>${className}ModelBean.nColsSearch}" style="width:100%">
<#list fieldList as field><#noparse>
					
					<ice:panelGroup rendered="#{edit</#noparse>${className}ModelBean.searchFieldMap['${field.fieldName}']}"><#noparse>
						<ice:outputLabel value="#{i18n['</#noparse>${entityName}.field.${field.fieldName}']}:" id="lbl${field.fieldName?cap_first}" />
						<ice:inputText id="txt${field.fieldName?cap_first}"
							<#noparse>value="#{search</#noparse>${className}ModelBean.search${className}.${field.fieldName}}" />
						<ice:message id="msg${field.fieldName?cap_first}" for="txt${field.fieldName?cap_first}" />
					</ice:panelGroup>			
</#list>

				</ice:panelGrid>
<#noparse>					
				<p/>
				
				<ace:dataTable id="</#noparse>${entityName}Table"
					<#noparse>value="#{search</#noparse>${className}ModelBean.${entityName}List}"
					var="${entityName}" 
					paginator="true" paginatorPosition="bottom"
					rows="<#noparse>#{edit</#noparse>${className}ModelBean.rowsPerPage}" 
					width="100%" >

<#list gridFields as field>
					<ace:column id="${field}" <#noparse>rendered="#{edit</#noparse>${className}ModelBean.resultFieldMap['${field}']}" 
						headerText="<#noparse>#{i18n['</#noparse>${entityName}.field.${field}']}"<#noparse>
						sortBy="#{</#noparse>${entityName}.${field}}" ><#noparse> 
						<ice:outputText value="#{</#noparse>${entityName}.${field}}"/>
					</ace:column>
</#list>
<#noparse>
					<ace:column id="ops">
						<ice:commandLink
							action="#{search</#noparse>${className}BackingBean.actionShow}">
							<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
							<#noparse><h:graphicImage value="/images/page.png" alt="#{i18n['button.show']}" />
						</ice:commandLink>
						<ice:commandLink
							action="#{search</#noparse>${className}BackingBean.actionEdit}">
							<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
							<#noparse><h:graphicImage value="/images/pencil.png" alt="#{i18n['button.edit']}" />
						</ice:commandLink>
						<ice:commandLink
							action="#{search</#noparse>${className}BackingBean.actionDelete}" 
							panelConfirmation=":::confirmDeletion" >
							<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
							<#noparse><h:graphicImage value="/images/delete.png" alt="#{i18n['button.delete']}" />
						</ice:commandLink>
						<ice:commandLink
							actionListener="#{search</#noparse>${className}BackingBean.actionPrintDetail}" 
							update="printing" >
							<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
							<#noparse><h:graphicImage value="/images/print.png" alt="#{i18n['button.print']}" />
						</ice:commandLink>
								
					</ace:column>
							
				</ace:dataTable>
				
				<ice:panelConfirmation 
					id="confirmDeletion"
					acceptLabel="#{i18n['button.confirm']}"
					cancelLabel="#{i18n['button.cancel']}"
					message="#{i18n['deletion-confirm.message']}"
					title="#{i18n['deletion-confirm.title']}" 
					draggable="false"
					autoCentre="true" 
					rendered="true" />
						 
				<p/>
				
					
				<ice:commandButton
					style="margin-right: 10px"
					value="#{i18n['button.new']}"
					action="#{search</#noparse>${className}<#noparse>BackingBean.actionNew}" />
				<ice:commandButton
					style="margin-right: 10px"
					value="#{i18n['button.print']}"
					rendered="#{! empty search</#noparse>${className}ModelBean.${entityName}List}"<#noparse> 
					actionListener="#{search</#noparse>${className}<#noparse>BackingBean.actionPrintResult}" 
					update="printing" />
				<h:commandButton
					styleClass="button"
					value="#{i18n['button.reset']}"
					type="reset" />
				<ice:commandButton
					styleClass="button"
					value="#{i18n['button.search']}"
					action="#{search</#noparse>${className}<#noparse>BackingBean.actionSearch}" 
					update="</#noparse>${entityName}Table<#noparse>"/>
					
			</ace:panel>
			
			<p/>
				
			<ice:messages globalOnly="true" layout="table" />
				
			<ui:fragment id="printing" rendered="#{search</#noparse>${className}<#noparse>BackingBean.printing}">
				<script>window.open('#{search</#noparse>${className}<#noparse>BackingBean.printUrl}', 'file', 'scrollbars=yes,toolbar=no,location=no')</script>
			</ui:fragment>
				
		</ice:form>

	</h:body>
	
</html>
</#noparse>