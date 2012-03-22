$(document).ready ()->
  $('#create_hotel_btn').click ()->
    $.ajax({
      url: '/hotels/new',
      data: 'json',
      type: 'GET',
      success: (html_response)->
        $.facebox(html_response)
        $("form#new_hotel").ajaxForm(
          dataType: 'json'
        )
    })
  $('select').chosen()
