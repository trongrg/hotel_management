@GoogleMap = ()->
GoogleMap.initGoogleMap = (lat = 10.781135, lng = 106.698457, canvasId = "map_canvas") ->
  myOptions =
    center: new google.maps.LatLng(lat, lng)
    zoom: 15
    mapTypeId: google.maps.MapTypeId.ROADMAP

  GoogleMap.map = new google.maps.Map(document.getElementById(canvasId), myOptions)
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

GoogleMap.setLocationFromAddress = () ->
  address = null
  $.each(['line1', 'line2', 'city', 'state'], (index, field)->
    address += $('#hotel_address_attributes_'+field).val() + ', '
  )
  address+= $("#hotel_address_attributes_country option[value='"+$("#hotel_country").val()+"']").text()
  geocoder = new google.maps.Geocoder()
  geocoder.geocode({'address': address}, (results, status) ->
    if (status == google.maps.GeocoderStatus.OK)
      GoogleMap.marker.setPosition(results[0].geometry.location)
      GoogleMap.map.setCenter(results[0].geometry.location)
      google.maps.event.trigger(GoogleMap.marker, 'mouseup')
  )
GoogleMap.getAddressFromMarker = () ->
  position = GoogleMap.marker.getPosition()
  geocoder = new google.maps.Geocoder()
  $('.address').val('')
  geocoder.geocode({'latLng': position}, (results, status) ->
    if (status == google.maps.GeocoderStatus.OK)
      address = {line1: '', line2: '', city: '', state: '', country: '', zip_code: ''}
      for component in results[0].address_components
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
        $("#hotel_address_attributes_"+field).val(value)
        $("#hotel_address_attributes_"+field).data("changed", true)
        $("#hotel_address_attributes_"+field).trigger('liszt:updated') if field == 'country'
  )

$(document).ready ->
  if ( typeof google != 'undefined' )
    if ( typeof lat == 'undefined' && typeof lng == 'undefined' )
      GoogleMap.initGoogleMap()
    else
      GoogleMap.initGoogleMap(lat, lng)
    $('#search_google_map_link').click (e)->
      e.preventDefault()
      GoogleMap.setLocationFromAddress()
    $('#get_address_link').click (e)->
      e.preventDefault()
      GoogleMap.getAddressFromMarker()
      GoogleMap.getLocationFromMarker()
