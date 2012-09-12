package ${packageName};

import javax.portlet.PortletSession;

import ${viewUtilPackage}.FormOperation;
import ${viewUtilPackage}.ResourceBundleProperty;
import ${viewUtilPackage}.VaadinComponentUtil;
import ${viewUtilPackage}.VaadinNotificationUtil;

import com.vaadin.data.Item;
import com.vaadin.data.Property.ValueChangeEvent;
import com.vaadin.data.Property.ValueChangeListener;
import com.vaadin.data.util.ObjectProperty;
import com.vaadin.ui.Button;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.Button.ClickListener;
import com.vaadin.ui.GridLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.Layout;
import com.vaadin.ui.Panel;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;

<#list importList as import>
import ${import};
</#list>

@SuppressWarnings("serial")
public class Registry${className}Layout extends VerticalLayout implements ValueChangeListener, ClickListener {
	
	private ResourceBundleProperty resourceBundleProperty;
	private Registry${className}ModelBean modelBean;
	private Search${className}Layout searchLayout;
	private Search${className}ModelBean searchModelBean;
	private Edit${className}ModelBean editModelBean;
	private ${className}CrudApplicationModelBean applicationModelBean;
	
	private Label headerLabel;

	private GridLayout registryFieldContainer;
	private Panel registryFieldPanel;
	
<#list fieldList as field>
	private Label ${field.fieldName}Label;
	private TextField ${field.fieldName}TextField;
</#list>

	private Button printButton;
	private Button confirmButton;
	private Button cancelButton;
	
	private String contextPath;
	
	public Registry${className}Layout(
			Registry${className}ModelBean registryModelBean,
			${className}CrudApplicationModelBean applicationModelBean) {
		
		this.modelBean = registryModelBean;
		this.resourceBundleProperty = applicationModelBean.getResourceBundleProperty();
		
		this.searchLayout = applicationModelBean.getSearchContent();
		this.searchModelBean = applicationModelBean.getSearchModelBean();
		this.editModelBean = applicationModelBean.getEditModelBean();
		this.applicationModelBean = applicationModelBean;
	
		this.contextPath = applicationModelBean.getPortletRequest().getContextPath();
		
		setWidth("100%");
		setSpacing(true);
		
		headerLabel = new Label();
		headerLabel.setContentMode(Label.CONTENT_XHTML);
		headerLabel.setHeight("100%");
		headerLabel.setWidth("100%");
		addComponent(headerLabel);

<#list fieldList as field>
		${field.fieldName}Label = new Label();
		${field.fieldName}TextField = new TextField();
		${field.fieldName}TextField.setPropertyDataSource(modelBean.get${className}().getItemProperty("${field.fieldName}"));
		${field.fieldName}TextField.setInputPrompt("${entityName} ${field.fieldName}");
		${field.fieldName}TextField.setNullRepresentation("");
	<#if keyField == field.fieldName>
		${field.fieldName}TextField.setReadOnly(true);
	</#if>
	
</#list>		
		
		registryFieldPanel = new Panel();
		setupFieldContainer();
		addComponent(registryFieldPanel);
		
		// registry view buttons
		confirmButton = new Button();
		confirmButton.addListener((ClickListener) this);
		
		cancelButton = new Button();
		cancelButton.addListener((ClickListener) this);
		
		printButton = new Button();
		printButton.addListener((ClickListener) this);
		
		Layout buttonContainer = VaadinComponentUtil.setupHorizontalContainer(
				confirmButton, cancelButton, printButton);
		buttonContainer.setMargin(false);
		addComponent(buttonContainer);

		updateI18NCaptions();
		
		resourceBundleProperty.getResourceBundleProp().addListener(this);
		
		this.editModelBean.getPropNColsRegistry().addListener(this);
<#list fieldList as field>
		((ObjectProperty) this.editModelBean.getPropRegistryFieldMap().getItemProperty("${field.fieldName}")).addListener(this);
</#list>
		
		this.modelBean.getFormOperation().addListener(this);
	}
	
