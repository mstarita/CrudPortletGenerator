<?xml version="1.0" encoding="utf-8"?>
<s:Application
	xmlns:fx="http://ns.adobe.com/mxml/2009"
	xmlns:s="library://ns.adobe.com/flex/spark"
	xmlns:mx="library://ns.adobe.com/flex/mx" 
	initialize="init()" creationComplete="initAfterComplete()" >
	
	<fx:Metadata>
		[ResourceBundle("Language")]
	</fx:Metadata>
	
	<fx:Style>
		 @namespace s "library://ns.adobe.com/flex/spark";
		 
		.h3 {
			color: #ffffff;
			fontSize: 20;
			paddingTop: 3;
			paddingBotton: 3;
		}
	
		@font-face {
			src: url("../../resources/Ubuntu-L.ttf");
			font-family: ubuntu;
			font-style: normal;
			font-weight: normal;
			embed-as-cff: true;
			advanced-anti-aliasing: true;
		}
		
		s|Label {
        	font-family: ubuntu;
    	}
	</fx:Style>
		
	<mx:VBox id="${entityName}Edit" width="100%" >
	
		<s:Label id="header" text="{resourceManager.getString('Language', '${entityName}.edit.header')}" width="100%" styleName="h3" />
		<mx:Spacer />
		
		<mx:Accordion resizeToContent="true" width="100%" >
			
			<mx:VBox label="{resourceManager.getString('Language', 'searchFields')}" width="100%" >
				<mx:Tile width="100%" 
					paddingTop="5" paddingBottom="5" paddingLeft="5" paddingRight="5" 
					verticalGap="5" horizontalGap="15" >

<#list fieldList as field>							
						<mx:CheckBox id="search${field.fieldName?cap_first}Check" 
							label="{resourceManager.getString('Language', '${entityName}.field.${field.fieldName}')}" 
							selected="@{editModel.searchFieldMap['${field.fieldName}']}" />
</#list>
							
				</mx:Tile>
				
				<mx:HBox paddingTop="5" paddingBottom="5" paddingLeft="5" paddingRight="5" >
					<mx:Button label="{resourceManager.getString('Language', 'button.selectAll')}" 		click="setAllFields('search', true)" />
					<mx:Button label="{resourceManager.getString('Language', 'button.deselectAll')}" 	click="setAllFields('search', false)" />
				</mx:HBox>

			</mx:VBox>
			
			<mx:HBox label="{resourceManager.getString('Language', 'searchFieldsOptions')}" 
				paddingTop="5" paddingBottom="5" paddingLeft="5" paddingRight="5"
				width="100%" >
				<mx:Label text="{resourceManager.getString('Language', 'columnNumber')}" />
				<mx:ComboBox id="nColsSearchCombo" selectedItem="{editModel.nColsSearch}" change="{editModel.nColsSearch = parseInt(event.currentTarget.selectedItem)}" >
					<mx:dataProvider>
						<mx:ArrayList>
							<fx:Number>1</fx:Number>
							<fx:Number>2</fx:Number>
							<fx:Number>3</fx:Number>
						</mx:ArrayList>
					</mx:dataProvider>
				</mx:ComboBox>
			</mx:HBox>
			
			<mx:VBox label="{resourceManager.getString('Language', 'resultFields')}" width="100%" >
				<mx:Tile width="100%"
					paddingTop="5" paddingBottom="5" paddingLeft="5" paddingRight="5" 
					verticalGap="5" horizontalGap="15" >

<#list fieldList as field>					
						<mx:CheckBox id="result${field.fieldName?cap_first}Check"
							label="{resourceManager.getString('Language', '${entityName}.field.${field.fieldName}')}" 
							selected="@{editModel.resultFieldMap['${field.fieldName}']}" />
