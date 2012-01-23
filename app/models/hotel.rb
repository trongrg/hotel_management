class Hotel < ActiveRecord::Base
  validates :name, :phone_number, :lat, :lng, :presence => true
  belongs_to :owner, :class_name => "User"
end
