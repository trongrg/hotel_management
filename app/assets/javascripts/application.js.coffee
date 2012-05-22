//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_tree ./application
//= require_self
//= require rails.validations
//= require rails.validations.custom

$(document).ready ()->
  $("select").chosen()
  $(".date_picker>input").datepicker
    dateFormat: 'dd/mm/yy'
  $("ul.nav_links").superfish
    hoverClass: 'active',
    delay: 800,
    autoArrows: false,
    dropShadows: false
  $("ul.account_nav").superfish
    hoverClass: 'active',
    delay: 800,
    autoArrows: false,
    dropShadows: false

  if $.browser.msie
    "article aside footer header nav section time".replace /\w+/g, (n) ->
      document.createElement n
