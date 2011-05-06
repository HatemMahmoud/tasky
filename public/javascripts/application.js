$(document).keypress(function(e) {
  if (e.keyCode == 27) {  // esc 
    $(".editable_form").hide();
    $(".editable").show(); 
  }
});

$(".editable").live("click", function() {
  $(this).hide();
  $(this).siblings("form").show().children("#task_name")[0].focus();
});

$(".toggle").live("click", function() {
  $(this).closest("form").submit();
});