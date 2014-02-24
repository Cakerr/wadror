class Style < ActiveRecord::Base
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def self.best_average(n)
    sorted = Style.all.sort_by{|s| -(s.average_rating ||0)}
    sorted[0..n-1]
  end

  def to_s
    "#{name}"
  end
end
