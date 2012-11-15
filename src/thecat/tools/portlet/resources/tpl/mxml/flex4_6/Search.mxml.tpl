<?xml version="1.0" encoding="utf-8"?>
<mx:VBox 
	xmlns:fx="http://ns.adobe.com/mxml/2009"
	xmlns:s="library://ns.adobe.com/flex/spark"
	xmlns:mx="library://ns.adobe.com/flex/mx" 
	width="100%" showEffect="Fade" hideEffect="Fade" 
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
		
	<s:Label id="header" 
		text="{resourceManager.getString('Language', '${entityName}.search.header')}" 
		width="100%" styleName="h3" />
	
	<mx:Spacer />
	
	<mx:Tile id="fieldsTile" width="100%" height="{computeFieldsTileHeight()}" 
		paddingTop="5" paddingLeft="5" paddingBottom="5" paddingRight="5" 
		horizontalGap="5" verticalGap="5" verticalScrollPolicy="off" >

<#list fieldList as field>
	<#if keyField == field.fieldName>		
		<mx:Label text="{resourceManager.getString('Language', '${entityName}.field.${field.fieldName}')}" 
			visible="{editModel.searchFieldMap['${field.fieldName}']}" includeInLayout="{editModel.searchFieldMap['${field.fieldName}']}" />
		<mx:TextInput id="${entityName}${field.fieldName?cap_first}" 
		<#if (field.fieldType == "Long") || (field.fieldType == "Integer") || (field.fieldType == "Short") || (field.fieldType == "Number") >restrict="0-9"</#if> 
			visible="{editModel.searchFieldMap['${field.fieldName}']}" includeInLayout="{editModel.searchFieldMap['${field.fieldName}']}" />
	<#else>		
		<mx:Label text="{resourceManager.getString('Language', '${entityName}.field.${field.fieldName}')}" 
			visible="{editModel.searchFieldMap['${field.fieldName}']}" includeInLayout="{editModel.searchFieldMap['${field.fieldName}']}" />
		<mx:TextInput id="${entityName}${field.fieldName?cap_first}" text="@{${entityName}Search.${field.fieldName}}" 
			visible="{editModel.searchFieldMap['${field.fieldName}']}" includeInLayout="{editModel.searchFieldMap['${field.fieldName}']}" />
	</#if>
</#list>
		
	</mx:Tile>
	
	<mx:DataGrid 
		id="${entityName}DataGrid"
		width="100%" 
		height="{(editModel.rowsPerPage + 1) * 25}" 
		dataProvider="{${entityName}List}" >
		<mx:columns>
<#list fieldList as field>		
			<mx:DataGridColumn dataField="${field.fieldName}" headerText="{resourceManager.getString('Language', '${entityName}.field.${field.fieldName}')}" 	
				visible="{editModel.resultFieldMap['${field.fieldName}']}" sortable="true" resizable="true" />
