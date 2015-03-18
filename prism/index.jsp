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
<script type="text/javascript">
$(init);
function init(){
	tick();
}
function showLocale(objD)
{
	var str,colorhead,colorfoot;
	var yy = objD.getYear();
	if(yy<1900) yy = yy+1900;
	var MM = objD.getMonth()+1;
	if(MM<10) MM = '0' + MM;
	var dd = objD.getDate();
	if(dd<10) dd = '0' + dd;
	var hh = objD.getHours();
	if(hh<10) hh = '0' + hh;
	var mm = objD.getMinutes();
	if(mm<10) mm = '0' + mm;
	var ss = objD.getSeconds();
	if(ss<10) ss = '0' + ss;
	var ww = objD.getDay();
	if  ( ww==0 )  colorhead="<font class='clock'>";
	if  ( ww > 0 && ww < 6 )  colorhead="<font class='clock'>";
	if  ( ww==6 )  colorhead="<font class='clock'>";
	if  (ww==0)  ww="星期日";
	if  (ww==1)  ww="星期一";
	if  (ww==2)  ww="星期二";
	if  (ww==3)  ww="星期三";
	if  (ww==4)  ww="星期四";
	if  (ww==5)  ww="星期五";
	if  (ww==6)  ww="星期六";
	colorfoot="</font>"
	str = colorhead + yy + "年" + MM + "月" + dd + "日&nbsp;&nbsp;" + hh + ":" + mm + ":" + ss + "&nbsp;&nbsp;" + ww + colorfoot;
	return(str);
}
function tick()
{
	var today;
	today = new Date();
	document.getElementById("date").innerHTML = showLocale(today);
	window.setTimeout("tick()", 1000);
}
function getPages(){
	$.dialog.confirm('你确定要生成页面吗？', function(){
		$.dialog.tips('页面生成中...',600,'loading.gif');
		var url = "pages.do";
		$.post(url,function(data){
			$.dialog.tips('页面生成完毕',1,'tips.gif',function(){
				$.dialog.confirm('你确定要预览这个页面？<br/>（注意：页面生成后，必需要做手工页面流量的填写）', function(){
					window.location.href="index.html";
				});
			});
		});
	});
}

</script>
<!--[if IE 6]>
<script type="text/javascript" src="scripts/DD_belatedPNG_0.0.8a-min.js" ></script>
<script type="text/javascript">
	DD_belatedPNG.fix('.pngfix');
</script>
<![endif]-->
</head>

<body class="fluid">

<div class="container">
  <div id="header">
    <div class="inner">
    <h1 id="site-name">事故跟单系统</h1>
    <div id="site-logo" class="fl"><a href="#"><img class="pngfix" src="images/logo.png" alt="" width="579" height="80" /></a></div>
    <div id="logout"><!--a class="pngfix" href="#">退出登录</a--></div>
    <ul id="site-nav" class="clearfix">
      <li class="user"><span><%=user_name%></span>欢迎您 </li>
 
      <li class="timer"><span id="date"></span></li>
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
      <p class="tc">Copyright &copy; 2000-2013 </p>
    </div>
  </div>
</div>
<!--/#footer-->

</body>
</html>