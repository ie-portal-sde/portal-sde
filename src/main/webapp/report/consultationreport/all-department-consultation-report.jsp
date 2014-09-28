<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/report/jquery-lib/jquery-ui.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/report/jquery-lib/table.css">
<script src="<%=request.getContextPath()%>/report/jquery-lib/jquery-1.9.1.js"></script>
<script src="<%=request.getContextPath()%>/report/jquery-lib/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/report/jquery-lib/jquery-plugin/jquery-ui-timepicker-addon.js"></script>
<script src="<%=request.getContextPath()%>/report/jquery-lib/jquery-plugin/jquery.ui.datepicker-zh-CN.js"></script>
<script src="<%=request.getContextPath()%>/report/jquery-lib/jquery-plugin/jquery.ui.timepicker-zh-CN.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
    	$("#startTime").datetimepicker({
            timeFormat: "HH:mm:ss",
            dateFormat: "yy-mm-dd"
    	});
    	
    	$("#endTime").datetimepicker({
            timeFormat: "HH:mm:ss",
            dateFormat: "yy-mm-dd"
    	});
    	
    	$("#statisticBtn").click(function(){
    		$("#consultationReportForm").attr("action","<%=request.getContextPath()%>/consultationreport/findAllDepartmentConsultationReport.do");
    		$("#consultationReportForm").submit();
    	});
    	
    	$("#exportExcelBtn").click(function(){
    		$("#consultationReportForm").attr("action","<%=request.getContextPath()%>/consultationreport/exportAllDepartmentReportToExcel.do");
    		$("#consultationReportForm").submit();
    	});
    });
    
</script>
<title>全院科室会诊报表</title>
</head>
<body>
    <form id="consultationReportForm" action="" method="post">
        <div>
	               会诊申请时间:<input type="text" id="startTime" name="startTime" value="${startTime}"/><input type="text" id="endTime" name="endTime" value="${endTime}"/><input type="button" id="statisticBtn" value="统计"/><input type="button" id="exportExcelBtn" value="导出Excel"/>
	    </div>
    </form>
	<table class="dataintable">
		<thead>
			<tr>
				<th rowspan="2">科室</th>
				<th rowspan="2">申请会诊数</th>
				<th colspan="5">会诊数</th>
				<th colspan="4">响应情况</th>
			</tr>
			<tr>
				<th>主任医师会诊数</th>
				<th>主治医师会诊数</th>
				<th>住院医师会诊数</th>
				<th>其它医师会诊数</th>
				<th>合计</th>
				<th>及时响应数</th>
				<th>未响应数</th>
				<th>延迟响应数</th>
				<th>及时响应率</th>
			</tr>
		</thead>
		<tbody>
		    <c:forEach items="${commonInfos}" var="commonInfo">
		        <tr>
		            <td>${commonInfo.departmentName}</td>
		            <td>${commonInfo.applyCount}</td>
		            <td>${commonInfo.directorCount}</td>
		            <td>${commonInfo.indicationCount}</td>
		            <td>${commonInfo.hospitalCount}</td>
		            <td>${commonInfo.otherCount}</td>
		            <td>${commonInfo.totalCount}</td>
		            <c:set var="responseInfo" value="${responseInfos[commonInfo.departmentId]}"></c:set>
		            <td>${responseInfo.timelyCount}</td>
		            <td>${responseInfo==null?commonInfo.totalCount:responseInfo.noResponseCount}</td>
		            <td>${responseInfo.deplayCount}</td>
		            <c:choose>
		                <c:when test="${commonInfo.totalCount == 0}">
		                    <td>0</td>
		                </c:when>
		                <c:otherwise>
		                    <td><fmt:formatNumber value="${(responseInfo.timelyCount/commonInfo.totalCount)*100}" pattern="#.##"/></td>
		                </c:otherwise>
		    	    </c:choose>
		    	</tr>
		    </c:forEach>
		</tbody>
	</table>
</body>
</html>