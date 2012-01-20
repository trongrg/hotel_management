require 'spec_helper'

describe WelcomeController do
  describe "GET 'show'" do
    it "returns http success" do
      get :show
      response.should be_success
    end

    it "renders 'show' template" do
      get :show
      response.should render_template("show")
    end
  end
end
