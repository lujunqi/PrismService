var systemObject = {};
systemObject["formValidatorResult"] = false;
$.ajaxSetup({ cache: false });
//标签加载
$.fn.prism = function(options,callback) {
	var $This = this;
	for(var i = 0;i<$This.length;i++){
		run($This.eq(i),options,callback);
	}
};

function run($this,options,callback){
	var prismType = $this.attr("prism:type");
	if (prismType == null){
		return;
	}

	if (prismType == "dataGrid") {
		return setGriddata($this,options,callback);
	}
	if(prismType == "include"){
		return setInclude($this,options,callback);
	}
	if(prismType == "dialog"){
		return setInclude($this,options,callback);
	}
}
//普通对话框
function setDialog($this,options,callback){
	var div = $("div");
	
}
//插入子页面
function setInclude($this,options,callback){
	var $url = $this.attr("prism:src");
	var $data = options["data"];
	$.post($url, $data, function(data) {
		$this.html(data);
	});
}
//设置Griddata
function setGriddata($this,options,callback){
	var html = $this.html();
	if(options["prismData"]=="NOTE"){
		html = html.replaceAll("<!--","");
		html = html.replaceAll("-->","");
	}
	if ($this.attr("prismMode") == null) {
		$this.attr("prismMode", html);
	} else {
		html = $this.attr("prismMode");
	}
	var $url = $this.attr("prism:src");
	
	$this.html("");
	
	var $data = {};
	var $async = true;
	
	
	if(options!=null){
		if(options["prism_src"]!=null){
			$url = options["prism_src"];
		}
		if(options["pageSize"]!=null){
			pageSize = options["pageSize"];
		}
		
		if(options["data"]!=null){
			$data = options["data"];
			if($data["@minnum"]!= null){
				$data["@maxnum"] = $data["@minnum"] + pageSize;
			}
		}
		if(options["async"]!=null){
			$async = options["async"];
		}
		if(options["loader"]!=null){
			showLoader();
		}
	}
	//属性方式传参数
	var data82 =   $this.attr("prism:data");
	if(data82!=null){
		$data = $.toJSON(data82);
	}
	
	$.ajax({
	url:$url,
	dataType:"json",
	async:$async,
	data:$data,
	cache:false,
	type: "post",
	success:function(data){

				if(data!=null){	
					var linkRegx = /#@([A-Za-z0-9_]+)#/ig;
					var group = html.match(linkRegx);
					for ( var i = 0; i < data.length; i++) {
						var d = data[i];
						d["JSIndex"] = i+1;
						var p50 = html;
						
						if(null!=group){
							for( var j = 0; j < group.length; j++) {
								var key = group[j].substring(2,group[j].length-1);
								if(d[key]==null){
									d[key]="";
								}
								p50 = p50.replaceAll("#@"+key+"#",d[key]);
							}
						}
						p50 = p50.replaceAll("@@","@");

						$this.append($(p50));
					}
					
					if(callback!=null){
						callback(data);
					}
					if(options!=null){
						var total_page;//分页元素
						var total_url = "";//总记录数URL
						if(options["total_url"]!=null){
							total_url = options["total_url"];
						}
						if(options["loader"]!=null){
							hideLoader();
						}
						if(options["total_page"]!=null){
							total_page = options["total_page"];
						}
						//
						if(options["total_url"]!=null){
							options["this"] = $this;
							options["callback"] = callback;
							
							paginateEx(options);
						}
					}
				}
			}
	});
}

