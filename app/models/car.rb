class Car < ApplicationRecord
  has_one :car_model 
  has_many :car_parts, dependent: :destroy
  has_one :computer, dependent: :destroy

  validates_presence_of :car_model_id

end
