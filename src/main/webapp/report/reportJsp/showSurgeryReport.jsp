<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.usermodel.Context"%>
<%@ page import="com.runqian.report4.util.ReportUtils"%>
<%@ page import="com.runqian.report4.usermodel.IReport"%>

<%
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
%>

<html>
<head>
<base href="<%=basePath%>">
<script type="text/javascript" src="<%=basePath%>/report/jquery-lib/jquery.js"></script>
<script type='text/javascript' src='<%=basePath%>/report/jquery-lib/jquery.bgiframe.min.js'></script>
<script type='text/javascript' src='<%=basePath%>/report/jquery-lib/jquery.ajaxQueue.js'></script>
<script type='text/javascript' src='<%=basePath%>/report/jquery-lib/thickbox-compressed.js'></script>
<script type='text/javascript' src='<%=basePath%>/report/jquery-lib/jquery.autocomplete.js'></script>
<script type='text/javascript' src='<%=basePath%>/report/jquery-lib/jquery.json.js'></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/report/jquery-lib/main.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/report/jquery-lib/jquery.autocomplete.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/report/jquery-lib/thickbox.css" />
</head>

<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
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
	
	File path = new File(reportFileHome);
	if (path.isAbsolute())
	{
	    session.setAttribute("reportPath", reportFileHome + File.separator + fileName);
	}
	else
	{
	    session.setAttribute("reportPath", application.getRealPath(reportFileHome + File.separator + fileName));
	}
	
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
			generateParamForm="no"
			submit=""
			params="<%=param.toString()%>"
			exceptionPage="/report/reportJsp/myError2.jsp"/>
	</td></tr>
</table>
</body>

<script type="text/javascript">
	var basePath = "<%=basePath%>";
</script>
<script type='text/javascript' src='<%=basePath%>/report/js/apply-ext.js'></script>
<script type='text/javascript' src='<%=basePath%>/report/js/apply-surgery-ext.js'></script>
</html>
