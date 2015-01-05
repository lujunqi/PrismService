<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" errorPage="" %>
<%@page import="com.prism.common.VMControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String viewName = (String)request.getAttribute("VIEWNAME");
List<Object[]> my_enum = (List<Object[]>)request.getAttribute("MAPPING");
Object dataUrl = request.getAttribute("DATAURL");
List<String> query = (List<String>)request.getAttribute("QUERY");
/*************************************/

%>
<base href="<%=basePath%>">
</base>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/global-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<style type="text/css">
#search_div li {
	float: left;
	padding-right: 10px;
	margin: 2px;
	height: 35px;
	line-height: 35px;
	display: table-column;
	width: 300px;
	font-size: 12px;
}
#search_div li input.text {
	width: 180px;
	height: 30px;
	line-height: 30px;
}
#search_div li select {
	width: 180px;
	height: 30px;
	line-height: 30px;
}
#search_div li label {
	text-align: right;
	width: 100px;
	display: inline-block;
	margin-right: 10px;
	height: 30px;
	line-height: 30px;
}
#search_div li span {
	text-align: right;
	display: inline-block;
	margin-right: 10px;
	height: 30px;
	line-height: 30px;
}
</style>
<!-- 引入jquery -->
<script type="text/javascript" src="scripts/jquery.js"></script>
<script type="text/javascript" src="scripts/jquery.blockUI.js"></script>
<script type="text/javascript" src="prism/jquery.prism.2.0.js"></script>
<script type="text/javascript" src="lhgdialog/lhgdialog.min.js?skin=dewblack"></script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="scripts/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
var param={};
var req={};
param["data"] = req;
$(init);
function init(){
	$("#list").prism({content:"<%=dataUrl%>"});
	$(".el").click(function(e) {
       var cb = $(":checkbox",$(this).parent());
	   if(cb.attr("checked")){
		   cb.removeAttr("checked");
	   }else{
		   cb.attr("checked","checked");
	   }
	   var rd = $(":radio",$(this).parent());
 	   if(rd.attr("checked")){
		   rd.removeAttr("checked");
	   }else{
		   rd.attr("checked","checked");
	   }
    });
}
function update(id){
	$.dialog({
		title:"修改信息",
		width:380,
		height:220,
		fixed: true,
		max: false,
		min: false,
		resize: false,
		drag: false,
		lock: true,
		lockScroll:true,
		content: 'url:page/vehicle_update.jsp?id='+id,
		ok: function(){

			var employeeName = $("#EMP_NAME",this.content.document.body).val();
			var employeePhone = $("#EMP_PHONE",this.content.document.body).val();
			var url = "vehicle_update.do";
			var param = $.formField("#form",this.content.document.body);

			param["id"] = id;
			$.post(url,param,function(data){

				data = $.parseJSON(data);
				if(data.code !='0'){
					alert("修改成功");
					init();
				}
			});
		}
	});
}
function win($content){
	$.dialog({
		title:"修改信息",
		width:380,
		height:220,
		fixed: true,
		max: false,
		min: false,
		resize: false,
		drag: false,
		lock: true,
		lockScroll:true,
		content: $content,
		ok: function(){
			var url = "vehicle_update.do";
			var param = $.formField("#form",this.content.document.body);
			$.post(url,param,function(data){
				data = $.parseJSON(data);
				if(data.code !='0'){
					alert("修改成功");
					init();
				}
			});
		}
	});
}


function del(id){
	$.dialog({
		title:"确认删除",
		content: '是否删除该信息',
		fixed: true,
		max: false,
		min: false,
		resize: false,
		drag: false,
		lock: true,
		lockScroll:true,
		ok: function(){
			var url = "vehicle_delete.do";
			$.post(url,{id:id},function(data){
				if(data["code"]!=0){
					$.dialog({max: false,min: false,content:"该信息已删除！"});
					init();
				}else{
					$.dialog({max: false,min: false,content:data["result"]});
				}
			},"json");
		},
		cancelVal: '关闭',
		cancel: true 
	});
}
function add(){
	$.dialog({
		title:"新增数据",
		width:380,
		fixed: true,
		max: false,
		min: false,
		resize: false,
		drag: false,
		lock: true,
		lockScroll:true,
		content: 'url:page/vehicle_insert.jsp',
		ok: function(){
			var param = $.formField("#form",this.content.document.body);
			var url = "vehicle_insert.do";
			$.post(url,param,function(data){
				data = $.parseJSON(data);
				if(data.code =='1'){
					alert("新增成功");
					location.reload();
				}
			});
		}
	});
}
</script>
</head>

<body class="mainBody">
<div class="crumb mb10">
  <div class="crumb-l">&nbsp;</div>
  <div class="crumb-r">&nbsp;</div>
  <div class="crumb-m clearfix"> <a href="#" class="home"><b>&nbsp;</b>首页</a> <span class="label"><%=viewName%></span> </div>
</div>
<div class="wrapper comWrap">
  <div class="wrap-tit clearfix">
    <h3 class="wrap-tit-l"><span class="icon icon-list-alt mr5"></span><%=viewName%></h3>
    <p class="wrap-tit-r"> 
      <!--
        <a class="fr" href="javascript:exportEmployeeInfo()"><i class="icon icon-share-alt mr5"></i>导出数据</a>
        <span class="fr mlr10">|</span>  
        --> 
      <a class="fr" href="javascript:add()"><i class="icon icon-plus mr5"></i>新增</a> </p>
  </div>
  <div class="wrap-inner">
    <div id="search_div" class="frmList clearfix">
      <%
for(int i=0;i<query.size();i++){
	VMControl vc = new VMControl(request,response);
	out.println(vc.getHtml(query.get(i)));
	if(i+1 == query.size()){
		out.println("<div style=\"clear:both\"></div>");
		out.println("<div style=\"float:right;margin:20px\"><a>查询</a></div>");
	}
}%>
    </div>
  </div>
  <div class="wrap-inner" style="">
    <table id="" class="comTabList" width="100%" border="0" cellspacing="0" cellpadding="0">
      <thead>
        <tr>
          <%for(int i=0;i<my_enum.size();i++){
			out.println("<th>"+my_enum.get(i)[0]+"</th>");
		  }%>
        </tr>
      </thead>
      <tbody id="list" class="comTabList" prism="dataGrid">
        <tr class="">
          <%for(int i=0;i<my_enum.size();i++){
			out.println("<td>"+my_enum.get(i)[1]+"</td>");
		  }%>
        </tr>
      </tbody>
    </table>
    <div>
      <div class="plr10 ptb5">
        <div id="pages" class="pages tr clearfix"> <span class="batch fl mr10" style="display:none;"> </span> <span class="info fl"> <em>共有<b id="total_pages"></b>条数据，当前第<b id="curr_pages">1</b>页</em> </span> <span id="pagesList" class="list"> </span> </div>
      </div>
    </div>
  </div>
  <div class="wrap-btm clearfix">
    <div class="wrap-btm-l">&nbsp;</div>
    <div class="wrap-btm-r">&nbsp;</div>
  </div>
</div>
<!--/.wrapper-->

</div>
</body>
</html>