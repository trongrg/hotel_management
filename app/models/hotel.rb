class Hotel < ActiveRecord::Base
  validates :name, :phone_number, :lat, :lng, :presence => true

  belongs_to :owner, :class_name => "User"
  has_many :room_types
  has_many :rooms, :through => :room_types

  after_initialize :default_country

  def default_country
    self.country ||= "VN"
  end
end