	@Override
	public void buttonClick(ClickEvent event) {
		
		${className} ${entityName} = modelBean.get${className}().getBean();
		
		if (event.getComponent() == confirmButton) {
			
			System.out.println("confirm button clicked!!! " + modelBean.get${className}().getBean());
			
			
			if (FormOperation.EDIT == modelBean.getFormOperation().getValue()) {
				
				System.out.println("confirm button: edit");
			
				try {
					
					update${className}(modelBean.get${className}().getBean());
					VaadinNotificationUtil.notificationInfo(this, resourceBundleProperty.getString("update.msg.success"), null);
					
				} catch (Exception ex) {
					
					VaadinNotificationUtil.notificationError(this, resourceBundleProperty.getString("update.msg.fail"), ex.getMessage());
					ex.printStackTrace();
					
				}
				
				Item itemToUpdate = searchModelBean.get${className}ListBC().getItem(${entityName}.get${keyField?cap_first}());
<#list fieldList as field>
	<#if keyField != field.fieldName>
				itemToUpdate.getItemProperty("${field.fieldName}").setValue(${entityName}.get${field.fieldName?cap_first}());
	</#if>
</#list>

			} else if (FormOperation.NEW == modelBean.getFormOperation().getValue()) {
				
				System.out.println("confirm button: new");
				
				try {
					
					create${className}(modelBean.get${className}().getBean());
					VaadinNotificationUtil.notificationInfo(this, resourceBundleProperty.getString("new.msg.success"), null);
				
					searchLayout.search();
					searchLayout.getSearchResultTable().sort();
					
				} catch (Exception ex) {
					
					VaadinNotificationUtil.notificationError(this, resourceBundleProperty.getString("new.msg.fail"), ex.getMessage());
					ex.printStackTrace();
					
				}
			}
			
			applicationModelBean.setCurrentViewState(${className}CrudApplicationModelBean.SEARCH_VIEW_STATE);
			
		} else if (event.getComponent() == cancelButton) {
			
			System.out.println("cancel button clicked!!!");
			applicationModelBean.setCurrentViewState(${className}CrudApplicationModelBean.SEARCH_VIEW_STATE);
			
		} else if (event.getComponent() == printButton) {
			
			System.out.println("print button clicked!!!");
			
			PortletSession portletSession = applicationModelBean.getPortletRequest().getPortletSession(false);
			portletSession.setAttribute("sourceBean", "selected${className}", PortletSession.APPLICATION_SCOPE);
			portletSession.setAttribute("selected${className}", ${entityName}, PortletSession.APPLICATION_SCOPE);
			
			String printUrl = contextPath + "/DocumentGeneratorServlet?templateName=dettaglio${className}.ftl";
			
			getWindow().executeJavaScript(
					"window.open('" + printUrl + "', 'file', 'scrollbars=yes,toolbar=no,location=no')");

		}
		
	}
	
	@Override
	public void valueChange(ValueChangeEvent event) {
		
		if (event.getProperty() == resourceBundleProperty.getResourceBundleProp()) {
			
			updateI18NCaptions();
			
		} else if (event.getProperty() == modelBean.getFormOperation()) {
		
			if (modelBean.getFormOperation().getValue() == FormOperation.SHOW) {

<#list fieldList as field>				
	<#if keyField != field.fieldName>				
				${field.fieldName}TextField.setReadOnly(true);
	</#if>
</#list>
				
				cancelButton.setVisible(false);
				printButton.setVisible(true);
				
			} else {
			
<#list fieldList as field>				
	<#if keyField != field.fieldName>				
				${field.fieldName}TextField.setReadOnly(false);
	</#if>
</#list>
				
				cancelButton.setVisible(true);
				printButton.setVisible(false);
				
			}
			
			updateI18NCaptions();
		} else if (event.getProperty() == editModelBean.getPropNColsRegistry()) { // !!!
			
			setupFieldContainer();
			
		}  else if (
<#list fieldList as field>
			(event.getProperty() == editModelBean.getPropRegistryFieldMap().getItemProperty("${field.fieldName}"))<#if field != fieldList[fieldList?size - 1]> ||<#else>) {</#if>
</#list>
			
			System.out.println("registryFieldMap changed!!!");
			setupFieldContainer();
			
		}
		
	}
	
	private void updateI18NCaptions() {
		
		String headerBundleKey = "${entityName}.registry.show.header";
		if (modelBean.getFormOperation().getValue() == FormOperation.EDIT) {
			headerBundleKey = "${entityName}.registry.edit.header";
		} else if (modelBean.getFormOperation().getValue() == FormOperation.NEW) {
			headerBundleKey = "${entityName}.registry.new.header";
		}
		// TODO check for theme style customization
		headerLabel.setValue("<h2 style='background:#57a700;color:#fff;font-size:20px'>" + 
				resourceBundleProperty.getString(headerBundleKey) +
				"</h2>");
<#list fieldList as field>				
		${field.fieldName}Label.setValue(resourceBundleProperty.getString("${entityName}.field.${field.fieldName}"));
</#list>

		confirmButton.setCaption(resourceBundleProperty.getString("button.confirm"));
		cancelButton.setCaption(resourceBundleProperty.getString("button.cancel"));
		printButton.setCaption(resourceBundleProperty.getString("button.print"));
		
	}
	
	private void setupFieldContainer() {

		// TODO setup margin amount using css
		registryFieldContainer = VaadinComponentUtil.setupGridContainer(
				this.editModelBean.getPropNColsRegistry().getValue().intValue() * 2, 1);

<#list fieldList as field>
		if ((Boolean) editModelBean.getPropRegistryFieldMap().getItemProperty("${field.fieldName}").getValue()) {
			registryFieldContainer.addComponent(${field.fieldName}Label);
			registryFieldContainer.addComponent(${field.fieldName}TextField);
		}
		
</#list>
		registryFieldPanel.removeAllComponents();
		registryFieldPanel.addComponent(registryFieldContainer);
	}
	
	private void update${className}(final ${className} ${entityName}) {
		
		applicationModelBean.get${className}Dao().update(${entityName});
		
	}

	private void create${className}(final ${className} ${entityName}) {
		
		applicationModelBean.get${className}Dao().create(${entityName});
		
	}

}
