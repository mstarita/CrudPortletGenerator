<#noparse><?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:p="http://primefaces.org/ui" >

	<h:head/>
	
	<h:body>
	
		<h:form>
			<p:panel header="#{i18n['</#noparse>${entityName}.search.header']}" ><#noparse>
			
				<p:panelGrid columns="#{edit</#noparse>${className}ModelBean.nColsSearch}" style="width:100%">
<#list fieldList as field><#noparse>
					
					<h:panelGroup rendered="#{edit</#noparse>${className}ModelBean.searchFieldMap['${field.fieldName}']}"><#noparse>
						<h:outputLabel value="#{i18n['</#noparse>${entityName}.field.${field.fieldName}']}:" id="lbl${field.fieldName?cap_first}" />
						<p:inputText id="txt${field.fieldName?cap_first}"
							<#noparse>value="#{search</#noparse>${className}ModelBean.search${className}.${field.fieldName}}" />
						<p:message id="msg${field.fieldName?cap_first}" for="txt${field.fieldName?cap_first}" />
					</h:panelGroup>			
</#list>

				</p:panelGrid>
<#noparse>					
				<p/>
				
				<p>
					<p:dataTable id="</#noparse>${entityName}Table"
						<#noparse>value="#{search</#noparse>${className}ModelBean.${entityName}List}"
						var="${entityName}" rows="<#noparse>#{edit</#noparse>${className}ModelBean.rowsPerPage}" 
						width="100%" paginator="true" rowsPerPageTemplate="5,10,15,20,30"
						paginatorTemplate="{CurrentPageReport}  {FirstPageLink} {PreviousPageLink} {PageLinks} {NextPageLink} {LastPageLink} {RowsPerPageDropdown}" >

<#list gridFields as field>
						<p:column id="${field}" <#noparse>rendered="#{edit</#noparse>${className}ModelBean.resultFieldMap['${field}']}" 
							<#noparse>sortBy="#{</#noparse>${entityName}.${field}}" <#noparse>headerText="#{i18n['</#noparse>${entityName}.field.${field}']}">
							<#noparse><h:outputText value="#{</#noparse>${entityName}.${field}}"/>
						</p:column>
</#list>
<#noparse>
						<p:column id="ops">
							<p:commandLink
								action="#{search</#noparse>${className}BackingBean.actionShow}">
								<f:setPropertyActionListener <#noparse>value="#{</#noparse>${entityName}.${keyField}}" 
						        	<#noparse>target="#{</#noparse>search${className}BackingBean.idSelected}" />
								<#noparse><h:graphicImage value="/images/page.png" alt="#{i18n['button.show']}" />
							</p:commandLink>
							<p:commandLink
								action="#{search</#noparse>${className}BackingBean.actionEdit}">
								<f:setPropertyActionListener <#noparse>value="#{</#noparse>${entityName}.${keyField}}" 
						        	<#noparse>target="#{</#noparse>search${className}BackingBean.idSelected}" />
								<#noparse><h:graphicImage value="/images/pencil.png" alt="#{i18n['button.edit']}" />
							</p:commandLink>
							<p:commandLink onclick="confirmDeletion.show()" ></#noparse>
								<f:setPropertyActionListener <#noparse>value="#{</#noparse>${entityName}.${keyField}}" 
						        	<#noparse>target="#{</#noparse>search${className}BackingBean.idSelected}" />
								<#noparse><h:graphicImage value="/images/delete.png" alt="#{i18n['button.delete']}" />
							</p:commandLink>
							<p:commandLink
								onsuccess="printDetail()" >
								<f:setPropertyActionListener value="#{</#noparse>${entityName}.${keyField}}" 
						        	<#noparse>target="#{</#noparse>search${className}BackingBean.idSelected}" />
								<#noparse><h:graphicImage value="/images/print.png" alt="#{i18n['button.print']}" />
							</p:commandLink>
							
							<p:confirmDialog id="confirmDialog" message="#{i18n['deletion-confirm.message']}"
						                header="#{i18n['deletion-confirm.title']}" severity="alert" widgetVar="confirmDeletion">
						        <p:commandButton id="confirm" value="#{i18n['button.confirm']}" update="@form" oncomplete="confirmDeletion.hide()"
						                    action="#{search</#noparse>${className}BackingBean.actionDelete}" /><#noparse>
						        <p:commandButton id="decline" value="#{i18n['button.cancel']}" onclick="confirmDeletion.hide()" type="button" />
						    </p:confirmDialog>
						</p:column>
							
					</p:dataTable>
				</p>
			</p:panel>
							 
			<p/>
				
			<p>
				<p:commandButton
					style="margin-right: 10px"
					value="#{i18n['button.new']}"
					action="#{search</#noparse>${className}<#noparse>BackingBean.actionNew}" />
				<p:commandButton
					style="margin-right: 10px"
					value="#{i18n['button.print']}"
					rendered="#{! empty search</#noparse>${className}ModelBean.${entityName}List}"<#noparse> 
					onclick="printResult()"
					update="msgs" />
				<h:commandButton
					value="#{i18n['button.reset']}"
					type="reset" />
				<p:commandButton
					value="#{i18n['button.search']}"
					action="#{search</#noparse>${className}<#noparse>BackingBean.actionSearch}" 
					update="</#noparse>${entityName}Table<#noparse> msgs @parent"/>
				
				<p:remoteCommand
					name="printDetail" 
					actionListener="#{search</#noparse>${className}<#noparse>BackingBean.actionPrintDetail}"
					onsuccess="window.open('#{facesUtil.baseUrl}/DocumentGeneratorServlet?templateName=dettaglioPerson.ftl', 'file', 'scrollbars=yes,toolbar=no,location=no')" 
					update="msgs" />	
				<p:remoteCommand
					name="printResult" 
					actionListener="#{search</#noparse>${className}<#noparse>BackingBean.actionPrintResult}"
					onsuccess="window.open('#{facesUtil.baseUrl}/DocumentGeneratorServlet?templateName=lista</#noparse>${className}<#noparse>.ftl', 'file', 'scrollbars=yes,toolbar=no,location=no')" 
					update="msgs" />
				
			</p>
		
			<p/>
			
			<p:messages id="msgs" globalOnly="true" layout="table" />
	
		</h:form>

	</h:body>
	
</html>
</#noparse>