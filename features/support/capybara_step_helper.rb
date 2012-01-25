module CapybaraStepHelper
  def valid_user
    @user ||= { :first_name => "Trong", :last_name => "Tran", :username => "trongtran",
      :email => "trongrg@gmail.com", :password => "please", :password_confirmation => "please",
      :dob => "1988/10/15",
      :phone_number => "01694622095", :address1 => "702 Nguyen Van Linh", :address2 => "District 7",
      :state => "Ho Chi Minh City", :country => "Viet Nam", :zip_code => "12345"
    }
  end

  def sign_up user
    visit '/sign_up'
    fill_fields user
    click_button "Sign up"
  end

  def create_user user
    visit '/users/new'
    fill_fields user
    click_button "Create User"
  end

  def fill_fields attrs
    attrs.each do |field, value|
      field = field.to_s.humanize
      case field
      when "Country", "Currency"
        select value, :from => field
      when "Dob"
        year, month, day= DateTime.parse(value).strftime("%Y %B %d").split(" ")
        select year, :from => 'user_dob_1i'
        select month, :from => 'user_dob_2i'
        select day, :from => 'user_dob_3i'
      else
        fill_in field, :with => value
      end
    end
  end

  def sign_in user
    visit '/sign_in'
    fill_in "Username", :with => user[:username]
    fill_in "Password", :with => user[:password]
    click_button "Sign in"
  end

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

  def find_method_for model
    case model
    when 'user'
      'find_by_username'
    when 'hotel'
      'find_by_name'
    when 'room type'
      'find_by_name'
    else
      'find'
    end
  end

  def valid_room_type
    { :name => "Deluxe", :price => 199, :currency => "USD" }
  end

  def create_room_type room_type
    room_type.each do |field, value|
      field = field.to_s.humanize
      if field == "Currency"
        select value, :from => field
      else
        fill_in field, :with => value
      end
    end
    click_button "Create Room type"
  end
end

World(CapybaraStepHelper)
