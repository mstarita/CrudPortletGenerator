package ${packageName};

import org.zkoss.zk.ui.Session;

public interface Registry${className}Action {
	
	void actionRegistryConfirm();

	void actionRegistryCancel();

	void actionRegistryPrint(Session session);
	
}
