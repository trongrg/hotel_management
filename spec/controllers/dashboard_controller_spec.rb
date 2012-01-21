require 'spec_helper'

describe DashboardController do
  context "with signed in user" do
    before do
      @user = User.make!
      sign_in @user
    end

    describe "GET 'show'" do
      it "returns http success" do
        get 'show'
        response.should be_success
      end

      it "renders show template" do
        get :show
        response.should render_template("show")
      end
    end
  end

  context "with not signed in user" do
    describe "GET 'show'" do
      it "redirects to sign in page" do
        get :show
        response.should be_redirect
        response.should redirect_to sign_in_path
      end
    end
  end
end
