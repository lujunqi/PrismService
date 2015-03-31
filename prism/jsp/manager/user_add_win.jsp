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
      <ul class="frmList clearfix">
        <li> <span class="lab">
          <label for="">用户名：</label>
          </span> <span class="mod">
          <input name="LOGIN_NAME" type="text" class="text w140" valida="ajax" validaParam='{"url":"user_check.do"}' validaMsg="用户名已存在"/>
          <em></em></span> </li>
        <li> <span class="lab">
          <label for="">密　码：</label>
          </span> <span class="mod">
          <input name="USER_PWD" type="password" class="password w140" valida="vLength" validaParam='{"min":6,"max":10}' validaMsg="密码长度6-10位"/>
          <em></em>
          </span> </li>
        <li> <span class="lab">
          <label for="">确认密码：</label>
          </span> <span class="mod">
          <input name="USER_REPWD" type="password" class="password w140" valida="v1" validaMsg="密码输入不一致"/>
          <em></em>
          </span> </li>
        <li> <span class="lab">
          <label for="">姓　名：</label>
          </span> <span class="mod">
          <input name="USER_NAME" type="text" class="text w140" id="" />
          </span> </li>
      </ul>
    </form>
  </div>
</div>
</body>
</html>
