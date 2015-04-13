function func_oper(data){
	var user_id = data["USER_ID"];
	var str ='';	
	str+='<a href="javascript:func_opt('+user_id+')">[赋权]</a>';
	str+='<a href="javascript:func_upt('+user_id+')">[修改]</a>';
	str+= '<a href="javascript:func_del('+user_id+')">[删除]</a>';
	return str;
}
function func_upt(id){
	win("url:jsp/manager/user_info_win.jsp?id="+id,"用户资料修改","user_upd.do");
}
function func_del(id){
	win("url:jsp/manager/user_info_win.jsp?id="+id,"用户资料修改","user_upd.do");
	$.post("user_del.do",{USER_ID:id},function(data){
		
	},"json");
}
