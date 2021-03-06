package thecat.tools.portlet;

import java.util.zip.ZipFile;

import org.codehaus.groovy.gfreemarker.FreeMarkerTemplateEngine
import org.apache.commons.lang.ClassUtils
import org.apache.commons.lang.StringUtils
import org.apache.commons.io.FileUtils
import org.apache.commons.io.FilenameUtils

def keyValueArgs = args.collect { def token = it.split('='); [key: token[0], value: token.length > 1 ? token[1] : null] }

def orderedFieldList = []
def defaultParams = ['-osiv-crud', '-icefaces-ext-req', '-verbose']
def mandatoryParams = ['-fq-class-name', '-key-field-name', '-output-package']

keyValueArgs.findAll { it.key in defaultParams }.each { it.value = true }

//check input parameters
if (	(keyValueArgs.size() < mandatoryParams.size()) ||
		(keyValueArgs.findAll { it.key in mandatoryParams }.size() != mandatoryParams.size()) || 
		(keyValueArgs.findAll { it.value == null }.size() > 0)) {
	showUsage()
	return
}

def outputPackage   = keyValueArgs.find { it.key == '-output-package'}.value
def fqClassName     = keyValueArgs.find { it.key == '-fq-class-name'}.value
def keyField        = keyValueArgs.find { it.key == '-key-field-name'}.value
def osivCrud        = keyValueArgs.find { it.key == '-osiv-crud'}?.value
def icefacesExtReq  = keyValueArgs.find { it.key == '-icefaces-ext-req'}?.value
def viewUtilPackage = keyValueArgs.find { it.key == '-viewutil-package'}?.value ?: 'thecat.common.view.util'
def daoPackage 	    = keyValueArgs.find { it.key == '-dao-package'}?.value ?: FilenameUtils.removeExtension(FilenameUtils.removeExtension(fqClassName)) + ".dao"
def searchFields    = keyValueArgs.find { it.key == '-search-fields'}?.value?.split(',')
def gridFields      = keyValueArgs.find { it.key == '-grid-fields'}?.value?.split(',')
def fieldsOrder     = keyValueArgs.find { it.key == '-fields-order'}?.value?.split(',')
def verboseOutput   = keyValueArgs.find { it.key == '-verbose'}?.value
def tplConfigDir    = keyValueArgs.find { it.key == '-tpl-config'}?.value ?: 'icefaces1_8'
def liferayVer      = keyValueArgs.find { it.key == '-liferay-version'}?.value ?: '6_1'

def classForCrud = null
try {
	classForCrud = Class.forName(fqClassName)
} catch (ClassNotFoundException ex) {
	println "Cannot find the required class in the current classpath!!!"
	println "ClassPath: ${System.getProperties().getProperty('java.class.path', null)}"
	return
}

def binding = ['packageName': outputPackage, 'className': classForCrud.simpleName , 
               'entityName': StringUtils.uncapitalize(classForCrud.simpleName),
               'viewUtilPackage': viewUtilPackage, 
               'daoPackage': daoPackage, 
               'fqClassName': fqClassName, 'osivCrud': osivCrud ?: false, 'icefacesExtReq': icefacesExtReq ?: false,
               'fieldList': [], 'importList': [], 'keyField': keyField, 'keyFieldType': '', 'searchFields': [], 'gridFields': []]

// Collect the fields name and type
def declaredGetMethods = classForCrud.getDeclaredMethods().findAll { 
	it.name.startsWith("get")
}.each { 
	def returnType = getType(it)
	def typeAsString = ClassUtils.getShortCanonicalName(returnType.type)
	if (returnType.generic != null) {
		typeAsString += "<" +
		returnType.generic.collect {
			ClassUtils.getShortCanonicalName(it.type)
		}.join(', ') + ">"
	}

	binding.fieldList.add([fieldName: "${StringUtils.uncapitalize(it.name.substring(3))}", fieldType: "${typeAsString}"])
	
	binding.fieldList.each {
		if (it.fieldName == keyField) {
			binding.keyFieldType = it.fieldType
		}
	}
	

}

// setup the order of fieldList... if necessary
if (fieldsOrder != null) {
    fieldsOrder.each { field ->
		orderedFieldList.add(binding.fieldList.find { it.fieldName == field })
	}
	binding.fieldList.each { field ->
		if (! orderedFieldList.find { it.fieldName == field.fieldName}) {
			orderedFieldList.add(field)
		}
	}
	binding.fieldList = orderedFieldList
}

