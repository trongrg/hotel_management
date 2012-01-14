module ControllerHelpers
  def sign_in_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in User.make!
    end
  end
end
