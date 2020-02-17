class Trip < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :start_date
  validates_presence_of :end_date

  has_many :trip_trails
  has_many :trails, through: :trip_trails

  def total_hike
    trails.sum(:length)
  end

  def avg_trail_hike
    trails.average(:length)
  end

  def longest_hike
    trails.order(length: :desc).pluck(:name, :length).first.join(", ")
  end

  def shortest_hike
    trails.order(:length).pluck(:name, :length).first.join(", ")
  end
end
