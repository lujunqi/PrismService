<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="css/global-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/form.css" />
<script type="text/javascript" src="scripts/jquery.js"></script>
<script type="text/javascript" src="scripts/jquery.prism.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="scripts/lhgdialog/lhgdialog.min.js?skin=dblue"></script>
<script type="text/javascript">
$(init);
function init(){
	$("#SMT").click(func_save);
	$.post("sltUrlTraffic.do",{URL:$("#URL").val()},function(data){
		if(data.length>0){
			$("#TRAFFIC").val(data[0]["TRAFFIC"]);
		}
	},"json");
}
function func_save(){
	var url = "instUrlTraffic.do";
	var param = {};
	param["URL"] = $("#URL").val();
	param["TRAFFIC"] = $("#TRAFFIC").val();
	$.dialog.tips('正在处理中...',600,'loading.gif');
	$.post(url,param,function(data){
		$.dialog.tips('处理完毕',1,'tips.gif',function(){});
	});
}
</script>
</head>

<body>
<div class="wrap-inner">
    <ul class="frmList clearfix" id="list" name="" >
      <li> <span class="lab">
        <label for="">文件名：</label>
        </span> <span class="mod">
        <select id="URL" name="URL" class="w200">
        	<option value="/index.html">/index.html</option>
        </select>
        </span> </li>
      <li> <span class="lab">
        <label for="">文件大小：</label>
        </span> <span class="mod">
        <input type="text" class="text w150"  onKeyUp="value=value.replace(/\D+/g,'')" id="TRAFFIC" name="TRAFFIC" />
        KB(1M=1024KB)
        </span> </li>
      <li>
      <li>
          <span class="lab">&nbsp;</span>
          <span class="mod">
          <input type="submit" class="frmSubmitAlt" id="SMT" name="" value="确定" />
          </span>
      </li>

    </ul>
</div>
</body>
</html>