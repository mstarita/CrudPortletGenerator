package ${packageName};

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.josql.Query;
import org.josql.QueryResults;

<#list importList as import>
import ${import};
</#list>

import com.liferay.portal.kernel.dao.search.SearchContainer;
import com.liferay.portal.kernel.util.ListUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;

public class Search${className}ModelBean implements Serializable {

	private static final long serialVersionUID = 1L;

<#list fieldList as field>
	public static final String SEARCH_FIELD_${field.fieldName?upper_case} = "search${field.fieldName?cap_first}";
</#list>
	
	private ${className} search${className} = new ${className}();
	private List<${className}> ${entityName}List = new ArrayList<${className}>();
	
	public void setSearch${className}(final ${className} search${className}) {
		this.search${className} = search${className};
	}
	public ${className} getSearch${className}() {
		return search${className};
	}
	
	public void set${className}List(final List<${className}> ${entityName}List) {
		this.${entityName}List = ${entityName}List;
	}
	public List<${className}> get${className}List() {
		return ${entityName}List;
	}
	
	public List<${className}> get${className}List(HttpServletRequest request, int start, int end) {
		
		String orderByCol = ParamUtil.getString(request, SearchContainer.DEFAULT_ORDER_BY_COL_PARAM);
		String orderByType = ParamUtil.getString(request, SearchContainer.DEFAULT_ORDER_BY_TYPE_PARAM);
		boolean sortAscending = true;
		
		if (Validator.isNull(orderByCol)) {
			orderByCol = "id";
		}
		if (Validator.isNull(orderByType)) {
			orderByType = "asc";
		}
		
		System.out.println("get${className}List - orderByCol: " + orderByCol + ", orderByType: " + orderByType);

		if (!orderByType.equals("asc")) {
			sortAscending = false;		
		}
		
		sort(orderByCol, sortAscending);
		
		if (end > ${entityName}List.size()) {
			end = ${entityName}List.size();
		}
		
		return ListUtil.subList(${entityName}List, start, end);
		
	}

	private void sort(String orderByCol, boolean sortAscending) {
		System.out.println("sorting ${entityName}List by " + orderByCol);
		
		String sqlSort = 
	        "SELECT * from ${fqClassName} " +
	        "ORDER BY " + orderByCol + " " + 
	        (sortAscending ? "ASC" : "DESC");
		
		Query query = new Query();
		try {
	        query.parse(sqlSort);
	        QueryResults queryResults = query.execute(${entityName}List);
	        ${entityName}List = queryResults.getResults();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