var pageSize = 10;
function paginateEx(options){
	var node = options["total_page"];
	var $url = options["total_url"];
	var req = options["data"];
	var key = options["total_key"];
	var nReq = eval("("+$.toJSON(req)+")");
	nReq["@minnum"] = options["@minnum"];
	nReq["@maxnum"] = options["@maxnum"];
	nReq["pageSize"] = options["pageSize"];
	if(options["startPage"] != undefined){
		nReq["startPage"] = options["startPage"];
	}
	if(options["curPage"] != undefined){
		nReq["curPage"] = options["curPage"];
	}
	var $display = 10;
	if(options["display"]!=null){
		$display = options["display"];
	}
	
	$.post($url,nReq,function(data){
		if(data!=null){
			var t_total = "TOTAL";
			if(key!=null){
				t_total = key;
			}
			var total = data[0][t_total];
			//如果total等于0
			if(total == 0 ){
				$count = 0;
				$start = 0;
				$("#total_pages",node).html(total);
				$("#curr_pages",node).html($start);
				var t =
	             "<a number=\"0\" class=\"tp\" >&lt;</a>" +
	             "<a number=\""+($count-1)+"\" class=\"tp\" >&gt;</a>";
	             
	             $("#pagesList",node).html($(t));
			}else{
				var $count = parseInt(total / pageSize);
				if (total % pageSize > 0) {
					$count = parseInt($count + 1);
				}
				var minnum = req["@minnum"];
				var $start = parseInt(minnum / pageSize)+1;
				if (minnum % pageSize > 0) {
					$start = parseInt($start + 1);
				}
				if(minnum==0){
					$start = 1;
				}
				$("#total_pages",node).html(total);
				$("#curr_pages",node).html($start);
				 var tp = "";
	             var t91 = parseInt($start / $display);
	             for (var i = 0; i < $count; i++) {
	                 if (i < t91 * $display - 1) {
	                     continue;
	                 }
	                 if (i >= (t91 + 1) * $display) {
	                     break;
	                 }
	                 if (i+1 == $start) {
	                     tp += "<a number="+i+" class=\"cur\"" +
	                     		">" + (i + 1) + "</a>";
	                 } else {
	                     tp += "<a number="+i+" class=\"tp\"" +
	                     		">" + (i + 1) + "</a>";
	                 }
	             }
	             var t =
	             "<a number=\"0\" class=\"tp\" >&lt;</a>" +
	              tp +
	             "<a number=\""+($count-1)+"\" class=\"tp\" >&gt;</a>";
	             
	             $("#pagesList",node).html($(t));
	             $(".tp",node).click(function(){
	            	 page = parseInt($(this).attr("number"))+1;
	            	 req["@minnum"] = (parseInt(page)-1) * pageSize;
	         		 req["@maxnum"] = req["@minnum"] + pageSize;
	         		 setGriddata(options["this"],options,options["callback"]);
	             });
			}
		}
	},"json");
	function onChange(page){
		
	}
}

