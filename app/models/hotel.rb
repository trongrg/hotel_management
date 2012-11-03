class Hotel < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  belongs_to :address
  has_many :room_types
  has_many :rooms, :through => :room_types

  has_many :hotels_staff_members
  has_many :staff_members, :through => :hotels_staff_members, :source => :user

  validates :name, :phone_number, :lat, :lng, :address, :presence => true
  validates :phone_number, :phone_number => true

  accepts_nested_attributes_for :address

  after_initialize :init_address

  scope :owned_by, lambda { |owner| where(:owner_id => owner.id) }
  scope :managed_by, lambda { |staff|
    joins(:staff_members).
    where("hotels_users.user_id = ?", staff.id)
  }

  protected
  def init_address
    self.address ||= Address.new
  end
end
