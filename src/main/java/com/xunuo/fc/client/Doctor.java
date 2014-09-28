package com.xunuo.fc.client;

import net.carefx.fc.component.editor.client.data.EditorClientConstants;
import net.carefx.fc.framework.web.client.FcFramework;
import net.carefx.fc.framework.web.gwt.util.MenuTreeUtil;
import net.carefx.fc.framework.web.gwt.util.SystemName;
import net.carefx.fc.framework.web.plugin.servertime.client.mvc.FcServerTimeController;
import net.carefx.framework.client.task.TaskConstants;
import net.carefx.framework.container.client.context.AppContext;
import net.carefx.framework.container.client.model.MenuTreeModel;
import net.carefx.framework.container.client.plugin.ITabView;
import net.carefx.framework.queue.client.InvokeQueue;
import net.carefx.framework.queue.client.InvokeTask;
import net.carefx.framework.queue.client.InvokeTaskContext;

import com.extjs.gxt.ui.client.GXT;
import com.extjs.gxt.ui.client.Registry;
import com.extjs.gxt.ui.client.event.BaseEvent;
import com.extjs.gxt.ui.client.event.Listener;

/**
 * Entry point classes define <code>onModuleLoad()</code>.
 */
public class Doctor extends FcFramework
{
    @Override
    protected void onFrameworkLoad ()
    {
        super.onFrameworkLoad ();
        // 使用电子病历编辑器时，层覆盖问题
        if (GXT.isIE || GXT.isChrome)
        {
            GXT.useShims = true;
        }
        ITabView tabView = getWorkbench ().getBodyView ().getWorkspace ().getTabView ();
        tabView.setAllowOpenMulitplePage (true);
        
        String imageUrl = "doctor" + "/images/titlebar_logo_doctor.png";
        getWorkbench ().getTitleBar ().setBackgroundImage (imageUrl);
        
        MenuTreeModel menuModel = new MenuTreeModel ("任务列表");
        menuModel.setAllowMultipleOpenPage (false);
        menuModel.setClosable (false);
        menuModel.setCode ("__homepage__");
        menuModel.setCommand ("com.xunuo.framework.xmessage.homepage.client.page.XMessageHomePageEntryPoint");
        getWorkbench ().getBodyView ().getWorkspace ().hideContextView ();
        tabView.openTempPage (menuModel);
        
        MenuTreeModel rootModel = AppContext.get ().getCurrentUser ().getMenuResources ();
        MenuTreeModel firstMenuTreeModel = MenuTreeUtil.findMenu ("_fc_doctor_patient_list", rootModel);
        if (firstMenuTreeModel != null)
        {
            tabView.openTempPage (firstMenuTreeModel);
        }
        
        FcServerTimeController.getInstance ().startTimer ();
    }
    
    @Override
    protected void beforeInitInvokeQueueStart(final InvokeQueue initInvokeQueue) {
    	initInvokeQueue.insertAfterTask(TaskConstants.LOAD_CONFIGURATION_TASK_ID, new InvokeTask() {
			
			@Override
			public void run(final InvokeTaskContext context) 
			{
				GXT.hideLoadingPanel ("loading");
				boolean isShowDialog = PluginUtil.createOrupdatePlugin( new Listener<BaseEvent>() {

					@Override
					public void handleEvent(BaseEvent be) {
						fireSuccess(context);
					}
				});
				if(!isShowDialog)
				{
					fireSuccess(context);
				}
			}
			
			@Override
			public String getTaskId() {
				return "CheckCxfPluginIfInstalled";
			}
		});
    }
    
	protected void onConfigFramework () // 重写onConfigFramework
    {
        AppContext.get ().setSystemName (SystemName.SYSTEMNAME_DOCTOR);// 代表是从index.html进入
    }


}
