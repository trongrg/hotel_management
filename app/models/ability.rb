class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    @user.roles.each { |role| send(role) }
  end

  def hotel_owner
    can :create, :all
    can :manage, Hotel, :user_id => @user.id
    can :manage, [RoomType, Reservation, CheckIn], :hotel_id => @user.hotel_ids
    can :manage, Room, :room_type_id => @user.room_type_ids
  end

  def staff_member
    can :read, Hotel, :id => @user.working_hotel_ids
    can :create, [Reservation, CheckIn]
    can :manage, [Reservation, CheckIn], :hotel_id => @user.working_hotel_ids
  end
end
