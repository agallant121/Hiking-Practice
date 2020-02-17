class Trail < ApplicationRecord
  validates_presence_of :name, :address, :length
  validates_numericality_of :length, only_integer: true, greater_than: 0

  has_many :trip_trails
  has_many :trips, through: :trip_trails

  def total_use
    trips.count
  end
end
