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

  scope :owned_by, lambda { |owner_id| where(:owner_id => owner_id) }

  protected
  def init_address
    self.address ||= Address.new
  end
end
