<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<body bgcolor="#dfe8f6">
	<%
			request.setCharacterEncoding("UTF-8");
	    String fieldLabel = request.getParameter("fieldLabel");
				if (null == fieldLabel) {
					fieldLabel = "请输入密码";
				} else {
				  fieldLabel = java.net.URLDecoder.decode(fieldLabel, "UTF-8");
				}

				String labelAlign = request.getParameter("labelAlign");
				if (null == labelAlign) {
					labelAlign = "left";
				}

				int labelWidth = Integer.parseInt(request
						.getParameter("labelWidth"));
				int removeWidth = Integer.parseInt(request
						.getParameter("removeWidth"));
	%>
	<label
		style="width: <%=labelWidth%>px; text-align:<%=labelAlign%>; display:block; float: left; padding-top:6px; padding-right: 3px; font-family: Arial Unicode MS, Arial, sans-serif; font-size: small; font: 12px tahoma, arial, helvetica, sans-serif;"><%=fieldLabel%>:</label>
	<input id="commitPassword" name="commitPassword" type="password"
		onkeyup="commitPasswordKeyUp(this)">
</body>

<script type="text/javascript">
	
	function commitPasswordKeyUp(obj) {
		var keyCode = event.keyCode;
		parent.passwordFieldKeyUpEventWithNative("" + keyCode);
	}

	var width = document.body.clientWidth - <%=labelWidth%> - <%=removeWidth%> - 4;
	document.getElementById("commitPassword").style.width = width + "px";
	document.getElementById("commitPassword").focus();
</script>
</html>