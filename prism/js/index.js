$(function(){
	
	$('.flexslider').flexslider({
	  animation:	'slide',
	  directionNav:	false
	});
	
	$(".tab").dewTabs({
		trigger:	'click',
		linked:		false,
		active:		0,
		delay:		0
	});
	
	$('.comList').each(function(index, element) {
		var $cmList = $(this);
		$cmList.children('li:gt(7)').hide();
        $cmList.next('.comListMore').find('a').click(function() {
			if($cmList.children('li:hidden').length > 0) {
				$cmList.children('li:hidden:lt(10)').show();
				$(window).scrollTop($(document).height());
			}
			else {
				alert('对不起，已经没有数据可加载！')
			}
			return false;
		});
    });
	
});