</#list>
							
				</mx:Tile>
				
				<mx:HBox paddingTop="5" paddingBottom="5" paddingLeft="5" paddingRight="5" >
					<mx:Button label="{resourceManager.getString('Language', 'button.selectAll')}" 		click="setAllFields('result', true)" />
					<mx:Button label="{resourceManager.getString('Language', 'button.deselectAll')}" 	click="setAllFields('result', false)"/>
				</mx:HBox>

			</mx:VBox>
			
			<mx:HBox label="{resourceManager.getString('Language', 'resultOptions')}" 
				paddingTop="5" paddingBottom="5" paddingLeft="5" paddingRight="5"
				width="100%" >
				<mx:Label text="{resourceManager.getString('Language', 'rowsPerPage')}" />
				<mx:ComboBox id="rowsPerPageCombo" selectedItem="{editModel.rowsPerPage}" change="{editModel.rowsPerPage = parseInt(event.currentTarget.selectedItem)}" >
					<mx:dataProvider>
						<mx:ArrayList>
							<fx:Number>5</fx:Number>
							<fx:Number>10</fx:Number>
							<fx:Number>15</fx:Number>
							<fx:Number>20</fx:Number>
							<fx:Number>30</fx:Number>
						</mx:ArrayList>
					</mx:dataProvider>
				</mx:ComboBox>
			</mx:HBox>
			
			<mx:VBox label="{resourceManager.getString('Language', 'registryFields')}" 
				width="100%" >
				<mx:Tile width="100%"
					paddingTop="5" paddingBottom="5" paddingLeft="5" paddingRight="5" 
					verticalGap="5" horizontalGap="15" >

<#list fieldList as field>					
						<mx:CheckBox id="registry${field.fieldName?cap_first}Check"
							label="{resourceManager.getString('Language', '${entityName}.field.${field.fieldName}')}" 
							selected="@{editModel.registryFieldMap['${field.fieldName}']}" />
