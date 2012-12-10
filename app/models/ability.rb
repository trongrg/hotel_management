class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    @user.roles.each { |role| send(role) }
  end

  def hotel_owner
    can :manage, Hotel do |hotel|
      hotel.belongs_to?(@user)
    end
  end
end
