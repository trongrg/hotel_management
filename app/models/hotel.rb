class Hotel < ActiveRecord::Base
  attr_accessible :name, :phone, :address_attributes, :location_attributes

  belongs_to :owner, :class_name => "User", :foreign_key => :user_id

  has_one :location, :as => :locatable
  accepts_nested_attributes_for :location

  has_one :address, :as => :addressable
  accepts_nested_attributes_for :address

  has_many :room_types

  after_initialize :initialize_address
  after_initialize :initialize_location

  validates :name, :phone, :address, :location, :owner, :presence => true

  def belongs_to?(user)
    self.new_record? || owner == user
  end

  private
  def initialize_address
    self.build_address unless self.address
  end

  def initialize_location
    self.build_location unless self.location
  end
end
