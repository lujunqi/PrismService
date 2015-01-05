<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>快乐冲浪手机门户</title>

<link rel="stylesheet" type="text/css" href="css/global-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script type="text/javascript" src="scripts/jquery.js"></script>
<script type="text/javascript" src="scripts/jquery.prism.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="scripts/lhgdialog/lhgdialog.min.js?skin=dblue"></script>
<script type="text/javascript">
$(init);
var param = {};
var req = {};
req["@minnum"] = 0;
param["total_page"] = "#pages";
param["pageSize"] = 10;
param["display"] = 10;
param["total_url"] = "sltNewsTotal.do";

function init(){
	
	req["NEWS_TYPE"] = "<%=request.getParameter("type")%>";
	param["data"] = req;

	$("#list").prism(param);
}
function upt(id){
	dialog("url:view/newsUpt.jsp?id="+id,function(){
		this.content.getContenet();
		var r = $.formField("#list",this.content.document.body);
		var url = "uptNews.do";
		
		if(r["NEWS_SUBJECT"]==""){
			$("#I_NEWS_SUBJECT",this.content.document.body).show();
			return false;
		}else{
			$("#I_NEWS_SUBJECT",this.content.document.body).hide();
		}
		if(r["NEWS_IMG"]==""){
			$("#I_NEWS_IMG",this.content.document.body).show();
			return false;
		}else{
			$("#I_NEWS_IMG",this.content.document.body).hide();
		}
		if(r["NEWS_ABOUT"]==""){
			$("#I_NEWS_ABOUT",this.content.document.body).show();
			return false;
		}else{
			$("#I_NEWS_ABOUT",this.content.document.body).hide();
		}
		
		
		$.post(url,r,function(data){
			$("#list").prism(param);
			if(data["code"] == "1" ){
				dialog2("操作成功");
			}else{
				dialog2("操作失败");
			}
		},"json");
	});
}
function inst(){
	dialog("url:view/newsAdd.jsp",function(){
		this.content.getContenet();
		var r = $.formField("#list",this.content.document.body);
		r["NEWS_TYPE"] = "<%=request.getParameter("type")%>";
 		var url = "instNews.do";
		if(r["NEWS_SUBJECT"]==""){
			$("#I_NEWS_SUBJECT",this.content.document.body).show();
			return false;
		}else{
			$("#I_NEWS_SUBJECT",this.content.document.body).hide();
		}
		if(r["NEWS_IMG"]==""){
			$("#I_NEWS_IMG",this.content.document.body).show();
			return false;
		}else{
			$("#I_NEWS_IMG",this.content.document.body).hide();
		}
		if(r["NEWS_ABOUT"]==""){
			$("#I_NEWS_ABOUT",this.content.document.body).show();
			return false;
		}else{
			$("#I_NEWS_ABOUT",this.content.document.body).hide();
		}
		
		
		$.post(url,r,function(data){
			$("#list").prism(param);
			
			if(data["code"] == "1" ){
				dialog2("操作成功");
			}else{
				dialog2("操作失败");
			}
		},"json");
	});
}
function del(id){
	dialog2("是否要删除该页面？",function(){
		var r = {"NEWS_ID":id};
		var url = "delNews.do";
		$.post(url,r,function(data){
			$("#list").prism(param);
			if(data["code"] == "1" ){
				dialog2("操作成功");
			}else{
				dialog2("操作失败");
			}
		},"json");
	});
}
function dialog(v_content,v_ok){
	$.dialog({
		title:"快乐冲浪",
		width:550,
		height:300,
		fixed: false,
		max: false,
		min: false,
		resize: false,
		drag: false,
		lock: true,
		lockScroll:true,
		content: v_content,
		ok:v_ok,
		cancelVal: '关闭',
		cancel: true
	});
}
function dialog2(v_content,v_ok){
	$.dialog({
		title:"快乐冲浪",
		width:150,
		height:100,
		fixed: false,
		max: false,
		min: false,
		resize: false,
		drag: false,
		lock: true,
		lockScroll:true,
		content: v_content,
		ok:v_ok,
		cancelVal: '关闭',
		cancel: true
	});
}

</script>
</head>

<body class="mainBody">

<div class="wrapper comWrap">
  <div class="wrap-tit clearfix">
    <h3 class="wrap-tit-l"><span class="icon">发布列表</span></h3>
    <div class="wrap-tit-r">
        <div class="filter">
            <span class="mr5">
	            <input type="button" onClick="inst();" class="btn " value="新增"/>
            </span>
        </div>
    </div>
  </div>
  <div class="wrap-inner">
  	
    <table id="" class="comTabList" width="100%" border="0" cellspacing="0" cellpadding="0">
      <thead>
          <tr>
            
            <th width="16%">图片</th>
            <th width="20%">主题</th>
            <th width="40%">内容简介</th>
            <th width="18%">时间</th>
            <th nowrap>排序</th>
            <th width="">操作</th>
          </tr>
      </thead> 
      <tbody id="list" prism:type="dataGrid" prism:src="sltNews.do">
        <tr>
          <td >
          <a href="#@NEWS_HREF#" target="_blank">
          <img src="#@NEWS_IMG#" width="100" height="100" />
          </a>
          </td>
          <td><a href="#@NEWS_HREF#" target="_blank">#@NEWS_SUBJECT#</a></td>
          <td>#@NEWS_ABOUT#</td>
          
          <td nowrap>#@CREATE_DATE#</td>
          <td nowrap>#@NEWS_ORDER#</td>
          
          <td class="last" nowrap> <span class="operate">
          <a href="javascript:upt(#@NEWS_ID#)">[修改]</a> 
          <a href="javascript:del(#@NEWS_ID#)">[删除]</a> 
          
          </span></td>
        </tr>
        
      </tbody>
    </table>
    <div>
    <div class="p10">
      <div id="pages" class="pages tr clearfix">
    	<span class="batch fl mr10" style="display:none;">
        <a class="opt" href="#" >批量删除</a>
        </span>
    	<span class="info fl">
        <em>共有<b id="total_pages"></b>条数据，当前第<b id="curr_pages">1</b>页</em>
        </span>
        <span id="pagesList" class="list"> </span>
      </div>
    </div>
    </div>
  </div>
  <div class="wrap-btm clearfix">
    <div class="wrap-btm-l">&nbsp;</div>
    <div class="wrap-btm-r">&nbsp;</div>
  </div>
</div>
<!--/.wrapper-->


</body>
</html>