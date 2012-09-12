package ${packageName};

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;

import javax.portlet.PortletSession;

import org.vaadin.dialogs.ConfirmDialog;

import ${viewUtilPackage}.BeanUtil;
import ${viewUtilPackage}.FormOperation;
import ${viewUtilPackage}.ResourceBundleProperty;
import ${viewUtilPackage}.VaadinComponentUtil;
import ${viewUtilPackage}.VaadinNotificationUtil;

import com.vaadin.data.Property.ValueChangeEvent;
import com.vaadin.data.Property.ValueChangeListener;
import com.vaadin.data.util.ObjectProperty;
import com.vaadin.event.Action;
import com.vaadin.terminal.ExternalResource;
import com.vaadin.ui.Button;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.Button.ClickListener;
import com.vaadin.ui.GridLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.Layout;
import com.vaadin.ui.Panel;
import com.vaadin.ui.Table;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;

<#list importList as import>
import ${import};
</#list>

@SuppressWarnings("serial")
public class Search${className}Layout extends VerticalLayout 
	implements ValueChangeListener, ClickListener {

	private static final Action SEARCH_ACTION_SHOW = new Action("");
	private static final Action SEARCH_ACTION_EDIT = new Action("");
	private static final Action SEARCH_ACTION_DELETE = new Action("");
	private static final Action SEARCH_ACTION_PRINT = new Action("");
	
	private static final Action[] SEARCH_ACTIONS = new Action[] 
			{ SEARCH_ACTION_SHOW, SEARCH_ACTION_EDIT, SEARCH_ACTION_DELETE, SEARCH_ACTION_PRINT };
	
	private ResourceBundleProperty resourceBundleProperty;
	private Search${className}ModelBean modelBean;
	private Registry${className}ModelBean registryModelBean;
	private Edit${className}ModelBean editModelBean;
	private ${className}CrudApplicationModelBean applicationModelBean;
	
	private Label headerLabel;
	
	private GridLayout searchContainer;
	private Panel searchFieldPanel;
	
<#list fieldList as field>	
	private Label ${field.fieldName}Label;
	private TextField ${field.fieldName}TextField;
</#list>

	private Table searchResultTable;
	private Label searchResultFooterLabel;
	
	private Button newButton;
	private Button printButton;
	private Button resetButton;
	private Button searchButton;

	private String contextPath;
	
	public Search${className}Layout(
			Search${className}ModelBean searchModelBean,
			${className}CrudApplicationModelBean applicationModelBean) {
		this.modelBean = searchModelBean;
		this.resourceBundleProperty = applicationModelBean.getResourceBundleProperty();
		
		this.registryModelBean = applicationModelBean.getRegistryModelBean();
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
		${field.fieldName}TextField.setPropertyDataSource(modelBean.get${className}Search().getItemProperty("${field.fieldName}"));
		${field.fieldName}TextField.setNullRepresentation("");
		${field.fieldName}TextField.setNullSettingAllowed(true);
		
</#list>
		searchFieldPanel = new Panel();
		setupFieldContainer();
		addComponent(searchFieldPanel);
		
		searchResultTable = new Table("", modelBean.get${className}ListBC());
		
		searchResultTable.setVisibleColumns(new Object[] {
<#list fieldList as field>		
			"${field.fieldName}"<#if field != fieldList[fieldList?size - 1]>, <#else>});</#if>
</#list>
		
		searchResultTable.setWidth("100%");
		searchResultTable.setPageLength(editModelBean.getPropRowsPerPage().getValue().intValue());
		searchResultTable.setColumnReorderingAllowed(true);
		searchResultTable.setColumnCollapsingAllowed(true);
		searchResultTable.setSelectable(true);
		
		searchResultTable.addActionHandler(new SearchTableActionHandler(this));
		
		String contextPath = applicationModelBean.getPortletRequest().getContextPath();
		SEARCH_ACTION_SHOW.setIcon(new ExternalResource(contextPath + ${className}CrudApplicationModelBean.RESOURCE_PATH_IMG + "page.png"));
		SEARCH_ACTION_EDIT.setIcon(new ExternalResource(contextPath + ${className}CrudApplicationModelBean.RESOURCE_PATH_IMG + "pencil.png"));
		SEARCH_ACTION_DELETE.setIcon(new ExternalResource(contextPath + ${className}CrudApplicationModelBean.RESOURCE_PATH_IMG + "delete.png"));
		SEARCH_ACTION_PRINT.setIcon(new ExternalResource(contextPath + ${className}CrudApplicationModelBean.RESOURCE_PATH_IMG + "print.png"));
		
		searchResultFooterLabel = new Label();
		searchResultFooterLabel.setContentMode(Label.CONTENT_XHTML);
		
		Layout searchResultContainer = VaadinComponentUtil.setupVerticalContainer(
				false,
				searchResultTable, searchResultFooterLabel);
		addComponent(searchResultContainer);
		
		// search view buttons
		newButton = new Button();
		newButton.addListener((ClickListener) this);
		
		resetButton = new Button();
		resetButton.addListener((ClickListener) this);
		
		searchButton = new Button();
		searchButton.addListener((ClickListener) this);
		
		printButton = new Button();
		printButton.addListener((ClickListener) this);
		printButton.setVisible(false);
		
		Layout buttonContainer = VaadinComponentUtil.setupHorizontalContainer(
				true, false,
				newButton, resetButton, searchButton, printButton);
		addComponent(buttonContainer);

		updateI18NCaptions();
		
		resourceBundleProperty.getResourceBundleProp().addListener(this);
		
		editModelBean.getPropRowsPerPage().addListener(this);
		editModelBean.getPropNColsSearch().addListener(this);
<#list fieldList as field>		
		((ObjectProperty) this.editModelBean.getPropSearchFieldMap().getItemProperty("${field.fieldName}")).addListener(this);
</#list>
<#list fieldList as field>		
		((ObjectProperty) this.editModelBean.getPropResultFieldMap().getItemProperty("${field.fieldName}")).addListener(this);
</#list>
	}

	public Table getSearchResultTable() {
		return searchResultTable;
	}
	
	@Override
	public void buttonClick(ClickEvent event) {
		
		
		if (event.getComponent() == newButton) { // New button
			
			System.out.println("new button clicked!!!");

			registryModelBean.setFormOperation(FormOperation.NEW);
			registryModelBean.reset${className}();
			applicationModelBean.setCurrentViewState(${className}CrudApplicationModelBean.REGISTRY_VIEW_STATE);			
			
		} else if (event.getComponent() == printButton) { // Print button
			
			System.out.println("print button clicked!!!");
			
			PortletSession portletSession = applicationModelBean.getPortletRequest().getPortletSession(false);
			portletSession.setAttribute("sourceBean", "search${className}ModelBean", PortletSession.APPLICATION_SCOPE);
			portletSession.setAttribute("search${className}ModelBean", modelBean, PortletSession.APPLICATION_SCOPE);
			
			String printUrl = contextPath + "/DocumentGeneratorServlet?templateName=lista${className}.ftl";
			
			getWindow().executeJavaScript(
					"window.open('" + printUrl + "', 'file', 'scrollbars=yes,toolbar=no,location=no')");
			
			
		} else if (event.getComponent() == resetButton) { // Reset button
			
			System.out.println("reset button clicked!!!");
			modelBean.resetSearch${className}();
			
		} else if (event.getComponent() == searchButton) { // Search button
			
			System.out.println("search button clicked!!!");
			
			try {
				
				search();
				
			} catch (Exception ex) {
				
				VaadinNotificationUtil.notificationError(this, 
						resourceBundleProperty.getString("search.msg.fail"), ex.getMessage());
				
			}
			
		}

	}
	
	@Override
	public void valueChange(ValueChangeEvent event) {
		
		if (event.getProperty() == editModelBean.getPropRowsPerPage()) {
			
			searchResultTable.setPageLength(editModelBean.getPropRowsPerPage().getValue().intValue());
			
		} else if (event.getProperty() == resourceBundleProperty.getResourceBundleProp()) {
			
			updateI18NCaptions();
			
		} else if (event.getProperty() == editModelBean.getPropNColsSearch()) {
			
			setupFieldContainer();
			
		} else if (
<#list fieldList as field>
			(event.getProperty() == editModelBean.getPropSearchFieldMap().getItemProperty("${field.fieldName}"))<#if field != fieldList[fieldList?size - 1]> ||<#else>) {</#if>
</#list>
			
			System.out.println("searchFieldMap changed!!!");
			setupFieldContainer();
			
		} else if (
<#list fieldList as field>
			(event.getProperty() == editModelBean.getPropResultFieldMap().getItemProperty("${field.fieldName}"))<#if field != fieldList[fieldList?size - 1]> ||<#else>) {</#if>
</#list>
		
			System.out.println("resultFieldMap changed!!!");
			setupResultField();
			
		}
		
	}
	
	private void updateI18NCaptions() {
		
		// TODO check for theme style customization
		headerLabel.setValue("<h2 style='background:#57a700;color:#fff;font-size:20px'>" + 
				resourceBundleProperty.getString("${entityName}.search.header") +
				"</h2>");

<#list fieldList as field>		
		${field.fieldName}Label.setValue(resourceBundleProperty.getString("${entityName}.field.${field.fieldName}"));
		${field.fieldName}TextField.setInputPrompt(
				resourceBundleProperty.getString("${entityName}.entity-name") + " " +
				resourceBundleProperty.getString("${entityName}.field.${field.fieldName}"));
</#list>

<#list fieldList as field>
		searchResultTable.setColumnHeader("${field.fieldName}", resourceBundleProperty.getString("${entityName}.field.${field.fieldName}"));
</#list>

		// TODO check for tooltip
		searchResultTable.setDescription(resourceBundleProperty.getString("${entityName}.search.result.help"));
		
		SEARCH_ACTION_SHOW.setCaption(resourceBundleProperty.getString("button.show"));
		SEARCH_ACTION_EDIT.setCaption(resourceBundleProperty.getString("button.edit"));
		SEARCH_ACTION_DELETE.setCaption(resourceBundleProperty.getString("button.delete"));
		SEARCH_ACTION_PRINT.setCaption(resourceBundleProperty.getString("button.print"));

		updateI18NFooterTableCaption();		
		
		newButton.setCaption(resourceBundleProperty.getString("button.new"));
		printButton.setCaption(resourceBundleProperty.getString("button.print"));
		resetButton.setCaption(resourceBundleProperty.getString("button.reset"));
		searchButton.setCaption(resourceBundleProperty.getString("button.search"));
		
	}
	
	public void updateI18NFooterTableCaption() {
		
		// TODO check for theme style customization
		searchResultFooterLabel.setValue(
				"<div style='border: 1px solid #aaaaaa;border-top: none;background: transparent repeat-x;background-image: url(" + 
				contextPath + ${className}CrudApplicationModelBean.RESOURCE_PATH_IMG + "header-bg-light.png);" +
				"height: 20px;font-size: 10px;font-weight: bold;color: #222;text-shadow: #f3f5f8 0 1px 0;line-height: normal;'>" +
				"<p style='margin-left: 5px'>" + 
				MessageFormat.format(resourceBundleProperty.getString("grid.summary"), modelBean.get${className}List().size()) + 
				"</p>" + "</div>");
		
	}
	
	private void setupFieldContainer() {
		
		// TODO setup margin amount using css
		GridLayout searchContainer = VaadinComponentUtil.setupGridContainer(
			editModelBean.getPropNColsSearch().getValue().intValue() * 2, 1);
			
<#list fieldList as field>
		if ((Boolean) editModelBean.getPropSearchFieldMap().getItemProperty("${field.fieldName}").getValue()) {
			searchContainer.addComponent(${field.fieldName}Label);
			searchContainer.addComponent(${field.fieldName}TextField);
		}
		
</#list>
		searchFieldPanel.removeAllComponents();
		searchFieldPanel.addComponent(searchContainer);
	}
	
	private void setupResultField() {
		List<String> fieldList = new ArrayList<String>();
		
		for (String field : BeanUtil.ORDERED_FIELD_LIST) {
			if ((Boolean) editModelBean.getPropResultFieldMap().getItemProperty(field).getValue()) {
				fieldList.add(field);
			}
		}
		
		searchResultTable.setVisibleColumns(fieldList.toArray());
	}
	
	public Search${className}ModelBean getSearchModelBean() {
		return modelBean;
	}
	
	public Registry${className}ModelBean getRegistryModelBean() {
		return registryModelBean;
	}
	
	public ${className}CrudApplicationModelBean getApplicationModelBean() {
		return applicationModelBean;
	}

	public void search() {
		
		modelBean.set${className}ListBC(
				applicationModelBean.get${className}Dao().findBy(
						modelBean.get${className}Search().getBean()));
		
		updatePrintButtonVisibility();
		updateI18NFooterTableCaption();
		
	}

	public void updatePrintButtonVisibility() {
		
		if (modelBean.get${className}ListBC().size() > 0) {
			
			printButton.setVisible(true);
			
		} else {
			
			printButton.setVisible(false);
			
		}
	}
	
	private class SearchTableActionHandler implements Action.Handler {
		
		private Search${className}Layout search${className};
		
		public SearchTableActionHandler(Search${className}Layout search${className}) {
			this.search${className} = search${className};
		}
		
		@Override
		public void handleAction(Action action, Object sender, Object target) {
			
			Long ${entityName}${keyField?cap_first} = (Long) target;
			${className} ${entityName} = search${className}.getSearchModelBean().get${className}ListBC().getItem(${entityName}${keyField?cap_first}).getBean(); 
			
			if (action == SEARCH_ACTION_SHOW) { // Show button
				
				System.out.println("showing " + ${entityName});
				
				search${className}.getRegistryModelBean().set${className}(${entityName});
				search${className}.getRegistryModelBean().getFormOperation().setValue(FormOperation.SHOW);
				search${className}.getApplicationModelBean().setCurrentViewState(${className}CrudApplicationModelBean.REGISTRY_VIEW_STATE);
				
			} else  if (action == SEARCH_ACTION_EDIT) { // Edit button
				
				System.out.println("editing " + ${entityName});
				
				search${className}.getRegistryModelBean().set${className}(${entityName});
				search${className}.getRegistryModelBean().getFormOperation().setValue(FormOperation.EDIT);
				search${className}.getApplicationModelBean().setCurrentViewState(${className}CrudApplicationModelBean.REGISTRY_VIEW_STATE);
				
			} else if (action == SEARCH_ACTION_DELETE) { // Delete button
				
				System.out.println("deleting " + ${entityName});
				
				ConfirmDialog.show(search${className}.getWindow(), 
						resourceBundleProperty.getString("deletion-confirm.title"), 
						resourceBundleProperty.getString("deletion-confirm.message"), 
						resourceBundleProperty.getString("button.confirm"), 
						resourceBundleProperty.getString("button.cancel"),
						new DeletionConfirmDialogListener(${entityName}, search${className}));
				
			} else if (action == SEARCH_ACTION_PRINT) { // Print button
				
				System.out.println("printing " + ${entityName});
				
				PortletSession portletSession = applicationModelBean.getPortletRequest().getPortletSession(false);
				portletSession.setAttribute("sourceBean", "selected${className}", PortletSession.APPLICATION_SCOPE);
				portletSession.setAttribute("selected${className}", ${entityName}, PortletSession.APPLICATION_SCOPE);
				
				String printUrl = contextPath + "/DocumentGeneratorServlet?templateName=dettaglio${className}.ftl";
				
				getWindow().executeJavaScript(
						"window.open('" + printUrl + "', 'file', 'scrollbars=yes,toolbar=no,location=no')");
				
			}
		}
		
		@Override
		public Action[] getActions(Object target, Object sender) {
			return SEARCH_ACTIONS;
		}
	}
	
	private class DeletionConfirmDialogListener implements ConfirmDialog.Listener {
		
		private ${className} ${entityName};
		private Search${className}Layout search${className};
		
		public DeletionConfirmDialogListener(final ${className} ${entityName}, final Search${className}Layout search${className}) {
			this.${entityName} = ${entityName};
			this.search${className} = search${className};
		}
		
		@Override
		public void onClose(ConfirmDialog dialog) {
			
			if (dialog.isConfirmed()) {
				try {
					
					applicationModelBean.get${className}Dao().delete(${entityName});
					
					search${className}.getSearchModelBean().get${className}ListBC().removeItem(${entityName}.get${keyField?cap_first}());
					
					search${className}.updatePrintButtonVisibility();
					
					search${className}.updateI18NFooterTableCaption();
					
				} catch (Exception ex) {
					
					VaadinNotificationUtil.notificationError(search${className}, 
							resourceBundleProperty.getString("delete.msg.fail"), ex.getMessage());
					ex.printStackTrace();
					
				}
			}
			
		}
	}
}
