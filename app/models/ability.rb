class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    authorize(user)
    can :show, User, :id => user.id
  end

  private
  def authorize(user)
    if user.role? :hotel_owner
      can :manage, Hotel, :owner_id => user.id
      can :manage, RoomType, :hotel_id => user.hotels.map(&:id) + [nil]
      can :manage, Room, :room_type_id => RoomType.owned_by(user).map(&:id) + [nil]
      can :manage, Furnishing, :room_type_id => RoomType.owned_by(user).map(&:id) + [nil]
      can :manage, :staff
      can :manage, CheckIn, :room_id => Room.owned_by(user).map(&:id) + [nil]
      can :manage, Reservation, :room_id => Room.owned_by(user).map(&:id) + [nil]
      can :manage, Guest
      can :manage, CheckOut, :room_id => Room.owned_by(user).map(&:id) + [nil]
    elsif user.role? :staff
      can :manage, CheckIn, :room_id => Room.managed_by(user).map(&:id) + [nil]
      can :manage, Reservation, :room_id => Room.managed_by(user).map(&:id) + [nil]
      can :manage, Guest
      can :manage, CheckOut, :room_id => Room.managed_by(user).map(&:id) + [nil]
    end
  end
end
