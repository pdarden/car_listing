class Car < ActiveRecord::Base
  validates_presence_of :color, :year, :mileage
  validates_numericality_of :year, only_integer: true, greater_than_or_equal_to: 1980
  validates_numericality_of :mileage, only_integer: true, greater_than_or_equal_to: 0
end
