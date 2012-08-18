class CheckOut < ActiveRecord::Base

  SETTLEMENT_TYPE = {:cash => "Cash", :credit_card => "Credit card", :debit_card => "Debit card", :check => "Check"}
  belongs_to :user
  belongs_to :guest
  belongs_to :room
  belongs_to :check_in
  validates :user, :room, :total_in_cents, :presence => true

  before_validation :set_check_in
  before_validation :set_room_price
  before_validation :set_guest
  before_validation :calculate_nights

  monetize :room_price_in_cents, :as => :room_price
  monetize :total_in_cents, :as => :total
  monetize :additional_charges_in_cents, :as => :additional_charges, :allow_nil => true

  def room_price_attributes=(value)
    self.room_price = Money.parse("#{value[:currency]}#{value[:dollars]}")
  end

  def total_attributes=(value)
    self.total = Money.parse("#{value[:currency]}#{value[:dollars]}")
  end

  def additional_charges_attributes=(value)
    self.additional_charges = Money.parse("#{value[:currency]}#{value[:dollars]}")
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
      check_out_time = Time.now.beginning_of_day + 12.hours
      while start_time < check_out_time
        self.nights += 1
        start_time = start_time + 1.day
      end
      self.nights += 1 if Time.now > check_out_time
    end
  end
end
