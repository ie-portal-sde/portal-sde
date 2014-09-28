<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/report/jquery-lib/table.css">
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/report/jquery-lib/jquery-plugin/jquery-ui-timepicker-addon.js"></script>
<script src="<%=request.getContextPath()%>/report/jquery-lib/jquery-plugin/jquery.ui.datepicker-zh-CN.js"></script>
<script src="<%=request.getContextPath()%>/report/jquery-lib/jquery-plugin/jquery.ui.timepicker-zh-CN.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
    	getClinicalDepartment();
    	
    	$("#startTime").datetimepicker({
            timeFormat: "HH:mm:ss",
            dateFormat: "yy-mm-dd"
    	});
    	
    	$("#endTime").datetimepicker({
            timeFormat: "HH:mm:ss",
            dateFormat: "yy-mm-dd"
    	});
    	
    	$("#statisticBtn").click(function(){
    		$("#qcreportForm").attr("action","<%=request.getContextPath()%>/qcreport/findQCReport.do");
    		$("#qcreportForm").submit();
    	});
    	
    	$("#exportExcelBtn").click(function(){
    		$("#qcreportForm").attr("action","<%=request.getContextPath()%>/qcreport/exportQCReportToExcel.do");
    		$("#qcreportForm").submit();
    	});
    	
    	if("${scoreRange}" != ""){
    		$("#scoreRange").val("${scoreRange}");
    	}

    });
    
    function getClinicalDepartment(){
    	$.ajax({
    		url:'<%=request.getContextPath()%>/qcreport/getClinicalDepartment.do',
    		type:'get',
    		dataType:'json',
    		success:function(data){
    			$("#clinicaldepartment").empty();
    			$.each(data,function(index,department){
    				$("#clinicaldepartment").append("<option value='"+ department.id +"'>"+ department.name +"</option>"); 
    			});
    	    	if("${orgId}" != ""){
    	    		$("#clinicaldepartment").val("${orgId}");
    	    	}
    		},
	    	error:function(data) {  
	            alert("加载科室信息错误!"); 
	        }  
    	});
    }
</script>
<title>质控报表</title>
</head>
<body>
    <form id="qcreportForm" action="" method="post">
        <div id="qcreport">
	               科室:<select id="clinicaldepartment" name="orgId"></select>评分范围:<select id="scoreRange" name="scoreRange"><option value="">全部</option><option value="0">自动评分</option><option value="1">手动评分</option></select>
	               统计时间:<input type="text" id="startTime" name="startTime" value="${startTime}"/><input type="text" id="endTime" name="endTime" value="${endTime}"/><input type="button" id="statisticBtn" value="统计"/><input type="button" id="exportExcelBtn" value="导出Excel"/>
	    </div>
	    <input type="hidden" name="systemId" value="10000"/>
    </form>
	<table class="dataintable">
		<thead>
			<tr>
				<th rowspan="2"><div style="width:80px">患者编号</div></th>
				<th rowspan="2"><div style="width:80px">科室</div></th>
				<th rowspan="2"><div style="width:80px">患者姓名</div></th>
				<th rowspan="2"><div style="width:80px">住院号</div></th>
				<th rowspan="2"><div style="width:80px">主要诊断</div></th>
				<th rowspan="2"><div style="width:80px">住院医生</div></th>
				<th rowspan="2"><div style="width:80px">主治医生</div></th>
				<th rowspan="2"><div style="width:80px">主任医生</div></th>
				<c:forEach items="${items}" var="item">
					<c:set var="subitemlists" value="${subitemMap[item.itemId]}"></c:set>
					<c:set var="subitemsize" value="${fn:length(subitemlists)}">
					</c:set>
					<th id="${item.itemId}" colspan="${subitemsize}">${item.itemName}</th>
				</c:forEach>
				<th rowspan="2">扣分</th>
				<th rowspan="2">总分</th>
			</tr>
			<tr>
				<c:forEach items="${items}" var="item">
					<c:set var="subitemlists" value="${subitemMap[item.itemId]}">
					</c:set>
					<c:forEach items="${subitemlists}" var="subitem">
						<th id="${subitem.subItemId}"><div style="width:380px;height:80px;">${subitem.subItemName}</div></th>
					</c:forEach>
				</c:forEach>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${visitDetails}" var="visitDetail">
				<tr>
					<td>${visitDetail.inPatientId}</td>
					<td>${visitDetail.orgName}</td>
					<td>${visitDetail.patientName}</td>
					<td>${visitDetail.mrn}</td>
					<td>${visitDetail.diagName}</td>
					<td>${visitDetail.hospitalDoctorName}</td>
					<td>${visitDetail.attendingDoctorName}</td>
					<td>${visitDetail.directorDoctorName}</td>
					<c:forEach items="${items}" var="item">
						<c:set var="subitemlists" value="${subitemMap[item.itemId]}">
						</c:set>
						<c:forEach items="${subitemlists}" var="subitem">
							<c:set var="currentSubItemKey"
								value="${visitDetail.inPatientId}:${item.itemId}:${subitem.subItemId}"></c:set>
							<td>${scoreDetails[currentSubItemKey]}</td>
						</c:forEach>
					</c:forEach>
					<c:set var="currentDefectTotalScore"
								value="${visitDetail.inPatientId}${'_totalDefectScore'}"></c:set>
					<c:set var="currentScore"
								value="${visitDetail.inPatientId}${'_score'}"></c:set>
					<td>${patientScoreDetails[currentDefectTotalScore]}</td>
					<td>${patientScoreDetails[currentScore]}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>