$(document).keypress(function(e) {
  // esc
  if (e.keyCode == 27) { 
    $('section form').css("display", "none");
    $('.editable').css("display", "inline"); 
  }
});

$('.editable').live('click', function() {
  $(this).css("display", "none");
  $(this).siblings("form").css("display", "inline").children('#task_name')[0].focus();
});