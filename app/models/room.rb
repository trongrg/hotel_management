class Room < ActiveRecord::Base
  belongs_to :room_type
  validates :number, :room_type, :presence => true
  has_many :check_ins
end
