//Add By Mark 2011-10-28 Start
var rereport_Id = "report1";

function _setValue(cellName, value, realValue) { // cellName的格式为report1_C1等，report1为tag的name属性
	var cell = document.getElementById(cellName);
	if (!cell) {
		return false;
	}
	var table = _lookupTable(cell);
	if (!_submitEditor(table)) {
		return false;
	}
	if (document.all)// IE
	{
		cell.setAttribute('value', realValue); // 修改真实值
		cell.innerText = value; // 修改显示值
	} else // FireFox
	{
		cell.setAttribute('value', realValue); // 修改真实值
		cell.textContent = value; // 修改显示值
	}

	if (table.isli) {// 判断当前报表是否为行式报表
		var editingRow = cell.parentElement;
		if (editingRow.status == "0")
			editingRow.status = "1";
		else if (editingRow.status == "2")
			editingRow.status = "3";
		_calcTbl(table, cell);
	}
	return true;
}

var divs = document.getElementsByTagName("DIV");
for ( var i = 0; i < divs.length; i++) {
	if (rereport_Id == divs[i].className) {
		divs[i].style.display = "none";
	}
}
// Add By Mark 2011-10-28 End

// 重写报表的按键事件，屏蔽上、下键事件
function _editorKeyPress() {
	var keyCode = event.keyCode;
	var flag = -1;
	var gotoNext = false;
	var editor = event.srcElement;
	if (keyCode == 39 && event.ctrlKey) { // right
		flag = 3;
		gotoNext = true;
	}
	if (keyCode == 13) {
		flag = 3;
		gotoNext = true;
		if (editor.tagName == "TEXTAREA" && !event.ctrlKey)
			gotoNext = false;
	}
	if (keyCode == 37 && event.ctrlKey) { // left
		flag = 1;
		gotoNext = true;
	}
	if (keyCode == 9) {
		flag = event.shiftKey ? 1 : 3;
		gotoNext = true;
	}
	if (keyCode == 38 || keyCode == 40) {
		if (keyCode == 38)
			flag = 2;
		if (keyCode == 40)
			flag = 4;
		gotoNext = true;
		if (editor.tagName == "TEXTAREA" && !event.ctrlKey)
			gotoNext = false;
		gotoNext = false; // 暂时屏蔽
	}
	if (gotoNext) {
		var cell = _lookupNextCell(editor.editingCell, flag);
		if (cell != null)
			_bindingEditor(cell);
	}
	if (keyCode == 9)
		return false;
	return true;
}

// 扩展表格的编辑器下拉控制
function _bindingEditor(cell) {
	var table = _lookupTable(cell);
	if (!_submitEditor(table))
		return;
	var editor = _lookupEditor(table, cell);
	bindMyReportEvent(table, cell, editor);
	table.currEditor = editor;
	_setRowColBackColor(cell);
	_setEditorStyle(editor, cell);
}

// 自定义报表事件，根据需要重写该方法
function bindMyReportEvent(table, cell, editor) {
}

/*
 * 扩展数据验证功能，统一将数据收集好后发到后台处理
 */
function _validData(validataUrl, action, callback) {
	var _callback = function(data) {
		callback(data.result + "", data.message);
	};
	var data = [];
	$("#" + rereport_Id).find("td[name]").each(function(index, td) {
		$td = $(td);
		var name = $td.attr("name")
		var value = $td.attr("value");
		data.push(name + "=" + value);
	});
	var paramStr = "action=" + action + "&" + data.join("&");
	$.post(validataUrl, paramStr, _callback, "json");
}

// 公用自动填充对象
function getReturnOption(table, cell, minChars, width) {
	minChars = minChars || 1;
	width = width || 150;
	return {
		minChars : minChars,
		width : width,
		matchContains : "word",
		multiple : false,
		parse : function parse(data) {
			var parsed = [];
			var rows = $.evalJSON(data);
			for ( var i = 0; i < rows.length; i++) {
				var row = rows[i];
				parsed[parsed.length] = {
					data : row,
					value : row.code,
					result : row.text
				};
			}
			return parsed;
		},
		formatItem : function(row, i, max) {
			return i + "/" + max + ": " + row.text;
		},
		formatMatch : function(row, i, max) {
			return row.text;
		},
		formatResult : function(row) {
			return row.text;
		},
		selectCallback : function(row) {
			cell.setAttribute('value', row.text);
			var hidden_cell_name = cell.name + "_code";
			$(table).find("td[name=" + hidden_cell_name + "]").attr("value",
					row.code);
		}
	};
}

// 设置checkbox列表值
function setCheckBoxData(obj, ary) {
	var strs = [];
	$(ary).each(function(index, item) {
		strs.push(item.code + "," + item.text);
	});

	var str = strs.join(";");
	$(obj).attr("editConfig", str);
}

// 设置checkBox显示值
function setCheckBoxDisplayValue(ary) {
	$(ary).each(function(index, item) {
		var value = $(item).attr("value");
		var editConfig = $(item).attr("editConfig");
		if("" == value || "" == editConfig)
		{
			return;
		}
		
		if (editConfig.length - 1 != editConfig.lastIndexOf (";"))
		{
			editConfig += ";";
		}

		var valueStr = "";
		var values = value.split(",");
		$(values).each(function(index, subItem){
			subItem = subItem + ",";
			if (-1 != editConfig.indexOf(subItem))
			{
				var otherStr = editConfig.substr(editConfig.indexOf(subItem));
				valueStr += otherStr.substring (otherStr.indexOf(",") + 1, otherStr.indexOf(";")) + ",";
			}
		});
		
		if ("" != valueStr)
		{
			valueStr = valueStr.substr(0, valueStr.length-1);
		}
		$(item).text(valueStr);
	});
}