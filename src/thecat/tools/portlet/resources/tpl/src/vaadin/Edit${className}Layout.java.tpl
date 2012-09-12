package ${packageName};

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.portlet.PortletRequest;

import ${viewUtilPackage}.VaadinNotificationUtil;
import ${viewUtilPackage}.ResourceBundleProperty;
import ${viewUtilPackage}.VaadinComponentUtil;

import com.vaadin.data.Property.ValueChangeEvent;
import com.vaadin.data.Property.ValueChangeListener;
import com.vaadin.data.util.PropertysetItem;
import com.vaadin.ui.Accordion;
import com.vaadin.ui.Button;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.Button.ClickListener;
import com.vaadin.ui.CheckBox;
import com.vaadin.ui.ComboBox;
import com.vaadin.ui.GridLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.Layout;
import com.vaadin.ui.TabSheet.Tab;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class Edit${className}Layout extends VerticalLayout implements ValueChangeListener, ClickListener {

	private Edit${className}ModelBean modelBean;
	private ResourceBundleProperty resourceBundleProperty;
	private ${className}CrudApplicationModelBean applicationModelBean;
	
	private Label headerLabel;
	
	private Map<String, Label> searchFieldLabelMap = new HashMap<String, Label>();
	private Map<String, Label> registryFieldLabelMap = new HashMap<String, Label>();
	private Map<String, Label> resultFieldLabelMap = new HashMap<String, Label>();
	
	private Label nColsSearchLabel;
	private Label nColsRegistryLabel;
	private Label rowsPerPageLabel;
	
	private Tab searchFieldsTab;
	private Tab searchFieldsOptionsTab;
	private Tab registryFieldsTab;
	private Tab registryFieldsOptionsTab;
	private Tab resultFieldsTab;
	private Tab resultFieldsOptionsTab;
	
	private ComboBox nColsSearchComboBox;
	private ComboBox nColsRegistryComboBox;
	private ComboBox rowsPerPageComboBox;
	
	private Button searchFieldsSelectAllButton;
	private Button searchFieldsDeselectAllButton;
	private Button registryFieldsSelectAllButton;
	private Button registryFieldsDeselectAllButton;
	private Button resultFieldsSelectAllButton;
	private Button resultFieldsDeselectAllButton;
	
	private Button resetButton;
	private Button saveButton;
	
	public Edit${className}Layout(
			Edit${className}ModelBean modelBean,
			${className}CrudApplicationModelBean applicationModelBean) {
		this.modelBean = modelBean;
		this.resourceBundleProperty = applicationModelBean.getResourceBundleProperty();
		this.applicationModelBean = applicationModelBean;
		
		setWidth("100%");
		setSpacing(true);
		
		// header label
		headerLabel = new Label();
		headerLabel.setContentMode(Label.CONTENT_XHTML);
		headerLabel.setHeight("100%");
		headerLabel.setWidth("100%");
		addComponent(headerLabel);
		
		// search fields Tab
		GridLayout searchFieldsGrid = VaadinComponentUtil.setupGridContainer(4, 1);
		setupFieldContainer(searchFieldsGrid, searchFieldLabelMap, modelBean.getPropSearchFieldMap());
		searchFieldsSelectAllButton = VaadinComponentUtil.setupButton((ClickListener) this);
		searchFieldsDeselectAllButton = VaadinComponentUtil.setupButton((ClickListener) this);
		Layout searchFieldsContainer = VaadinComponentUtil.setupVerticalContainer(
				searchFieldsGrid, 
				VaadinComponentUtil.setupHorizontalContainer(searchFieldsSelectAllButton, searchFieldsDeselectAllButton));
		
		// search fields options Tab
		nColsSearchLabel = new Label();
		nColsSearchComboBox = VaadinComponentUtil.setupComboBox(
				modelBean.getPropNColsSearch(), modelBean.getPropNColsSearch().getValue(), 
				1L, 2L, 3L);
		Layout searchFieldsOptionsContainer = VaadinComponentUtil.setupHorizontalContainer(		
				nColsSearchLabel, nColsSearchComboBox);
		
		// result fields Tab
		GridLayout resultFieldsGrid = VaadinComponentUtil.setupGridContainer(4, 1);
		resultFieldsGrid.setWidth("100%");
		resultFieldsGrid.setSpacing(true);
		setupFieldContainer(resultFieldsGrid, resultFieldLabelMap, modelBean.getPropResultFieldMap());
		resultFieldsSelectAllButton = VaadinComponentUtil.setupButton((ClickListener) this);
		resultFieldsDeselectAllButton = VaadinComponentUtil.setupButton((ClickListener) this);
		Layout resultFieldsContainer = VaadinComponentUtil.setupVerticalContainer(
				resultFieldsGrid, 
				VaadinComponentUtil.setupHorizontalContainer(resultFieldsSelectAllButton, resultFieldsDeselectAllButton));
		
		// result fields options Tab
		rowsPerPageLabel = new Label();
		rowsPerPageComboBox = VaadinComponentUtil.setupComboBox(
				modelBean.getPropRowsPerPage(), modelBean.getPropRowsPerPage().getValue(), 
				5L, 10L, 15L, 20L, 30L);
		Layout resultFieldsOptionsContainer = VaadinComponentUtil.setupHorizontalContainer(		
				rowsPerPageLabel, rowsPerPageComboBox);
		
		// registry fields Tab
		GridLayout registryFieldsGrid = VaadinComponentUtil.setupGridContainer(4, 1);
		setupFieldContainer(registryFieldsGrid, registryFieldLabelMap, modelBean.getPropRegistryFieldMap());
		registryFieldsSelectAllButton = VaadinComponentUtil.setupButton((ClickListener) this);
		registryFieldsDeselectAllButton = VaadinComponentUtil.setupButton((ClickListener) this);
		Layout registryFieldsContainer = VaadinComponentUtil.setupVerticalContainer(
				registryFieldsGrid, 
				VaadinComponentUtil.setupHorizontalContainer(registryFieldsSelectAllButton, registryFieldsDeselectAllButton));
		
		// registry fields options Tab
		nColsRegistryLabel = new Label();
		nColsRegistryComboBox = VaadinComponentUtil.setupComboBox(
				modelBean.getPropNColsRegistry(), modelBean.getPropNColsRegistry().getValue(), 
				1L, 2L, 3L);
		Layout registryFieldsOptionsContainer = VaadinComponentUtil.setupHorizontalContainer(		
				nColsRegistryLabel, nColsRegistryComboBox);
				
		Accordion accordion = new Accordion();
		accordion.setWidth("100%");
		searchFieldsTab = accordion.addTab(searchFieldsContainer);
		searchFieldsOptionsTab = accordion.addTab(searchFieldsOptionsContainer);
		resultFieldsTab = accordion.addTab(resultFieldsContainer);
		resultFieldsOptionsTab = accordion.addTab(resultFieldsOptionsContainer);
		registryFieldsTab = accordion.addTab(registryFieldsContainer);
		registryFieldsOptionsTab = accordion.addTab(registryFieldsOptionsContainer);
		
		addComponent(accordion);
		
		resetButton = VaadinComponentUtil.setupButton((ClickListener) this);
		saveButton = VaadinComponentUtil.setupButton((ClickListener) this);
		addComponent(VaadinComponentUtil.setupHorizontalContainer(resetButton, saveButton));
		
		updateI18NCaptions();
		
		resourceBundleProperty.getResourceBundleProp().addListener(this);
	}
	
	@Override
	public void buttonClick(ClickEvent event) {
		
		if (event.getComponent() == saveButton) saveButtonClick(event);
			
		else if (event.getComponent() == resetButton) resetButtonClick(event);
			
		else if (event.getComponent() == searchFieldsSelectAllButton) searchFieldsSelectAllButtonClick(event);
			
		else if (event.getComponent() == searchFieldsDeselectAllButton) searchFieldsDeselectAllButtonClick(event);
			
		else if (event.getComponent() == registryFieldsSelectAllButton) registryFieldsSelectAllButtonClick(event);
			
		else if (event.getComponent() == registryFieldsDeselectAllButton) registryFieldsDeselectAllButtonClick(event);
			
		else if (event.getComponent() == resultFieldsSelectAllButton) resultFieldsSelectAllButtonClick(event);
			
		else if (event.getComponent() == resultFieldsDeselectAllButton) resultFieldsDeselectAllButtonClick(event);

	}
	
	@Override
	public void valueChange(ValueChangeEvent event) {
		
		if (event.getProperty() == resourceBundleProperty.getResourceBundleProp()) updateI18NCaptions();
		
	}
	
	private void setupFieldContainer(Layout container, Map<String, Label> fieldLabelMap, PropertysetItem propertysetItem) {
		for (String field: modelBean.getFieldList()) {
			Label label = new Label();
			fieldLabelMap.put(field, label);
			CheckBox fieldCheckBox = new CheckBox("", propertysetItem.getItemProperty(field));

			container.addComponent(label);
			container.addComponent(fieldCheckBox);
		}
	}

	private void saveButtonClick(ClickEvent event) {
		System.out.println("Saving ${entityName} portlet preferences... [" + modelBean + "]");
		
		try {
			syncFieldPropertysetItemPrefs(modelBean.getPropSearchFieldMap(), "searchFields");
			syncFieldPropertysetItemPrefs(modelBean.getPropRegistryFieldMap(), "registryFields");
			syncFieldPropertysetItemPrefs(modelBean.getPropResultFieldMap(), "resultFields");
			
			PortletRequest portletRequest = applicationModelBean.getPortletRequest();
			
			portletRequest.getPreferences().setValue("rowsPerPage", modelBean.getPropRowsPerPage().getValue().toString());
			portletRequest.getPreferences().setValue("nColsSearch", modelBean.getPropNColsSearch().getValue().toString());
			portletRequest.getPreferences().setValue("nColsRegistry", modelBean.getPropNColsRegistry().getValue().toString());
			
			portletRequest.getPreferences().store();
			
			VaadinNotificationUtil.notificationInfo(this, 
					resourceBundleProperty.getString("edit.save.msg.success"), "");
			
		} catch (Exception ex) {
			System.out.println("error saving ${entityName} portlet preferences: " + ex.getMessage());
			
			VaadinNotificationUtil.notificationError(this, 
					resourceBundleProperty.getString("edit.save.msg.fail"), "");
		}
	}
	
	private void resetButtonClick(ClickEvent event) {
		System.out.println("Reset ${entityName} portlet preferences");
		
		try {
			PortletRequest portletRequest = applicationModelBean.getPortletRequest();
			
			portletRequest.getPreferences().reset("searchFields");
			portletRequest.getPreferences().reset("resultFields");
			portletRequest.getPreferences().reset("registryFields");
			portletRequest.getPreferences().reset("rowsPerPage");
			portletRequest.getPreferences().reset("nColsSearch");
			portletRequest.getPreferences().reset("nColsRegistry");
			
			modelBean.init(portletRequest);
			
		} catch (Exception ex) {
			System.out.println("error resetting ${entityName} portlet preferences: " + ex.getMessage());
	
			VaadinNotificationUtil.notificationError(this, 
					resourceBundleProperty.getString("edit.reset.msg.fail"), "");
		}
	}

	private void searchFieldsSelectAllButtonClick(ClickEvent event) {
		System.out.println("searchFieldsSelectAllButton clicked!!!");
		
		for (Object id : modelBean.getPropSearchFieldMap().getItemPropertyIds()) {
			modelBean.getPropSearchFieldMap().getItemProperty(id).setValue(true);
		}
	}
	
	private void searchFieldsDeselectAllButtonClick(ClickEvent event) {
		System.out.println("searchFieldsDeselectAllButton clicked!!!");
		
		for (Object id : modelBean.getPropSearchFieldMap().getItemPropertyIds()) {
			modelBean.getPropSearchFieldMap().getItemProperty(id).setValue(false);
		}
	}
	
	private void registryFieldsSelectAllButtonClick(ClickEvent event) {
		System.out.println("registryFieldsSelectAllButton clicked!!!");
		
		for (Object id : modelBean.getPropRegistryFieldMap().getItemPropertyIds()) {
			modelBean.getPropRegistryFieldMap().getItemProperty(id).setValue(true);
		}
	}
	
	private void registryFieldsDeselectAllButtonClick(ClickEvent event) {
		System.out.println("registryFieldsDeselectAllButton clicked!!!");
		
		for (Object id : modelBean.getPropRegistryFieldMap().getItemPropertyIds()) {
			modelBean.getPropRegistryFieldMap().getItemProperty(id).setValue(false);
		}
	}
	
	private void resultFieldsSelectAllButtonClick(ClickEvent event) {
		System.out.println("resultFieldsSelectAllButton clicked!!!");
		
		for (Object id : modelBean.getPropResultFieldMap().getItemPropertyIds()) {
			modelBean.getPropResultFieldMap().getItemProperty(id).setValue(true);
		}
	}
	
	private void resultFieldsDeselectAllButtonClick(ClickEvent event) {
		System.out.println("resultFieldsDeselectAllButton clicked!!!");
		
		for (Object id : modelBean.getPropResultFieldMap().getItemPropertyIds()) {
			modelBean.getPropResultFieldMap().getItemProperty(id).setValue(false);
		}
	}
	
	private void syncFieldPropertysetItemPrefs(PropertysetItem source, String prefName) throws Exception {
		List<String> curFields = new ArrayList<String>();
		for (Object id : source.getItemPropertyIds()) {
			if ((Boolean) source.getItemProperty(id).getValue()) {
				curFields.add((String) id);
			}
		}
		
		String[] curFieldArr = new String[curFields.size()];
		curFields.toArray(curFieldArr);
		
		PortletRequest portletRequest = applicationModelBean.getPortletRequest();
		
		portletRequest.getPreferences().setValues(prefName, curFieldArr);
	}
	
	private void updateI18NFieldLabelMap(Map<String, Label> fieldLabelMap) {
		for (Entry<String, Label> entry: fieldLabelMap.entrySet()) {
			entry.getValue().setValue(resourceBundleProperty.getString("${entityName}.field." + entry.getKey()));
		}
	}
	
	private void updateI18NCaptions() {
		headerLabel.setValue("<h2 style='background:#57a700;color:#fff;font-size:20px'>" + 
				resourceBundleProperty.getString("${entityName}.edit.header") +
				"</h2>");
		
		searchFieldsTab.setCaption(resourceBundleProperty.getString("searchFields"));
		updateI18NFieldLabelMap(searchFieldLabelMap);
		
		searchFieldsOptionsTab.setCaption(resourceBundleProperty.getString("searchFieldsOptions"));
		nColsSearchLabel.setCaption(resourceBundleProperty.getString("columnNumber"));
		
		registryFieldsTab.setCaption(resourceBundleProperty.getString("registryFields"));
		updateI18NFieldLabelMap(registryFieldLabelMap);
		
		registryFieldsOptionsTab.setCaption(resourceBundleProperty.getString("registryOptions"));
		nColsRegistryLabel.setCaption(resourceBundleProperty.getString("columnNumber"));
		
		resultFieldsTab.setCaption(resourceBundleProperty.getString("resultFields"));
		updateI18NFieldLabelMap(resultFieldLabelMap);
		
		resultFieldsOptionsTab.setCaption(resourceBundleProperty.getString("resultOptions"));
		rowsPerPageLabel.setCaption(resourceBundleProperty.getString("rowsPerPage"));
		
		searchFieldsSelectAllButton.setCaption(resourceBundleProperty.getString("button.selectAll"));
		searchFieldsDeselectAllButton.setCaption(resourceBundleProperty.getString("button.deselectAll"));
		registryFieldsSelectAllButton.setCaption(resourceBundleProperty.getString("button.selectAll"));
		registryFieldsDeselectAllButton.setCaption(resourceBundleProperty.getString("button.deselectAll"));
		resultFieldsSelectAllButton.setCaption(resourceBundleProperty.getString("button.selectAll"));
		resultFieldsDeselectAllButton.setCaption(resourceBundleProperty.getString("button.deselectAll"));
		
		resetButton.setCaption(resourceBundleProperty.getString("button.reset"));
		saveButton.setCaption(resourceBundleProperty.getString("button.save"));
	}
}
