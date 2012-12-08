###
= require jquery
= require jquery_ujs
= require jquery-ui
= require bootstrap
= require_tree ./lib
= require_tree ./application
= require jquery_nested_form
###

$(document).ready ->
  $('input.date_picker').datepicker({autoclose: true})
  $('select').chosen({search_contains: true, allow_single_deselect: true})
  $('input[title]').tooltip
    html: true
  $('.chzn-container[title]').tooltip
    html: true
