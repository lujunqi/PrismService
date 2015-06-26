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

List<String> query = qvm.getQuery();
List<String> button  = qvm.getButton();
String js = qvm.getJS();
/*************************************/
%>
<base href="<%=basePath%>"></base>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/global-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.selectbox.css" />
<link rel="stylesheet" type="text/css" href="prism/prism.2.0.css" />
<script type="text/javascript" src="scripts/jquery.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="prism/validator.js"></script>
<script type="text/javascript" src="lhgdialog/lhgdialog.min.js?skin=dewblack"></script>
<script type="text/javascript" src="prism/jquery.prism.2.0.js"></script>
<script type="text/javascript">
var api = frameElement.api;
var W = api.opener;

$(init);
function init(){
	var dt = api.data;
	var html = "";
	if(dt["WIDGET"]!=null){
		$("#list").prism({
			content:dt["URL"],
			param:dt["WIDGET"],
			begin:function(el){
				loadingOne("show");
			},
			end:function(el,data){
				loadingOne("hide");
				initComTablist();
			}
	});
	}
}
function win2($content,$title,$ok,$data){
	return W.$.dialog({
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
function confirm($content,$title,$ok){
	return W.$.dialog({
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
<%=js%>
</script>
</head>

<body class="popLayer">
		<div class="comFrmList p15" id="form">
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

</body>
</html>