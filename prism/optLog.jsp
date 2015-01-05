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
req["@minnum"] = 0;
param["total_page"] = "#pages";
param["pageSize"] = 10;
param["display"] = 10;
param["total_url"] = "sltOptTotal.do";
function init(){
	param["data"] = req;
	$("#list").prism(param);
}
function submitBtn(){
	req["startDate"] = $("#startDate").val();
	req["endDate"] = $("#endDate").val();
	req["@minnum"] = 0;
	param["data"] = req;
	$("#list").prism(param);
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
            	 <span class="lab"><label for="">查询时间：</label></span>
              <span class="mod">
              <input type="text" class="itm w130" id="startDate" value="${startDate }" name="startDate" onclick="WdatePicker({el:'startDate',dateFmt:'yyyy-MM-dd HH:m'})"/>
              </span>
            	 到
              <span class="mod">
              <input type="text" class="itm w130" id="endDate" value="${endDate }" name="endDate" onclick="WdatePicker({el:'endDate',dateFmt:'yyyy-MM-dd HH:m'})"/>
              </span>
              <input type="button" value="查  询" onclick="submitBtn();"/> 
            </span>
        </div>
    </div>
  </div>
  <div class="wrap-inner">
  	
    <table id="" class="comTabList" width="100%" border="0" cellspacing="0" cellpadding="0">
      <thead>
          <tr>
            <th>ID</th>
            <th>链接</th>
            <th>操作员</th>
            <th nowrap>生成时间</th>
            
             
          </tr>
      </thead> 
      <tbody id="list" prism:type="dataGrid" prism:src="sltOpt.do">
        <tr>
          <td >#@LOGS_ID#</td>
          <td>#@LOGS_INFO#</td>
          <td>#@USER_NAME#</td>
          <td>#@CREATE_DATE#</td>
          

        </tr>
        
      </tbody>
    </table>
    <div>
    <div class="p10">
      <div id="pages" class="pages tr clearfix">

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