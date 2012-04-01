class RoomType < ActiveRecord::Base
  composed_of :price,
  :class_name => "Money",
  :mapping => [%w(price_in_cents cents), %w(currency currency_as_string)],
  :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
  :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  validates :name, :price_in_cents, :currency, :presence => true

  belongs_to :hotel
  has_many :rooms
  has_many :furnishings

  def price_attributes=(value)
    self.price = "#{value[:currency]}#{value[:dollars]}"
  end
end
