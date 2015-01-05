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

	
	dialog("url:view/addUser.jsp",function(){
		var $this = this;
		var r = $.formField("#list",this.content.document.body);
 		var url = "instUser.do";
		
		if(r["USER_NAME"]==""){
			$("#I_USER_NAME",this.content.document.body).show();
			return false;
		}else{
			$("#I_USER_NAME",this.content.document.body).hide();
		}
		if(r["USER_ACC"]==""){
			$("#I_USER_ACC",this.content.document.body).html("账号不能为空~");
			$("#I_USER_ACC",this.content.document.body).show();
			return false;
		}else{
			$("#I_USER_ACC",this.content.document.body).hide();
		}
		if(r["f"]=="N"){
			return false;
		}
		if(r["USER_PWD"]==""){
			$("#I_USER_PWD",this.content.document.body).show();
			return false;
		}else{
			$("#I_USER_PWD",this.content.document.body).hide();
			$("#I_USER_PWD2",this.content.document.body).hide();
			if(r["USER_PWD"]!=r["USER_PWD2"]){
				$("#I_USER_PWD2",this.content.document.body).show();
				return false;
			}
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
	dialog("url:view/uptUser.jsp?id="+id,function(){
		var r = $.formField("#list",this.content.document.body);
 		var url = "uptUser2.do";
		r["USER_ID"] = id;
		
		if(r["USER_NAME"]==""){
			$("#I_USER_NAME",this.content.document.body).show();
			return false;
		}else{
			$("#I_USER_NAME",this.content.document.body).hide();
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
	dialog2("是否要删除？",function(){
		var r = {"USER_ID":id};
		var url = "delUser.do";
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
function pwd(id){
	dialog("url:view/pwdUser.jsp",function(){
		var r = $.formField("#list",this.content.document.body);
		r["USER_ID"] = id;
		var url = "uptUser.do";
		if(r["USER_PWD"]==""){
			$("#I_USER_PWD",this.content.document.body).show();
			return false;
		}else{
			$("#I_USER_PWD",this.content.document.body).hide();
			$("#I_USER_PWD2",this.content.document.body).hide();
			if(r["USER_PWD"]!=r["USER_PWD2"]){
				$("#I_USER_PWD2",this.content.document.body).show();
				return false;
			}
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

function dialog(v_content,v_ok){
	$.dialog({
		title:"快乐冲浪",
		width:550,
		height:200,
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
		height:80,
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
    <h3 class="wrap-tit-l"><span class="icon">推荐业务列表</span></h3>
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
            <th>姓名</th>
            <th>用户名</th>
            <th width="18%">操作</th>
          </tr>
      </thead> 
      <tbody id="list" prism:type="dataGrid" prism:src="sltUser.do">
        <tr>

          <td>#@USER_NAME#</td>
          <td>#@USER_ACC#</td>
          <td class="last" nowrap> <span class="operate">
			<a href="javascript:upt(#@USER_ID#)">[修改]</a>
            <a href="javascript:pwd(#@USER_ID#)">[修改密码]</a>
            
            <a href="javascript:del(#@USER_ID#)">[删除]</a> 
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