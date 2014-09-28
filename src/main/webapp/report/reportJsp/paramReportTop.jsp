<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report"%>
<%
	request.setCharacterEncoding("utf-8");
	String param = request.getParameter("param");
	String paramFileName = request.getParameter("paramFileName");
	String reportFileName = "report/reportJsp/paramReportBelow.jsp?reportFileName="+request.getParameter("reportFileName");
%>
<html>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<table id="param_tbl" width="880" height="100%" align="center">
<tr>
	<td width="800">
		<report:param name="form1" paramFileName="<%=paramFileName%>" needSubmit="no" params="<%=param%>" target="result" resultPage="<%=reportFileName%>"/>
	</td>
	<td width="80">
		<button onclick="_submit( form1 )">&nbsp;&nbsp;查询&nbsp;&nbsp;</button>
	</td>
</tr>
</table>
</body>
</html>