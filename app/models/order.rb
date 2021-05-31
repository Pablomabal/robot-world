class Order < ApplicationRecord
  has_one :car
  has_one :model

  validates_presence_of :car_model_id
  validates_presence_of :car_id
end
