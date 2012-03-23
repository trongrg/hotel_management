@GoogleMap = ()->
GoogleMap.init_google_map = (lat = 10.781135, lng = 106.698457) ->
  myOptions =
    center: new google.maps.LatLng(lat, lng)
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
  $("#hotel_lat").data("changed", true)
  $("#hotel_lng").data("changed", true)

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
  $('.address').val('')
  geocoder.geocode({'latLng': position}, (results, status) ->
    if (status == google.maps.GeocoderStatus.OK)
      address = {address1: '', address2: '', city: '', state: '', country: '', zip_code: ''}
      for component in results[0].address_components
        if ($.inArray('street_number', component.types) > -1)
          address.address1 = component.long_name
        else if ($.inArray('route', component.types) > -1)
          address.address1 = address.address1 + ' ' + component.long_name
        else if ($.inArray('neighborhood', component.types) > -1)
          address.address2 = component.long_name
        else if ($.inArray('sublocality', component.types) > -1)
          address.address2 = address.address2 + ' ' + component.long_name
        else if ($.inArray('locality', component.types) > -1 || $.inArray('administrative_area_level_2', component.types) > -1)
          address.city = component.long_name
        else if ($.inArray('administrative_area_level_1', component.types) > -1)
          address.state = component.long_name
        else if ($.inArray('country', component.types) > -1)
          address.country = component.short_name
        else if ($.inArray('postal_code', component.types) > -1)
          address.zip_code = component.long_name
      for field, value of address
        $("#hotel_"+field).val(value)
  )

$(document).ready ->
  if (typeof lat == 'undefined' && typeof lng == 'undefined')
    GoogleMap.init_google_map()
  else
    GoogleMap.init_google_map(lat, lng)
  $('#search_google_map_link').click (e)->
    e.preventDefault()
    GoogleMap.getLocationFromAddress()
  $('#get_address_link').click (e)->
    e.preventDefault()
    GoogleMap.getAddress()
    GoogleMap.getLocation()
