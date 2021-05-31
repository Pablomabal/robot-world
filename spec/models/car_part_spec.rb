require 'rails_helper'

RSpec.describe CarPart, type: :model do

  it "is not valid without a car_id"do
    part = CarPart.new(car_id: nil)
    expect(part).to_not be_valid
  end

end
