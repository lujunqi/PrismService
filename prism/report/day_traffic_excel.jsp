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
<script type="text/javascript" src="scripts/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
$(init);
var param = {};
var req = {};

function init(){
	param["data"] = req;
	param["prismData"] = "NOTE";
	$("#excel").click(func_excel);
	$("#search").click(func_search);
}
function func_excel(){
	if($("#startDate").val()==""){
		dialog2("起始时间不能为空！");
		return;
	}
	if($("#endDate").val()==""){
		dialog2("结束时间不能为空！");
		return;
	}
	var url = "dayTrafficExcel.do?startDate="+ $("#startDate").val()+"&endDate="+ $("#endDate").val();
	$("#ifm").attr("src",url);
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
function func_search(){
	req["startDate"] = $("#startDate").val();
	req["endDate"] = $("#endDate").val();
	if($("#startDate").val()==""){
		dialog2("起始时间不能为空！");
		return;
	}
	if($("#endDate").val()==""){
		dialog2("结束时间不能为空！");
		return;
	}		
	$("#list").prism(param,function(e){
		var IP_TOTAL = 0;
		var TOTAL_CLICK = 0;
		var TRAFFIC_TOTAL = 0;
		
		for(var i=0;i<e.length;i++){
			IP_TOTAL += e[i]["IP_TOTAL"];
			TOTAL_CLICK += e[i]["TOTAL_CLICK"];
			TRAFFIC_TOTAL += e[i]["TRAFFIC_TOTAL"];
		}
		$("#IP_TOTAL").html(IP_TOTAL);
		$("#TOTAL_CLICK").html(TOTAL_CLICK);
		$("#TRAFFIC_TOTAL").html(TRAFFIC_TOTAL);
	});
}
</script>
</head>

<body class="mainBody">
<iframe id="ifm" style="display:none;"></iframe>
<ul class="frmList clearfix">
  <li> <span class="lab">
    <label for="">查询时间：</label>
    </span> <span class="mod">
    <input type="text" class="itm w130" id="startDate" name="startDate" onclick="WdatePicker({el:'startDate',dateFmt:'yyyy-MM-dd'})"/>
    </span> 到 <span class="mod">
    <input type="text" class="itm w130" id="endDate" name="endDate" onclick="WdatePicker({el:'endDate',dateFmt:'yyyy-MM-dd'})"/>
    </span>
    <span class="mr5">
    <input type="button" id="search" value="查  询" />
    <div style="float:right">
    <input type="button" id="excel" value="导出EXCEL" class="btn" />
    </div>
    </span>
  </li>
</ul>
<div class="wrapper comWrap">
  <div class="wrap-tit clearfix">
    <h3 class="wrap-tit-l"><span class="icon">流量记录</span></h3>
  </div>
  <div class="wrap-inner">
    <table id="" class="comTabList" width="100%" border="0" cellspacing="0" cellpadding="0">
      <thead>
        <tr>
          <th>日期</th>
          <th>IP总数</th>
          <th>点击量</th>
          <th>总流量</th>

        </tr>
      </thead>
      <tbody id="list" prism:type="dataGrid" prism:src="dayTraffic.do">
      <!--
        <tr>
          <td>#@ACCESS_DATE#</td>
          <td>#@IP_TOTAL#</td>
          <td>#@TOTAL_CLICK#</td>
          <td>#@TRAFFIC_TOTAL#</td>
        </tr>
      -->
      </tbody>
      <tfoot>
      <tr>
      <td>合计</td>
      <td id="IP_TOTAL"></td>
      <td id="TOTAL_CLICK"></td>
      <td id="TRAFFIC_TOTAL"></td>
      
      </tr>
      </tfoot>
    </table>
  </div>
  <div class="wrap-btm clearfix">
    <div class="wrap-btm-l">&nbsp;</div>
    <div class="wrap-btm-r">&nbsp;</div>
  </div>
</div>

<!--/.wrapper-->
</body>
</html>