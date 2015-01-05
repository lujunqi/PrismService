var displayBar = true;
function switchBar() {
	var $parentDoc = $(window.parent.document);
	var $togBtn = $('#togSide');
    if (displayBar) {
        displayBar=false;		
		$('#mid',$parentDoc).prop('cols', '0,*');
		$togBtn.text('>').attr('title', '打开左边管理菜单');
    }
    else {
        displayBar=true;
		$('#mid',$parentDoc).prop('cols', '190,*');
		$togBtn.text('<').attr('title', '打开左边管理菜单');
    }
}


// checkAllBox
function bindCheck($obja, $objb) {
	if ($obja.attr('checked') == 'checked') {
		$objb.attr('checked', 'checked');
	}
	else {
		$objb.removeAttr('checked');
	}		
}
function checkAll() {	
	$('#cbCheckAll').click(function() {
		bindCheck($(this), $('#cbSelectAll'));
		$('#cbSelectAll').click();
		bindCheck($(this), $('#cbSelectAll'));		
	});
	// checkAll
	$('#cbSelectAll').click(function() {
		bindCheck($('#cbSelectAll'),$(this));
		if ($(this).attr('checked') == 'checked') {
			$('[name="tabCheck"]').attr('checked', 'checked');
		}
		else {			
			$('[name="tabCheck"]').removeAttr('checked');
		}
		bindCheck($(this), $('#cbCheckAll'));
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
$(function() {
	// switch sidebar
	$('body.mainBody').append('<a id="togSide" href="#" title="收缩侧边栏">&lt;</a>');
	$('#togSide').click(switchBar);		
	checkAll();	// checkAllBox
	init();
});

//页面初始化调用的初始化方法
function init(){
	//初始化数据库数据（第一次加载，查询出所有符合条件的数据）
	$("#mymenu").prism({},function(){
		/**********************************/
		initComTablList();
		//$('.cls212:odd').addClass('odd');
		//$('.cls212:even').addClass('eve');
			
	});
}

//新增菜单方法begin
function addMenu(){
	$.dialog({
		title:"新增菜单",
		content: 'url:sm/v_add_menu.jsp',
		ok: function(){
		
			if(this.content.checkData()){
				return false;
			}
			//菜单名称
			var menuName = $("#menuName",this.content.document.body).val();
			//菜单路径
			var menuUrl = $("#menuUrl",this.content.document.body).val();
			//排序号
			var menuOrder = $("#menuOrder",this.content.document.body).val();
			//确认登陆密码
			var url = "menu_insert!insertObject.action";
			var param = {"menuName":menuName,"menuUrl":menuUrl,"menuOrder":menuOrder};
			$.post(url,param,function(data){
				data = $.parseJSON(data);
				if(data.code =='0'){
					$.dialog({max: false,min: false,content:"新增成功！"});
					location.reload();
				}
			});
		}
	});
}
//新增菜单方法end

//选择父菜单begin
function selectParentMenu(menuId){
	$.dialog({
		title:"选择父菜单",
		height:100,
		width:200,
		content: 'url:sm/v_select_parentMenu.jsp',
		ok: function(){
		
			var parentMenus = $("[name='chk_parentMenu']",this.content.document.body);
			//被选择的父菜单
			var parentMenuId;
			parentMenus.each(function(){
				if(this.checked){
					parentMenuId = $(this).val();
				}
			});
			var url = "select_parent_menu!updateObject.action";
			var param = {"menuId":menuId,"parentMenuId":parentMenuId};
			$.post(url,param,function(data){
				data = $.parseJSON(data);
				if(data.code =='0'){
					$.dialog({max: false,min: false,content:"操作成功！"});
					window.parent.frames["side"].location.reload();
				}
			});
		}
	});
}
//选择父菜单end

//删除菜单begin
function deleteMenu(menuId){
		$.dialog({
			content: '是否删除该目录',
			max: false,min: false,
			ok: function(){
				var url = "menu_del!updateObject.action";
				$.post(url,{"menuId":menuId},function(data){
					if(data["code"]==0){
						$.dialog({max: false,min: false,content:"操作成功！"});
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
//删除菜单end