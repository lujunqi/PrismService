<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Map<String,Object>> list = (List<Map<String,Object>>)request.getAttribute("this");
%>
<base href="<%=basePath%>"></base>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/global-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.selectbox.css" />
<script type="text/javascript" src="scripts/jquery.js"></script>
<script type="text/javascript" src="scripts/jquery.selectbox-0.2.min.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="scripts/jquery.prism.js"></script>
<script type="text/javascript" src="scripts/validation.js"></script>

</head>

<body class="popLayer">
		<div class="comFrmList p15" id="form">
		<ul class="list">
        <%for(Map<String,Object> map:list){%>
	      <li>
	        <label class="tit w100" for="">参数：</label>
	        <input type="text" class="itm w130" id="<%=map.get("D")%>" value="<%=map.get("V")%>" name="<%=map.get("D")%>" />
	      </li>
	     <%}%>
   		</ul>
	</div>

</body>
</html>