//println "ordered field list: ${orderedFieldList}"

// setup search fields
if (searchFields != null) {
	binding.searchFields = searchFields
} else {
	binding.fieldList.each {
		binding.searchFields.add(it.fieldName)
	}
}

// setup grid fields
if (gridFields != null) {
	binding.gridFields = gridFields
} else {
	binding.fieldList.each {
		binding.gridFields.add(it.fieldName)
	}
}

// setup liferay support lib dir
def jsfVer = null
def liferayDefaultVer = null
def liferaySupportLibDir = null
def liferayDefaultSupportLibDir = null
if (tplConfigDir == 'icefaces1_8') { // jsf 1.2
	jsfVer = '1_2'
	liferayDefaultVer = '6_1' 
} else if (['icefaces3_1', 'mojarra2', 'primefaces3_3', 'moj2tomahawk2', 'moj2alloy', 'richfaces4'].find { it == tplConfigDir }) { // jsf 2.1
	jsfVer = '2_1'
	liferayDefaultVer = '6_1'
}

if (jsfVer != null) {
	liferaySupportLibDir = "liferay_support/jsf${jsfVer}/liferay${liferayVer}"
	liferayDefaultSupportLibDir = "liferay_support/jsf${jsfVer}/liferay${liferayDefaultVer}"
}

