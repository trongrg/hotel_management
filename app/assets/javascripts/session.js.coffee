#= require jquery
#= require jquery_ujs
$(document).ready ->
  $('.placeholder #user_username, .placeholder #user_password').focus ->
    $(this).siblings('label').hide()
  $('.placeholder #user_username, .placeholder #user_password').blur ->
    $(this).siblings('label').show()
