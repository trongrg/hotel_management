module HotelHelpers
  def valid_hotel
    Hotel.make.attributes.symbolize_keys.except(:id, :owner_id, :created_at, :updated_at)
  end

  def create_hotel hotel
    hotel.each do |field, value|
      field = field.to_s.humanize
      if field == "Country"
        select value, :from => field
      else
        fill_in field, :with => value
      end
    end
    click_button "Create Hotel"
  end
end

World(HotelHelpers)
