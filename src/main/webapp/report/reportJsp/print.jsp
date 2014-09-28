<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.usermodel.Context"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="com.runqian.report4.view.ParamsPool"%>
<%@ page import="com.runqian.report4.util.ReportUtils"%>
<%@ page import="com.runqian.report4.usermodel.IReport"%>
<%@ page import="net.carefx.cpoe.web.server.util.AnalysisXmlGetSavePath"%>

<html>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
	<%
	    String fileName = request.getParameter ("raq");
	    String reportFileHome = Context.getInitCtx ().getMainDir ();
	    File reportFilePath = AnalysisXmlGetSavePath.getSavePath (application.getRealPath (""));
	    session.setAttribute ("reportPath", reportFilePath.getPath () + File.separator + fileName);
	    Hashtable paramsMap = new Hashtable ();
	    Enumeration paramNames = request.getParameterNames ();
	    while (paramNames.hasMoreElements ())
	    {
	        String paramName = (String) paramNames.nextElement ();
	        String paramValue = request.getParameter (paramName);
	        paramsMap.put (paramName, paramValue);
	    }

	    String paramsId = ParamsPool.createParamsId ();
	    ParamsPool.put (paramsId, paramsMap);

	    String url = "/reportServlet?action=2&reportFileName=" + fileName;
	    url += "&srcType=file&savePrintSetup=no&appletJarName=runqianReport4Applet.jar&serverPagedPrint=no&mirror=no&reportParamsId="
	           + paramsId;
	    RequestDispatcher dispatcher = request.getRequestDispatcher (url);
	    System.out.println ("url---------------" + url);
	    dispatcher.forward (request, response);
	%>
</body>
</html>
