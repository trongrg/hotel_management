module SessionHelpers
  def valid_user
    @user ||= { :first_name => "Trong", :last_name => "Tran", :username => "trongtran",
      :email => "trongrg@gmail.com", :password => "please", :password_confirmation => "please",
      :dob => {:"1i" => "1988", :"2i" => "December", :"3i" => "15"},
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

  def fill_fields user
    user.each do |field, value|
      field = field.to_s.humanize
      case field
      when "Country"
        select value, :from => field
      when "Dob"
        value.each do |k, v|
          select v, :from => "user_dob_#{k}"
        end
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
end

World(SessionHelpers)
