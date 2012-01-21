require 'spec_helper'

describe Profile::PasswordController do
  context "with signed in user" do
    before do
      @user = User.make!
      sign_in @user
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get :edit
        response.should be_success
      end

      it "renders 'edit' template" do
        get :edit
        response.should render_template("edit")
      end

      it "assigns current_user as @user" do
        get :edit
        assigns(:user).should == @user
      end
    end

    describe "PUT 'update'" do
      context "valid inputs" do
        before do
          put :update, :user => {:current_password => "please", :password => "newpass", :password_confirmation => "newpass"}
        end

        it "updates current_user's password" do
          @user.valid_password?("newpass")
        end

        it "redirects to dashboard page" do
          response.should be_redirect
          response.should redirect_to dashboard_path
        end

        it "shows successful message" do
          flash[:notice].should == "You updated your password successfully."
        end
      end

      context "invalid inputs" do
        it "re-renders edit template" do
          put :update, :user => {:current_password => "something_else"}
          response.should be_success
          response.should render_template('edit')
        end
      end
    end
  end

  context "with not signed in user" do
    describe "GET 'edit'" do
      it "redirects to sign in page" do
        get :edit
        response.should redirect_to new_user_session_path
      end
    end

    describe "PUT 'update'" do
      it "redirects to sign in page" do
        put :edit
        response.should redirect_to new_user_session_path
      end
    end
  end
end
