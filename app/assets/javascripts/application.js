//= require jquery
//= require jquery_ujs
//= require_tree ./application
//= require_self
//= require rails.validations

$(document).ready(function(){
  $("ul.nav_links").superfish({
    hoverClass: 'active',
    delay: 800,
    autoArrows: false,
    dropShadows: false
  });
  $("ul.account_nav").superfish({
    hoverClass: 'active',
    delay: 800,
    autoArrows: false,
    dropShadows: false
  });
});
