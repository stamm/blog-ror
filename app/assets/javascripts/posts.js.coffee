//= require markitup
//= require markitup-settings

$(document).ready ->
  $('#post_post_time').datepicker();
  $("textarea").markItUp(window.markitup_settings)
