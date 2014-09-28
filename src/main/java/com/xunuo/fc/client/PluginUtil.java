package com.xunuo.fc.client;

import net.carefx.fc.common.contant.cpoe.FcConstants;
import net.carefx.fc.common.contant.sde.SdeSysParam;
import net.carefx.fc.component.editor.client.data.ArgModel;
import net.carefx.fc.component.editor.client.data.EditorClientConstants;
import net.carefx.fc.component.editor.client.jsni.JSActiveX;
import net.carefx.framework.container.client.context.AppContext;
import net.carefx.framework.queue.client.InvokeTask;

import com.extjs.gxt.ui.client.Registry;
import com.extjs.gxt.ui.client.event.BaseEvent;
import com.extjs.gxt.ui.client.event.Events;
import com.extjs.gxt.ui.client.event.Listener;
import com.extjs.gxt.ui.client.widget.Dialog;

public  final class PluginUtil {
	private static final String activeID = "activex_check";
    // 打开下载对话框
    private static boolean IS_NEED_OPEN_DIALOG = true;
    private static boolean IS_FISTER_TIME_OPEN_DIALOG = true;
    
    /**
     * 获取下载路径
     * 
     * @param paramKey
     * @return
     */
    private String getPluginPath (String paramKey)
    {
        String plugin_path = null;
        try
        {
            plugin_path = AppContext.get ().getConfiguration ().get (paramKey);
        }
        catch (Exception ex)
        {
            return null;
        }
        return plugin_path;
    }
	/**
     * 创建更新电子病历编辑器
     */
    public static boolean createOrupdatePlugin (Listener<BaseEvent> listener)
    {
//    	ctl_system_fc_emr_activex_update_url
    	Registry.register(EditorClientConstants.SATURN_UPDATE_URL, FcPotalParamUtil.getActiveXUpdateUrl());
  		Registry.register(EditorClientConstants.SATURN_DOWN_URL, FcPotalParamUtil.getActiveXUpdateUrl());
        // 是否安装
        boolean intalledCxfPlugin = intalledCxfPlugin ();
        boolean installedJre = intalledJre ();
        try
        {
            if (IS_FISTER_TIME_OPEN_DIALOG && (!intalledCxfPlugin || !installedJre))
            {
                IS_NEED_OPEN_DIALOG = true;
                showDownloadDialog (intalledCxfPlugin, installedJre,listener);
            }
            else if (intalledCxfPlugin)
            {
                IS_NEED_OPEN_DIALOG = false;
            }
        }
        catch (Exception e)
        {
            // Info.display ("提示信息", "编辑器未安装或编辑器更新失败！");
        }
        return IS_NEED_OPEN_DIALOG;
    }
    
    /**
     * 打开对话框
     */
    private static void showDownloadDialog (boolean installedCxf, boolean uninstalledJre, Listener<BaseEvent> listener)
    {
        Dialog dialog = new DownloadDialog (installedCxf, uninstalledJre);
        dialog.addListener(Events.Hide,listener);
        dialog.show ();
    }
	/**
     * 安装cxf插件，如果没有，安装，如果存在，跳过该步骤
     */
    private static boolean intalledCxfPlugin ()
    {
        // 是否下载,如果不下载，表示已经安装
        String isDownload = AppContext.get ().getConfiguration ()
                                      .get (SdeSysParam.CTL_SYSTEM_IS_DOWNLOAD_ACTIVEX_PLUGIN);
        if (isDownload == null || !"true".equals (isDownload.toLowerCase ()))
        {
            return true;
        }
        ArgModel<Object> argModel = new ArgModel<Object>();
        argModel.set("pluginVersion", "2.9");
        return JSActiveX.getInstance().installedActivex (activeID + "_containerID", activeID,argModel.toString(), 0, 0);
    }
	/**
     * 安装jre，如果没有，安装，如果存在，跳过该步骤
     */
    private static boolean intalledJre ()
    {
        // 是否下载,如果不下载，表示已经安装
        String isDownload = AppContext.get ().getConfiguration ().get (FcConstants.CTL_SYSTEM_IS_DOWNLOAD_JRE_PLUGIN);
        if (isDownload == null || !"true".equals (isDownload.toLowerCase ()))
        {
            return true;
        }
        return checkInstallJre ();
    }


    /**
     * 检查是否安装jre
     * 
     * @return
     */
    public static native boolean checkInstallJre ()
    /*-{
		return $wnd.deployJava.isPluginInstalled();
    }-*/;
}
