def it_should_only_allow_access_to_signed_in_user(actions, &block)
  actions = [actions] unless actions.is_a?(Array)

  actions.each do |action|
    describe action do
      it "denies access" do
        yield(controller) if block_given?

        get action
        response.should redirect_to new_user_session_path
      end
    end
  end
end