// outputFiles
// outputDir
def files4config =
		['icefaces1_8,icefaces3_1,mojarra2,primefaces3_3,moj2tomahawk2,moj2alloy,richfaces4' :
			['webcfg': [inputDir: 'tpl/webcfg', outputDir: 'web/WEB-INF', postfix: '.tpl',
                        files: ['web.xml', 'faces-config.xml', 'portlet.xml', 'liferay-portlet.xml', 
                              'liferay-plugin-package.properties', 'liferay-hook.xml', 'liferay-display.xml']],
             'i18n':   [inputDir: 'tpl/i18n', outputDir: 'src/resources', postfix: '.tpl',
                        files: ['Language_it_IT.properties', 'Language_en_US.properties']], 
             'src':    [inputDir: 'tpl/src', outputDir: "src/${binding.packageName.replaceAll('[.]', '/')}", postfix: '.tpl',
                        files: ['Edit${className}BackingBean.java', 'Edit${className}ModelBean.java',
                              'Registry${className}BackingBean.java', 'Registry${className}ModelBean.java',
							  'Search${className}BackingBean.java', 'Search${className}ModelBean.java']],
			 'viewutil':[inputDir: 'tpl/viewutil', outputDir: "src/${binding.viewUtilPackage.replaceAll('[.]', '/')}", postfix: '.tpl',
				  		files: ['FacesUtil.java', 'PortletUtil.java', 'FormOperation.java', 'BeanUtil.java']],
             'jsp':    [inputDir: 'tpl/jsp', outputDir: "web/${binding.entityName}", postfix: '.tpl',
                        files: ['edit.*', 'registry.*', 'search.*', 'searchFieldSet.*']],
             'printtpl':[inputDir: 'tpl/printtpl', outputDir: "web/docTemplate", postfix: '.tpl',
                        files: ['lista${className}.ftl', 'dettaglio${className}.ftl']],
		     'printpng':[inputDir: 'tpl/printtpl', outputDir: "web/docTemplate", postfix: '',
						files: ['logo.png']],
             'css':    [inputDir: 'css', outputDir: 'web/css', postfix: '',
                        files: ['form.css']],
             'image':  [inputDir: 'images', outputDir: 'web/images', postfix: '',
                        files: ['001_01.png', '001_55.png', 'delete.png', 'form_button.gif', 'form_heading.gif', 'form_input.gif', 
                                'form_top.gif', 'page.png', 'pencil.png', 'print.png']],
			 'lib':    [inputDir: 'lib', outputDir: 'web/lib', postfix: '', 
				 		files: []],
			 'projlib':[inputDir: 'projlib', outputDir: 'projlib', postfix: '', 
				 		files: ['log4j.jar', 'portlet.jar', 'servlet-api.jar']]],
		'vaadin' :
			 ['webcfg': [inputDir: 'tpl/webcfg', outputDir: 'web/WEB-INF', postfix: '.tpl',
						 files: ['web.xml', 'portlet.xml',
								 'liferay-portlet.xml', 'liferay-display.xml']],
			  'i18n':   [inputDir: 'tpl/i18n', outputDir: 'src/resources', postfix: '.tpl',
						 files: ['Language_it_IT.properties', 'Language_en_US.properties']],
			  'src':    [inputDir: 'tpl/src', outputDir: "src/${binding.packageName.replaceAll('[.]', '/')}", postfix: '.tpl',
						 files: ['${className}CrudApplication.java', '${className}CrudApplicationModelBean.java',
								 'Edit${className}Layout.java', 'Edit${className}ModelBean.java',
								 'Registry${className}Layout.java', 'Registry${className}ModelBean.java',
								 'Search${className}Layout.java', 'Search${className}ModelBean.java']],
			  'viewutil':[inputDir: 'tpl/viewutil', outputDir: "src/${binding.viewUtilPackage.replaceAll('[.]', '/')}", postfix: '.tpl',
						   files: ['BeanUtil.java', 'FormOperation.java', 'ResourceBundleProperty.java', 
							   'VaadinComponentUtil.java', 'VaadinNotificationUtil.java']],
			  //'jsp':    [inputDir: 'tpl/jsp', outputDir: "web/${binding.portletName}", postfix: '.tpl',
			  //           files: []],
			  //'css':    [inputDir: 'css', outputDir: 'web/css', postfix: '',
			  //           files: []],
			  'printtpl':[inputDir: 'tpl/printtpl', outputDir: "web/VAADIN/docTemplate", postfix: '.tpl',
				  			files: ['lista${className}.ftl', 'dettaglio${className}.ftl']],
			  'printpng':[inputDir: 'tpl/printtpl', outputDir: "web/VAADIN/docTemplate", postfix: '',
				  			files: ['logo.png']],
			  'image':  [inputDir: 'images', outputDir: 'web/VAADIN/images', postfix: '',
				  			files: ['delete.png', 'header-bg-light.png', 'page.png', 'pencil.png', 'print.png']],
			  'lib':    [inputDir: 'lib', outputDir: 'web/lib', postfix: '',
						  files: []],
			  'projlib':[inputDir: 'projlib', outputDir: 'projlib', postfix: '',
						  files: ['log4j.jar', 'portlet.jar', 'servlet-api.jar']]],
		'liferay_jsp' :
					  ['webcfg': [inputDir: 'tpl/webcfg', outputDir: 'web/WEB-INF', postfix: '.tpl',
								  files: ['web.xml', 'portlet.xml',
										  'liferay-portlet.xml', 'liferay-display.xml', 'liferay-hook.xml']],
					   'i18n':   [inputDir: 'tpl/i18n', outputDir: 'src/resources', postfix: '.tpl',
								  files: ['Language_it_IT.properties', 'Language_en_US.properties']],
					   'src':    [inputDir: 'tpl/src', outputDir: "src/${binding.packageName.replaceAll('[.]', '/')}", postfix: '.tpl',
								  files: ['${className}CrudPortlet.java', '${className}CrudPortletModelBean.java', 'Search${className}Util.java',
										  'Edit${className}ActionBean.java', 'Edit${className}ActionBeanImpl.java', 'Edit${className}ModelBean.java',
										  'Registry${className}ActionBean.java', 'Registry${className}ActionBeanImpl.java', 'Registry${className}ModelBean.java',
										  'Search${className}ActionBean.java', 'Search${className}ActionBeanImpl.java', 'Search${className}ModelBean.java']],
					   'viewutil':[inputDir: 'tpl/viewutil', outputDir: "src/${binding.viewUtilPackage.replaceAll('[.]', '/')}", postfix: '.tpl',
									files: ['BeanUtil.java', 'FormOperation.java']],
					   'jsp':    [inputDir: 'tpl/jsp', outputDir: "web/${binding.entityName}", postfix: '.tpl',
					              files: ['edit.jsp', 'init.jsp', 'registry.jsp', 'resultAction.jsp', 'search.jsp']],
					   'css':    [inputDir: 'css', outputDir: 'web/css', postfix: '',
					              files: ['form.css']],
					   'printtpl':[inputDir: 'tpl/printtpl', outputDir: "web/docTemplate", postfix: '.tpl',
									   files: ['lista${className}.ftl', 'dettaglio${className}.ftl']],
					   'printpng':[inputDir: 'tpl/printtpl', outputDir: "web/docTemplate", postfix: '',
									   files: ['logo.png']],
					   'image':  [inputDir: 'images', outputDir: 'web/images', postfix: '',
									   files: ['delete.png', 'header-bg-light.png', 'page.png', 'pencil.png', 'print.png']],
					   'lib':    [inputDir: 'lib', outputDir: 'web/lib', postfix: '',
								   files: []],
					   'tld':    [inputDir: 'tld', outputDir: 'web/WEB-INF/tld', postfix: '',
								   files: ['c.tld', 'liferay-aui.tld', 'liferay-portlet.tld', 'liferay-security.tld',
											   'liferay-theme.tld', 'liferay-ui.tld', 'liferay-util.tld']],
					   'projlib':[inputDir: 'projlib', outputDir: 'projlib', postfix: '',
								   files: ['log4j.jar', 'portal-impl.jar', 'portal-service.jar',  'portlet.jar', 'servlet-api.jar', 'util-bridges.jar', 'util-taglib.jar']]],
			   'zk6' :
							   ['webcfg': [inputDir: 'tpl/webcfg', outputDir: 'web/WEB-INF', postfix: '.tpl',
										   files: ['zk.xml', 'web.xml', 'portlet.xml',
												   'liferay-portlet.xml', 'liferay-plugin-package.properties', 'liferay-display.xml']],
								'i18n':   [inputDir: 'tpl/i18n', outputDir: 'src/resources', postfix: '.tpl',
										   files: ['Language_it_IT.properties', 'Language_en_US.properties']],
								'src':    [inputDir: 'tpl/src', outputDir: "src/${binding.packageName.replaceAll('[.]', '/')}", postfix: '.tpl',
										   files: ['Edit${className}Model.java', 'Edit${className}ViewModel.java',
												   'Registry${className}Action.java', 'Registry${className}ActionImpl.java', 'Registry${className}Model.java',
												   'Search${className}Action.java', 'Search${className}ActionImpl.java', 'Search${className}Model.java',
												   'View${className}Util.java', 'View${className}ViewModel.java']],
								'viewutil':[inputDir: 'tpl/viewutil', outputDir: "src/${binding.viewUtilPackage.replaceAll('[.]', '/')}", postfix: '.tpl',
											 files: ['BeanUtil.java', 'FormOperation.java']],
								'zkportlet':[inputDir: 'tpl/viewutil', outputDir: "src/org/zkoss/zk/ui/http", postfix: '.tpl',
											 files: ['FullDHtmlLayoutPortlet.java']],
							    'zul':    [inputDir: 'tpl/zul', outputDir: "web/${binding.entityName}", postfix: '.tpl',
										 files: ['edit.zul', 'registry.zul', 'search.zul', 'view.zul']],
								'css':    [inputDir: 'css', outputDir: 'web/css', postfix: '',
										   files: ['form.css']],
								'printtpl':[inputDir: 'tpl/printtpl', outputDir: "web/docTemplate", postfix: '.tpl',
												files: ['lista${className}.ftl', 'dettaglio${className}.ftl']],
								'printpng':[inputDir: 'tpl/printtpl', outputDir: "web/docTemplate", postfix: '',
												files: ['logo.png']],
								'image':  [inputDir: 'images', outputDir: 'web/images', postfix: '',
												files: ['delete.png', 'page.png', 'pencil.png', 'print.png']],
								'lib':    [inputDir: 'lib', outputDir: 'web/lib', postfix: '',
											files: []],
								'projlib':[inputDir: 'projlib', outputDir: 'projlib', postfix: '',
											files: ['log4j.jar', 'portal-service.jar',  'portlet.jar', 'servlet-api.jar']]],
					'flex4_6' :
								['webcfg': [inputDir: 'tpl/webcfg', outputDir: 'web/WEB-INF', postfix: '.tpl',
											files: ['web.xml', 'portlet.xml',
													'liferay-portlet.xml', 'liferay-display.xml']],
								 'flex': [inputDir: 'tpl/flex', outputDir: 'web/WEB-INF/flex', postfix: '.tpl',
											files: ['services-config.xml']],
								 'granite': [inputDir: 'tpl/flex', outputDir: 'web/WEB-INF/granite', postfix: '.tpl',
											files: ['granite-config.xml']],
								 'i18n_it':   [inputDir: 'tpl/i18n/it', outputDir: 'locale/it_IT', postfix: '.tpl',
											files: ['Language.properties']],
								 'i18n_en':   [inputDir: 'tpl/i18n/en', outputDir: 'locale/en_US', postfix: '.tpl',
											files: ['Language.properties']],
								 'src':    [inputDir: 'tpl/src', outputDir: "src/${binding.packageName.replaceAll('[.]', '/')}", postfix: '.tpl',
											files: ['Edit${className}ModelBean.java', '${className}CrudPortlet.java',
														'Edit${className}Model.as']],
								 'src-service': [inputDir: 'tpl/src', outputDir: "src/${binding.packageName.replaceAll('[.]', '/')}/service", postfix: '.tpl',
											files: ['${className}Service.java', '${className}ServiceImpl.java']],
								 'viewutil':[inputDir: 'tpl/viewutil', outputDir: "src/${binding.viewUtilPackage.replaceAll('[.]', '/')}", postfix: '.tpl',
											files: ['BeanUtil.java', 'FormOperation.as']],
								 'font':	[inputDir: 'fonts', outputDir: "resources", postfix: '',
												files: ['Ubuntu-L.ttf']],
								 'jsp':    [inputDir: 'tpl/jsp', outputDir: "web/${binding.entityName}", postfix: '.tpl',
											files: ['view.jsp', 'edit.jsp']],
								 'mxml':    [inputDir: 'tpl/mxml', outputDir: "web/${binding.entityName}", postfix: '.tpl',
											files: ['Registry.mxml', 'Search.mxml', 'edit.mxml', 'view.mxml']],
								 'build':  [inputDir: 'tpl/build', outputDir: ".", postfix: '.tpl',
											files: ['build.xml', 'env.properties']],
								 'printtpl':[inputDir: 'tpl/printtpl', outputDir: "web/docTemplate", postfix: '.tpl',
											files: ['lista${className}.ftl', 'dettaglio${className}.ftl']],
								 'printpng':[inputDir: 'tpl/printtpl', outputDir: "web/docTemplate", postfix: '',
											files: ['logo.png']],
								 'image':  [inputDir: 'images', outputDir: 'web/images', postfix: '',
											files: ['delete.png', 'page.png', 'pencil.png', 'print.png']],
								 'lib':    [inputDir: 'lib', outputDir: 'web/lib', postfix: '',
											 files: []],
								 'projlib':[inputDir: 'projlib', outputDir: 'projlib', postfix: '',
											 files: ['portal-service.jar', 'portlet.jar', 'servlet-api.jar', 'util-bridges.jar']]]
		 ]

