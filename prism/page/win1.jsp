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

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
label{
	display: inline-block;
	vertical-align: top;
	width: 120px;
	height: 100%;
	padding: 0 5px;
	text-align: right;
	background: #f9f9f9;
}
-->
</style></head>
<body class="mainBody">
<div class="wrapper comWrap">
  <div class="wrap-inner">
  	
    <form class="baseFrm" id="form" name="" action="" target="" method="post">
      <ul class="frmList clearfix">
      <%
		List<String> list = (List<String>)request.getAttribute("WIDGET");
		for(String c:list){
			out.print("<li>");
			VMControl vc = new VMControl(request,response);
			out.println(vc.getHtml(c));
			out.print("</li>");
		}%>
      </ul>
    </form>
  </div>
  
</div>

</body>
</html>
