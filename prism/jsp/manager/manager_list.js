//用户
function func_user(data){
	var user_id = data["USER_ID"];
	var str ='';	
	str+='<a href="javascript:func_user_opt('+user_id+')">[赋权]</a>';
	str+='<a href="javascript:func_user_upt('+user_id+')">[修改]</a>';
	str+= '<a href="javascript:func_user_del('+user_id+')">[删除]</a>';
	return str;
}
function func_user_upt(id){
	win("url:jsp/manager/user_info_win.jsp?id="+id,"用户资料修改","user_upt.do");
}
function func_user_del(id){
	$.post("user_del.do",{USER_ID:id},function(data){		
	},"json");
}
// 菜单
function func_menu(data){
	var id = data["MENU_ID"];
	var str ='';	
	str+='<a href="javascript:func_opt('+id+')">[修改]</a>';
	return str;
}
//字典
function func_enum(data){
	var id = data["MENU_ID"];
	var str ='';	
	str+='<a href="javascript:func_opt('+id+')">[修改]</a>';
	return str;
}