//Collect class to import
def typesForMethods = declaredGetMethods.collect() { getType(it).type }
def genericsForMethods =  declaredGetMethods.collect() { getType(it).generic }.findAll() { it != null }.collect() { it.type }.flatten()
def types = typesForMethods + genericsForMethods
types.add(classForCrud.name)

types.sort().unique().findAll { !it.startsWith('java.lang.') && it != 'java.util.List' }.each { binding.importList.add(it) }

//println "typesForMethods: ${typesForMethods}"
//println "genericsForMethods: ${genericsForMethods}"
//println "types: ${types}"

//println "field list: ${binding.fieldList}"
//println "importList: ${binding.importList}"

showRunInfo outputPackage, viewUtilPackage, daoPackage, classForCrud, keyField,
	osivCrud, binding.fieldList, tplConfigDir, liferayVer, jsfVer

// setup config files
def files = null
files4config.each { config ->
	config.key.split(',').each {
		if (it == tplConfigDir) {
			files = config.value
		}
	}
}

if (!files) {
	println "Cannot find the specified ${tplConfigDir} configuration!!!"
	System.exit 0
}

def baseLibDir = "thecat/tools/portlet/resources/lib"

// fill files for lib key
if (verboseOutput) println "fill libs for ${tplConfigDir}"

