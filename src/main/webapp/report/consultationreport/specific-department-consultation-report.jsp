<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
//     	getClinicalDepartment();
    	
    	$("#startTime").datetimepicker({
            timeFormat: "HH:mm:ss",
            dateFormat: "yy-mm-dd"
    	});
    	
    	$("#endTime").datetimepicker({
            timeFormat: "HH:mm:ss",
            dateFormat: "yy-mm-dd"
    	});
    	
    	$("#statisticBtn").click(function(){
    		$("#consultationReportForm").attr("action","<%=request.getContextPath()%>/consultationreport/findSpecificDepartmentConsultationReport.do");
    		$("#consultationReportForm").submit();
    	});
    	
    	$("#exportExcelBtn").click(function(){
    		$("#consultationReportForm").attr("action","<%=request.getContextPath()%>/consultationreport/exportSpecificDepartmentReportToExcel.do");
    		$("#consultationReportForm").submit();
    	});
    	
		var applyCountTotal = 0;
		var consultationCountTotal = 0;
		var timelyCountTotal = 0;
		var noResponseCountTotal = 0;
		var delayCountTotal = 0;
		var count = 0;
		var timelyResponseRatioTotal =0;
		
    	$(".dataintable tr").each(function () {  
    		$(this).find("td:eq(1):not(#applyCount_total)").each(function () {
    			applyCountTotal += getNumValue($(this));
                $("#applyCount_total").html(applyCountTotal);
    		});
    		
    		$(this).find("td:eq(2):not(#consultationCount_total)").each(function () {
    			consultationCountTotal += getNumValue($(this));
                $("#consultationCount_total").html(consultationCountTotal);
    		});
    		
    		$(this).find("td:eq(3):not(#timelyCount_total)").each(function () {
    			timelyCountTotal += getNumValue($(this));
                $("#timelyCount_total").html(timelyCountTotal);
    		});
    		
    		$(this).find("td:eq(4):not(#noResponseCount_total)").each(function () {
    			noResponseCountTotal += getNumValue($(this));
                $("#noResponseCount_total").html(noResponseCountTotal);
    		});
    		
    		$(this).find("td:eq(5):not(#delayCount_total)").each(function () {
    			delayCountTotal += getNumValue($(this));
                $("#delayCount_total").html(delayCountTotal);
    		});
    		
    		$(this).find("td[id='timelyResponseRatio']").html((timelyCountTotal*100/consultationCountTotal).toFixed(2));
    		
    		$(this).find("td:eq(6):not(#timelyResponseRatio_total)").each(function () {
    			count++;
    			timelyResponseRatioTotal += getNumValue($(this));
        		$("#timelyResponseRatio_total").html((timelyResponseRatioTotal/count).toFixed(2));
    		});
    	});
    	
    	if("${departmentId}" != ""){
	    	$("#clinicaldepartment").val("${departmentId}");
	    }

    });
    
    function getNumValue(controlid) {
    	if(controlid.html() != ''){
        	var num = controlid.html();
        	return parseInt(num);
        }
        return 0;
    }
    
    
    
    
//     function getClinicalDepartment(){
//     	$.ajax({
<%--     		url:'<%=request.getContextPath()%>/consultationreport/getClinicalDepartment.do', --%>
//     		type:'get',
//     		dataType:'json',
//     		success:function(data){
//     			$("#clinicaldepartment").empty();
//     			$.each(data,function(index,department){
//     				$("#clinicaldepartment").append("<option value='"+ department.id +"'>"+ department.name +"</option>"); 
//     			});
//     	    	if("${departmentId}" != ""){
//     	    		$("#clinicaldepartment").val("${departmentId}");
//     	    	}
//     		},
// 	    	error:function(data) {  
// 	            alert("加载科室信息错误!"); 
// 	        }  
//     	});
//     }
    
</script>
<title>科内会诊报表</title>
</head>
<body>
    <form id="consultationReportForm" action="" method="post">
        <div>
          <!--科室:<select id="clinicaldepartment" name="departmentId"></select>-->
         <input id="clinicaldepartment" type="hidden" name="departmentId" value="${param.orgId}"/>
	               会诊申请时间:<input type="text" id="startTime" name="startTime" value="${startTime}"/><input type="text" id="endTime" name="endTime" value="${endTime}"/><input type="button" id="statisticBtn" value="统计"/><input type="button" id="exportExcelBtn" value="导出Excel"/>
	    </div>
    </form>
	<table class="dataintable">
		<thead>
			<tr>
				<th>医生</th>
				<th>申请会诊数</th>
				<th>会诊数</th>
				<th>及时响应数</th>
				<th>未响应数</th>
				<th>延迟响应数</th>
				<th>及时响应率</th>
			</tr>
		</thead>
		<tbody>
		    <c:forEach items="${responseInfos}" var="responseInfo">
		        <tr>
		          <td>${responseInfo.employeeName}</td>
		          <td>${responseInfo.applyCount==null?0:responseInfo.applyCount}</td>
		          <td>${responseInfo.totalCount==null?0:responseInfo.totalCount}</td>
		          <td>${responseInfo.timelyCount==null?0:responseInfo.timelyCount}</td>
		          <td>${responseInfo.noResponseCount==null?0:responseInfo.noResponseCount}</td>
		          <td>${responseInfo.deplayCount==null?0:responseInfo.deplayCount}</td>
		          <td id="timelyResponseRatio">${responseInfo.timelyResponseRatio}</td>
		        </tr>
		    </c:forEach>
		    <tr id="consultationtotal">
		       <td>合计</td>
		       <td id="applyCount_total"></td>
		       <td id="consultationCount_total"></td>
		       <td id="timelyCount_total"></td>
		       <td id="noResponseCount_total"></td>
		       <td id="delayCount_total"></td>
		       <td id="timelyResponseRatio_total"></td> 
		    </tr>
		</tbody>
	</table>
</body>
</html>