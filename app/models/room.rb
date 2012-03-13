class Room < ActiveRecord::Base
  belongs_to :room_type
  validates :number, :room_type, :presence => true
end