ZipFile zipFile = new ZipFile(getClass().getProtectionDomain().getCodeSource().getLocation().getFile())
zipFile.entries().each {
	def entryName = FilenameUtils.getName(it.name)
	//if (it.name.startsWith("thecat/tools/portlet/resources/${files['lib'].value.inputDir}/${tplConfigDir}/")) {
	if (it.name.startsWith("${baseLibDir}/${tplConfigDir}/")) {
		if (entryName.count > 0) {
			if (entryName.endsWith('.fake')) {
				files['lib'].files.add(entryName[0..-6])
			} else {
				files['lib'].files.add(entryName)
			}
		}
	}
}

if (!files['lib'].files.count) {
	println "Cannot find the specified ${tplConfigDir} configuration!!!"
	System.exit 0
}

// fill files for liferay support lib
if (verboseOutput) println "fill liferay support lib for ${tplConfigDir}"

def liferaySupportLibFiles = []
def liferayDefaultSupportLibFiles = []
zipFile = new ZipFile(getClass().getProtectionDomain().getCodeSource().getLocation().getFile())
zipFile.entries().each {
	def entryName = FilenameUtils.getName(it.name)
	if (it.name.startsWith("${baseLibDir}/${liferaySupportLibDir}")) {
		if (entryName.count > 0) {
			liferaySupportLibFiles.add(entryName)
		}
	}
	if (it.name.startsWith("${baseLibDir}/${liferayDefaultSupportLibDir}")) {
		if (entryName.count > 0) {
			liferayDefaultSupportLibFiles.add(entryName)
		}
	}
}

