@GoogleMap = ()->
GoogleMap.init_google_map = () ->
  myOptions =
    center: new google.maps.LatLng(10.781135,106.698457)
    zoom: 15
    mapTypeId: google.maps.MapTypeId.ROADMAP

  GoogleMap.map = new google.maps.Map(document.getElementById("map_canvas"), myOptions)
  GoogleMap.marker = new google.maps.Marker(
    map: @map
    draggable: true
    animation: google.maps.Animation.DROP
    position: myOptions.center
  )
  google.maps.event.addListener @marker, "mouseup", GoogleMap.getLocation
  return [@map, @marker]

GoogleMap.getLocation = () ->
  position = GoogleMap.marker.getPosition()
  $('#hotel_lat').val(position.lat())
  $('#hotel_lng').val(position.lng())

GoogleMap.getLocationFromAddress = () ->
  address = $('#hotel_address1').val() + ', ' + $('#hotel_address2').val() + ', ' + $('#hotel_city').val() + ', ' + $('#hotel_state').val() + ', ' + $("#hotel_country option[value='"+$("#hotel_country").val()+"']").text()
  geocoder = new google.maps.Geocoder()
  geocoder.geocode({'address': address}, (results, status) ->
    if (status == google.maps.GeocoderStatus.OK)
      GoogleMap.marker.setPosition(results[0].geometry.location)
      GoogleMap.map.setCenter(results[0].geometry.location)
      google.maps.event.trigger(GoogleMap.marker, 'mouseup')
  )
GoogleMap.getAddress = () ->
  position = GoogleMap.marker.getPosition()
  geocoder = new google.maps.Geocoder()
  geocoder.geocode({'latLng': position}, (results, status) ->
    if (status == google.maps.GeocoderStatus.OK)
      components = results[0].address_components
      for component in components
        for type in component.types
          switch type
            when 'country'
              $('#hotel_country').val(component.short_name)
            when 'route'
              $('#hotel_address1').val($('#hotel_address1').val() + ' ' + component.long_name)
  )

$(document).ready ->
  GoogleMap.init_google_map()
  $('#search_google_map_link').click (e)->
    e.preventDefault()
    GoogleMap.getLocationFromAddress()
