// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
	$('.clearMeFocus').each(function(){
		if($(this).val()=="")
		{
			$(this).addClass('clear-me-init');
			$(this).val($(this).attr('title'));
		}
	});
		
	// clear input on focus
	$('.clearMeFocus').focus(function()
		{
			if($(this).val()==$(this).attr('title'))
			{
				$(this).val('');
				$(this).toggleClass('clear-me-init');
			}
	});
	
	// if field is empty afterward, add text again
	$('.clearMeFocus').blur(function()
		{
			if($(this).val()=='')
		{
			$(this).val($(this).attr('title'));
			$(this).toggleClass('clear-me-init');
		}
	});
});