class Room < ActiveRecord::Base
  belongs_to :room_type
  attr_accessible :name, :room_type, :room_type_id
  has_one :hotel, :through => :room_type
  validates :name, :room_type, :presence => true
  # validates :name, :uniqueness => :hotel
end
