class CheckOut < ActiveRecord::Base

  SETTLEMENT_TYPE = {:cash => "Cash", :credit_card => "Credit card", :debit_card => "Debit card", :check => "Check"}
  belongs_to :user
  belongs_to :guest
  belongs_to :room
  belongs_to :check_in
  validates :user, :room, :presence => true

  before_validation :set_check_in
  before_validation :set_room_price
  before_validation :set_guest
  before_validation :calculate_nights

  composed_of :room_price,
  :class_name => "Money",
  :mapping => [%w(room_price_in_cents cents), %w(currency currency_as_string)],
  :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
  :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  composed_of :total,
  :class_name => "Money",
  :mapping => [%w(total_in_cents cents), %w(currency currency_as_string)],
  :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
  :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  composed_of :additional_charges,
  :class_name => "Money",
  :mapping => [%w(additional_charges_in_cents cents), %w(currency currency_as_string)],
  :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
  :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  def room_price_attributes=(value)
    self.room_price = "#{value[:currency]}#{value[:dollars]}"
  end

  def total_attributes=(value)
    self.total = "#{value[:currency]}#{value[:dollars]}"
  end

  def additional_charges_attributes=(value)
    self.additional_charges = "#{value[:currency]}#{value[:dollars]}"
  end

  private
  def set_check_in
    self.check_in = self.room.current_check_in if self.room.present?
  end

  def set_room_price
    self.room_price = self.room.room_type.price.format if self.room.present?
  end

  def set_guest
    self.guest = self.check_in.guest
  end

  def calculate_nights
    if self.room.present?
      self.nights = 0
      start_time = self.check_in.created_at
      check_out_time = DateTime.now.beginning_of_day + 12.hours
      while start_time < check_out_time
        self.nights += 1
        start_time = start_time + 1.day
      end
      self.nights += 1 if DateTime.now > check_out_time
    end
  end
end
