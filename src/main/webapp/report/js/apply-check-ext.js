$(document).ready(function(){
	init_PlaceData();
});

function init_PlaceData(){
	
	//检查部位从后台提取数据
	var placeAry = $("#" + rereport_Id).find("td[name='place']");
	if (0 != placeAry.length)
	{
		var _callback = function (data)
		{
			setCheckBoxData(placeAry, data);
			setCheckBoxDisplayValue(placeAry);
			var item = $("#" + rereport_Id).find("td[name='item']:first");
			if ("" != $(item).attr("value"))
			{
				setItemEditorConfig(item, true);
			}
		};
		
		var url = "/cpoe/normalCheckApply.do?action=getCheckItemList&applyTemplateId=" + $("#applyTemplateId").val();
		$.post(url, "", _callback, "json");
	}
}

var currentCell = null;
var currentEditor = null;

function bindMyReportEvent(table, cell, editor)
{
	currentCell = cell;
	currentEditor = editor;
}

var my_RQS_multiSelectOk = RQS_multiSelectOk;

RQS_multiSelectOk = function() {
	var _this = this;
	my_RQS_multiSelectOk.apply(_this);

	if(currentCell==null){
		return;
	}
	
	//选择检查项目时需要清空检查项目的内容
	var itemName = $(currentCell).attr("name");
	if ("place" == itemName)
	{
		var item = $("#" + rereport_Id).find("td[name='item']");
		$(item).html("");
		$(item).attr("value", "");
		setCheckBoxData(item, []);
		setItemEditorConfig(item, false);
	}
} 

//设置可选项目的editorConfig 和显示值
function setItemEditorConfig(obj, displayTextFlag)
{	
	var val = currentEditor.editBox.realValue;
	var checkPointIdStr = $("#" + rereport_Id).find("td[name='place']:first").attr("value");	
	var _callback = function (data)
	{
		setCheckBoxData(obj, data);
		if (displayTextFlag)
		{
			setCheckBoxDisplayValue(obj);
		}
	};
	
	var url = "/cpoe/vibrationCheckApply.do?action=getCheckItemDetailList";
	var paramsStr = "checkPointIdStr=" + val;
	$.post(url, paramsStr, _callback, "json");
}