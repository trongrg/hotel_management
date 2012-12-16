class GeocoderController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def get_location
    results = Geocoder.coordinates(params[:address])
    if results.length > 0
      render :json => results
    else
      render :text => "", :status => 404
    end
  end

  def get_address
    results = Geocoder.search(params[:location])
    if results.length > 0
      render :json => results.first.address_components
    else
      render :text => "", :status => 404
    end
  end
end
