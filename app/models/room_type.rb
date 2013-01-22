class RoomType < ActiveRecord::Base
  include FriendlyId
  friendly_id :name, :use => :scoped, :scope => :hotel

  attr_accessible :name, :description, :price_cents, :currency, :price_attributes, :hotel, :hotel_id
  monetize :price_cents, :as => :price

  validates :name, :price_cents, :currency, :presence => true

  belongs_to :hotel
  has_many :rooms
  # has_many :furnishings
  after_initialize :initialize_price

  # scope :owned_by, lambda { |owner|
  #   joins( :hotel => :owner ).
  #     where( "users.id = ?", owner.id )
  # }

  def price_attributes=(attributes)
    self.price = Money.parse("#{attributes[:currency]}#{attributes[:dollars]}")
  end

  private
  def initialize_price
    self.price ||= Money.new(0)
  end
end
