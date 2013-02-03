class RoomType < ActiveRecord::Base
  include FriendlyId
  friendly_id :name, :use => :scoped, :scope => :hotel

  attr_accessible :name, :description, :price_attributes, :hotel_id

  # associations
  belongs_to :hotel
  has_many :rooms
  # has_many :furnishings

  # validations
  validates :name, :price_cents, :currency, :presence => true

  # callbacks
  after_initialize :initialize_price, :unless => :price

  monetize :price_cents, :as => :price

  def price_attributes=(attributes)
    self.price = Money.parse("#{attributes[:currency]}#{attributes[:dollars]}")
  end

  private
  def initialize_price
    self.price = Money.new(0)
  end
end
