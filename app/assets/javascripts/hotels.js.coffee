$(document).ready ()->
  $('#create_hotel_btn').click ()->
    $.ajax({
      url: '/hotels/new',
      type: 'GET',
      success: (html_response)->
        # console.log($(html_response))
        $("#modal").html(html_response)
        $("#modal").modal()
        $("form#new_hotel").validate()
        $("form#new_hotel #hotel_submit_action button").click ->
          $("form#new_hotel input").data("changed", true)
        $("form#new_hotel").ajaxForm(
          dataType: 'json',
          success: (response)->
            $notice = $("<div class='alert alert-success'/>").append("<a class='close' data-dissmiss='alert'>×</a>").append("<div id='flash_notice'>Hotel has been created successfully.</div>")
            $("#flash").html($notice)
            new_hotel = $("#hotels .tabular_data ul.template>li").clone()
            new_hotel.find(".title a").html(response.name)
            new_hotel.find(".title a").attr("href", "/hotels/"+response.id)
            new_hotel.find("a.edit_link").attr("href", "/hotels/"+response.id+"/edit")
            new_hotel.find("a.delete_link").attr("href", "/hotels/"+response.id)
            new_hotel.find("a.delete_link").data("confirm", new_hotel.find("a.delete_link").data("confirm").replace("{hotel_name}", response.name))
            $("#hotels .tabular_data ul.tbody").append(new_hotel)
            $("#modal").modal('hide')
        )
        $('select').chosen()
    })
    false
  $('select').chosen()
