${entityName}.entity-name=${entityName}
<#list fieldList as field>						
${entityName}.field.${field.fieldName}=${field.fieldName}
</#list>

${entityName}.search.header=${className}
${entityName}.edit.header=${className} config parameters
${entityName}.registry.edit.header=Edit ${className}
${entityName}.registry.new.header=New ${className}
${entityName}.registry.show.header=Show ${className}

grid.no.record.found=No record found

deletion-confirm.title=Confirm deletion
deletion-confirm.message=Are you sure to delete the selected record?

update.msg.success=Update done successfully
update.msg.fail=Error on update
new.msg.success=New record created successfully
new.msg.fail=Error on new record creation
search.msg.fail=Error on search
search-after-delete.msg.fail=Error on update the search result after delete
delete.msg.fail=Error on delete
edit.save.msg.success=Portlet preferences successfully saved
edit.save.msg.fail=Error on saving portlet preferences
edit.reset.msg.fail=Error on resetting portlet preferences

button.search=Search
button.reset=Reset
button.new=New...
button.print=Print
button.show=Show
button.edit=Edit
button.delete=Delete
button.save=Save
button.confirm=Confirm
button.cancel=Cancel
button.selectAll=Select all
button.deselectAll=Deselect all

searchFields=Search fields
searchFieldsOptions=Search fields options
columnNumber=Column number
resultFields=Result fields
resultOptions=Result options
rowsPerPage=Rows per page
sortField=Sort Field
registryFields=Registry fields
registryOptions=Registry options

