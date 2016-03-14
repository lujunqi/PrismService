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

<div class="search">
    <form id="frmSearch" method="post" action="search.do">
      <div class="ipt">
        <input type="text" id="INFO" name="INFO" data-widget="quickdelete" data-pagetype="search" autocomplete="off">
      </div>
      <div class="btn">
        <input type="submit" id="search" value="搜索">
      </div>
    </form>
</div><!--/.search-->

<div class="wrap">

  
    <ul class="comList clearfix">
<%
if(list.size()==0){
	out.println("没有搜索到结果..");
}
%>
<%for(int i=0;i<list.size();i++){
	Map m = (Map)list.get(i);
	%>
        <li>
        <a class="clearfix" href="<%=m.get("NEWS_URL")%>">
            <em class="name"><%=Null(m.get("NEWS_SUBJECT"))%></em>
            <span class="icon"><img src="<%=Null(m.get("NEWS_IMG"))%>" width="80" height="64" alt="<%=Null(m.get("NEWS_SUBJECT"))%>"></span>
            <span class="caption">
                <span class="param"><%=Null(m.get("NEWS_ABOUT"))%></span>
            </span>
        </a>
        </li>
<%}%>
    </ul>
    <div class="comListRtn"><a href="index.html">返回首页</a></div>  
    
</div>
  
</div><!--/.wrap-->

</body>
</html>
