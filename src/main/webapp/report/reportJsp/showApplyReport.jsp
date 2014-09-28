<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.usermodel.Context"%>
<%@ page import="com.runqian.report4.util.ReportUtils"%>
<%@ page import="com.runqian.report4.usermodel.IReport"%>
<%@ page import="net.carefx.cpoe.web.server.util.AnalysisXmlGetSavePath"%>

<html>
<head>
<jsp:include page="/report/reportJsp/include_head.jsp"/>
</head>

<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
	Enumeration names = request.getParameterNames();
	while (names.hasMoreElements())
	{
	    String name = (String)names.nextElement();
	    out.println("<input type='hidden' id='" + name + "' name='" + name + "' value='" + request.getParameter(name) + "'>");
	}
%>

<%
	request.setCharacterEncoding("utf-8");
	String fileName = request.getParameter("raq");
	String reportFileHome=Context.getInitCtx().getMainDir();
	StringBuffer param=new StringBuffer();
	
	//保证报表名称的完整性
	int iTmp = 0;
	if( (iTmp = fileName.lastIndexOf(".raq")) <= 0 ){
		fileName = fileName + ".raq";
		iTmp = 0;
	}
	File reportFilePath = AnalysisXmlGetSavePath.getSavePath(application.getRealPath(""));
	session.setAttribute("reportPath", reportFilePath.getPath() + File.separator + fileName);
	File path = new File(reportFileHome);
	Enumeration paramNames = request.getParameterNames();
	if(paramNames!=null){
		while(paramNames.hasMoreElements()){
			String paramName = (String) paramNames.nextElement();
			String paramValue=request.getParameter(paramName);
			if(paramValue!=null){
				//把参数拼成name=value;name2=value2;.....的形式
				param.append(paramName).append("=").append(paramValue).append(";");
			}
		}
	}

	//以下代码是检测这个报表是否有相应的参数模板
	String paramFile = fileName.substring(0,iTmp)+"_arg.raq";
	File f = null;
	if (path.isAbsolute())
	{
	    f = new File(reportFileHome+ File.separator +paramFile);
	}
	else
	{
	    f = new File(application.getRealPath(reportFileHome+ File.separator +paramFile));
	}
%>

<table id="rpt" align="center"><tr><td>
<%	//如果参数模板存在，则显示参数模板
	if( f.exists() ) {
	%>
	<table id="param_tbl" width="100%" height="100%"><tr><td>
		<report:param name="form1" paramFileName="<%=paramFile%>"
			needSubmit="no"
			params="<%=param.toString()%>"
			
		/>
	</td>
	<td><a href="javascript:_submit( form1 )"><img src="/report/images/query.jpg"%>" border=no style="vertical-align:middle"></a></td>
	</tr></table>
	<% }
%>

<table align="center" width="100%" height="100%">
	<tr><td>
		<report:html name="report1" reportFileName="<%=fileName%>"
			firstPageLabel=""
			prevPageLabel=""
			pageMarkLabel=""
			nextPageLabel=""
			lastPageLabel=""
			promptAfterSave="no"
			generateParamForm="no"
			submit=""
			params="<%=param.toString()%>"
			exceptionPage="/report/reportJsp/myError2.jsp"/>
	</td></tr>
</table>
</body>
</html>
