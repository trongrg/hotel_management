class Location < ActiveRecord::Base
  belongs_to :locatable, :polymorphic => true
  attr_accessible :latitude, :longitude

  validates :latitude, :longitude, :locatable, :presence => true

  def all_blank?
    [:latitude, :longitude].all? do |attr|
      self.send(attr).blank?
    end
  end
end
