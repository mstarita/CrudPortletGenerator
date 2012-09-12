<#noparse><#assign pageNumber="$" + "{pageNumber}"/>
<#assign pageCount="$" + "{pageCount}"/>
<#setting locale="it_IT" />
<#assign sourceBeanName = session.getAttribute("sourceBean") />
<#assign sourceBean = session.getAttribute(sourceBeanName) />
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
						<b>Dettaglio </#noparse>${className}<#noparse></b>
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

	<#if sourceBean?? >
				
		<table columns="2" widths="20,80" halign="left" font="normal"
			border-width="0.5" border-style="box" 
			padding-bottom="5" padding-left="2" padding-right="2">
			
			<table-header>
				<cell halign="center" colspan="2">
					<b></#noparse>${className}<#noparse></b>
				</cell>
			</table-header>
	</#noparse><#list fieldList as field><#noparse>
			<cell>
				</#noparse>${field.fieldName}<#noparse>
			</cell>
			<cell>
				<#if sourceBean.</#noparse>${field.fieldName}<#noparse>??>
					${sourceBean.</#noparse>${field.fieldName}<#noparse>}			
				</#if>
			</cell>
			
	</#noparse></#list><#noparse>	
		</table>

	</#if>

</document>
</#noparse>