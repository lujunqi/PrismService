
$(function() {
	init();
});

function init(){	
	var req = {};
	req["@minnum"] = 0;
	dataList(req);
}
function dataList(req){
	req["@maxnum"] = req["@minnum"] + pageSize;
	var param = {};
	param["data"] = req;
	param["total_page"] = "#pages";
	param["total_url"] = "user_info_total!select2Json.action";
	
	$("#user").prism(param,function(){
		//initComTablList();

		//paginate("#pages","user_info_total!select2Json.action",req,dataList);

	});
}

function initComTablList(){
	// comTablList 


		$('.comTabList').each(function() {
			$(this).find('tr:first').addClass('first').end().find('tr:last').addClass('last');
			$('tr:odd', this).addClass('odd');
			$('tr:even', this).addClass('eve');
			$('tr', this).each(function() {
				$(this).find('th:last, td:last').addClass('last');
			});
			$('tr').hover(function() {
				$(this).addClass('hover');
			}, function() {
				$(this).removeClass('hover');
			});
			return false;
		});
	}

function initPwd(id){
	$.dialog({
		content: '是否初始化该账号密码',
		max: false,min: false,
		ok: function(){
			var url = "user_pwd_init!updateObject.action";
			$.post(url,{USER_ID:id},function(data){
				if(data["code"]==0){
					$.dialog({max: false,min: false,content:"密码已初始化"});
					true;
				}else{
					$.dialog({max: false,min: false,content:data["result"]});
				}
			},"json");
			
		},
		cancelVal: '关闭',
		cancel: true /*为true等价于function(){}*/
	});
}
function del(id){
	$.dialog({
		content: '是否注销该账号',
		max: false,min: false,
		ok: function(){
			var url = "user_del!updateObject.action";
			$.post(url,{USER_ID:id},function(data){
				if(data["code"]==0){
					$.dialog({max: false,min: false,content:"用户已注销！"});
					init();
					true;
				}else{
					$.dialog({max: false,min: false,content:data["result"]});
				}
			},"json");
			
		},
		cancelVal: '关闭',
		cancel: true 
	});
}

//给一个用户授予某种权限
function privilege(user_id){
	$.dialog({
		title:"权限规则",
		content: 'url:sm/v_pri_spec.jsp?user_id='+user_id,
		ok: function(){
			var chks = $(".chk_spec",this.content.document.body);
			for(i=0;i<chks.length;i++){
				if(chks.eq(i).attr("checked")){
					//赋权
					var url="user_pri_auth_inst!insertObject.action";
					var param = {USER_ID:user_id,PRI_SPEC_ID_ID:chks.eq(i).val()};
					$.post(url,param,function(data){
						alert(data);
					});
				}
			}
		}
	});
	/**/
}

//取消用户的某种权限
function cancelPrivilege(user_id){
	$.dialog({
		title:"权限规则",
		content: 'url:sm/v_cancelpri_spec.jsp?user_id='+user_id,
		ok: function(){
			//定义被选中了的值
			var specId = "";
			var chks = $(".chk_spec",this.content.document.body);
			for(i=0;i<chks.length;i++){
				if(chks.eq(i).attr("checked")){
					if(specId ==""){
						specId = chks.eq(i).val()+",";
					}else{
						specId += chks.eq(i).val()+",";
					}
				}
			}
			//取消最后一个逗号
			specId = specId.substr(0,specId.length-1);
			//赋权
			var url="user_cancelpri_auth_inst!deleteData.action";
			var param = {PRI_SPEC_ID:specId,USER_ID:user_id};
			$.post(url,param,function(data){
				data = $.parseJSON(data);
				alert(data.result);
			});
		}
	});
	/**/
}

function addUser(){
	//这里要设置一个标识，当输入的用户名在数据库中已经存在的时候就不让用户提交(目前这个标识还没写的)
	$.dialog({
		title:"新增管理员",
		content: 'url:sm/v_add_user.jsp',
		ok: function(){
			if(this.content.checkData()){
				return false;
			}
			//登录名
			var loginName = $("#LOGIN_NAME",this.content.document.body).val();
			//登陆密码
			var loginPwd = $("#LOGIN_PWD",this.content.document.body).val();
			//确认登陆密码
			var loginPwd2 = $("#LOGIN_PWD2",this.content.document.body).val();
			//用户姓名
			var userName = $("#USER_NAME",this.content.document.body).val();
			//判断如果两次输入的密码不一样的话  就弹出错误提示信息
			if(loginPwd != loginPwd2){
				alert("两次输入的密码不一样");
				return false;
			}
			//提交注册的用户信息
			var url = "user_inst!insertObject.action";
			var param = {"LOGIN_NAME":loginName,"LOGIN_PWD":loginPwd,"LOGIN_PWD2":loginPwd2,"USER_NAME":userName};
			$.post(url,param,function(data){
				data = $.parseJSON(data);
				if(data.code =='0'){
					alert("新增成功");
					location.reload();
				}
			});
		}
	});
}