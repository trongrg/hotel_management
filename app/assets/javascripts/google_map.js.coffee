@GoogleMap = ()->
GoogleMap.initGoogleMap = (options = {lat: 10.781135, lng: 106.698457, canvasId: "map_canvas"}) ->
  myOptions =
    center: new google.maps.LatLng(options.lat, options.lng)
    zoom: 15
    mapTypeId: google.maps.MapTypeId.ROADMAP

  GoogleMap.map = new google.maps.Map(document.getElementById(options.canvasId), myOptions)
  GoogleMap.marker = new google.maps.Marker(
    map: @map
    draggable: true
    animation: google.maps.Animation.DROP
    position: myOptions.center
  )
  google.maps.event.addListener @marker, "mouseup", GoogleMap.getLocationFromMarker
  return [@map, @marker]

GoogleMap.getLocationFromMarker = () ->
  position = GoogleMap.marker.getPosition()
  $('#hotel_location_attributes_latitude').val(position.lat()).data('changed', true)
  $('#hotel_location_attributes_longitude').val(position.lng()).data('changed', true)

GoogleMap.getLocationFromAddress = () ->
  address = ($('#hotel_address_attributes_'+field).val() for field in ['line1', 'line2', 'city', 'state', 'country']).join(", ")
  $.ajax
    url: '/geocoder/get_location'
    dataType: 'json'
    data: {address: address}
    type: 'POST'
    success: (result) ->
      $('#hotel_location_attributes_latitude').val(result[0]).data('changed', true)
      $('#hotel_location_attributes_longitude').val(result[1]).data('changed', true)
      if ( google? )
        position = new google.maps.LatLng(result[0], result[1])
        GoogleMap.marker.setPosition(position)
        GoogleMap.map.setCenter(position)

GoogleMap.getAddressFromLocation = () ->
  # position = GoogleMap.marker.getPosition()
  $('.address').val('')
  $.ajax(
    url: '/geocoder/get_address'
    dataType: 'json'
    data: {location: [$("#hotel_location_attributes_latitude").val(), $("#hotel_location_attributes_longitude").val()]}
    type: 'POST'
    success: (result) ->
      address = {line1: '', line2: '', city: '', state: '', country: '', zip_code: ''}
      for component in result
        if ($.inArray('street_number', component.types) > -1)
          address.line1 = component.long_name
        else if ($.inArray('route', component.types) > -1)
          address.line1 = address.line1 + ' ' + component.long_name
        else if ($.inArray('neighborhood', component.types) > -1)
          address.line2 = component.long_name
        else if ($.inArray('sublocality', component.types) > -1)
          address.line2 = address.line2 + ' ' + component.long_name
        else if ($.inArray('locality', component.types) > -1 || $.inArray('administrative_area_level_2', component.types) > -1)
          address.city = component.long_name
        else if ($.inArray('administrative_area_level_1', component.types) > -1)
          address.state = component.long_name
        else if ($.inArray('country', component.types) > -1)
          address.country = component.short_name
        else if ($.inArray('postal_code', component.types) > -1)
          address.zip_code = component.long_name
      for field, value of address
        $("#hotel_address_attributes_"+field).val(value).data("changed", true)
        $("#hotel_address_attributes_"+field).trigger('liszt:updated') if field == 'country'
  )
  false

$(document).ready ->
  if ( google? )
    GoogleMap.initGoogleMap()
  $('#search_google_map_link').click (e)->
    e.preventDefault()
    GoogleMap.getLocationFromAddress()
  $('#get_address_link').click (e)->
    e.preventDefault()
    GoogleMap.getAddressFromLocation()
