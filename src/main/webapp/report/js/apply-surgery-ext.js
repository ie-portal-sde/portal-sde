function bindMyReportEvent(table, cell, editor) {
	$(editor).unautocomplete();
	var cellName = $(cell).attr("name");	
	if ("leadDoc" == cellName || "firstHelper" == cellName || "secondHelper" == cellName) {
		$(editor).select();
		$(editor).focus().autocomplete(basePath + "/cpoe/surgeryApply.do?action=getDoctorList", getReturnOption(table,cell));
	}
	else if ("icd9Name" == cellName)
	{
		$(editor).select();
		$(editor).focus().autocomplete(basePath + "/cpoe/surgeryApply.do?action=getICD9Info", getReturnOption(table,cell));
	}
}