$.extend(  
{  
   /** 
   * @see   将javascript数据类型转换为json字符串 
   * @param 待转换对象,支持object,array,string,function,number,boolean,regexp 
   * @return 返回json字符串 
   */  
   toJSON : function (object)  
   {  
    var type = typeof object;  
    if ('object' == type)  
    {  
     if (Array == object.constructor)  
      type = 'array';  
     else if (RegExp == object.constructor)  
      type = 'regexp';  
     else  
      type = 'object';  
    }  
      switch(type)  
    {  
        case 'undefined':  
       case 'unknown':   
      return;  
      break;  
     case 'function':  
       case 'boolean':  
     case 'regexp':  
      return object.toString();  
      break;  
     case 'number':  
      return isFinite(object) ? object.toString() : 'null';  
        break;  
     case 'string':
       return '"' + object.replace(/(\\|\")/g, "\\$1").replace(/\n|\r|\t/g, function() {
         var a = arguments[0];
         return (a == '\n') ? '\\n': (a == '\r') ? '\\r': (a == '\t') ? '\\t': ""
       }) + '"';
       break;
     case 'object':  
      if (object === null) return 'null';  
        var results = [];  
        for (var property in object) {  
          var value = $.toJSON(object[property]);  
          if (value !== undefined)  
            results.push($.toJSON(property) + ':' + value);  
        }  
        return '{' + results.join(',') + '}';  
      break;  
     case 'array':  
      var results = [];  
      for(var i = 0; i < object.length; i++)  { 
      	var value = $.toJSON(object[i]);  
        if (value !== undefined) results.push(value);  
      }  
      return '[' + results.join(',') + ']';  
      break;  
     }  
   },
	getParameter : function(name){//获取URL值
		var q=location.search.substring(1);
		var qs = q.split("&"); 
		if(qs){
			for(var i=0;i<qs.length;i++){
				var pos=qs[i].indexOf('=');//查找name=value   
                if(pos==-1) continue;
				var value=qs[i].substring(pos+1);
				var argname=qs[i].substring(0,pos);
				if(name == argname){
					return value;
				}
			}
		}
		return null;
	},formField : function(name,contont){//获取表单域值
		var $this = $(name);
		if(contont!=null){
			 $this = $(name,contont);
		}
		
		var $input = $this.find("INPUT[type!='checkbox'][type!='radio']");//待续
		var param = {};
		for ( var i = 0; i < $input.length; i++) {
				var key = $input[i].name;
				var val = $input[i].value;
				if(key!=""){
					param[key]=val;
				}
		}
		var $select = $this.find("SELECT");
		for ( var i = 0; i < $select.length; i++) {
			param[$select[i].name] = $select[i].value;
		}
		var $textarea =  $this.find("textarea");
		$textarea.each(function(){
			param[$(this).attr("name")] = $(this).val();
		})
		var $radio = $this.find("input:radio:checked");
		$radio.each(function(){
			if($(this).attr("checked")){
				param[$(this).attr("name")] = $(this).val();
			}
		})
		var $check = $this.find("input:checkbox[checked='checked']");
		$check.each(function(){
			if($(this).attr("checked")){
				var v =  $(this).val();
				var n =  $(this).attr("name");
				if(param[n]==null){
					param[n] = [];
					param[n][0] = v;
				}else{
					param[n][param[n].length] = v;
				}
			}
		})
		return param;
	},isEmptyObject: function( obj ) {
        for ( var name in obj ) {
            return false;
        }
        return true;
    },copyAttribute:function(objA,objB){//赋值对象的值到另一个对象
    	for(var attr in objA){
    		objB[attr] = objA[attr];
    	}
    },clearObjectValue:function(obj){//清除对象的值
    	for(var attr in objA){
    		objB[attr] = '';
    	}
    },containsValueInArray:function(obj,value){//判断数组是否存在值
		for(var i = 0 ;i<obj.length;i++){
			//如果数组存在值就返回true
			if(obj[i] == value){
				return true;
			}
		}
    },clearFormField:function(name){//清楚表单域的值
    	var $this = $(name);
		var $input = $this.find("INPUT");//待续
		$input.each(function(){
			if($(this).attr("type") == 'text'){
				$(this).val("");
			}
		});
		
		var $textarea = $this.find("TEXTAREA");
		$textarea.each(function(){
			$(this).val("");
		})
		var $radio = $this.find("input:radio[@checked]");
		
		var $check = $this.find("input:checkbox[checked='checked']");
		$check.each(function(){
			if($(this).attr("checked")){
				$(this).removeAttr("checked");
			}
		})

    },isUrl:function IsURL(str_url){
        var strRegex = "[a-zA-z]+://[^s]*";
            var re=new RegExp(strRegex);
            if (re.test(str_url)){
                return (true);
            }else{
                return (false);
            }
    }
});
String.prototype.replaceAll  = function(s1,s2){    
	return this.replace(new RegExp(s1,"gm"),s2);    
};


function setValue(param, key, val) {
	if (param[key] == null) {
		param[key] =  val ;
	} else {
		param[key].push(val);
	}
	return param;
}

