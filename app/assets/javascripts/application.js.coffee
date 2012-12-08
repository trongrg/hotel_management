###
= require jquery
= require jquery_ujs
= require jquery-ui
= require bootstrap
= require_tree ./lib
= require_tree ./application
###

$(document).ready ->
  $('input.date_picker').datepicker({autoclose: true})
  $('select').chosen({search_contains: true})
  $('input[title]').tooltip
    html: true
  $('.chzn-container[title]').tooltip
    html: true
