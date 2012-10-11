<?xml version="1.0" encoding="UTF-8"?><#noparse>
<?taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c"?>
<zk>
	<style src="/css/form.css" />
		
	<vlayout width="100%" >

		<html visible="@init(vm.registryModel.formOperation eq 'NEW') @load(vm.registryModel.formOperation eq 'NEW', after={'actionShow', 'actionEdit', 'actionNew'})" >
			<h3 class="header"><span>${labels.</#noparse>${entityName}<#noparse>.registry.new.header }</span></h3>
		</html>
		<html visible="@init(vm.registryModel.formOperation eq 'EDIT') @load(vm.registryModel.formOperation eq 'EDIT', after={'actionShow', 'actionEdit', 'actionNew'})" >
			<h3 class="header"><span>${labels.</#noparse>${entityName}<#noparse>.registry.edit.header }</span></h3>
		</html>
		<html visible="@init(vm.registryModel.formOperation eq 'SHOW') @load(vm.registryModel.formOperation eq 'SHOW', after={'actionShow', 'actionEdit', 'actionNew'})" >
			<h3 class="header"><span>${labels.</#noparse>${entityName}<#noparse>.registry.show.header }</span></h3>
		</html>
		
		<div>
			<zscript>
				String divWidth = "" + (100 / vm.getEditModel().getnColsRegistry()) + "%";
			</zscript></#noparse>
<#list fieldList as field><#noparse>	
			<div width="${divWidth}" style="float:left" visible="@load(vm.editModel.registryFieldMap.</#noparse>${field.fieldName}<#noparse>)" >	
				<label value="${labels.</#noparse>${entityName}.field.${field.fieldName}}" style="display:block" />
				<textbox
	<#if field.fieldName == keyField>
					value="@load(vm.registryModel.${entityName}.${field.fieldName}, after={'actionNew', 'actionEdit', 'actionShow'})"
	<#else>
					value="@load(vm.registryModel.${entityName}.${field.fieldName}, after={'actionNew', 'actionEdit', 'actionShow'}) @save(vm.registryModel.${entityName}.${field.fieldName}, before='actionRegistryConfirm')"
	</#if>
	<#if field.fieldName == keyField>					 
					readonly="true" />
	<#else>
					readonly="@init(vm.registryModel.formOperation eq 'SHOW') @load(vm.registryModel.formOperation eq 'SHOW', after={'actionShow', 'actionEdit', 'actionNew'})" />
	</#if>
			</div>
</#list><#noparse>
		</div>
		
	</vlayout>
	
	<separator />
	
	<vlayout width="100%">
		
		<hlayout>
			<button label="${labels.button.print}" onClick="@command('actionRegistryPrint')" visible="@init(vm.registryModel.formOperation eq 'SHOW') @load(vm.registryModel.formOperation eq 'SHOW', after={'actionShow', 'actionEdit', 'actionNew'})" />
			<button label="${labels.button.confirm}" onClick="@command('actionRegistryConfirm')" />
			<button label="${labels.button.cancel}" onClick="@command('actionRegistryCancel')" visible="@init(vm.registryModel.formOperation ne 'SHOW') @load(vm.registryModel.formOperation ne 'SHOW', after={'actionShow', 'actionEdit', 'actionNew'})" />
		</hlayout>
		
	</vlayout>
		
</zk>
</#noparse>