package ${viewUtilPackage};

import com.vaadin.data.Property;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Button.ClickListener;
import com.vaadin.ui.ComboBox;
import com.vaadin.ui.Component;
import com.vaadin.ui.GridLayout;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Layout;
import com.vaadin.ui.VerticalLayout;

public class VaadinComponentUtil {

	private VaadinComponentUtil() {	}
	
	public static Button setupButton(ClickListener clickListener) {
		Button button = new Button();
		button.addListener(clickListener);
		
		return button;
	}
	
	public static GridLayout setupGridContainer(int cols, int rows, Component ... components) {
		GridLayout container = new GridLayout(cols, rows);
		container.setWidth("100%");
		container.setSpacing(true);
		container.setMargin(true);
		
		for (Component component : components) {
			container.addComponent(component);
		}
		
		return container;
	}
	
	public static Layout setupVerticalContainer(Component ... components) {
		VerticalLayout container = new VerticalLayout();
		container.setWidth("100%");
		container.setSpacing(true);
		
		for (Component component : components) {
			container.addComponent(component);
		}
		
		return container;
	}
	
	public static Layout setupVerticalContainer(boolean useSpacing, Component ... components) {
		VerticalLayout container = new VerticalLayout();
		container.setWidth("100%");
		container.setSpacing(useSpacing);
		
		for (Component component : components) {
			container.addComponent(component);
		}
		
		return container;
	}
	
	public static Layout setupHorizontalContainer(Component ... components) {
		HorizontalLayout container = new HorizontalLayout();
		container.setSpacing(true);
		container.setMargin(true);
		for (Component component : components) {
			container.addComponent(component);
			container.setComponentAlignment(component, Alignment.MIDDLE_CENTER);
		}
		
		return container;
	}
	
	public static Layout setupHorizontalContainer(boolean useSpacing, boolean useMargin, Component ... components) {
		HorizontalLayout container = new HorizontalLayout();
		container.setSpacing(useSpacing);
		container.setMargin(useMargin);
		for (Component component : components) {
			container.addComponent(component);
			container.setComponentAlignment(component, Alignment.MIDDLE_CENTER);
		}
		
		return container;
	}
	
	public static ComboBox setupComboBox(Property propertyDataSource, Object initValue, Object ... items) {
		ComboBox comboBox = new ComboBox();
		
		comboBox.setNewItemsAllowed(false);
		comboBox.setNullSelectionAllowed(false);
		comboBox.setImmediate(true);
		comboBox.setWidth("90px");
		
		for (Object item : items) {
			comboBox.addItem(item);
		}
		
		comboBox.setValue(initValue);
		
		if (propertyDataSource != null) {
			comboBox.setPropertyDataSource(propertyDataSource);
		}
		
		return comboBox;
	}
}
