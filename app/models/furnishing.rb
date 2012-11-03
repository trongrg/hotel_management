class Furnishing < ActiveRecord::Base
  monetize :price_in_cents, :as => :price

  validates :name, :price_in_cents, :room_type_id, :presence => true
  belongs_to :room_type

  def price_attributes=(value)
    self.price = Money.parse("#{value[:currency]}#{value[:dollars]}")
  end
  scope :owned_by, lambda { |owner|
    joins( :room_type => { :hotel => :owner } ).
      where("users.id = ?", owner.id)
  }
end
