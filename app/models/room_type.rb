class RoomType < ActiveRecord::Base
  validates :name, :price, :currency, :presence => true

  belongs_to :hotel
  has_many :rooms
  has_many :furnishings

  CURRENCIES = ['USD', 'VND', 'GBP']
end
