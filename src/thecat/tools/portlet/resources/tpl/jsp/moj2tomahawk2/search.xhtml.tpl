<#noparse><?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core" 
	xmlns:ui="http://java.sun.com/jsf/facelets"
	xmlns:t="http://myfaces.apache.org/tomahawk" >

	<h:head/>
	
	<h:body>
	
		<h:form>
			<h3><span><t:outputText value="#{i18n['</#noparse>${entityName}.search.header']}" /></span></h3><#noparse>
			
				<fieldset>
					<t:panelGrid columns="#{edit</#noparse>${className}ModelBean.nColsSearch}" style="width:100%">
<#list fieldList as field><#noparse>
					
						<t:panelGroup rendered="#{edit</#noparse>${className}ModelBean.searchFieldMap['${field.fieldName}']}"><#noparse>
							<t:outputLabel value="#{i18n['</#noparse>${entityName}.field.${field.fieldName}']}:" id="lbl${field.fieldName?cap_first}" />
							<t:inputText id="txt${field.fieldName?cap_first}"
								<#noparse>value="#{search</#noparse>${className}ModelBean.search${className}.${field.fieldName}}" />
							<t:message id="msg${field.fieldName?cap_first}" for="txt${field.fieldName?cap_first}" />
						</t:panelGroup>			
</#list>

					</t:panelGrid>
<#noparse>					
					<p/>
				
					<p>
						<t:dataTable id="</#noparse>${entityName}Table"
							<#noparse>value="#{search</#noparse>${className}ModelBean.${entityName}List}"
							var="${entityName}" rows="<#noparse>#{edit</#noparse>${className}ModelBean.rowsPerPage}" 
							sortColumn="<#noparse>#{search</#noparse>${className}ModelBean.sortField}"
							sortAscending="<#noparse>#{search</#noparse>${className}ModelBean.ascending}"
							width="100%" >

<#list gridFields as field>
							<h:column id="${field}" <#noparse>rendered="#{edit</#noparse>${className}ModelBean.resultFieldMap['${field}']}" >
								<f:facet name="header">
									<t:commandSortHeader columnName="${field}">
										<#noparse>#{i18n['</#noparse>${entityName}.field.${field}']}
									</t:commandSortHeader>
								</f:facet>
								<#noparse><h:outputText value="#{</#noparse>${entityName}.${field}}"/>
							</h:column>
</#list>
<#noparse>
							<h:column id="ops">
									<t:commandLink
										action="#{search</#noparse>${className}BackingBean.actionShow}">
										<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
										<#noparse><h:graphicImage value="/images/page.png" alt="#{i18n['button.show']}" />
									</t:commandLink>
									<t:commandLink
										action="#{search</#noparse>${className}BackingBean.actionEdit}">
										<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
										<#noparse><h:graphicImage value="/images/pencil.png" alt="#{i18n['button.edit']}" />
									</t:commandLink>
									<t:commandLink
										action="#{search</#noparse>${className}BackingBean.actionDelete}" 
										onclick="return <#noparse>confirm('#{i18n['deletion-confirm.message']}')" ></#noparse>
										<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
										<#noparse><h:graphicImage value="/images/delete.png" alt="#{i18n['button.delete']}" />
									</t:commandLink>
									<t:commandLink
										actionListener="#{search</#noparse>${className}BackingBean.actionPrintDetail}" 
										update="printing" >
										<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
										<#noparse><h:graphicImage value="/images/print.png" alt="#{i18n['button.print']}" />
									</t:commandLink>	
							</h:column>
							
						</t:dataTable>
						
						<h:panelGrid columns="1" styleClass="scrollerTable2"
							columnClasses="standardTable_ColumnCentered"
							id="navigazionePagine"></#noparse>
							<t:dataScroller id="scroll_1" for="${entityName}Table" 
								fastStep="<#noparse>#{edit</#noparse>${className}ModelBean.rowsPerPage}"
								pageCountVar="pageCount" pageIndexVar="pageIndex"
								styleClass="scroller" paginator="true" paginatorMaxPages="9"
								paginatorTableClass="paginator"
								paginatorActiveColumnStyle="font-weight:bold;" immediate="true">

								<f:facet name="first">
									<t:graphicImage url="/images/arrow-first.gif" border="1" />
								</f:facet>
								<f:facet name="last">
									<t:graphicImage url="/images/arrow-last.gif" border="1" />
								</f:facet>
								<f:facet name="previous">
									<t:graphicImage url="/images/arrow-previous.gif" border="1" />
								</f:facet>
								<f:facet name="next">
									<t:graphicImage url="/images/arrow-next.gif" border="1" />
								</f:facet>
								<f:facet name="fastforward">
									<t:graphicImage url="/images/arrow-ff.gif" border="1" />
								</f:facet>
								<f:facet name="fastrewind">
									<t:graphicImage url="/images/arrow-fr.gif" border="1" />
								</f:facet>
							</t:dataScroller>

						</h:panelGrid>
					</p>
					 
					<p/>
				
					<p>
						<t:commandButton
							style="margin-right: 10px"<#noparse>
							value="#{i18n['button.new']}"
							action="#{search</#noparse>${className}<#noparse>BackingBean.actionNew}" />
						<t:commandButton
							style="margin-right: 10px"
							value="#{i18n['button.print']}"
							rendered="#{! empty search</#noparse>${className}ModelBean.${entityName}List}"<#noparse> 
							actionListener="#{search</#noparse>${className}<#noparse>BackingBean.actionPrintResult}" 
							update="printing" />
						<h:commandButton
							value="#{i18n['button.reset']}"
							type="reset" />
						<t:commandButton
							value="#{i18n['button.search']}"
							action="#{search</#noparse>${className}<#noparse>BackingBean.actionSearch}" 
							update="</#noparse>${entityName}Table<#noparse>"/>
					</p>
					
				</fieldset>
			
				<p/>
				
				<t:messages globalOnly="true" layout="table" />
				
				<ui:fragment id="printing" rendered="#{search</#noparse>${className}<#noparse>BackingBean.printing}">
					<script>window.open('#{search</#noparse>${className}<#noparse>BackingBean.printUrl}', 'file', 'scrollbars=yes,toolbar=no,location=no')</script>
				</ui:fragment>
				
		</h:form>

	</h:body>
	
</html>
</#noparse>