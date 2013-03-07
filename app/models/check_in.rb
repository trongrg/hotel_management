class CheckIn < ActiveRecord::Base
  STATUSES = {:active => "Active", :expired => "Expired"}

  attr_accessible :adults, :children, :special_request, :status,
    :prepaid_attributes, :guest_attributes, :room_ids

  # associations
  belongs_to :guest
  belongs_to :hotel
  has_and_belongs_to_many :rooms

  # validations
  validates :guest, :hotel, :rooms, :status, :presence => true
  validates :status, :inclusion => STATUSES.values
  validate :rooms_availability

  # callbacks
  after_initialize :set_default_status, :unless => :status
  after_initialize :build_guest, :unless => :guest
  before_save :update_rooms_availability

  # scopes
  STATUSES.keys.each do |status|
    scope status, where(:status => STATUSES[status])
  end
  scope :status, lambda { |status|
    where(:status => STATUSES[status.to_sym]) if status && STATUSES[status.to_sym]
  }

  accepts_nested_attributes_for :guest

  monetize :prepaid_cents, :as => :prepaid, :allow_nil => true

  def prepaid_attributes=(value)
    self.prepaid = Money.parse("#{value[:currency]}#{value[:dollars]}")
  end

  private
  def set_default_status
    self.status = STATUSES[:active]
  end

  def rooms_availability
    unless self.rooms.all? { |room| room.available? }
      self.errors.add(:base, :not_available)
      return false;
    end
  end

  def update_rooms_availability
    rooms.update_all(:available => (status != STATUSES[:active]))
  end
end
