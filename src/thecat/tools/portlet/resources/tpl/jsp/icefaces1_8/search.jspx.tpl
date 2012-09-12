<#noparse><?xml version="1.0" encoding="UTF-8"?>
<f:view 
	xmlns:h="http://java.sun.com/jsf/html"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:ice="http://www.icesoft.com/icefaces/component"
	xmlns:pf="http://portletfaces.org/facelets" >

	<ice:portlet>

		<ice:outputStyle href="/xmlhttp/css/rime/rime-portlet.css"/>
		<ice:outputStyle href="/css/form.css"/>
		
		<ice:form id="</#noparse>${entityName}<#noparse>Form" styleClass="form" >
			<h3><span><h:outputText value="#{i18n['</#noparse>${entityName}.search.header']}" /></span></h3><#noparse>
		
				<fieldset>
					<ice:panelGrid columns="#{edit</#noparse>${className}ModelBean.nColsSearch}" width="100%">
<#list fieldList as field><#noparse>
					
						<ice:panelGroup rendered="#{edit</#noparse>${className}ModelBean.searchFieldMap['${field.fieldName}']}"><#noparse>
							<p>
								<ice:outputLabel value="#{i18n['</#noparse>${entityName}.field.${field.fieldName}']}:" id="lbl${field.fieldName?cap_first}" />
								<ice:inputText id="txt${field.fieldName?cap_first}"
									<#noparse>value="#{search</#noparse>${className}ModelBean.search${className}.${field.fieldName}}" />
								<ice:message id="msg${field.fieldName?cap_first}" for="txt${field.fieldName?cap_first}" />
							</p>
						</ice:panelGroup>			
</#list>

					</ice:panelGrid>
<#noparse>					
					<p/>
				
					<p>
						<ice:dataTable id="</#noparse>${entityName}Table"
							<#noparse>value="#{search</#noparse>${className}ModelBean.${entityName}List}"
							var="${entityName}" rows="<#noparse>#{edit</#noparse>${className}ModelBean.rowsPerPage}"
							<#noparse>sortColumn="#{search</#noparse>${className}ModelBean.sortField}"
							<#noparse>sortAscending="#{search</#noparse>${className}ModelBean.ascending}" 
							resizable="true" width="100%" >
							
							<f:facet name="footer">
								<ice:dataPaginator
				                       for="${entityName}<#noparse>Table"
				                       rowsCountVar="rowsCount"
				                       displayedRowsCountVar="displayedRowsCountVar"
				                       firstRowIndexVar="firstRowIndex"
				                       lastRowIndexVar="lastRowIndex"
				                       pageCountVar="pageCount"
				                       pageIndexVar="pageIndex">
					                <ice:outputFormat value="#{i18n['grid.summary']}"
										styleClass="footerTableText">
					                    <f:param value="#{rowsCount}"/>
					                    <f:param value="#{displayedRowsCountVar}"/>
					                    <f:param value="#{firstRowIndex}"/>
					                    <f:param value="#{lastRowIndex}"/>
					                    <f:param value="#{pageIndex}"/>
					                    <f:param value="#{pageCount}"/>
					                </ice:outputFormat>
				            	</ice:dataPaginator>
							</f:facet>
</#noparse>
<#list gridFields as field>
							<ice:column id="${field}" <#noparse>rendered="#{edit</#noparse>${className}ModelBean.resultFieldMap['${field}']}">
								<f:facet name="header">
									<ice:commandSortHeader id="${field}Sorter" columnName="${field}">
										<#noparse><ice:outputText value="#{i18n['</#noparse>${entityName}.field.${field}']}" />
									</ice:commandSortHeader>
								</f:facet>
								<#noparse><h:outputText value="#{</#noparse>${entityName}.${field}}"/>
							</ice:column>
