<?xml version="1.0" encoding="UTF-8"?><#noparse>
<?taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c"?>
<zk>
	<style src="/css/form.css" />
	
	<window border="normal" width="100%" 
		apply="org.zkoss.bind.BindComposer"
		viewModel="@id('vmEdit') @init('</#noparse>${packageName}.Edit${className}ViewModel')" ><#noparse>
		
		<vlayout width="100%" >
		
			<html><h3 class="header"><span>${labels.</#noparse>${entityName}<#noparse>.edit.header}</span></h3></html>

			<tabbox width="100%" mold="accordion">
				<tabs>
					<tab label="${labels.searchFields}" />
					<tab label="${labels.searchFieldsOptions}" />
					<tab label="${labels.resultFields}" />
					<tab label="${labels.resultOptions}" />
					<tab label="${labels.registryFields}" />
					<tab label="${labels.registryOptions}" />
				</tabs>
				
				<tabpanels>
					
					<tabpanel id="searchFieldTab" >
						<grid>
							<rows></#noparse>
<#assign count = 0 />
<#list fieldList as field>
	<#assign count = count + 1 />
	<#if count % 2 == 1>
								<row>
	</#if><#noparse>
									<label value="${labels.</#noparse>${entityName}.field.${field.fieldName}<#noparse>}" />
									<checkbox checked="@init(vmEdit.editModel.searchFieldMap.</#noparse>${field.fieldName}) @load(vmEdit.editModel.searchFieldMap.${field.fieldName}, after={'actionSelectAllSearchField', 'actionDeselectAllSearchField', 'actionReset'}) @save(vmEdit.editModel.searchFieldMap.${field.fieldName})" />
									
	<#if count % 2 == 0>
								</row>
	</#if>
</#list>
<#if count % 2 == 1>
								</row>
</#if><#noparse>
							</rows>
						</grid>
						
						<separator />
						
						<hlayout>
							<button id="selectAllSearchFieldButton" label="${labels.button.selectAll}" onClick="@command('actionSelectAllSearchField')" />
							<button id="deselectAllSearchFieldButton" label="${labels.button.deselectAll}" onClick="@command('actionDeselectAllSearchField')" />
						</hlayout>
					</tabpanel>
					
					<tabpanel>
						<label value="${labels.columnNumber}" width="40%" />
						<combobox value="@bind(vmEdit.editModel.nColsSearch)" readonly="true" >
							<comboitem label="1" />
							<comboitem label="2" />
							<comboitem label="3" />
						</combobox>
					</tabpanel>
					
					<tabpanel>
						<grid>
							<rows></#noparse>
<#assign count = 0 />
<#list fieldList as field>
	<#assign count = count + 1 />
	<#if count % 2 == 1>
								<row>
	</#if><#noparse>
								<label value="${labels.</#noparse>${entityName}.field.${field.fieldName}<#noparse>}" />
								<checkbox checked="@init(vmEdit.editModel.resultFieldMap.</#noparse>${field.fieldName}) @load(vmEdit.editModel.resultFieldMap.${field.fieldName}, after={'actionSelectAllResultField', 'actionDeselectAllResultField', 'actionReset'}) @save(vmEdit.editModel.resultFieldMap.${field.fieldName})" />
	<#if count % 2 == 0>
								</row>
	</#if>
</#list>
<#if count % 2 == 1>
								</row>
</#if><#noparse>
							
							</rows>
						</grid>
						
						<separator />
						
						<hlayout>
							<button label="${labels.button.selectAll}" onClick="@command('actionSelectAllResultField')" />
							<button label="${labels.button.deselectAll}" onClick="@command('actionDeselectAllResultField')" />
						</hlayout>
					</tabpanel>
					
					<tabpanel>
						<label value="${labels.rowsPerPage}" width="40%" />
						<combobox value="@bind(vmEdit.editModel.rowsPerPage)" readonly="true" >
							<comboitem label="5" />
							<comboitem label="10" />
							<comboitem label="15" />
							<comboitem label="20" />
							<comboitem label="30" />
						</combobox>
					</tabpanel>
					
					<tabpanel>
						<grid>
							<rows></#noparse>
<#assign count = 0 />
<#list fieldList as field>
	<#assign count = count + 1 />
	<#if count % 2 == 1>
								<row>
	</#if><#noparse>
								<label value="${labels.</#noparse>${entityName}.field.${field.fieldName}<#noparse>}" />
								<checkbox checked="@init(vmEdit.editModel.registryFieldMap.</#noparse>${field.fieldName}) @load(vmEdit.editModel.registryFieldMap.${field.fieldName}, after={'actionSelectAllRegistryField', 'actionDeselectAllRegistryField', 'actionReset'}) @save(vmEdit.editModel.registryFieldMap.${field.fieldName})" />
	<#if count % 2 == 0>
								</row>
	</#if>
</#list>
<#if count % 2 == 1>
								</row>
</#if><#noparse>							
							</rows>
						</grid>
						
						<separator />
						
						<hlayout>
							<button label="${labels.button.selectAll}" onClick="@command('actionSelectAllRegistryField')" />
							<button label="${labels.button.deselectAll}" onClick="@command('actionDeselectAllRegistryField')" />
						</hlayout>
					</tabpanel>
					
					<tabpanel>
						<label value="${labels.columnNumber}" width="40%" />
						<combobox value="@bind(vmEdit.editModel.nColsRegistry)" readonly="true" >
							<comboitem label="1" />
							<comboitem label="2" />
							<comboitem label="3" />
						</combobox>
					</tabpanel>
				</tabpanels>
			</tabbox>	
			
			<separator />
			
			<hlayout>
				<button label="${labels.button.reset}" onClick="@command('actionReset')" />
				<button label="${labels.button.save}" onClick="@command('actionSave')" />
			</hlayout>
		
			<div visible="@load(!empty vmEdit.errorMessage)" sclass="portlet-msg-error">
				<label value="@load(vmEdit.errorMessage)" />
			</div>
			
			<div visible="@load(!empty vmEdit.infoMessage)" sclass="portlet-msg-success">
				<label value="@load(vmEdit.infoMessage)" />
			</div>
					
		</vlayout>

	</window>
</zk>
</#noparse>