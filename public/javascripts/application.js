$(document).keypress(function(e) {
  if (e.keyCode == 27) {  // esc 
    $(".editable_form").hide();
    $(".editable").css("display", "inline"); 
  }
});

$(".editable").live("click", function() {
  $(this).hide();
  $(this).siblings("form").css("display", "inline");
});

$(".toggle").live("click", function() {
  $(this).closest("form").submit();
});