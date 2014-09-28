<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report"%>
<%
	String reportFileName = request.getParameter("reportFileName");
%>
<html>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0 align="center" valign="top">
<table id="param_tbl" width="880" height="100%" align="center">
<tr>
	<td width="800" valign="top" align="center">
<report:html name="report1" reportFileName="<%=reportFileName%>" funcBarLocation="both" needPageMark="no" generateParamForm="no" exceptionPage="../reportJsp/myError2.jsp"/>
	</td>
</tr>
</table>
</body>
</html>