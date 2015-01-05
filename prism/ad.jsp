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

function init(){
	param["data"] = req;
	$("#list").prism(param);
}

function inst(){
	var t = $("tr","#list");
	if(t.length>4){
		dialog2("最多只能添加5个广告？");
		return;
	}
	
	dialog("url:view/addAd.jsp",function(){
		this.content.getContenet();
		var r = $.formField("#list",this.content.document.body);
 		var url = "instAd.do";
		if(r["AD_INFO"]==""){
			$("#I_AD_INFO",this.content.document.body).show();
			return false;
		}else{
			$("#I_AD_INFO",this.content.document.body).hide();
		}
		if(r["AD_HREF"]==""){
			$("#I_AD_HREF",this.content.document.body).show();
			return false;
		}else{
			$("#I_AD_HREF",this.content.document.body).hide();
		}
		if(r["AD_IMG"]==""){
			$("#I_AD_IMG",this.content.document.body).show();
			return false;
		}else{
			$("#I_AD_IMG",this.content.document.body).hide();
		}
		if(r["AD_ORDER"]==""){
			$("#I_AD_ORDER",this.content.document.body).show();
			return false;
		}else{
			$("#I_AD_ORDER",this.content.document.body).hide();
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
function upt(id){
	
	dialog("url:view/uptAd.jsp?id="+id,function(){
		this.content.getContenet();
		var r = $.formField("#list",this.content.document.body);
 		var url = "uptAd.do";
		r["AD_ID"] = id;
		if(r["AD_INFO"]==""){
			$("#I_AD_INFO",this.content.document.body).show();
			return false;
		}else{
			$("#I_AD_INFO",this.content.document.body).hide();
		}
		if(r["AD_HREF"]==""){
			$("#I_AD_HREF",this.content.document.body).show();
			return false;
		}else{
			$("#I_AD_HREF",this.content.document.body).hide();
		}
		if(r["AD_IMG"]==""){
			$("#I_AD_IMG",this.content.document.body).show();
			return false;
		}else{
			$("#I_AD_IMG",this.content.document.body).hide();
		}
		if(r["AD_ORDER"]==""){
			$("#I_AD_ORDER",this.content.document.body).show();
			return false;
		}else{
			$("#I_AD_ORDER",this.content.document.body).hide();
		}
		
		$.post(url,r,function(data){
			if(data["code"] == "1" ){
				dialog2("操作成功");
			}else{
				dialog2("操作失败");
			}
			$("#list").prism(param);
		},"json");
	});
}
function del(id){
	dialog2("是否要删除该页面？",function(){
		var r = {"AD_ID":id};
		var url = "delAd.do";
		$.post(url,r,function(data){
			if(data["code"] == "1" ){
				dialog2("操作成功");
			}else{
				dialog2("操作失败");
			}
			$("#list").prism(param);
		},'json');
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
    <h3 class="wrap-tit-l"><span class="icon">广告列表</span></h3>
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
            <th>图片</th>
            <th>文字内容</th>
            <th>链接</th>
            <th nowrap>排序</th>
            
            <th width="18%">操作</th>
          </tr>
      </thead> 
      <tbody id="list" prism:type="dataGrid" prism:src="sltAd.do">
        <tr>
          <td >
          <a href="#@AD_URL#" target="_blank">
          <img src="#@AD_IMG#" width="200" height="100" />
          </a>
          </td>
          <td><a href="#@AD_URL#" target="_blank">#@AD_INFO#</a></td>
          <td>#@AD_HREF#</td>
          <td>#@AD_ORDER#</td>
          
          <td class="last" nowrap> <span class="operate">
			<a href="javascript:upt(#@AD_ID#)">[修改]</a> 
            <a href="javascript:del(#@AD_ID#)">[删除]</a> 
            
            
          </span></td>
        </tr>
        
      </tbody>
    </table>
    <div>
    <div class="p10">
      
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