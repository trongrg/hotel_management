class RoomType < ActiveRecord::Base
  monetize :price_in_cents, :as => :price

  validates :name, :price_in_cents, :currency, :presence => true

  belongs_to :hotel
  has_many :rooms
  has_many :furnishings

  scope :owned_by, lambda { |owner|
    joins( :hotel => :owner ).
      where( "users.id = ?", owner.id )
  }

  def price_attributes=(value)
    self.price = Money.parse("#{value[:currency]}#{value[:dollars]}")
  end
end
