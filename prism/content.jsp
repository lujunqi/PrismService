<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" errorPage="" %>
<%!
public Object Null(Object v){
	if(v==null){
		return "";
	}else{
		return v;
	}
}
%>
<%
List list = (List)request.getAttribute("this");
Map m = new HashMap();
if(list.size()>0){
	m = (Map)list.get(0);
}
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="HandheldFriendly" content="true" />
<meta name="apple-mobile-web-app-capable" content="no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<meta name="format-detection" content="telephone=no" />
<title>快乐冲浪</title>
<link type="text/css" rel="stylesheet" href="css/global-min.css" />
<link type="text/css" rel="stylesheet" href="css/mobile.css" />
<link type="text/css" rel="stylesheet" href="css/flexslider.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.flexslider-min.js"></script>
<script type="text/javascript" src="js/jquery.dewTabs.min.js"></script>
<script type="text/javascript">
$(function(){
	
	$('.comList').each(function(index, element) {
		var $cmList = $(this);
		$cmList.children('li:gt(7)').hide();
        $cmList.next('.comListMore').find('a').click(function() {
			if($cmList.children('li:hidden').length > 0) {
				$cmList.children('li:hidden:lt(10)').show();
				$(window).scrollTop($(document).height());
			}
			else {
				alert('对不起，已经没有数据可加载！')
			}
			return false;
		});
    });
});
</script>
</head>

<body>

<div class="header">
  <h1 class="name fl"><span>快乐冲浪</span></h1>
  <div class="clear"></div>  
</div><!--/.header-->

<div class="wrap">

    <div class="article">
			<div class="articleTitle">
				<h2><%=Null(m.get("NEWS_SUBJECT"))%></h2>
			</div>

			<div class="articleContent">
				<div class="tc"><img src="<%=Null(m.get("NEWS_IMG"))%>" alt="pic"></div>
				　<%=Null(m.get("NEWS_INFO"))%>
			</div>
    </div>
    <div class="comListRtn"><a href="index.html">返回首页</a></div>  
    
</div>
  
</div><!--/.wrap-->

</body>
</html>