</#list>
<#noparse>
							<ice:column id="ops">
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
										panelConfirmation="confirmDeletion" >
										<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
										<#noparse><h:graphicImage value="/images/delete.png" alt="#{i18n['button.delete']}" />
									</ice:commandLink>
									<ice:commandLink
										actionListener="#{search</#noparse>${className}BackingBean.actionPrintDetail}" >
										<f:param name="${keyField}" <#noparse>value="#{</#noparse>${entityName}.${keyField}}" />
										<#noparse><h:graphicImage value="/images/print.png" alt="#{i18n['button.print']}" />
									</ice:commandLink>
									
									<ice:panelConfirmation 
										id="confirmDeletion"
										acceptLabel="#{i18n['button.confirm']}"
										cancelLabel="#{i18n['button.cancel']}"
										message="#{i18n['deletion-confirm.message']}"
										title="#{i18n['deletion-confirm.title']}" 
										draggable="false"
										autoCentre="true" />
										
							</ice:column>
							
						</ice:dataTable>
					</p>
					 
					<p>
							<center>
								<ice:dataPaginator id="dataScroll_1"
									for="</#noparse>${entityName}<#noparse>Table"
									fastStep="3"
									paginator="true"
									paginatorMaxPages="4"
									style="width:420px; margin:none; padding:5px;">
									
		                			<f:facet name="first">
					                    <ice:graphicImage id="firstpage_1"
					                                      url="/xmlhttp/css/rime/css-images/arrow-first.gif"
					                                      style="border:none;"
					                                      title="first page"/>
		                			</f:facet>
					                <f:facet name="last">
					                    <ice:graphicImage id="lastpage_1"
					                                      url="/xmlhttp/css/rime/css-images/arrow-last.gif"
					                                      style="border:none;"
					                                      title="last page"/>
					                </f:facet>
					                <f:facet name="previous">
					                    <ice:graphicImage id="previouspage_1"
					                                      url="/xmlhttp/css/rime/css-images/arrow-previous.gif"
					                                      style="border:none;"
					                                      title="previous page"/>
					                </f:facet>
					                <f:facet name="next">
					                    <ice:graphicImage id="nextpage_1"
					                                      url="/xmlhttp/css/rime/css-images/arrow-next.gif"
					                                      style="border:none;"
					                                      title="next page"/>
					                </f:facet>
					                <f:facet name="fastforward">
					                    <ice:graphicImage id="fastforward_1"
					                                      url="/xmlhttp/css/rime/css-images/arrow-ff.gif"
					                                      style="border:none;"
					                                      title="fast forward"/>
					                </f:facet>
					                <f:facet name="fastrewind">
					                    <ice:graphicImage id="fastrewind_1"
					                                      url="/xmlhttp/css/rime/css-images/arrow-fr.gif"
					                                      style="border:none;"
					                                      title="fast backward"/>
					                </f:facet>
		            			</ice:dataPaginator>
	            			</center>
					</p>
									
					<p></p>
				
					<p class="submit">
						<ice:commandButton
							style="margin-right: 10px"
							value="#{i18n['button.new']}"
							action="#{search</#noparse>${className}<#noparse>BackingBean.actionNew}" />
						<ice:commandButton
							style="margin-right: 10px"
							value="#{i18n['button.print']}"
							rendered="#{! empty search</#noparse>${className}ModelBean.${entityName}List}"<#noparse> 
							actionListener="#{search</#noparse>${className}<#noparse>BackingBean.actionPrintResult}" />
						<ice:commandButton
							styleClass="button"
							value="#{i18n['button.reset']}"
							type="reset" />
						<ice:commandButton
							styleClass="button"
							value="#{i18n['button.search']}"
							action="#{search</#noparse>${className}<#noparse>BackingBean.actionSearch}" />
					</p>
					
				</fieldset>
			
				<p/>
				
				<ice:messages globalOnly="true" layout="table" />
				
		</ice:form>

	</ice:portlet>
</f:view>
</#noparse>