<%@ page contentType="text/html; charset=utf-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>卡布管理后台</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link rel="stylesheet" type="text/css" href="css/global-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<!--[if IE 6]>
<script type="text/javascript" src="scripts/DD_belatedPNG_0.0.8a-min.js" ></script>
<script type="text/javascript">
	DD_belatedPNG.fix('.pmgfix');
</script>
<![endif]-->
<script type="text/javascript" src="scripts/jquery.js"></script>
<script type="text/javascript" src="lhgdialog/lhgdialog.min.js?skin=blue"></script>
<script type="text/css">
	.clock{
		font-size:12px;
	}
</script>
<script type="text/javascript">
//window.top.location.href="login.html";

$(init);
function init(){
	$("#logout").click(function(){
		if(confirm("是否退出登录")){
			$.post("login!logout.action",function(data){
				location.reload();
			});
		}
	});
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
	str = colorhead + yy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss + "  " + ww + colorfoot;
	return(str);
}
function tick()
{
	var today;
	today = new Date();
	document.getElementById("date").innerHTML = showLocale(today);
	window.setTimeout("tick()", 1000);
}


</script>
<body>

  <div id="header">
    <h1 id="site-name">卡布管理后台</h1>
    <div id="site-logo" class="fl"><a href="#"><img src="images/logo.jpg" alt="卡布管理后台" width="591" height="94" /></a></div>
    <div id="site-banner" class="fr">&nbsp;</div>
    <div class="clear"></div>    
    <div id="main-nav" class="clearfix">
      <ul class="clearfix">
      <li><span class="mr5">系统管理员【<%=session.getAttribute("USER_NAME")%>】</span>欢迎您</li>
      <li class="timer"><span id="date" style="color:#FFF;font-size:12px;"></span></li>
      </ul>
    </div>
  </div><!--/#header-->
</body>
</html>