$(document).ready(function() {
  $('#loading').ajaxStart(function(){
    $(this).show();
  }).ajaxComplete(function(){
    $(this).hide();
  });
});