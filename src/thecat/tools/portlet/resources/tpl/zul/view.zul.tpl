<?xml version="1.0" encoding="UTF-8"?><#noparse>
<zk>
	
	<style src="/css/form.css" />
	
	<zscript language="Java">
		String searchId = </#noparse>${packageName}.View${className}<#noparse>Util.INCLUDE_ID_SEARCH;
		String registryId = </#noparse>${packageName}.View${className}<#noparse>Util.INCLUDE_ID_REGISTRY;
	</zscript>
	
	<window id="viewWin" border="normal" width="100%" 
		apply="org.zkoss.bind.BindComposer"
		viewModel="@id('vm') @init('</#noparse>${packageName}.View${className}<#noparse>ViewModel')">
		
		<include id="${searchId}" src="/</#noparse>${entityName}<#noparse>/search.zul" visible="true" />
		<include id="${registryId}" src="/</#noparse>${entityName}<#noparse>/registry.zul" visible="false" />
		
	</window>
</zk>
</#noparse>