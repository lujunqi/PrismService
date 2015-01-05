$.extend(  
{
	//表单校验 type:调用函数名，par:函数入参（json格式）,msg:提示信息
	validation:function(name){
		var $this = $(name);
		var valida = $this.find("[valida]");
		var result = [];
		for1:
		for(var i =0;i<valida.length;i++){
			var c = valida.eq(i);
			var $v = eval("("+c.attr("valida")+")");
			if($v.length==null){
				$v = [$v];
			}
			var msgInfo = func_msgInfo(c);/*初始化消息提示框*/
			
			for(j=0;j<$v.length;j++){
				v = $v[j];
				var type = v["type"];
				if(v["par"]==null){
					v["par"] = {$this:c.val()};
				}else{
					v["par"]["$this"] = c.val();
				}
				var par = $.toJSON(v["par"]);
				if(eval(type+"("+par+")")){//验证不通过
					msgInfo.show();
					result.push(v["msg"]);
					if(v["msg"]!=null){
						msgInfo.html(msgInfo.html()+v["msg"]+";");
					}else{
						msgInfo.html(msgInfo.attr("html"));
					}
					if($this.attr("prism:vRule")=='single'){
						
						break for1;
					}
				}else{
					msgInfo.hide();
				}
			}
		}
		return result.length>0;
	}
});
//初始化提示框
function func_msgInfo(c){
	var msgInfo = $("div[forId='"+c.attr("id")+"']");
	if(msgInfo.length==0){
		msgInfo = $("<div>");
		msgInfo.attr("forId",c.attr("id"));
		$("body").append(msgInfo);
		var offset = c.offset();
		var right = offset.left+c.width();
		var down = offset.top+c.height();
		var css = {};
		css["position"]="absolute";
		css["left"]=right+10;
		css["top"]=offset.top;
		css["z-index"]="100000";
		css["color"]="#C00";
		css["padding"] = 5;
		msgInfo.css(css);
		msgInfo.html("");
	}else{
		msgInfo.attr("html",msgInfo.html());
		msgInfo.html("");
	}
	msgInfo.hide();
	return msgInfo;
}

function isNum(param){
	var str = param["$this"];
	
	return true;
}
function isNull(param){
	var str = param["$this"];
	if (str == "") return true;
	var regu = "^[ ]+$";
	var re = new RegExp(regu);
	return re.test(str);
}
