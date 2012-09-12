package ${viewUtilPackage};

import com.vaadin.ui.Component;
import com.vaadin.ui.Window.Notification;

public class VaadinNotificationUtil {

	public static void notificationInfo(Component component, String caption, String description) {
        
        component.getWindow().showNotification(
        	caption,
            description,
            Notification.TYPE_HUMANIZED_MESSAGE);

    }

	public static void notificationWarning(Component component, String caption, String description) {
        
        component.getWindow().showNotification(
        	caption,
            description,
            Notification.TYPE_WARNING_MESSAGE);
        
    }

    public static void notificationError(Component component, String caption, String description) {
        
        component.getWindow().showNotification(
        	caption,
            description,
            Notification.TYPE_ERROR_MESSAGE);
        
    }    
}

