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
VMControl qvm = new VMControl(request,response);
List<Object[]> my_enum = qvm.getMapping();

Object dataUrl = request.getAttribute("DATAURL");
Object dataUrlTotal = request.getAttribute("DATAURLTOTAL");

List<String> query = qvm.getQuery();
List<String> button  = qvm.getButton();
String js = qvm.getJS();
/*************************************/
%>
<base href="<%=basePath%>">
</base>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/global-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<!-- 引入jquery -->
<script type="text/javascript" src="scripts/jquery.js"></script>
<script type="text/javascript" src="scripts/jquery.blockUI.js"></script>
<script type="text/javascript" src="prism/validator.js"></script>
<script type="text/javascript" src="prism/jquery.prism.2.0.js"></script>
<script type="text/javascript" src="lhgdialog/lhgdialog.min.js?skin=dewblack"></script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="scripts/My97DatePicker/WdatePicker.js"></script>

<%
if(request.getAttribute("JS_SRC")!=null){
	out.println("<script type=\"text/javascript\" src=\""+request.getAttribute("JS_SRC")+"\"></script>");
}
%>
<script type="text/javascript">
var param={};
var req={};
param["data"] = req;
$(init);
function init(){
	queryInfo();
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
function queryInfo(){
	var $param = $.formField("#queryInfo");
	$("#list").prism({
		content:"<%=dataUrl%>",
		param:$param,
		<%if(dataUrlTotal!=null){
			out.println("pageUrl:\""+dataUrlTotal+"\",");
		}%>
		end:function(el,data){
			initComTablist();
		}
	});
}
function confirm($content,$title,$ok){
	return $.dialog({
		title:$title,
		fixed: true,
		max: false,
		min: false,
		resize: false,
		drag: true,
		lock: true,
		lockScroll:true,
		content: $content,
		ok: $ok,
		cancel:function(){
		}
	});
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
			var fv = this.content.validator();
			if(!fv){
				alert("验证不通过");
				return false;
			}else{
				var url = $url;
				var param = $.formField("#form",this.content.document.body);
				$.post(url,param,function(data){
					if(data.result !='0'){
						queryInfo();
					}else{
						return false;
					}
				},"json");
			}		
		},
		cancel:function(){
		}
	});
}
function win2($content,$title,$ok,$data){
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
		ok:$ok,
		cancel:function(){
		}
	});
}
<%=js%>
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
    <div class="wrap-tit-r">     
        <div class="filter" id="queryInfo">
<%
for(int i=0;i<query.size();i++){
	out.println(qvm.getHtml(query.get(i)));
}
out.println("<span class=\"mr5\"><a class=\"btn\" href=\"javascript:queryInfo()\">查询</a></span>");
for(int i=0;i<button.size();i++){
	out.println("<span class=\"mr5\">"+button.get(i)+"</span>");
}
/*****************************************/

%>
		</div>
	</div>
  </div>

  <div class="wrap-inner">
  	
    <table id="" class="comTabList" width="100%" border="0" cellspacing="0" cellpadding="0">
      <thead>
          <tr>
<%for(int i=0;i<my_enum.size();i++){
	out.println("<th>"+my_enum.get(i)[0]+"</th>");
}%>
          </tr>
      </thead> 
      <tbody id="list" class="comTabList" prism="dataGrid">
        <tr>
<%for(int i=0;i<my_enum.size();i++){
	out.println("<td>"+my_enum.get(i)[1]+"</td>");
}%>
        </tr>
	 </tbody>
     <tfoot>
    	<tr><td colspan="<%=my_enum.size()%>" nowrap="nowrap" class="page"></td></tr>
     </tfoot>
	</table>

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