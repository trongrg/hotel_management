$(document).ready ()->
  $('#create_hotel_btn').click ()->
    $.ajax({
      url: '/hotels/new',
      data: 'json',
      type: 'GET',
      success: (html_response)->
        $.facebox(html_response)
        $("form#new_hotel").validate()
        $("form#new_hotel").ajaxForm(
          dataType: 'json',
          success: (response)->
            $.facebox.close()
            $("#flash").html("<div id='notice'>"+response.notice+"</div>")
            new_hotel = $("#hotels .tabular_data ul.template>li").clone()
            new_hotel.find(".title a").html(response.result.name)
            new_hotel.find(".title a").attr("href", "/hotels/"+response.result.id)
            new_hotel.find("a.edit_link").attr("href", "/hotels/"+response.result.id+"/edit")
            new_hotel.find("a.delete_link").attr("href", "/hotels/"+response.result.id)
            new_hotel.find("a.delete_link").data("confirm", new_hotel.find("a.delete_link").data("confirm").replace("{hotel_name}", response.result.name))
            $("#hotels .tabular_data ul.tbody").append(new_hotel)
        )
        $('select').chosen()
    })
  $('select').chosen()
