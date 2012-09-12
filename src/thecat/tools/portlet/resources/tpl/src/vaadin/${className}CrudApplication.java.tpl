package ${packageName};

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.EventRequest;
import javax.portlet.EventResponse;
import javax.portlet.PortletMode;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import com.vaadin.Application;
import com.vaadin.data.Property.ValueChangeEvent;
import com.vaadin.data.Property.ValueChangeListener;
import com.vaadin.terminal.gwt.server.PortletApplicationContext2;
import com.vaadin.terminal.gwt.server.PortletApplicationContext2.PortletListener;
import com.vaadin.terminal.gwt.server.PortletRequestListener;
import com.vaadin.ui.Window;

@SuppressWarnings("serial")
public class ${className}CrudApplication extends Application 
	implements PortletListener, PortletRequestListener, ValueChangeListener {
	
	private static final String themeName = "reindeer";
	
	private Window mainWindow;
	
	private ${className}CrudApplicationModelBean modelBean = new ${className}CrudApplicationModelBean();

	@Override
	public void init() {
		setTheme(themeName);
		mainWindow = new Window("${className} Crud Portlet Application");
		setMainWindow(mainWindow);
		
		// start in search mode
		mainWindow.setContent(modelBean.getSearchContent());
		
		if (getContext() instanceof PortletApplicationContext2) {
			PortletApplicationContext2 ctx = (PortletApplicationContext2) getContext();
			ctx.addPortletListener(this, this);
		}
		
		modelBean.getCurrentViewState().addListener(this);
	}
	
	@Override
	public void onRequestStart(javax.portlet.PortletRequest request, javax.portlet.PortletResponse response) {
		
		modelBean.setPortletRequest(request);
		
		if (mainWindow == null) {
			
			modelBean.setEditModelBean(new Edit${className}ModelBean(request));
			modelBean.setSearchModelBean(new Search${className}ModelBean());
			modelBean.setRegistryModelBean(new Registry${className}ModelBean());
			
			modelBean.setEditContent(new Edit${className}Layout(modelBean.getEditModelBean(), modelBean));
			modelBean.setSearchContent(new Search${className}Layout(modelBean.getSearchModelBean(), modelBean));
			modelBean.setRegistryContent(new Registry${className}Layout(modelBean.getRegistryModelBean(), modelBean));

		}
	}
	
	@Override
	public void onRequestEnd(javax.portlet.PortletRequest request, javax.portlet.PortletResponse response) {
		
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void handleEventRequest(EventRequest request,
			EventResponse response, Window window) {
		
		// TODO Auto-generated method stub
		
	}

	@Override
	public void handleRenderRequest(RenderRequest request,
			RenderResponse response, Window window) {
		
		// TODO Auto-generated method stub
		
	}

	@Override
	public void handleActionRequest(ActionRequest request,
			ActionResponse response, Window window) {

		// TODO Auto-generated method stub
		
	}

	@Override
	public void handleResourceRequest(ResourceRequest request,
			ResourceResponse response, Window window) {
		
		modelBean.getResourceBundleProperty().setupLocale(request.getLocale());
				
		 if (request.getPortletMode() == PortletMode.EDIT) {
			 
			 window.setContent(modelBean.getEditContent());
			 
		 } else if (request.getPortletMode() == PortletMode.VIEW) {

			 setupViewStateMainWindow();

		 }
	}

	@Override
	public void valueChange(ValueChangeEvent event) {
		
		setupViewStateMainWindow();
		
	}
	
	private void setupViewStateMainWindow() {
		
		if (modelBean.getCurrentViewState().getValue() == ${className}CrudApplicationModelBean.REGISTRY_VIEW_STATE) { 
		
			mainWindow.setContent(modelBean.getRegistryContent());
			
		} else {
			
			mainWindow.setContent(modelBean.getSearchContent());
			
		}
		
	}
}
