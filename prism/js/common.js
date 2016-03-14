/**
* main
*/
$(document).ready(function(e) {
	$('.classify .list').show();
	$('.classify .tit').toggle(function(){
		$('.classify .list').hide();
		$(this).addClass('alt');
		return false;
	},function() {
		$('.classify .list').show();
		$(this).removeClass('alt');
		return false;
	});    
});

$(document).ready(function(e) {
	$('.popMemu').hide();
	$('#popMenuBtn').text('分类 >>');
	$('#popMenuBtn').toggle(function(){
		$(this).text('<< 分类');
		$('.popMemu').show(180);
		return false;
	},function() {
		$(this).text('分类 >>');
		$('.popMemu').hide(180);
		return false;
	});    
});

$(document).ready(function(e) {
	$('.slide-cnt').hide();
	$('.slide-btn').toggle(function(){
		$(this).addClass('alt');
		$('.slide-cnt').slideDown('fast');
		return false;
	},function() {
		$(this).removeClass('alt');
		$('.slide-cnt').slideUp('fast');
		return false;
	});    
});