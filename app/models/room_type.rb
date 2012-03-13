class RoomType < ActiveRecord::Base
  validates :name, :price, :currency, :presence => true

  belongs_to :hotel
  has_many :rooms

  CURRENCIES = ['USD', 'VND', 'GBP']
end
