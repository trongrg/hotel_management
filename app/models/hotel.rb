class Hotel < ActiveRecord::Base
  attr_accessible :name, :phone, :address_attributes, :location_attributes

  has_and_belongs_to_many :owners, :class_name => "User"

  has_one :location, :as => :locatable
  accepts_nested_attributes_for :location

  has_one :address, :as => :addressable
  accepts_nested_attributes_for :address

  after_initialize :initialize_address
  after_initialize :initialize_location

  validates :name, :phone, :address, :location, :owners, :presence => true

  def belongs_to?(user)
    self.new_record? || owners.include?(user)
  end

  private
  def initialize_address
    self.build_address unless self.address
  end

  def initialize_location
    self.build_location unless self.location
  end
end
