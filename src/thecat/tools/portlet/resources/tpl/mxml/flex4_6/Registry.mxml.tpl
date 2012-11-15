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
		text="{resourceManager.getString('Language', '${entityName}.registry.' + formOperation + '.header')}" 
		width="100%" styleName="h3" />
	
	<mx:Spacer />
	
	<mx:Tile id="fieldsTile" width="100%" height="{computeFieldsTileHeight()}"  
		paddingTop="5" paddingLeft="5" paddingBottom="5" paddingRight="5" 
		horizontalGap="5" verticalGap="5" verticalScrollPolicy="off" >

<#list fieldList as field>
	<#if keyField == field.fieldName>
		<mx:Label text="{resourceManager.getString('Language', '${entityName}.field.${field.fieldName}')}" 
			visible="{editModel.registryFieldMap['${field.fieldName}']}" includeInLayout="{editModel.registryFieldMap['${field.fieldName}']}" />
		<mx:TextInput id="${entityName}${field.fieldName?cap_first}" enabled="false" text="{get${className}${field.fieldName?cap_first}()}" 
			visible="{editModel.registryFieldMap['${field.fieldName}']}" includeInLayout="{editModel.registryFieldMap['${field.fieldName}']}" />
	<#else>
		<mx:Label text="{resourceManager.getString('Language', '${entityName}.field.${field.fieldName}')}" 
			visible="{editModel.registryFieldMap['${field.fieldName}']}" includeInLayout="{editModel.registryFieldMap['${field.fieldName}']}" />
		<mx:TextInput id="${entityName}${field.fieldName?cap_first}" enabled="{formOperation != FormOperation.SHOW}" text="@{${entityName}.${field.fieldName}}" 
			visible="{editModel.registryFieldMap['${field.fieldName}']}" includeInLayout="{editModel.registryFieldMap['${field.fieldName}']}" />
	</#if>
</#list>
	
	</mx:Tile>
	
	<mx:HBox paddingTop="5" paddingBottom="5" paddingLeft="5" paddingRight="5" >
		<mx:Button label="{resourceManager.getString('Language', 'button.print')}" click="doPrintRegistry()"
			visible="{formOperation == FormOperation.SHOW}" includeInLayout="{formOperation == FormOperation.SHOW}" />
		<mx:Button label="{resourceManager.getString('Language', 'button.confirm')}" click="doConfirm()" />
		<mx:Button label="{resourceManager.getString('Language', 'button.cancel')}" click="doCancel()" 
			visible="{formOperation != FormOperation.SHOW}" includeInLayout="{formOperation != FormOperation.SHOW}" />
	</mx:HBox>	
	
	<fx:Declarations>
		<mx:RemoteObject id="${entityName}Service" showBusyCursor="true" fault="onFault(event)" destination="${entityName}Service" >
			<mx:method name="newAction" 		result="onResultNewAction(event)" 			fault="on${className}ServiceFault(event, resourceManager.getString('Language', 'new.msg.fail'))" />
			<mx:method name="updateAction" 		result="onResultUpdateAction(event)" 		fault="on${className}ServiceFault(event, resourceManager.getString('Language', 'update.msg.fail'))" />
			<mx:method name="printDetailAction" result="onResultPrintAction(event)" />
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
        	
        	public var search: Search;
        	
        	[Bindable]
        	public var ${entityName}: ${className};
        	[Bindable]
        	public var formOperation: String = FormOperation.NEW;
        	
        	private function init():void {
        		header.setStyle("backgroundColor", "#57a700");
        	}
        	
        	private function initAfterComplete() {
    			fieldsTile.tileWidth = (this.width / (editModel.nColsRegistry * 2)) - 20;
    		}
    		
    		[Bindable]
    		private function computeFieldsTileHeight(): Number {
    			var fieldCount: uint = 0;
    			for (var field: String in editModel.registryFieldMap) {
    				if (editModel.registryFieldMap[field] == true) {
    					fieldCount++;
    				}
    			}
    			
    			var row: uint = fieldCount / editModel.nColsRegistry;
    			if (fieldCount % editModel.nColsRegistry != 0) {
    				row += 1;
    			}
    			
				return fieldsTile.height = 30 * row;
    		}
    		
        	[Bindable]
        	private function get${className}${keyField?cap_first}(): String {
        		if (isNaN(${entityName}.${keyField})) {
        			return null;
        		} else {
        			return ${entityName}.${keyField}.toString();
        		}
        	}
        	
        	private function showSearch(): void {
        		parent.dispatchEvent(new Event('currentState_search', true, false));
        	}
        	
        	private function doPrintRegistry(): void {
        		${entityName}Service.printDetailAction(${entityName});
        	}
        	
        	private function doConfirm(): void {
        		if (formOperation == FormOperation.NEW) {
        			${entityName}Service.newAction(${entityName});
        		} else if (formOperation == FormOperation.EDIT) {
        			${entityName}Service.updateAction(${entityName});
        		}
        		
        		showSearch();
        	}
        	
        	private function doCancel(): void {
        		showSearch();
        	}
        	
        	private function onFault(event : FaultEvent) : void {
				Alert.show(event.fault.message);
			}
			
			private function on${className}ServiceFault(event : FaultEvent, msg: String) : void {
				NotificatorManager.show(msg, NotificatorMode.FAILURE, 3000);
			}
			
			private function onResultNewAction(event : ResultEvent) : void {
				NotificatorManager.show(resourceManager.getString('Language', "new.msg.success"), NotificatorMode.SUCCESS, 3000);
			}
			
			private function onResultUpdateAction(event : ResultEvent) : void {
				NotificatorManager.show(resourceManager.getString('Language', "update.msg.success"), NotificatorMode.SUCCESS, 3000);
			}
			
			private function onResultPrintAction(event : ResultEvent) : void {
				var printUrl: URLRequest = new URLRequest(event.result as String);
				navigateToURL(printUrl, "_blank");
			}
			
        ]]>
	</fx:Script>	
</mx:VBox>
