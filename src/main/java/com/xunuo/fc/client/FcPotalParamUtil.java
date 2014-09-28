package com.xunuo.fc.client;

import net.carefx.fc.common.contant.cpoe.FcConstants;
import net.carefx.fc.common.contant.sde.SdeSysParam;
import net.carefx.framework.container.client.context.AppContext;

public class FcPotalParamUtil
{
	public static String getActiveXDownloadUrl()
	{
		return getPluginPath(SdeSysParam.CTL_SYSTEM_EMR_ACTIVEX_DOWNLOAD_URL);
	}
	
	public static String getActiveXUpdateUrl()
	{
		return getPluginPath("sde/ctl_system_fc_emr_activex_update_url");
	}
	
	public static String getJaveJreDownUrl()
	{
		return getPluginPath(FcConstants.CTL_SYSTEM_EMR_JRE_DOWNLOAD_URL);
	}
	
	 /**
     * 获取下载路径
     * 
     * @param paramKey
     * @return
     */
    public static String getPluginPath (String paramKey)
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
}
