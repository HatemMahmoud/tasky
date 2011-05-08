// always set focus on new task name
$('#add_task #task_name').focus();

// check/uncheck
$('.toggle').live('click', function() {
  $(this).closest('form').submit();
});

// start editing
$('.editable').live('click', function() {
  $(this).children().hide();
  $(this).children('form').css('display', 'inline');
  $(this).children('form').first().children('input').first().focus();
});

// cancel editing
$(document).keypress(function(e) {
  if (e.keyCode == 27) {  // esc
    $('.editable').children().show();
    $('.editable_form').hide();
  }
});