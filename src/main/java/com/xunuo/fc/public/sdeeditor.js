function doctor_create_return(containerId, activeId, width, height) {
	var div = document.getElementById("editor_plugin_");
	var objstr = '';
	if (window.addEventListener) 
	{
		div.innerHTML = "<embed id='" + activeId
		+ "' type='application/x-cfx' width='" + width + "' height='"
		+ height + "'></embed>";
		// 检查ACTIVEX是否安装
		var obj = document.getElementById(activeId);
//		alert("No IE,obj = " + obj);
		if (("" + obj) == "[object HTMLEmbedElement]") {
			div.hidden = false;
			return false;
		}
		// 已安装
		else {
			return true;
		}
	} else {
		div.innerHTML = "<object id='" + activeId
		+ "' type='application/x-cfx' width='" + width + "' height='"
		+ height + "'></object>";
		// 检查ACTIVEX是否安装
		var obj = document.getElementById(activeId);
//		alert("IE obj = " + obj);
		if (("" + obj) == "[object]") {
			div.hidden = false;
			return false;
		}
		// 已安装
		else {
			return true;
		}
	}
}

function doctor_execute_return(activeId, functionName, args) {
	var div = document.getElementById("editor_plugin_");
	if (window.addEventListener) 
	{
		div.innerHTML = "<embed id='" + activeId
		+ "' type='application/x-cfx' width='" + 0 + "' height='"
		+ 0 + "'></embed>";
	}
	else
	{
		div.innerHTML = "<object id='" + activeId
		+ "' type='application/x-cfx' width='" + 0 + "' height='"
		+ 0 + "'></object>";
	}
	// 检查ACTIVEX是否安装
	var obj = document.getElementById(activeId);
	return eval("obj." + functionName + "(" + args + ")");
}

//禁止退格键在在光标或焦点放到菜单上或者工具条上时
	function forbidBackSpace(e) {   
            var ev = e || window.event; //获取event对象    
           var obj = ev.target || ev.srcElement; //获取事件源  
          var t = obj.type || obj.getAttribute('type'); //获取事件源类型   			  
           //获取作为判断条件的事件类型    
          var vReadOnly = obj.readOnly;   
            var vDisabled = obj.disabled;  		
           //处理undefined值情况    
           vReadOnly = (vReadOnly == undefined) ? false : vReadOnly;   
         vDisabled = (vDisabled == undefined) ? true : vDisabled;  	 
          //当敲Backspace键时，事件源类型为密码或单行、多行文本的，    
          //并且readOnly属性为true或disabled属性为true的，则退格键失效    
           var flag1 = ev.keyCode == 8 && (t == "password" || t == "text" || t == "textarea") && (vReadOnly == true || vDisabled == true);   
           //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效    
          var flag2 = ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea";  
            //判断    
           if (flag2 || flag1) return false;   
       }   
        //禁止后退键 作用于Firefox、Opera   
      document.onkeypress = forbidBackSpace;   
        //禁止后退键  作用于IE、Chrome   
      document.onkeydown = forbidBackSpace;  

