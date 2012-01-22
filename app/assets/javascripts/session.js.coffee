$(document).ready ->
  $('#user_username').focus ->
    $("label[for='user_username']").hide()
  $('#user_username').blur ->
    $("label[for='user_username']").show()

  $('#user_password').focus ->
    $("label[for='user_password']").hide()
  $('#user_password').blur ->
    $("label[for='user_password']").show()
