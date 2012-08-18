class Furnishing < ActiveRecord::Base
  monetize :price_in_cents, :as => :price

  validates :name, :price_in_cents, :room_type_id, :presence => true
  belongs_to :room_type

  def price_attributes=(value)
    self.price = Money.parse("#{value[:currency]}#{value[:dollars]}")
  end
end
