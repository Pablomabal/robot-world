require 'rails_helper'

RSpec.describe Order, type: :model do
  
  it "is not valid without a car_id"do
    order = Order.new(car_id: nil)
    expect(order).to_not be_valid
  end

  it "is not valid without a car_model_id"do
    order = Order.new(car_model_id: nil)
    expect(order).to_not be_valid
  end
end
