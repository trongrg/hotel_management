class Reservation < ActiveRecord::Base
  STATUSES = {:active => "Active", :expired => "Expired", :canceled => "Canceled"}

  attr_accessible :check_in_date, :check_out_date, :adults, :children,
    :special_request, :status, :room_ids, :hotel_id, :guest_attributes,
    :prepaid_attributes

  # associations
  belongs_to :guest
  belongs_to :hotel
  has_and_belongs_to_many :rooms

  # validations
  validates :guest, :status, :check_in_date, :hotel, :presence => true
  validates :status, :inclusion => STATUSES.values

  # callbacks
  after_initialize :set_default_status, :unless => :status
  after_initialize :build_guest, :unless => :guest

  # scopes
  STATUSES.keys.each do |status|
    scope status, where(:status => STATUSES[status])
  end

  accepts_nested_attributes_for :guest

  monetize :prepaid_cents, :as => :prepaid, :allow_nil => true

  def prepaid_attributes=(attributes)
    self.prepaid = Money.parse("#{attributes[:currency]}#{attributes[:dollars]}")
  end

  private
  def set_default_status
    self.status = STATUSES[:active]
  end
end
