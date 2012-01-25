shared_examples_for "not signed in" do
  it "redirects to sign in page" do
    response.should redirect_to new_user_session_path
  end

  it "shows not signed in message" do
    flash[:alert].should == "You need to sign in or sign up before continuing."
  end
end

shared_examples_for "not authorized" do
  it "redirects to dashboard page" do
    response.should redirect_to dashboard_path
  end

  it "shows not have permission message" do
    flash[:alert].should == "You are not authorized to access this page."
  end
end
