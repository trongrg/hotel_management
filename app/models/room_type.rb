class RoomType < ActiveRecord::Base
  validates :name, :price, :currency, :presence => true

  belongs_to :hotel

  CURRENCIES = ['USD', 'VND', 'GBP']
end
