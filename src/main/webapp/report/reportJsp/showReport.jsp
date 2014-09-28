<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.usermodel.Context"%>
<%@ page import="com.runqian.report4.util.ReportUtils"%>
<%@ page import="com.runqian.report4.usermodel.IReport"%>
<%
    request.setCharacterEncoding ("utf-8");
    String fileName = request.getParameter ("raq");
    String seachPageHeight = request.getParameter ("seachPageHeight");
    if (seachPageHeight == null)
    {
        seachPageHeight = "35";
    }
    String reportFileHome = Context.getInitCtx ().getMainDir ();
    StringBuffer param = new StringBuffer ();

    //保证报表名称的完整性
    int iTmp = 0;
    if ((iTmp = fileName.lastIndexOf (".raq")) <= 0)
    {
        fileName = fileName + ".raq";
        iTmp = 0;
    }

    File path = new File (reportFileHome);
    if (path.isAbsolute ())
    {
        session.setAttribute ("reportPath", reportFileHome + File.separator + fileName);
    }
    else
    {
        session.setAttribute ("reportPath",
                              application.getRealPath (reportFileHome + File.separator + fileName));
    }

    Enumeration paramNames = request.getParameterNames ();
    if (paramNames != null)
    {
        while (paramNames.hasMoreElements ())
        {
            String paramName = (String) paramNames.nextElement ();
            String paramValue = request.getParameter (paramName);
            if (paramValue != null)
            {
                //把参数拼成name=value;name2=value2;.....的形式
                if ("creatorName".equals(paramName))
				{
				    paramValue = java.net.URLDecoder.decode(paramValue, "UTF-8");
				    session.setAttribute("creatorName",paramValue);
				}
                param.append (paramName).append ("=").append (paramValue).append (";");
            }
        }
    }

    //以下代码是检测这个报表是否有相应的参数模板
    String paramFile = fileName.substring (0, iTmp) + "_arg.raq";
    File f = null;
    if (path.isAbsolute ())
    {
        f = new File (reportFileHome + File.separator + paramFile);
    }
    else
    {
        f = new File (application.getRealPath (reportFileHome + File.separator + paramFile));
    }
    String reportFileName = "report/reportJsp/paramReportBelow.jsp?reportFileName=../reportFiles/" + fileName;
    String paramFileName = "../reportFiles/" + paramFile;
%>
<html>
<body topmargin=0 leftmargin=0 scroll=no border=0 rightmargin=0
	bottomMargin=0 align="center">
	<table cellspacing=0 cellpadding=0 align="center" width="100%"
		height="100%" border=0>
		<tr>
			<td height="<%=seachPageHeight%>" width="100%" align="center">
				<table id="param_tbl" width="880" height="100%" align="center">
					<tr>
						<td width="800">
						        <report:param name="form1"
								paramFileName="<%=paramFileName%>" needSubmit="no"
								params="<%=param.toString()%>" target="result"
								resultPage="<%=reportFileName%>" />
						</td>
						<td width="80">
							<a href="javascript:_submit( form1 )"><img src="../images/query.jpg"  border=no style="vertical-align:middle"></a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td><iframe name="result" id="result" marginheight="0"
					marginwidth="0" frameborder="0" border=0 height="100%" width="100%"
					scrolling="yes"
					src="paramReportBelow.jsp?reportFileName=../reportFiles/<%=fileName%>"></iframe>
			</td>
		</tr>
	</table>
	
<script language=javascript> 
	function report1_toPage( pageNo ) {
		document.result.report1_toPage(pageNo);
	}
</script>
<script language=javascript> 
	function report1_getCurrPage() {
		return document.result.report1_getCurrPage();
	}
	function report1_getTotalPage() {
		return document.result.report1_getTotalPage();
	}
	var report1_cachedId = "A_59";
</script>
<script language=javascript> 
	function report1_saveAsExcel() {
		document.result.report1_saveAsExcel();
	}
	function report1_saveAsExcel2( returnVal) {
		document.result.report1_saveAsExcel2(returnVal);
	}
	function report1_saveAsExcel2007() {
		document.result.report1_saveAsExcel2007();
	}
</script>
<script language=javascript> 
	function report1_saveAsPdf() {
		document.result.report1_saveAsPdf();
	}
	function report1_saveAsPdf2( returnVal ) {
		document.result.report1_saveAsPdf2(returnVal);
	}
</script>
 
<script language=javascript> 
	function report1_saveAsWord() {
		document.result.report1_saveAsWord();
	}
</script>
 
<script language=javascript> 
	function report1_saveAsText() {
		document.result.report1_saveAsText();
	}
</script>
 
<script language=javascript> 
	function report1_pivot() {
		document.result.report1_pivot();
	}
</script>
 
<script language=javascript> 
	function report1_print() {
		document.result.report1_print();
	}
</script>
<script language=javascript> 
	function report1_directPrint() {
		document.result.report1_directPrint();
	}
</script>
</body>
</html>