
function deleteMany() {
	
		if(validateIsSelect()) {	
			//alert(1);
			deleteDepartment11();
		}else {
			alert("请选择要操作的记录");
		}		
	}

/*
 * 判断是否选择了记录
 */
function validateIsSelect(){
	var t = $("#tabCheck:checked");
	if(t.length>0){
		return true;
	}else{
		return false;
	}
}

function checkAll() {
	
	// checkAll
	$('#cbSelectAll').change(function(){
		if(this.checked==true){
			$(".select").each(function(){this.checked = true});
		}else{
			$(".select").each(function(){this.checked = false});
		}
	});
	
}


/**
 * 页面初始化的时候加载init()方法
 */
$(function() {
	init();
	checkAll();
});

/**
 * init方法需要参数@minnum(供后台分页用)
 * 该方法主要用途是创建一个req对象，把要传递到后台的参数统统都封装在这个对象里，
 * 然后再通过第24行param["data"] = req把这个对象继承到这个框架中，
 * 最后由框架把这些参数解析之后通过HttpServletRequest对象传递到后台
 * @return
 */
function init(){	
	var req = {};
	req["@minnum"] = 0;	
	//发送请求道后台、加载数据的方法
	dataList(req);

}

/**
 * 发送请求道后台、加载数据的方法
 * @param req
 * @return
 */
function dataList(req){
	//req["@maxnum"] = req["@minnum"] + pageSize;
	//param对象是框架规定用来传递参数到后台的对象
	var param = {};
	param["data"] = req;
	//加载数据到ID位user的HTML组件上    prism需要一个参数对象param和一个回调函数其中param是传递到后台的对象，
	//回调函数主要是用来把数据都显示到列表中
	param["total_page"] = "#pages";
	param["pageSize"] = 4;

	param["total_url"] = "department_info_total!select2Json.action";
	$("#department").prism(param);
	
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


//删除部门beging
function deleteDepartment11(){
	//alert(111);
	$.dialog({
		content: '是否删除该部门',
		max: false,min: false,
		ok: function(){
			var url = "department_manydelete!updateObject.action";
			var t = $(".select:checked");
			var mulSelect= [];			
			for(var i=0;i<t.length;i++){
				var v = t.eq(i).val();			
				mulSelect[i] = v;			
			}
			mulSelect[mulSelect.length]=-1;
			//alert(mulSelect);	
			/*var req1 = {};
			req1["DPT_IDS"] = mulSelect; */
			$.post(url,{"DPT_IDS":mulSelect},function(data){	
				//alert(data);
				if(data["code"]==0){
					$.dialog({max: false,min: false,content:"部门已删除！"});
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
//删除部门end


//修改部门信息begin
function updateDepartment1(department_id,department_parent,department_mgr){
	$.dialog({
		title:"修改部门信息",		
		content: 'url:page/update_department.jsp?department_id='+department_id +'&department_parent='+department_parent + '&department_mgr='+department_mgr,
		height:200,
		ok: function(){
			if(this.content.checkData()){
				return false;
			}
			//部门名称
			var departmentName = $("#DPT_NAME",this.content.document.body).val();
			//部门管理员
			var departmentManager = $("#DPT_MANAGER",this.content.document.body).val();
			//部门电话
			var departmentPhone = $("#DPT_PHONE",this.content.document.body).val();
			//上级部门
			var departmentParent = $("#DPT_PARENT",this.content.document.body).val();
			//部门职能描述
			var departmentDesc = $("#DPT_DESC",this.content.document.body).val();
			//提交注册的部门信息
			var url = "department_update!updateObject.action";
			var param = {"DPT_NAME":departmentName,"DPT_MANAGER":departmentManager,"DPT_PHONE":departmentPhone,"DPT_PARENT":departmentParent,"DPT_DESC":departmentDesc,"DPT_ID":department_id};
			//alert(111);
			$.post(url,param,function(data){
				//alert(1111111);
				data = $.parseJSON(data);
				if(data.code =='0'){
					alert("修改成功");
					location.reload();
				}
			});
		}
	
	});
}
//修改部门信息end

//增加部门信息begin
function addDepartment(){
	
	$.dialog({
		title:"新增部门",
		content: 'url:page/add_department.jsp',
		ok: function(){
			if(this.content.checkData()){
				return false;
			}
			//部门名称
			var departmentName = $("#DPT_NAME",this.content.document.body).val();
			//部门管理员
			var departmentManager = $("#DPT_MANAGER",this.content.document.body).val();
			//部门电话
			var departmentPhone = $("#DPT_PHONE",this.content.document.body).val();
			//上级部门
			var departmentParent = $("#DPT_PARENT",this.content.document.body).val();			
			//部门职能描述
			var departmentDesc = $("#DPT_DESC",this.content.document.body).val();
			//alert(111);	
			//提交注册的用户信息
			var url = "department_insert!insertObject.action";		
			if(departmentParent!=null && departmentParent!='null'){
				var param = {"DPT_NAME":departmentName,"DPT_MANAGER":departmentManager,"DPT_PHONE":departmentPhone,"DPT_PARENT":departmentParent,"DPT_DESC":departmentDesc};
			}else {
				param = {"DPT_NAME":departmentName,"DPT_MANAGER":departmentManager,"DPT_PHONE":departmentPhone,"DPT_PARENT":0,"DPT_DESC":departmentDesc};
			}
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
//增加部门信息end