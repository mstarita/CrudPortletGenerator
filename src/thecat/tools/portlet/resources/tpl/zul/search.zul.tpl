<?xml version="1.0" encoding="UTF-8"?><#noparse>
<?taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c"?>
<zk>
		
	<vlayout width="100%" >
	
		<html><h3 class="header"><span>${labels.</#noparse>${entityName}<#noparse>.search.header}</span></h3></html>
		
		<div>
			<zscript>
				String divWidth = "" + (100 / vm.getEditModel().getnColsSearch()) + "%";
			</zscript></#noparse>
<#list fieldList as field><#noparse>			
			<div width="${divWidth}" style="float:left" visible="@load(vm.editModel.searchFieldMap.</#noparse>${field.fieldName}<#noparse>)" >
				<label value="${labels.</#noparse>${entityName}.field.${field.fieldName}<#noparse>}" style="display:block" />
				<textbox 
					value="@load(vm.searchModel.search</#noparse>${className}.${field.fieldName}<#noparse>, after='actionReset') @save(vm.searchModel.search</#noparse>${className}.${field.fieldName}, before='actionSearch')" />
			</div>
</#list><#noparse>			
		</div>
		
	</vlayout>
			
	<separator />

	<vlayout width="100%" >
		
		<grid mold="paging" 
			pageSize="@load(vm.editModel.rowsPerPage)" 
			model="@load(vm.searchModel.</#noparse>${entityName}<#noparse>List)"
			emptyMessage="${labels.grid.no.record.found}" 
			style="display:block" >
			<columns></#noparse>
<#list fieldList as field><#noparse>			
				<column label="${labels.</#noparse>${entityName}.field.${field.fieldName}<#noparse>}" visible="@load(vm.editModel.resultFieldMap.</#noparse>${field.fieldName})" sort="auto(${field.fieldName})" />
</#list><#noparse>				
				<column label="" width="90px" />
			</columns>
			<template name="model">
				<row></#noparse>
<#list fieldList as field><#noparse>		
					<label value="@load(each.</#noparse>${field.fieldName})" visible="@load(vm.editModel.resultFieldMap.${field.fieldName})" />
</#list><#noparse>
					<hlayout>
						<image src="/images/page.png" onClick="@command('actionShow', </#noparse>${entityName}<#noparse>=each)" />
						<image src="/images/pencil.png" onClick="@command('actionEdit', </#noparse>${entityName}<#noparse>=each)" />
						<image src="/images/delete.png" onClick="@command('actionConfirmDelete', </#noparse>${entityName}<#noparse>=each)" />
						<image src="/images/print.png" onClick="@command('actionPrintDetail', </#noparse>${entityName}<#noparse>=each)" /> 
					</hlayout>
				</row>
			</template>
		</grid>
		
		<separator />
		
		<hlayout>
			<button label="${labels.button.new}" onClick="@command('actionNew')" />
			<button label="${labels.button.print}" visible="@load(!empty vm.searchModel.</#noparse>${entityName}<#noparse>List)" onClick="@command('actionPrintResult')" />
			<button label="${labels.button.reset}" onClick="@command('actionReset')" />
			<button label="${labels.button.search}" onClick="@command('actionSearch')" />
		</hlayout>
		
		<div visible="@init(!empty vm.searchModel.errorMessage) @load(!empty vm.searchModel.errorMessage, after={'actionRegistryConfirm', 'actionConfirmDelete', 'actionSearch', 'actionPrintDetail', 'actionPrintResult', 'actionReset'})" 
			sclass="portlet-msg-error">
			<label value="@init(vm.searchModel.errorMessage) @load(vm.searchModel.errorMessage, after={'actionRegistryConfirm', 'actionConfirmDelete', 'actionSearch'})" />
		</div>
		
		<div visible="@init(!empty vm.searchModel.infoMessage) @load(!empty vm.searchModel.infoMessage, after={'actionRegistryConfirm', 'actionConfirmDelete', 'actionSearch', 'actionPrintDetail', 'actionPrintResult', 'actionReset'})" 
			sclass="portlet-msg-success">
			<label value="@init(vm.searchModel.infoMessage) @load(vm.searchModel.infoMessage, after={'actionRegistryConfirm', 'actionConfirmDelete', 'actionSearch'})" />
		</div>
		
		<window title="${c:l('deletion-confirm.title')}" mode="modal" border="normal" width="400px" 
			visible="@load(vm.searchModel.showConfirmDelete)" >
	        <vbox hflex="true">
	            <hlayout height="50px" sclass="z-valign-middle">
	                <image src="~./zul/img/msgbox/question-btn.png"/>
	                <separator />
	                <label value="${c:l('deletion-confirm.message')}"/>
	            </hlayout>
	            <hbox pack="center" hflex="true">
	                <button label="${labels.button.confirm}" onClick="@command('actionDeleteConfirm')"/>
	                <button label="${labels.button.cancel}" onClick="@command('actionDeleteCancel')"/>
	            </hbox>
	        </vbox>
	    </window>
	    
	</vlayout>
	
</zk>
</#noparse>