package ${viewUtilPackage};

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

public class BeanUtil {

	public static String[] ORDERED_FIELD_LIST = {
<#list fieldList as field>
	"${field.fieldName}"<#if field != fieldList[fieldList?size - 1]>, </#if>
</#list>
	};
	
	public static List<String> getFieldList(String className) {
		System.out.println("\t\tgetFieldList of Person class...");
		
		List<String> fieldList = new ArrayList<String>();
		
		try {
			Method[] methods = Class.forName(className).getDeclaredMethods();
		
			
			for (Method method : methods) {
				if (method.getName().startsWith("get")) {
					fieldList.add(
							StringUtils.uncapitalize(
									method.getName().substring(3)));
				}
			}			
			return fieldList;
		} catch (ClassNotFoundException ex) {
			ex.printStackTrace();
			return fieldList;
		}
	}
	
}
