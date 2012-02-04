#= require jquery
#= require jquery_ujs
$(document).ready ->
  $('#user_username').focus ->
    $("label[for='user_username']").hide()
  $('#user_username').blur ->
    if $('#user_username').val().length == 0
      $("label[for='user_username']").show()

  $('#user_password').focus ->
    $("label[for='user_password']").hide()
  $('#user_password').blur ->
    if $('#user_password').val().length == 0
      $("label[for='user_password']").show()
