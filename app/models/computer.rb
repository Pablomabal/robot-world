class Computer < ApplicationRecord
  belongs_to :car

  validates_presence_of :car_id

  def hasDefectiveParts
    return getDefectiveParts.length > 0
  end

  def getDefectiveParts
    car.car_parts.select {|part| part.defective}
  end
end
