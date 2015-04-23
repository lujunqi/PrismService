<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" errorPage="" %>
<%@page import="com.prism.common.VMControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<base href="<%=basePath%>">
</base>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/global-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script type="text/javascript" src="scripts/jquery.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="prism/validator.js"></script>
<script type="text/javascript" src="prism/jquery.prism.2.0.js"></script>
<script type="text/javascript">
$(init);
function init(){
	var id = "<%=request.getParameter("id")%>";
	if(id!=null){
	$.post("pa/enum_info.s",{NKEY:id},
		function(data){
			if(data.length>0){
				$("input[name='ENUM_KEY']").val(data[0]["ENUM_KEY"]);
				$("input[name='ENUM_VAL']").val(data[0]["ENUM_VAL"]);
				$("input[name='ENUM_TYPE']").val(data[0]["ENUM_TYPE"]);
			}
		},"json");
	}
}
/*必有*/
function validator(){
	var fv = $("#form").formValidator();
	if(fv.length>0){
		return false;
	}else{
		return true;
	}
}

</script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
em{
	font-size:9px;
	color:#FF0000;
}
-->
</style>
</head>
<body class="mainBody">
<div class="wrapper comWrap">
  <div class="wrap-inner">
    <form class="baseFrm" id="form" name="" action="" target="" method="post">
	<input name="NKEY" type="hidden" value="<%=request.getParameter("id")%>" />
      <ul class="frmList clearfix">
        <li> <span class="lab">
          <label for="">名称：</label>
          </span> <span class="mod">
          <input name="ENUM_KEY" type="text" class="text w140" id="ENUM_KEY" />
          <em></em></span> </li>
        <li> <span class="lab">
          <label for="">值：</label>
          </span> <span class="mod">
          <input name="ENUM_VAL" type="text" class="text w140" id="ENUM_VAL" />
          <em></em> </span> </li>
        <li> <span class="lab">
          <label for="">类型：</label>
          </span> <span class="mod">
          <input name="ENUM_TYPE" type="text" class="text w140" id="ENUM_TYPE" />
          </span> </li>
      </ul>
    </form>
  </div>
</div>
</body>
</html>
