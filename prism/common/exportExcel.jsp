<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">        
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">        
<meta http-equiv="expires" content="0">  
<title>导出</title>

</head>
  
<body>
 
共导出数据：<font color='red'><s:property value="#request.dataSize"/></font>条<br>
文件生成完毕：
<a href='<s:property value="#request.downloadPath"/>'><s:property value="#request.fileName"/></a>
&nbsp;请右键另存为
 
</body>
<script type="text/javascript">

	//alert("<s:property value="#request.downloadPath"/>");

</script>
</html> 

