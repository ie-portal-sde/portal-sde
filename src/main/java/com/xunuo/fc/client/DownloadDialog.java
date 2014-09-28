package com.xunuo.fc.client;

import net.carefx.framework.client.mvc.WorkbenchEvents;
import net.carefx.framework.container.client.context.AppContext;

import com.extjs.gxt.ui.client.event.ButtonEvent;
import com.extjs.gxt.ui.client.event.SelectionListener;
import com.extjs.gxt.ui.client.mvc.Dispatcher;
import com.extjs.gxt.ui.client.widget.Dialog;
import com.extjs.gxt.ui.client.widget.button.Button;
import com.extjs.gxt.ui.client.widget.layout.FitLayout;

public class DownloadDialog extends Dialog
{   
	private static boolean IS_NEED_OPEN_DIALOG = true;
	private static boolean IS_FISTER_TIME_OPEN_DIALOG = true;
    /** ACTIVEX安装文件路径. */
    public final String ACTIVEX_FILE_PATH =FcPotalParamUtil.getActiveXDownloadUrl();
//    public final String ACTIVEX_FILE_PATH = "http://192.168.1.41:8280/control-update/download.action?fileName=npcfx.msi";
    /** jre安装文件路径. */
    public final String JRE_FILE_PATH =  FcPotalParamUtil.getJaveJreDownUrl();
    private String m_activex_path;
    // private String m_download_html = "help/downloadActivex.html";
    private boolean m_installedCxf;
    private boolean m_installedJre;

    public DownloadDialog (boolean installedCxf, boolean installedJre)
    {
        m_installedCxf = installedCxf;
        m_installedJre = installedJre;
        initUI ();
    }

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

    private String downloadCxfPluginHtml (String url)
    {
        String html = "<br /><div><h2>&nbsp;编辑器控件下载提示:</h2><hr />"
                      + "<span style='font-size: 14px'>&nbsp;&nbsp;&nbsp;&nbsp;您还没有安装电子病历编辑器控件，将不能编辑电子病历</span><br /> <br />"
                      + "<span style='font-size: 14px'>&nbsp;&nbsp;&nbsp;&nbsp;点击<a href='" + url
                      + "'>下载</a>安装电子病历编辑器，点击取消跳过该步骤</span><br /> </div>";
        return html;
    }

    private String downloadJreHtml (String url)
    {
        String html = "<br /><div><h2>&nbsp;JAVA运行环境下载提示:</h2><hr />"
                      + "<span style='font-size: 14px'>&nbsp;&nbsp;&nbsp;&nbsp;您还没有安装JAVA运行环境，将不打印医嘱</span><br /> <br />"
                      + "<span style='font-size: 14px'>&nbsp;&nbsp;&nbsp;&nbsp;点击<a href='" + url
                      + "'>下载</a>安装JAVA运行环境，点击取消跳过该步骤</span><br /> </div>";
        return html;
    }

    public void initUI ()
    {

        setLayout (new FitLayout ());
        setHeading ("系统提示");
        setBorders (false);
        setButtons ("");
        setClosable (false);
        this.setModal (false);

        if (!m_installedCxf && !m_installedJre)
        {
            addText (downloadCxfPluginHtml (ACTIVEX_FILE_PATH) + downloadJreHtml (JRE_FILE_PATH));
            setSize (450, 300);
        }
        else if (!m_installedCxf && m_installedJre)
        {
            addText (downloadCxfPluginHtml (ACTIVEX_FILE_PATH));
            setSize (450, 220);
        }
        else if (m_installedCxf && !m_installedJre)
        {
            addText (downloadJreHtml (JRE_FILE_PATH));
            setSize (450, 220);
        }

        // addButton (createDowanloadBtn ());
        addButton (cancelDowanloadBtn ());
    }

    private Button cancelDowanloadBtn ()
    {
        Button downLoadBtn = new Button ("取消");
        downLoadBtn.addSelectionListener (new SelectionListener <ButtonEvent> ()
        {
            @Override
            public void componentSelected (ButtonEvent ce)
            {
                hide ();
                IS_NEED_OPEN_DIALOG = false;
                Dispatcher.forwardEvent (WorkbenchEvents.DO_LOGIN);

            }
        });
        return downLoadBtn;
    }
}