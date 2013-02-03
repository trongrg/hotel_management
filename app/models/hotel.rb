class Hotel < ActiveRecord::Base
  include FriendlyId
  friendly_id :name, :use => :scoped, :scope => :owner

  attr_accessible :name, :phone, :address_attributes, :location_attributes

  # associations
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id
  has_one :location, :as => :locatable
  has_one :address, :as => :addressable
  has_many :room_types
  has_many :rooms, :through => :room_types
  has_many :reservations
  has_and_belongs_to_many :staff_members, :class_name => "User"

  # callbacks
  after_initialize :build_address, :unless => :address
  after_initialize :build_location, :unless => :location

  # validations
  validates :name, :phone, :address, :location, :owner, :presence => true

  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :address
end
