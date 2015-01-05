	var param={};
	var req={};
	param["data"] = req;
	/*分页begin*/
	req["@minnum"] = 0;
	param["total_page"] = "#pages";
	param["pageSize"] = 3;
	param["display"] = 10;
	param["total_url"] = "employee_info_total!selectObject.action";
/**
 * 页面初始化的时候加载init()方法
 */
$(function() {
	init();
});

/**
 * init方法需要参数@minnum(供后台分页用)
 * 该方法主要用途是创建一个req对象，把要传递到后台的参数统统都封装在这个对象里，
 * 然后再通过第24行param["data"] = req把这个对象继承到这个框架中，
 * 最后由框架把这些参数解析之后通过HttpServletRequest对象传递到后台
 * @return
 */
function init(){	
	$("#departmentS").prism(null,function(){
		showLoader();
		setTimeout($.unblockUI, 1000);
		//window.setTimeout("$.unblockUI()",1500);
		var op = $("<option value='' selected='selected' >请选择部门</option>");
		$("#departmentS").prepend(op);
		var node = $("#departmentS");
		findEmployee(node.val());
	});
	//发送请求到后台、加载数据的方法
	dataList();
}

/**
 * 发送请求到后台、加载数据的方法
 * @param req
 * @return
 */
function dataList(){
	$("#employee").prism(param,	function(data){
		initComTablist();
	});
	
	/*$("#employee").prism(param,function(){
		alert(1);
		initComTablList();
		//paginate("#pages","employee_info_total!select2Json.action",req,dataList);
	});*/
	
}
function findEmployee(departmentId){
	
	var obj={};
	var department = {};
	department["DPT_ID"] = departmentId;
	obj["data"] = department;
	$("#employeeS").prism(obj,function(data){
		if(data[0]!=null){
			var empNode = $("<option value= '' selected='selected' >全部</option>")
			$("#employeeS").prepend(empNode);
		}
	});
}




//删除员工beging
function deleteEmployee(id){
	$.dialog({
		title:"确认删除",
		content: '是否删除该员工',
		fixed: true,
		max: false,
		min: false,
		resize: false,
		drag: false,
		lock: true,
		lockScroll:true,
		ok: function(){
			var url = "employee_delete!updateObject.action";
			$.post(url,{EMP_ID:id},function(data){
				if(data["code"]==0){
					$.dialog({max: false,min: false,content:"员工已删除！"});
					init();
				}else{
					$.dialog({max: false,min: false,content:data["result"]});
				}
			},"json");
			
		},
		cancelVal: '关闭',
		cancel: true 
	});
}
//删除员工end


//修改员工信息begin
function updateEmployee(employee_id){
	$.dialog({
		title:"修改员工信息",
		width:380,
		height:220,
		fixed: true,
		max: false,
		min: false,
		resize: false,
		drag: false,
		lock: true,
		lockScroll:true,
		content: 'url:page/v_update_employee.jsp?employee_id='+employee_id,
		ok: function(){
			//员工姓名
			var employeeName = $("#EMP_NAME",this.content.document.body).val();
			//员工电话
			var employeePhone = $("#EMP_PHONE",this.content.document.body).val();
			//提交注册的用户信息
			var url = "employee_update!updateObject.action";
			var param = {"EMP_NAME":employeeName,"EMP_PHONE":employeePhone,"EMP_ID":employee_id};
			$.post(url,param,function(data){
				data = $.parseJSON(data);
				if(data.code =='0'){
					alert("修改成功");
					location.reload();
				}
			});
		}
	});
}
//修改员工信息end

//增加员工信息begin
function addEmployee(){
	$.dialog({
		title:"新增员工",
		width:380,
		fixed: true,
		max: false,
		min: false,
		resize: false,
		drag: false,
		lock: true,
		lockScroll:true,
		content: 'url:page/v_add_employee.jsp',
		ok: function(){
			if(this.content.checkData()){
				return false;
			}
			//员工姓名
			var employeeName = $("#EMP_NAME",this.content.document.body).val();
			//所属部门
			var department = $("#DEPARTMENT",this.content.document.body).val();
			//员工电话
			var employeePhone = $("#EMP_PHONE",this.content.document.body).val();
			//身份证号
			var employeeSex = $("#EMP_SEX",this.content.document.body).val();
			//入职时间
			var entryTime = $("#ENTRY_TIME",this.content.document.body).val();
			//提交注册的用户信息
			var url = "employee_insert!insertEmployee.action";
			var param = {"EMP_NAME":employeeName,"DPT_ID":department,"EMP_PHONE":employeePhone,"EMP_SEX":employeeSex,"ENTRY_TIME":entryTime};
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
//增加员工信息end

//带条件查询
function queryEmployeeInfo(){
	req["DPT_ID"] = "";
	req["GROUP_ID"] = "";
	req["QUERY_STRING"] = "";
	req["@minnum"] = 0;
	showLoader();
	window.setTimeout("$.unblockUI()",1500);
	var groupId = $("#employeeS").val();
	var dptId = $("#departmentS").val();
	var queryString = $("#search").val();
	if(groupId !="" && groupId != null){
		req["GROUP_ID"] = groupId;
	}
	if(dptId !="" && dptId != null){
		req["DPT_ID"] = dptId;
	}
	if(queryString !=""){
		req["QUERY_STRING"] = queryString;
	}
	param["data"] = req;
	$("#employee").prism(param);
}//带条件查询end

//导出数据
function exportEmployeeInfo(){
	document.getElementById("report").submit();
}

//分页功能
function paginates(node){
	showLoader();
	setTimeout($.unblockUI,1500);
	var pageN = $(node).text();
	curpage = pageN;
	param["curPage"] = pageN;
	req["@minnum"] =(pageN-1)*param["pageSize"];
	req["@maxnum"] = pageN*param["pageSize"];
	$("#employee").prism(param);
	
}

//后十条
function behidenTen(node){
	showLoader();
	setTimeout($.unblockUI, 1500);
	var lastPageInControl = $("#pages").children("a:last").prev().text();
	var firstPageInControl = $("#pages").children("a:first").next().text();
	if(lastPageInControl - firstPageInControl > 10){
		param["startPage"] = (firstPageInControl-0)+10;
		$("#employee").prism(param,	initComTablist);
	}else{
		return;
	}
}
//前十条
function beforeTen(node){
	showLoader();
	setTimeout($.unblockUI, 1500);
	var firstPageInControl = $("#pages").children("a:first").next().text();
	if((firstPageInControl-0)>1){
		var startPage = (firstPageInControl-0)-10;
		if(startPage < 1){
			startPage =1;
		}
		param["startPage"] = startPage;
		$("#employee").prism(param,	initComTablist);
	}else{
		return;
	}
}