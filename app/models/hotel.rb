class Hotel < ActiveRecord::Base
  validates :name, :phone_number, :lat, :lng, :presence => true
  belongs_to :owner, :class_name => "User"
  after_initialize :default_country

  def default_country
    self.country ||= "VN"
  end
end