if (liferaySupportLibDir) {
	if (liferaySupportLibFiles.count) {
		liferaySupportLibFiles.each {
			files['lib'].files.add(it)
		}
	} else {
		println ">>> The requested liferay version, ${liferayVer}, not found for the view technology specified."
		println ">>> Using the default liferay lib, ${liferayDefaultVer}"
		liferayVer = liferayDefaultVer
		liferaySupportLibDir = liferayDefaultSupportLibDir
		liferayDefaultSupportLibFiles.each {
			files['lib'].files.add(it)
		}
	}
}

print 'Generating code...'
if (verboseOutput) println ''

files.each { file -> 
	def baseOutputDir = "output-${tplConfigDir}"
	if (jsfVer) {
		baseOutputDir += "-liferay${liferayVer}"
	}
	def outputDir = file.value.outputDir
	def inputDir  = file.value.inputDir
	def postfix   = file.value.postfix
	
	if (verboseOutput) println "\t${outputDir}"
	FileUtils.forceMkdir(new File("${baseOutputDir}/${outputDir}"))
	
	file.value.files.each { value ->
		def outputFile = freemark(value, binding)
		def inputFile = "resources/${inputDir}/${value}"
		def inputFileConfigDir = "resources/${inputDir}/${tplConfigDir}/${value}"
		def inputFileLiferaySupportDir = "resources/${inputDir}/${liferaySupportLibDir}/${value}"
		
		if (value ==~ /^.+\.\*$/) { // if the entry ends with '.*'	
			//zipFile = new ZipFile(getClass().getProtectionDomain().getCodeSource().getLocation().getFile())
			zipFile.entries().each {
				def entryName = FilenameUtils.getName(FilenameUtils.removeExtension(it.name))
				
				if (it.name.startsWith("thecat/tools/portlet/${inputFileConfigDir[0..-2]}")) {
					inputFile = "resources/${inputDir}/${tplConfigDir}/${entryName}"
					outputFile = freemark(entryName, binding)
				} else if (it.name.startsWith("thecat/tools/portlet/${inputFile[0..-2]}")) {
					inputFile = "resources/${inputDir}/${entryName}"
					outputFile = freemark(entryName, binding)
				}
				
			}
		} else if (getClass().getResource(inputFileConfigDir + postfix) != null) {
			inputFile = inputFileConfigDir
		} else if (getClass().getResource(inputFileLiferaySupportDir + postfix) != null) {
			inputFile = inputFileLiferaySupportDir
		} 
		
		if (verboseOutput) println "\t\t$inputFile"
		
		if (postfix == '.tpl') {
			freemark("${inputFile}${postfix}", "${baseOutputDir}/${outputDir}/${outputFile}", binding)
		} else {
			FileUtils.copyURLToFile getClass().getResource(inputFile), 
				new File("${baseOutputDir}/${outputDir}/${outputFile}")
		}		
	}
}
println 'That\'s all Folks!!!'

def freemark(inputString, binding) {
	def engine = new FreeMarkerTemplateEngine('')
	
	return engine.createTemplate(inputString).make(binding)
}

def freemark(templateName, outputFileName, binding) {
	def engine = new FreeMarkerTemplateEngine('')
	
	def templateUrl = getClass().getResource(templateName);
	def templateText = templateUrl.getContent().getText()
	String freemarkedText = engine.createTemplate(templateText).make(binding)
	new File(outputFileName).setText(freemarkedText)
}

