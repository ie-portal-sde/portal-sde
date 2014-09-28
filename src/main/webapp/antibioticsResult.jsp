<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<title>抗生素系统返回结果页面</title>
<meta http-equiv="content-type" content="text/html; charset=GBK">
</head>

<script language="javascript">
<%	request.setCharacterEncoding("UTF-8");
	String value = request.getParameter("name");
%>
	window.parent.setAntibicticsReturnResult("<%=value%>");
</script>

<body>
</body>
</html>
