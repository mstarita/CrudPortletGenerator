<?xml version="1.0" encoding="utf-8"?>
<s:Application
	xmlns:fx="http://ns.adobe.com/mxml/2009"
	xmlns:s="library://ns.adobe.com/flex/spark"
	xmlns:mx="library://ns.adobe.com/flex/mx" 
	xmlns:local="*" 
	initialize="init(event)" >
	
	<s:states>
		<s:State name="default"/>
		<s:State name="registry" />
	</s:states>
	
	<local:Search id="search" 
		visible="true" includeInLayout="true" 
		visible.registry="false" includeInLayout.registry="false" 
		showEffect="Fade" hideEffect="Fade" />
	
	<local:Registry id="registry"
		visible="false" includeInLayout="true" 
		visible.registry="true" includeInLayout.registry="true" 
		showEffect="Fade" hideEffect="Fade" />
	
	<fx:Script>
        <![CDATA[
        	import ${packageName}.Edit${className}Model;
    
    		import mx.core.FlexGlobals;
    		import mx.controls.Alert;
    		
        	private var editModel: Edit${className}Model;
        	
			private function initEditModel(): void {
        		var searchFields:String = FlexGlobals.topLevelApplication.parameters.searchFields;
        		var resultFields:String = FlexGlobals.topLevelApplication.parameters.resultFields;
        		var registryFields:String = FlexGlobals.topLevelApplication.parameters.registryFields;
        		var nColsSearch:int = parseInt(FlexGlobals.topLevelApplication.parameters.nColsSearch);
        		var nColsRegistry:int = parseInt(FlexGlobals.topLevelApplication.parameters.nColsRegistry);
        		var rowsPerPage:int = parseInt(FlexGlobals.topLevelApplication.parameters.rowsPerPage);
        		
        		editModel = new Edit${className}Model(searchFields, resultFields, registryFields, nColsSearch, nColsRegistry, rowsPerPage);
        		
        	}
        	
        	private function init(e: Event):void {
        		initEditModel();
        		
        		search.editModel = editModel;
        		search.registry = registry;
        		
        		registry.editModel = editModel;
        		registry.search = search;
        		
        		var locale: String = FlexGlobals.topLevelApplication.parameters.locale;
        		resourceManager.localeChain = [ locale ];
        		
        		this.addEventListener('currentState_registry', onChangeCurrentState);
        		this.addEventListener('currentState_search', onChangeCurrentState);
        	}
        	
        	private function onChangeCurrentState(e: Event): void {
        		if (e.type == 'currentState_registry') {
        			currentState = 'registry';
        			ExternalInterface.call('resizeContainer', registry.height);
        		} else if (e.type == 'currentState_search') {
        			currentState = '';
        			ExternalInterface.call('resizeContainer', search.height);
        		}
        	}
		]]>
	</fx:Script>
	
</s:Application>
