<%
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
%>
<base href="<%=basePath%>">
<script type="text/javascript" src="/report/jquery-lib/jquery.js"></script>
<script type='text/javascript' src='/report/jquery-lib/jquery.bgiframe.min.js'></script>
<script type='text/javascript' src='/report/jquery-lib/jquery.ajaxQueue.js'></script>
<script type='text/javascript' src='/report/jquery-lib/thickbox-compressed.js'></script>
<script type='text/javascript' src='/report/jquery-lib/jquery.autocomplete.js'></script>
<script type='text/javascript' src='/report/jquery-lib/jquery.json.js'></script>
<link rel="stylesheet" type="text/css" href="/report/jquery-lib/main.css" />
<link rel="stylesheet" type="text/css" href="/report/jquery-lib/jquery.autocomplete.css" />
<link rel="stylesheet" type="text/css" href="/report/jquery-lib/thickbox.css" />