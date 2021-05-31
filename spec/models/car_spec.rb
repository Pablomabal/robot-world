require 'rails_helper'

RSpec.describe Car, type: :model do

  it "is not valid without a car_model_id"do
    car = Car.new(car_model_id: nil)
    expect(car).to_not be_valid

  end


end
