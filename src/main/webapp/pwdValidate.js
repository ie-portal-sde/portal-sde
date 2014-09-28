function testpass(password)
{
 var score = 0;
 if(password == null || password == '' || password == 'undefined'){return -2}
 if (password.length < 4 ) { return -4; }
// if (typeof(username) != 'undefined' && password.toLowerCase() == username.toLowerCase()){return -2}
 score += password.length * 4;
 score += ( repeat(1,password).length - password.length ) * 1;
 score += ( repeat(2,password).length - password.length ) * 1;
 score += ( repeat(3,password).length - password.length ) * 1;
 score += ( repeat(4,password).length - password.length ) * 1;
 if (password.match(/(.*[0-9].*[0-9].*[0-9])/)){ score += 5;}
 if (password.match(/(.*[!,@,#,$,%,^,&,*,?,_,~].*[!,@,#,$,%,^,&,*,?,_,~])/)){ score += 5 ;}
 if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)){ score += 10;}
 if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/)){ score += 15;}
 if (password.match(/([!,@,#,$,%,^,&,*,?,_,~])/) && password.match(/([0-9])/)){ score += 15;}
 if (password.match(/([!,@,#,$,%,^,&,*,?,_,~])/) && password.match(/([a-zA-Z])/)){score += 15;}
 if (password.match(/^w+$/) || password.match(/^d+$/) ){ score -= 10;}
 if ( score < 0 ){score = 0;}
 if ( score > 100 ){ score = 100;}
 return score;
 
 function repeat(len,str)
 {
  var res = ""; 
  for (var i = 0; i < str.length; i++ ) 
  { 
   var repeated = true; 
   for (var j = 0, max = str.length - i - len; j < len && j < max; j++)
   {
    repeated = repeated && (str.charAt(j + i) == str.charAt(j + i + len)); 
   } 
   if (j < len) repeated = false;
   if (repeated) { 
    i += len - 1; 
    repeated = false; 
   } 
   else 
   {
    res += str.charAt(i); 
   }
  } 
  return res; 
 }
}

//function checkpass(pass)
//{
//    var username = document.getElementById('username').value;
//    var score = testpass(pass.value,username);
//    var password_label = document.getElementById('password_label');
//    if(score == -4)
//    {
//        password_label.innerHTML = '太短';
//    }
//    else if(score == -2)
//    {
//        password_label.innerHTML = '与用户名相同';
//    }
//    else
//    {
//        var color = score < 34 ? '#edabab' : (score < 68 ? '#ede3ab' : '#d3edab');
//        var text = score < 34 ? '弱' : (score < 68 ? '一般' : '很好');
//        var width = score + '%';
//        password_label.innerHTML = "<span style='width:"+width+";display:block;overflow:hidden;height:20px;line-height:20px;background:"+color+";'>"+text+"</span>";
//    }
//}


