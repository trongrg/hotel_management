def it_should_only_allow_access_to(actions, allowed_users, &block)
  all_users = Role.all.map { |r| r.name.downcase.gsub(' ', '_').to_sym }

  if allowed_users == :all
    allowed_users = all_users.dup
  end
  allowed_users = [allowed_users] unless allowed_users.is_a?(Array)

  denied_users = all_users - allowed_users

  actions = [actions] unless actions.is_a?(Array)

  actions.each do |action|
    describe action do
      allowed_users.each do |user|
        it "allows access to #{user}" do
          sign_in User.make!(user)
          controller.stub!(action) { raise "access granted" }
          yield(controller) if block_given?

          controller.should_not_receive(:redirect_to)
          expect { get action }.to raise_error(/access granted/)
        end
      end

      denied_users.each do |user|
        it "denies access to #{user}" do
          sign_in User.make!(user)
          yield(controller) if block_given?

          controller.should_receive(:redirect_to) { raise "access denied" }
          expect { get action }.to raise_error(/access denied/)
        end
      end
    end
  end
end