def getType(type) {
	if (type.getReturnType().toString() == type.getGenericReturnType().toString()) {
		return [type: type.returnType.name]
	} else {
		def returnType = [type: type.getReturnType().name, generic: []]
		
		def genericReturnType = type.getGenericReturnType().toString()
		genericReturnType = genericReturnType.substring(genericReturnType.indexOf("<") + 1, genericReturnType.lastIndexOf(">"))
		genericReturnType.split(',').each {
			returnType.generic.add([type: it])
		}
		
		return returnType
	}
}

def showRunInfo(outputPackage, viewUtilPackage, daoPackage, classForCrud, keyField,
	osivCrud, fields, tplConfig, liferayVer, jsfVer) {
	println "Output package: ${outputPackage}"
	println "View Util package: ${viewUtilPackage}"
	println "Dao package: ${daoPackage}"
	println "OSIV Crud: ${osivCrud ?: false}"
	println "Entity class: ${classForCrud.name}"
	println "Entity key field: ${keyField}"
	println "TPL Config: ${tplConfig}"
	if (jsfVer) {
		println "Liferay Version: ${liferayVer}"
	}
	println "Attributes found: (* - key field)"
	fields.each { field ->
		def props = []
		if (field.fieldName == keyField) props.add('(*)')
		println "\t${field.fieldType} ${field.fieldName} ${props.join(' ')}" 
	}
	println ""
}

def showUsage() {
	println "Please specify the following parameters:"
	println "\t-fq-class-name=<full qualified class name of the entity from which generate the Portlet CRUD code>"
	println "\t-key-field-name=<key field of the entity>"
	println "\t-output-package=<package of the generated code>"
	println "\t[-osiv-crud]"
	println "\t[-icefaces-ext-req]"
	println "\t[-viewutil-package=<package of the view util classes>] - default: thecat.common.view.util"
	println "\t[-dao-package=<package of the dao classes>]"
	println "\t[-search-fields=<field1>,<field2>,...]"
	println "\t[-grid-fields=<field1>,<field2>,...]"
	println "\t[-fields-order=<field1>,<field2>,...]"
	println "\t[-verbose] verbose output"
	println "\t[-tpl-config=<template config dir starting from thecat.tools.portlet.resources.tpl.*...] template configuration - default: icefaces1_8"
	println "\tAvailable template configuration: icefaces1_8, icefaces3_1, mojarra2, primefaces3_3, moj2tomahawk2, moj2alloy, vaadin, richfaces4, liferay_jsp, zk6, flex4_6"
	println "\t[-liferay-version=<version>] Liferay support lib version - default 6_1"
	println "\tSupported Liferay version: 5_2, 6_0, 6_1"
	
	println ""
	
	showCompatibilityMatrix()
}

def showCompatibilityMatrix() {
	println "*********** Liferay Compatibility Matrix *********"
	println "*       View             *        Liferay        *"
	println "*     technology         *        version        *"
	println "**************************************************"
	println "*                        * 5.2    * 6.0   * 6.1  *"
	println "**************************************************"
	println "* IceFaces 1.8           * No     * Yes   * No   *"
	println "**************************************************"
	println "* IceFaces 3.1           * Yes    * Yes   * Yes  *"
	println "**************************************************"
	println "* PrimeFaces 3.3         * No     * Yes   * Yes  *"
	println "**************************************************"
	println "* RichFaces 4            * Yes(1) * Yes   * Yes  *"
	println "**************************************************"
	println "* Mojarra 2 + Alloy      * Yes    * Yes   * Yes  *"
	println "**************************************************"
	println "* Mojarra 2 + Tomahawk 2 * Yes    * Yes   * Yes  *"
	println "**************************************************"
	println "* Mojarra 2              * Yes    * Yes   * Yes  *"
	println "**************************************************"
	println "* Jsp + Liferay TagLibs  * No     * Yes   * No   *"
	println "**************************************************"
	println "* Vaadin                 * No     * Yes   * Yes  *"
	println "**************************************************"
	println "* ZK6                    * Yes    * Yes   * No   *"
	println "**************************************************"
	println "* Flex 4.6               * No     * Yes   * Yes  *"
	println "**************************************************"
	println "(1) Portlet context menu don't work"
}
