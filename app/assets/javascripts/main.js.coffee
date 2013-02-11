//= require markitup
//= require markitup-settings

$(document).ready ->
  el = $("#comment_content")
  if el.length > 0
    el.markItUp(window.markitup_settings)