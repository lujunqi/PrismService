$(document).ready(function(e) {
    $('.uploader').each(function(index, element) {
		var $uploader = $(this);
		var $path = $('.path', $uploader);
		var $file = $('.file', $uploader);
		$file.change(function() {
			var filePath = $(this).val().split('\\');;
			$path.val(filePath[filePath.length-1]);
		})
    });
});