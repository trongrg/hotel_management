class Furnishing < ActiveRecord::Base
  validates :name, :price, :room_type_id, :presence => true
  belongs_to :room_type
end
