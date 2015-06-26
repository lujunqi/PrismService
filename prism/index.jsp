<%@ page language="java" import="java.util.*,java.net.*" pageEncoding="UTF-8"%>
<%@page import="manager.ManagerMenu"%>
<%
Object user_name = session.getAttribute("USER_NAME");
Object user_id = session.getAttribute("USER_ID");
if(user_id==null){
	response.sendRedirect("login.jsp");
}

%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<meta charset="utf-8">
<meta name="keywords" content=".........">
<meta name="description" content=".........">
<link rel="stylesheet" href="css/global-min.css">
<link rel="stylesheet" href="css/common.css">
<script type="text/javascript" src="scripts/jquery.js"></script>
<script type="text/javascript" src="scripts/lhgdialog/lhgdialog.min.js?skin=dblue"></script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="prism/jquery.prism.2.0.js"></script>

<script type="text/javascript">
function func_pwd(){
  var w = {};
  var dt = [];
  w["WIDGET"] = dt;
  dt.push(['原密码','<input name="OLD_LOGIN_PWD" type="password" class="password w140" />']);
  dt.push(['新密码','<input name="NEW_LOGIN_PWD" type="password" class="password w140"/>']);
  dt.push(['确认密码','<input name="RE_LOGIN_PWD" type="password" class="password w140"/>']);
  win("url:page/win1.jsp","修改密码","pa/user_pwd_upt.u",w);
  
}
function win($content,$title,$url,$data){
	return $.dialog({
		title:$title,
		width:450,
		height:220,
		fixed: true,
		max: false,
		min: false,
		resize: false,
		drag: true,
		lock: true,
		lockScroll:true,
		content: $content,
		data:$data,
		ok: function(){
			var url = $url;
			var param = $.formField("#form",this.content.document.body);
			if(param["NEW_LOGIN_PWD"]!=param["NEW_LOGIN_PWD"]){
				alert("密码输入不一致");
				return false;
			}
			$.post(url,param,function(data){
				if(data.result !='0'){
					
				}else{
					return false;
				}
			},"json");

		},
		cancel:function(){
		}
	});
}
</script>
</head>

<body class="fluid">
<div class="container">
  <div id="header">
    <div class="inner">
    <h1 id="site-name"></h1>
    <div id="site-logo" class="fl"><a href="#"></a></div>
    <div id="logout"><!--a class="pngfix" href="#">退出登录</a--></div>
    <ul id="site-nav" class="clearfix">
      <li class="user"><span><%=user_name%></span>欢迎您</li>
 
      <li style="float: right;"><a href="logout.jsp" style="clear:both;">注销</a></li>
	  <li style="float: right;"><a href="javascript:func_pwd();" style="clear:both;">修改密码</a></li>
    </ul>
    </div>
  </div>
  <!--/#header-->
  
  <div class="section clearfix">
    <div class="hidden">
      <h2>Site Content</h2>
    </div>
    <div class="content clearfix">
      <iframe class="mainFrame" id="main" name="main" src="welcome.html" frameborder="0" scrolling="yes" hidefocus></iframe>
    </div>
    <!--/.content-->
    
    <div class="sidebar">
		<ul class="sideNav">
		<%
		ManagerMenu mm = new ManagerMenu();
		out.println(mm.service(request,response));
		%>
		</ul>
    </div>
    <!--/.sidebar -->
    
    <div class="addBar"> 
      <!--/.addBar --> 
    </div>
  </div>
  <!--/.section--> 
  
</div>
<!--/.container -->

<div id="footer">
  <div class="container">
    <div id="copyright">
      <p class="tc">Copyright &copy; 2000-2015 </p>
    </div>
  </div>
</div>
<!--/#footer-->

</body>
</html>