</#list>				
			<mx:DataGridColumn headerText="" width="70" sortable="false" resizable="false" >
				<mx:itemRenderer>
					<fx:Component>
						<mx:HBox horizontalScrollPolicy="off" verticalScrollPolicy="off" horizontalGap="1" paddingTop="1" paddingLeft="1" >
							<fx:Script>
								<![CDATA[
								import ${packageName}.Edit${className}Model;
    							import ${fqClassName};
    							import ${viewUtilPackage}.FormOperation;
    	
								import mx.controls.Alert;
								import mx.events.CloseEvent;
		
								private function doShow(event: Event): void {
					        		outerDocument.registry.${entityName} = outerDocument.${entityName}List.getItemAt(outerDocument.${entityName}DataGrid.selectedIndex) as ${className};
					        		outerDocument.showRegistry(FormOperation.SHOW);
					        	}
					        	
					        	private function doEdit(event: Event): void {
					        		outerDocument.registry.${entityName} = (outerDocument.${entityName}List.getItemAt(outerDocument.${entityName}DataGrid.selectedIndex) as ${className}).copy();
					        		outerDocument.showRegistry(FormOperation.EDIT);
					        	}
					        	
					        	private function doDelete(event: Event): void {
					        		var alert: Alert = Alert.show(resourceManager.getString('Language', 'deletion-confirm.message'), 
					        			resourceManager.getString('Language', 'deletion-confirm.title'),
					        			Alert.YES + Alert.NO, null, doDeleteConfirmClose);
					        	}
					        	
					        	private function doDeleteConfirmClose(event: CloseEvent): void {
					        		if (event.detail == Alert.YES) {
					        			outerDocument.${entityName}Service.deleteAction(
					        				outerDocument.${entityName}List.getItemAt(
					        					outerDocument.${entityName}DataGrid.selectedIndex));
					        		}
					        	}
					        	
					        	private function doPrintDetail(event: Event): void {
					        		outerDocument.${entityName}Service.printDetailAction(
					        			outerDocument.${entityName}List.getItemAt(
					        				outerDocument.${entityName}DataGrid.selectedIndex));
					        	}
					        	]]>
							</fx:Script>
							<mx:Image source="../images/page.png" 	click="doShow(event)" />
							<mx:Image source="../images/pencil.png" click="doEdit(event)" />
							<mx:Image source="../images/delete.png" click="doDelete(event)" />
							<mx:Image source="../images/print.png" 	click="doPrintDetail(event)" />
						</mx:HBox>
					</fx:Component>
				</mx:itemRenderer>
			</mx:DataGridColumn>
		</mx:columns>
	</mx:DataGrid>
	
	<mx:Spacer />
	
	<mx:HBox paddingTop="5" paddingBottom="5" paddingLeft="5" paddingRight="5" resizeEffect="Resize" >
		<mx:Button label="{resourceManager.getString('Language', 'button.new')}" 	click="doNew()" />
		<mx:Button label="{resourceManager.getString('Language', 'button.print')}" click="doPrintResult()" 
			visible="{(${entityName}List != null &amp;&amp; ${entityName}List.length &gt; 0)}" 
			includeInLayout="{(${entityName}List != null &amp;&amp; ${entityName}List.length &gt; 0)}" 
			showEffect="WipeRight" hideEffect="WipeLeft" />
		<mx:Button label="{resourceManager.getString('Language', 'button.reset')}" 	click="doReset()" />
		<mx:Button label="{resourceManager.getString('Language', 'button.search')}" click="doSearch()" />
	</mx:HBox>
	
	<fx:Declarations>
		<mx:RemoteObject id="${entityName}Service" showBusyCursor="true" fault="onFault(event)" destination="${entityName}Service" >
			<mx:method name="searchAction" 		result="onResultSearchAction(event)" 		fault="on${className}ServiceFault(event, resourceManager.getString('Language', 'search.msg.fail'))" />
			<mx:method name="deleteAction" 		result="onResultDeleteAction(event)" 		fault="on${className}ServiceFault(event, resourceManager.getString('Language', 'delete.msg.fail'))" />
			<mx:method name="printDetailAction" result="onResultPrintAction(event)" />
			<mx:method name="printListAction" 	result="onResultPrintAction(event)" />
		</mx:RemoteObject>
	</fx:Declarations>
	
	<fx:Script>
        <![CDATA[
        	import ${packageName}.Edit${className}Model;
        	import ${fqClassName};
        	import ${viewUtilPackage}.FormOperation;
        	
        	import br.com.rectius.library.notificator.NotificatorManager;
			import br.com.rectius.library.notificator.NotificatorMode;
			
			import flash.net.navigateToURL;
			
        	import mx.collections.ArrayCollection;
        	
        	import mx.core.FlexGlobals;
        	import mx.controls.Alert;
        	import mx.rpc.events.FaultEvent;
			import mx.rpc.events.ResultEvent;
			
        	[Bindable]
        	public var editModel: Edit${className}Model;
    
    		public var registry: Registry;
    		    	
        	[Bindable]
        	private var ${entityName}Search: ${className} = new ${className}();
        	[Bindable]
        	public var ${entityName}List: ArrayCollection;
        	
        	private function init():void {
        		header.setStyle("backgroundColor", "#57a700");
        	}
    
    		private function initAfterComplete() {
    			fieldsTile.tileWidth = (this.width / (editModel.nColsSearch * 2)) - 20;
				
				ExternalInterface.call('resizeContainer', parentApplication.search.height);
    		}
    		
    		[Bindable]
    		private function computeFieldsTileHeight(): Number {
    			var fieldCount: uint = 0;
    			for (var field: String in editModel.searchFieldMap) {
    				if (editModel.searchFieldMap[field] == true) {
    					fieldCount++;
    				}
    			}
    			
    			var row: uint = fieldCount / editModel.nColsSearch;
    			if (fieldCount % editModel.nColsSearch != 0) {
    				row += 1;
    			}
    			
				return fieldsTile.height = 30 * row;
    		}
    		
        	private function doReset(): void {
<#list fieldList as field>
	<#if keyField == field.fieldName>
        		${entityName}${field.fieldName?cap_first}.text = null;
        		${entityName}Search.${field.fieldName} = null;
	<#else>
				${entityName}Search.${field.fieldName} = null;
	</#if>
</#list>
        	}
        	
        	public function showRegistry(formOp:String): void {
        		registry.formOperation = formOp;
        		
        		if (formOp == FormOperation.NEW) { 
        			registry.${entityName} = new ${className}();
        		}
        		
        		parent.dispatchEvent(new Event('currentState_registry', true, false));
        	}
        	
        	private function doSearch(): void {
        		${entityName}Search.${keyField} = parseInt(${entityName}${keyField?cap_first}.text);
        		
        		${entityName}List = ${entityName}Service.searchAction(${entityName}Search);
        	}
        	
        	private function doPrintResult(): void {
        		${entityName}Service.printListAction(${entityName}List);
        	}
        	
        	private function doNew(): void {
        		showRegistry(FormOperation.NEW);
        	}
        	
        	private function onFault(event : FaultEvent) : void {
				Alert.show(event.fault.message);
			}
			
			private function on${className}ServiceFault(event : FaultEvent, msg: String) : void {
				NotificatorManager.show(msg, NotificatorMode.FAILURE, 3000);
			}
			
			private function onResultSearchAction(event : ResultEvent) : void {
				${entityName}List = event.result as ArrayCollection;
			}
			
			private function onResultDeleteAction(event : ResultEvent) : void {
				${entityName}List.removeItemAt(${entityName}DataGrid.selectedIndex);
			}
			
			private function onResultPrintAction(event : ResultEvent) : void {
				var printUrl: URLRequest = new URLRequest(event.result as String);
				navigateToURL(printUrl, "_blank");
			}
			
        ]]>
	</fx:Script>
	
</mx:VBox>
