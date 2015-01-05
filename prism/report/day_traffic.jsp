<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
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
<script type="text/javascript" src="FusionCharts/js/FusionCharts.js"></script>
<script type="text/javascript">
	function submitBtn()
	{
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		if (startDate != "" && endDate != "")
		{
			jQuery.ajax({
				type: "POST",
				url: "/happySurf/trafficAction!getDayTrafficXml.action?t="+Math.random(),
				data: "startDate="+startDate+"&endDate="+endDate,
				cache: false,
				success:function(xml)
				{
				 	var chart = new FusionCharts("./FusionCharts/swf/MSColumn3DLineDY.swf", "ChartId", "800", "450", "0", "0");　
					chart.setDataXML(xml)
					chart.render("chartdiv");
				}
			}); 
		}
		else
		{
			alert("请选择查询时间");
			return;
		}
	}
</script>
</head>

<body class="mainBody">
<s:form action="trafficAction!accessHistory.action"  id="form"  name="form" method="post" namespace="/"> 
	<ul class="frmList clearfix">
		<li>
              <span class="lab"><label for="">查询时间：</label></span>
              <span class="mod">
              <input type="text" class="itm w130" id="startDate" value="${startDate }" name="startDate" onclick="WdatePicker({el:'startDate',dateFmt:'yyyy-MM-dd'})"/>
              </span>
            	 到
              <span class="mod">
              <input type="text" class="itm w130" id="endDate" value="${endDate }" name="endDate" onclick="WdatePicker({el:'endDate',dateFmt:'yyyy-MM-dd'})"/>
              </span>
              <input type="button" value="查  询" onclick="submitBtn();"/> 
        </li>
	</ul>
<div class="wrapper comWrap">
  <div class="wrap-tit clearfix">
    <h3 class="wrap-tit-l"><span class="icon">流量记录</span></h3>
  </div>
  <div class="wrap-inner">
    <div id="chartdiv" align="center">
    	
    </div>
  </div>
  <div class="wrap-btm clearfix">
    <div class="wrap-btm-l">&nbsp;</div>
    <div class="wrap-btm-r">&nbsp;</div>
  </div>
</div>
</s:form>
<!--/.wrapper-->
</body>
</html>