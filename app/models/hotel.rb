class Hotel < ActiveRecord::Base
  validates :name, :address1, :city, :phone_number, :lat, :lng, :presence => true
  validates :phone_number, :phone_number => true

  belongs_to :owner, :class_name => "User"
  has_many :room_types
  has_many :rooms, :through => :room_types
  has_many :staff_members, :through => :hotels_staff_members, :source => :user
  has_many :hotels_staff_members

  after_initialize :default_country

  protected
  def default_country
    self.country ||= "VN"
  end
end
