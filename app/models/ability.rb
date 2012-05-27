class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    user ||= User.new
    if user.role? :admin
      can :manage, :all
    elsif user.role? :hotel_owner
      can :manage, Hotel, :owner_id => user.id
      can :manage, RoomType, :hotel_id => user.hotels.map(&:id) + [nil]
      can :manage, Room, :room_type_id => user.hotels.find(:all, :include => :room_types).map(&:room_type_ids).flatten + [nil]
      can :manage, Furnishing, :room_type_id => user.hotels.find(:all, :include => :room_types).map(&:room_type_ids).flatten + [nil]
      can :manage, :staff
      can :manage, CheckIn, :room_id => user.hotels.find(:all, :include => :room_types).map(&:room_types).flatten.map(&:room_ids).flatten + [nil]
      can :manage, Reservation, :room_id => user.hotels.find(:all, :include => :room_types).map(&:room_types).flatten.map(&:room_ids).flatten + [nil]
      can :manage, Guest
      can :manage, CheckOut, :room_id => user.hotels.find(:all, :include => :room_types).map(&:room_types).flatten.map(&:room_ids).flatten + [nil]
    elsif user.role? :staff
      can :manage, CheckIn, :room_id => user.working_hotels.find(:all, :include => :room_types).map(&:room_types).flatten.map(&:room_ids).flatten + [nil]
      can :manage, Reservation, :room_id => user.working_hotels.find(:all, :include => :room_types).map(&:room_types).flatten.map(&:room_ids).flatten + [nil]
      can :manage, Guest
      can :manage, CheckOut, :room_id => user.working_hotels.find(:all, :include => :room_types).map(&:room_types).flatten.map(&:room_ids).flatten + [nil]
    end
    can :show, User, :id => user.id
  end
end
