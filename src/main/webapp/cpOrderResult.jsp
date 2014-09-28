<%@ page contentType="text/html;charset=GBK"%>
<html>
<head>
<title>CP路径系统返回结果页面</title>
<meta http-equiv="content-type" content="text/html; charset=GBK">
</head>

<script language="javascript"><!--
<%request.setCharacterEncoding ("GBK");
            String value = request.getParameter ("result");
            if (value == null)
            {
                value = "addOrder";
            }%>
			window.parent.setCpResult("<%=value%>");
</script>

<body>
</body>
</html>