</#list>
							
				</mx:Tile>
				
				<mx:HBox paddingTop="5" paddingBottom="5" paddingLeft="5" paddingRight="5" >
					<mx:Button label="{resourceManager.getString('Language', 'button.selectAll')}" 		click="setAllFields('registry', true)" />
					<mx:Button label="{resourceManager.getString('Language', 'button.deselectAll')}" 	click="setAllFields('registry', false)" />
				</mx:HBox>

			</mx:VBox>
			
			<mx:HBox label="{resourceManager.getString('Language', 'registryOptions')}" 
				paddingTop="5" paddingBottom="5" paddingLeft="5" paddingRight="5"
				width="100%" >
				<mx:Label text="{resourceManager.getString('Language', 'columnNumber')}" />
				<mx:ComboBox id="nColsRegistryCombo" selectedItem="{editModel.nColsRegistry}" change="{editModel.nColsRegistry = parseInt(event.currentTarget.selectedItem)}" >
					<mx:dataProvider>
						<mx:ArrayList>
							<fx:Number>1</fx:Number>
							<fx:Number>2</fx:Number>
							<fx:Number>3</fx:Number>
						</mx:ArrayList>
					</mx:dataProvider>
				</mx:ComboBox>
			</mx:HBox>
			
		</mx:Accordion>
		
		<mx:HBox paddingTop="5" paddingBottom="5" paddingLeft="5" paddingRight="5" >
			<mx:Button label="{resourceManager.getString('Language', 'button.reset')}" 	click="{resetPrefsRPC.send()}" />
			<mx:Button label="{resourceManager.getString('Language', 'button.save')}" 	click="{savePrefsClick()}" />
		</mx:HBox>
		
	</mx:VBox>

	<fx:Declarations>
		<mx:HTTPService id="savePrefsRPC" fault="onFault(event);" resultFormat="text"
		    url="{saveActionURL}"
		    useProxy="false" showBusyCursor="true"
		    method="POST">
		    <mx:request xmlns="">
		        <searchFields>{searchFieldAsString}</searchFields>
		        <resultFields>{resultFieldAsString}</resultFields>
		        <registryFields>{registryFieldAsString}</registryFields>
		        <nColsSearch>{editModel.nColsSearch}</nColsSearch>
		        <nColsRegistry>{editModel.nColsRegistry}</nColsRegistry>
		        <rowsPerPage>{editModel.rowsPerPage}</rowsPerPage>
		    </mx:request>
		</mx:HTTPService>
    
	    <mx:HTTPService id="resetPrefsRPC" result="onResetPrefsResult(event);" fault="onFault(event);" 	    
	    	url="{resetActionURL}"
		    method="POST"
		    useProxy="false" showBusyCursor="true">
		    <mx:request xmlns="">
		    </mx:request>
		</mx:HTTPService>
	</fx:Declarations>
	
	<fx:Script>
        <![CDATA[
        	import ${packageName}.Edit${className}Model;
			
			import mx.core.FlexGlobals;
			import mx.controls.Alert;
        	import mx.rpc.events.FaultEvent;
			import mx.rpc.events.ResultEvent;
			
        	[Bindable]
        	private var editModel: Edit${className}Model;
        	
        	[Bindable]
        	private var searchFieldAsString: String;
        	[Bindable]
        	private var resultFieldAsString: String;
        	[Bindable]
        	private var registryFieldAsString: String;
        	
        	[Bindable]
        	private var saveActionURL: String;
        	[Bindable]
        	private var resetActionURL: String;
        	
        	private function initEditModel(): void {
        		var searchFields:String = FlexGlobals.topLevelApplication.parameters.searchFields;
        		var resultFields:String = FlexGlobals.topLevelApplication.parameters.resultFields;
        		var registryFields:String = FlexGlobals.topLevelApplication.parameters.registryFields;
        		var nColsSearch:int = parseInt(FlexGlobals.topLevelApplication.parameters.nColsSearch);
        		var nColsRegistry:int = parseInt(FlexGlobals.topLevelApplication.parameters.nColsRegistry);
        		var rowsPerPage:int = parseInt(FlexGlobals.topLevelApplication.parameters.rowsPerPage);
        		
        		editModel = new Edit${className}Model(searchFields, resultFields, registryFields, nColsSearch, nColsRegistry, rowsPerPage);
        		
        	}
        	
        	private function init(): void {
        		header.setStyle("backgroundColor", "#57a700");
        		
        		initEditModel();
        		
        		var locale: String =  FlexGlobals.topLevelApplication.parameters.locale;
        		resourceManager.localeChain = [ locale ];
        		
        		var reg: RegExp = /[|]/g;
        		saveActionURL = FlexGlobals.topLevelApplication.parameters.saveActionURL.replace(reg, "&");
        		resetActionURL = FlexGlobals.topLevelApplication.parameters.resetActionURL.replace(reg, "&");
        	}
        	
        	private function initAfterComplete() {
				resizeContainer();
    		}
    		
    		private function resizeContainer(): void {
    			ExternalInterface.call('resizeContainer', ${entityName}Edit.height);
    		}
    		
        	private function setAllFields(prefix: String, value: Boolean): void {
<#list fieldList as field>        	
        		this[prefix + "${field.fieldName?cap_first}Check"].selected = value;
</#list>
        	}
        	
        	private function setFields(prefix: String, fields: Array): void {
<#list fieldList as field>        	
        		this[prefix + "${field.fieldName?cap_first}Check"].selected = fields['${field.fieldName}'];
</#list>        		
        	}
        	
        	private function savePrefsClick(): void {
        		searchFieldAsString = editModel.searchFieldMapAsString();
        		resultFieldAsString = editModel.resultFieldMapAsString();
        		registryFieldAsString = editModel.registryFieldMapAsString();
        		 
        		savePrefsRPC.send();
        	}
        	
        	public function onFault(event : FaultEvent) : void {
				Alert.show(event.fault.message);
			}
			
			public function onResetPrefsResult(event : ResultEvent) : void {
				var searchFields:String = event.result.searchFields;
        		var resultFields:String = event.result.resultFields;
        		var registryFields:String = event.result.registryFields;
        		var nColsSearch:int = parseInt(event.result.nColsSearch);
        		var nColsRegistry:int = parseInt(event.result.nColsRegistry);
        		var rowsPerPage:int = parseInt(event.result.rowsPerPage);
        		
        		editModel = new Edit${className}Model(searchFields, resultFields, registryFields, nColsSearch, nColsRegistry, rowsPerPage);
			}
        ]]>
	</fx:Script>
	
</s:Application>
