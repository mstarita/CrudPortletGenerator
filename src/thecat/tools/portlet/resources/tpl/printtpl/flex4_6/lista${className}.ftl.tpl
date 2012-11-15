<#noparse><#assign pageNumber="$" + "{pageNumber}"/>
<#assign pageCount="$" + "{pageCount}"/>
<#setting locale="it_IT" />
<#assign sourceListName = session.getAttribute("sourceList") />
<#assign sourceList = session.getAttribute(sourceListName) />
</#noparse><#assign widthList = "" />
<#list 1..fieldList?size as count >
	<#assign widthList = widthList + (100 / fieldList?size) />
	<#if count != fieldList?size>
		<#assign widthList = widthList + "," />
	</#if>
</#list><#noparse>
<document size="A4" margin-left="25" margin-right="25" margin-top="50"
	margin-bottom="25">
	<font-def name="small" family="Helvetica" style="normal" size="9" />
	<font-def name="title" family="Helvetica" size="10" style="bold" />
	<font-def name="section" family="Helvetica" size="8" style="bold" />
	<font-def name="oggetto" family="Helvetica" size="10" style="bold" />
	<font-def name="normal" family="Helvetica" size="8" style="normal" />
	<font-def name="code" family="Courier" size="8" style="normal" />
	<header font="small">
		<header-part halign="center" width="540">
			<table border-style="none" columns="2" widths="20,80" padding-bottom="5">
				<cell halign="left" valign="middle">
					<image source="logo.png" scale-to-fit="true" width="30" height="30"/>
				</cell>
				<cell valign="middle">
					<paragraph font="title" halign="center">
						TITOLO TITOLO TITOLO
					</paragraph>
					<paragraph font="title" halign="center">
						<b>Lista </#noparse>${className}<#noparse></b>
					</paragraph>
				</cell>
			</table>
		</header-part>
	</header>
	<footer font="small">
		<footer-part padding-top="10" halign="center">
			Pag. ${pageNumber} di ${pageCount}
		</footer-part>
		<footer-part padding-top="10" halign="right">
			${today?string("dd/MM/yyyy")}
		</footer-part>
	</footer>
	
	</#noparse><table columns="${fieldList?size}" widths="${widthList}" halign="left" font="normal"<#noparse>
		border-width="0.5" border-style="box" 
		padding-bottom="5" padding-left="2" padding-right="2">
		
		<table-header></#noparse>
	<#list fieldList as field>
		<#if keyField == field.fieldName>
			<cell halign="center">
				<b>${field.fieldName}</b>
			</cell>
		<#else>
			<cell>
				<b>${field.fieldName}</b>
			</cell>
		</#if>
	</#list>
		</table-header><#noparse>
		
		<#if sourceList?? >
			<#list sourceList as </#noparse>${entityName}>
	<#list fieldList as field>
		<#if keyField == field.fieldName>
				<cell halign="center">
					<#noparse>${</#noparse>${entityName}.${field.fieldName}}
				</cell>
		<#else>
				<cell>
					<#noparse><#if </#noparse>${entityName}.${field.fieldName}??><#noparse>
						${</#noparse>${entityName}.${field.fieldName}}<#noparse>
					</#if>
				</cell></#noparse>
		</#if>
	</#list>
			<#noparse></#list>
		</#if>
	</table>
</document>
</#noparse>