(function($){  
	
	/**点击按钮的时候判断session是否失效begin*/
    var _ajax=$.ajax;  
    $.ajax=function(opt){  
        var fn = {  
            error:function(XMLHttpRequest, textStatus, errorThrown){},  
            success:function(data, textStatus){}  
        }  
        if(opt.error){  
            fn.error=opt.error;  
        }  
        if(opt.success){  
            fn.success=opt.success;  
        }  
 
        var _opt = $.extend(opt,{  
            error:function(XMLHttpRequest, textStatus, errorThrown){  
                fn.error(XMLHttpRequest, textStatus, errorThrown);  
            },  
            success:function(data, textStatus){  
                //session 超时  
                if(666221==data["code"]){
					window.top.location.href=data["href"];
				}else{
                	fn.success(data, textStatus);
				}
            }  
        });  
        _ajax(_opt);  
    };  
    /**点击按钮的时候判断session是否失效begin*/
    
    /**在输入框添加提示信息begin*/
    $.fn.dewHolder = function(options) {
		var defaults = {
			inputClass:		'p_input',
			labelClass:		'p_label',
			statusClass:	'disable'
		};		
		var options = $.extend(defaults, options);
		
		this.each(function(){
			
			var $placehoder = $(this);			
			var $ph_input = $('input', $placehoder);
			var $ph_label = $('label', $placehoder);
			
			$ph_input.addClass(options.inputClass);
			$ph_label.addClass(options.labelClass);
			$ph_label.width($ph_input.outerWidth());
			/**
			$ph_label.click(function() {
				$ph_input.focus();
			});
			
			$ph_input.focus(function(){	
				$ph_input.keydown(function() {
					toggleLab($ph_input, $ph_label); 
				});							
				$ph_input.keyup(function() {					
					toggleLab($ph_input, $ph_label); 
				});	
			});
			
			function toggleLab($obj, $tag) {
				if ($obj.val() !== '') {
					$tag.addClass(options.statusClass);	
				}
				else {
					$tag.removeClass(options.statusClass);	
				}
			};
			*/
			$ph_label.click(function() {
				$(this).addClass(options.statusClass);
				$ph_input.focus();
			});
			$ph_input.blur(function(){
				var textValue = $(this).val();
				if(textValue == ""){
					$ph_label.removeClass(options.statusClass);
				}
			});
			if($ph_input.val() !=""){
				$ph_label.addClass(options.statusClass);
			}
		});
		
	};
	/**在输入框添加提示信息begin*/
	
	/**验证表单数据begin*/
	//验证参数中必须有  type 、 message、messageId
	/**
	 * 目前有的验证列表:
	 * 1、非空验证
	 * 2、长度验证
	 * 3、手机号码验证
	 * 4、电话号码验证
	 * 5、数据库非空验证
	 */
	$.fn.formValidator = function(options){
		var type="";
		var textV="";
		$("[validator]").each(function(){
			//当每个被验证的DOM节点失去焦点的时候进行验证
			$(this).blur(function(){
				var validatorObjects = $.parseJSON($(this).attr("validator"));
				for(var i=0;i< validatorObjects.length;i++){
					var validatorObject = validatorObjects[i];
					type = validatorObject.type;
					if(type == undefined || type == ""){
						return false;
					}else{
						//判断是否为空
						if(type == "isNotEmpty"){
							textV = $(this).val();
							//如果输入框中的值为空就显示错误信息
							if(textV ==""){
								$("#"+validatorObject.messageId).text(validatorObject.message);
								systemObject["formValidatorResult"] = false;
								return false;
								//如果不为空就清空错误信息
							}else{
								$("#"+validatorObject.messageId).text("");
								systemObject["formValidatorResult"] = true;
							}
						//判断长度(判断长度需要 lengthNum参数,长度包括空格)
						}else if(type == "lengthLimit"){
							textV = $(this).val();
							if(textV.length > validatorObject.lengthNum){
								$("#"+validatorObject.messageId).text(validatorObject.message);
								systemObject["formValidatorResult"] = false;
								return false;
							}else{
								$("#"+validatorObject.messageId).text("");
								systemObject["formValidatorResult"] = true;
							}
						//判断唯一（判断唯一的时候要与数据库交互，需要表名tableName，字段名fieldName,url参数,inputName）
						}else if(type == "isUnique"){
							textV = $(this).val();
							var vo = '{"tableName":'+'"'+validatorObject.tableName+'",'+'"inputName":'+'"'+textV+'",'+'"fieldName":'+'"'+validatorObject.fieldName+'"'+'}';
							var ob = $.parseJSON(vo);
							//请求数据库
							$.post(validatorObject.url,ob,function(data){
								//如果大于零就表示数据已经存在
								if(data[0]["TOTAL"] > 0){
									$("#"+validatorObject.messageId).text(validatorObject.message);
									systemObject["formValidatorResult"] = false;
									return false;
								}else{
									$("#"+validatorObject.messageId).text("");
									systemObject["formValidatorResult"] = true;
								}
							},'json')
						}else if(type == "isMobile"){
							textV = $(this).val();
							//验证手机号码
							//if(textV.length == 11){
								var t=/^1[358]\d{9}$/;
								 if(!t.test(textV)){
									$("#"+validatorObject.messageId).text(validatorObject.message);
									systemObject["formValidatorResult"] = false;
									return false;
								 }else{
									$("#"+validatorObject.messageId).text("");
									systemObject["formValidatorResult"] = true;
								 }
							//验证电话号码
							/**
							}else{
								var p1 = /^(([0+]d{2,3}-)?(0d{2,3})-)?(d{7,8})(-(d{3,}))?$/;
								if (!p1.test(textV)){
									$("#"+validatorObject.messageId).text(validatorObject.message);
									return false;
								}else{
									$("#"+validatorObject.messageId).text("");
								}
							}
							*/
						}
					}
				}
			});
		});
	};
	/**验证表单数据end*/
})(jQuery);  

