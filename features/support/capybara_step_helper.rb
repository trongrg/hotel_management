module CapybaraStepHelper
  def valid_user
    @user ||= {
      :first_name => "Trong",
      :last_name => "Tran",
      :gender => "Male",
      :email => "trongrg@gmail.com",
      :password => "please",
      :password_confirmation => "please",
      :date_of_birth => "1988/10/15",
      :phone => "01694622095",
      :address_attributes => {
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

  def find_method_for model
    case model.strip
    when 'user'
      'find_by_email'
    when 'room_type', 'room type', 'room', 'furnishing', 'hotel'
      'find_by_name'
    else
      'find'
    end
  end

  def valid_room_type
    {
      :name => "Deluxe",
      :price_attributes => {
        :dollars => 19.9,
        :currency => "USD"
      }
    }
  end

  def valid_room
    {
      :name => "101",
      :room_type => valid_room_type[:name]
    }
  end

  def valid_furnishing
    {
      :name => "Bed",
      :price => 100,
      :description => "giuong"
    }
  end

  def valid_check_in
    {
      :guest_attributes => {
        :first_name => 'Trong',
        :last_name => 'Tran',
        :passport => '250737373',
        :phone => '0987654321',
        :gender => "Male"
      },
      :room_ids => [Room.first.name]
    }
  end

  def valid_reservation
    {
      :guest_attributes => {
        :first_name => 'Trong',
        :last_name => 'Tran',
        :passport => '250737373',
        :phone => '0987654321',
        :gender => "Male"
      },
      :check_in_date => DateTime.now.to_date,
      :check_out_date => 1.day.from_now.to_date
    }
  end

  def valid_check_out
    {
      :additional_charges_attributes => {
        :additional_charges => 0,
        :currency => "USD"
      },
      :settlement_type => "Cash"
    }
  end

  def fill_fields attrs
    attrs.each do |field, value|
      field = field.to_s.gsub(' ', '_')
      case field
      when /attributes/
        fill_fields value
      when "password_confirmation", "password"
        fill_in "user_#{field}", :with => value
      when "currency", "rooms", "gender", "room_type", "country"
        within(".#{field}") { select_value value.to_s, :from => field.humanize }
      when "date_of_birth"
        fill_date value
      when "room_ids"
        value.each {|v| check v}
      else
        within(".#{field}") { fill_in field.humanize, :with => value }
      end
    end
  end

  private
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
      page.execute_script(%{$("##{field[:id]}").val("#{option}").trigger('liszt:updated')})
    else
      select value, options
    end
  end
end

World(CapybaraStepHelper)
