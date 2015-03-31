function func_oper(data){
	var TEMINAL_INFO_ID = data["TEMINAL_INFO_ID"];
	var APPPAY_ID = data["APPPAY_ID"];
	
	var str ='';	
	str+='<a href="javascript:func_clean(\''+TEMINAL_INFO_ID+'\',\''+APPPAY_ID+'\')">[初始化]</a>';
	return str;
}
function func_clean(V_TEMINAL_INFO_ID,V_APPPAY_ID){
	//alert(TEMINAL_INFO_ID+"=="+APPPAY_ID);
	$.post("tat_clean.do",{TEMINAL_INFO_ID:V_TEMINAL_INFO_ID,APPPAY_ID:V_APPPAY_ID},function(data){
		alert(data);
		queryInfo();
	});
}
