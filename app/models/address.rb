class Address < ActiveRecord::Base
  validates :address_1, :city, :country, :presence => true
  attr_accessible :address_1, :address_2, :city, :state, :zip_code, :country

  after_initialize :default_country

  def to_string
    [address_1, address_2, city, state, country, zip_code].join(" ")
  end


  protected
  def default_country
    self.country ||= "VN"
  end
end
