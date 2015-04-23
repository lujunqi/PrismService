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
<script type="text/javascript" src="lhgdialog/lhgdialog.min.js?skin=dewblack"></script>
<script type="text/javascript" src="prism/jquery.prism.2.0.js"></script>
<script type="text/javascript">
var api = frameElement.api;
$(init);
function init(){
	var dt = api.data;
	var html = "";
	if(dt["WIDGET"]!=null){
		var data = dt["WIDGET"];
		for(var i=0;i<data.length;i++){
			var d = data[i];
			if(d.length==1){
				html+=d[0];
			}else{
				html+='<li><span class="lab"><label>'+d[0]+'：</label></span><span class="mod">'+d[1]+'<em></em></span> </li>';
			}
		}
		$("#WIDGET").html(html);
	}
	if(dt["VALUE"]!=null){
		for(var p in dt["VALUE"]){
			$("input[name='"+p+"']").val(dt["VALUE"][p]);

		}
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
      <ul class="frmList clearfix" id="WIDGET">
        
      </ul>
    </form>
  </div>
</div>
</body>
</html>
