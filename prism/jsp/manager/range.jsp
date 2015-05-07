<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" errorPage="" %>
<%@page import="com.prism.common.VMControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

/*************************************/
%>
<base href="<%=basePath%>"></base>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/global-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.selectbox.css" />
<script type="text/javascript" src="scripts/jquery.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="prism/validator.js"></script>
<script type="text/javascript" src="lhgdialog/lhgdialog.min.js?skin=dewblack"></script>
<script type="text/javascript" src="prism/jquery.prism.2.0.js"></script>
<script type="text/javascript">
var api = frameElement.api;
var W = api.opener;

$(init);
function init(){
	var dt = api.data;
	var html = "";
	if(dt["WIDGET"]!=null){
		$("#list").prism({
			content:dt["URL"],
			param:dt["WIDGET"],
			end:function(el,data){
				initComTablist();
			}
	});
	}
}
function func_opt(data){
	var auth_range = data["AUTH_RANGE"];
	var user_id = data["USER_ID"];
  	var auth_id = data["AUTH_ID"];
	var range_val = data["RANGE_VAL"];
	
	var str ='加载中';
	$.post("pa/user_auth_range.s",{USER_ID:user_id,AUTH_ID:auth_id,RANGE_VAL:range_val},function(d){
		if(d[0]["total"]==0){
			str='<a href="javascript:func_enum_upt(\''+range_val+'\')">[添加]</a>';
		}else{
			str='<a href="javascript:func_enum_upt(\''+range_val+'\')">[取消]</a>';
		}
	},"json");
	return str;
}
function confirm($content,$title,$ok){
	return W.$.dialog({
		title:$title,
		fixed: true,
		max: false,
		min: false,
		resize: false,
		drag: true,
		lock: true,
		lockScroll:true,
		content: $content,
		ok: $ok,
		cancel:function(){
		}
	});
}
</script>
</head>

<body class="popLayer">
		<div class="comFrmList p15" id="form">
		    <table id="" class="comTabList" width="100%" border="0" cellspacing="0" cellpadding="0">
      <thead>
          <tr>
			<th>值</th>
			<th>名称</th>
			<th>操作</th>
			
          </tr>
      </thead> 
      <tbody id="list" class="comTabList" prism="dataGrid">
        <tr>
			<td>#@RANGE_VAL#</td>
			<td>#@RANGE_NAME#</td>
			<td>#@func:func_opt#</td>
        </tr>
	 </tbody>
     <tfoot>
    	<tr><td colspan="3" nowrap="nowrap" class="page"></td></tr>
     </tfoot>
	</table>
	</div>

</body>
</html>