require 'rails_helper'

RSpec.describe Computer, type: :model do
  
  it "is not valid without a car_id"do
    computer = Computer.new(car_id: nil)
    expect(computer).to_not be_valid
  end
end
