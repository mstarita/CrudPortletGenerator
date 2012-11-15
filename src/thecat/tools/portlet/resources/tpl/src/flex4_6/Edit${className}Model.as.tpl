package ${packageName} {
		
	[Bindable]
    [RemoteClass(alias="${packageName}.Edit${className}ModelBean")]
	public class Edit${className}Model {

		public static const ORDERED_FIELD_LIST : Array = 
			new Array(
<#list fieldList as field>
				"${field.fieldName}"<#if field != fieldList[fieldList?size - 1]>, </#if>
</#list>
		);
			
		private var _fieldList : Array; 
		private var _searchFieldMap : Array;
		private var _resultFieldMap : Array;
		private var _registryFieldMap : Array;
		private var _nColsSearch : int;
		private var _nColsRegistry : int;
		private var _rowsPerPage : int;
		
		public function Edit${className}Model(
			searchFieldMap: String, resultFieldMap: String, registryFieldMap: String,
			nColsSearch: int, nColsRegistry: int, rowsPerPage: int) {
			
			_searchFieldMap = new Array();
			_resultFieldMap = new Array();
			_registryFieldMap = new Array();
			
			for (var field:String in ORDERED_FIELD_LIST) {
				_searchFieldMap[ORDERED_FIELD_LIST[field]] = false;
				_resultFieldMap[ORDERED_FIELD_LIST[field]] = false;
				_registryFieldMap[ORDERED_FIELD_LIST[field]] = false;
			}
			
			var fields:Array = searchFieldMap.split(",");
			for (field in fields) {
				_searchFieldMap[fields[field]] = true;
			}
					
			fields = resultFieldMap.split(",");
			for (field in fields) {
				_resultFieldMap[fields[field]] = true;
			}
			
			fields = registryFieldMap.split(",");
			for (field in fields) {
				_registryFieldMap[fields[field]] = true;
			}
			
			_nColsSearch = nColsSearch;
			_nColsRegistry = nColsRegistry;
			_rowsPerPage = rowsPerPage;
			
		}
		
        public function get fieldList():Array {
            return _fieldList;
        }

        public function get searchFieldMap():Array {
            return _searchFieldMap;
        }

        public function get resultFieldMap():Array {
            return _resultFieldMap;
        }
        
        public function get registryFieldMap():Array {
            return _registryFieldMap;
        }
        
        public function set nColsSearch(value:int):void {
            _nColsSearch = value;
        }
        public function get nColsSearch():int {
            return _nColsSearch;
        }
        
        public function set nColsRegistry(value:int):void {
            _nColsRegistry = value;
        }
        public function get nColsRegistry():int {
            return _nColsRegistry;
        }
        
        public function set rowsPerPage(value:int):void {
            _rowsPerPage = value;
        }
        public function get rowsPerPage():int {
            return _rowsPerPage;
        }
        
        private function fieldMapAsString(fieldMap:Array):String {
        	var result:String = new String();
        	
        	for (var key:String in fieldMap) {
        		if (fieldMap[key] == true) {
        			result += key + ",";
        		}
        	}
        	
        	return result.substring(0, result.length - 1);
        }
        
        public function searchFieldMapAsString():String {
        	return fieldMapAsString(searchFieldMap);
        }
        
        public function resultFieldMapAsString():String {
        	return fieldMapAsString(resultFieldMap);
        }
        
        public function registryFieldMapAsString():String {
        	return fieldMapAsString(registryFieldMap);
        }
	}
}
