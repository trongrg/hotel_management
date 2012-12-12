module CapybaraStepHelper
  def valid_user
    @user ||= { :first_name => "Trong", :last_name => "Tran", :gender => "Male",
      :email => "trongrg@gmail.com", :password => "please", :password_confirmation => "please",
      :date_of_birth => "1988/10/15",
      :phone => "01694622095", :address_attributes => {
        :line1 => "line1",
        :line2 => "line2",
        :city => "city",
        :state => "state",
        :zip => "12345",
        :country => "Viet Nam"
      }
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
    click_button "Create user"
  end

  def sign_in user
    visit '/sign_in'
    fill_in "Email", :with => user[:email]
    fill_in "Password", :with => user[:password]
    click_button "Sign in"
  end

  def valid_hotel
    {
      :name => "Hotel Name",
      :phone => '123456',
      :address_attributes => {
        :line1 => "702 Nguyen Van Linh",
        :line2 => "District 7",
        :city => 'District 1',
        :state => "Ho Chi Minh City",
        :zip => "12345",
        :country => "Viet Nam",
      },
      :location_attributes => {
        :latitude => 123,
        :longitude => 123
      }
    }
  end

  def create_hotel hotel
    fill_fields hotel
    click_button "Create Hotel"
  end

  def find_method_for model
    case model
    when 'user'
      'find_by_email'
    when 'hotel'
      'find_by_name'
    when 'room_type', 'room type'
      'find_by_name'
    when 'room'
      'find_by_number'
    when 'furnishing'
      'find_by_name'
    else
      'find'
    end
  end

  def valid_room_type
    { :name => "Deluxe", :price => 199, :currency => "USD" }
  end

  def create_room_type room_type
    fill_fields room_type
    click_button "Create Room type"
  end

  def valid_room
    {:number => "101", :room_type => valid_room_type[:name]}
  end

  def create_room room
    fill_fields room
    click_button "Create Room"
  end

  def valid_furnishing
    { :name => "Bed", :price => 100, :description => "giuong" }
  end

  def create_furnishing furnishing
    fill_fields furnishing
    click_button "Create Furnishing"
  end

  def valid_check_in
    {:guest_attributes =>
     {:first_name => 'Trong', :last_name => 'Tran', :passport => '250737373', :phone_number => '0987654321', :gender => "Male" }
    }
  end

  def create_check_in check_in
    fill_fields check_in
    click_button "Create Check in"
  end

  def valid_reservation
    {:guest_attributes =>
     {:first_name => 'Trong', :last_name => 'Tran', :passport => '250737373', :phone_number => '0987654321', :gender => "Male" },
       :check_in_date => DateTime.now.to_date, :check_out_date => 1.day.from_now.to_date
    }
  end

  def create_reservation reservation
    fill_fields reservation
    click_button "Create Reservation"
  end

  def valid_check_out
    {:additional_charges_attributes => {:additional_charges => 0, :currency => "USD"},
     :settlement_type => "Cash"}
  end

  def create_check_out check_out
    fill_fields check_out
    click_button "Create Check out"
  end

  def fill_fields attrs
    attrs.each do |field, value|
      field = field.to_s.humanize
      case field
      when "Country"
        if value
          select_value value, :from => field
        else
          select_value "", :from => field
        end
      when "Currency", "Room type", "Settlement type", "Gender"
        select_value value, :from => field
      when "Date of birth"
        fill_date value
      when /attributes$/
        fill_fields value
      when "Password"
        fill_in "user_password", :with => value
      when "Password confirmation"
        fill_in "user_password_confirmation", :with => value
      else
        fill_in field, :with => value
      end
    end
  end

  private
  def room_type_attributes
    room_type = RoomType.make!
    {:name => room_type.name, :price => room_type.price, :currency => room_type.currency, :image => room_type.image, :description => room_type.description, :hotel_id => hotel.id }
  end

  def fill_date date
    year, month, day = DateTime.parse(date).strftime("%Y %B %d").split(" ")
    select_value year, :from => 'user_date_of_birth_1i'
    select_value month, :from => 'user_date_of_birth_2i'
    select_value day, :from => 'user_date_of_birth_3i'
  end

  def select_value(value, options)
    return unless options.has_key?(:from)
    if Capybara.current_driver == :selenium
      field = find(:select, options[:from])
      option = field.find(:option, value)[:value]
      page.execute_script(%{$("##{field[:id]}").val("#{option}")})
    else
      find(:select, options[:from]).find(:option, value).select_option
    end
  end
end

World(CapybaraStepHelper)
