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
<script type="text/javascript">
	function submitBtn()
	{
		$.dialog.tips('正在处理中...',600,'loading.gif');
	  	setTimeout($.unblockUI, 1000);
		$("#form").submit();
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
    <h3 class="wrap-tit-l"><span class="icon">访问记录</span></h3>
  </div>
  <div class="wrap-inner">
  	
    <table id="" class="comTabList" width="100%" border="0" cellspacing="0" cellpadding="0">
      <thead>
          <tr>
            <th>访问时间</th>
            <th>访问IP</th>
            <th>HTTP信息</th>
            <th>访问页面</th>
            <th>流量</th>
          </tr>
      </thead> 
      <tbody>
      	<s:iterator value="#request.pager.objList" id="obj" status="st">	
        <tr>
          <td><s:property value="ACCESS_TIME"/></td>
          <td><s:property value="IP"/></td>
          <td><s:property value="HTTP_HEADER"/></td>
          <td><s:property value="URL"/></td>
          <td><s:property value="TRAFFIC"/></td>
        </tr>
       	</s:iterator>
      </tbody>
    </table>
    <div>
    <div class="plr10 ptb5">
      <div id="pages" class="pages tr clearfix">
    	<span class="info fl">
        <em><s:property value="#request.pager.pageInfo" escape="false"/></em>
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
</s:form>
<!--/.wrapper-->
</body>
</html>