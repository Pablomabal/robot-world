require 'rails_helper'

RSpec.describe CarsFactory, type: :model do
  context 'CarsFactory.checkStoreStock' do 
  
    it 'Should not transfer anything if not available' do
      model = CarModel.new(id:1)
      allow(CarModel).to receive(:all).and_return([model])
      allow(CarsFactory).to receive(:getStoreStock).with(model.id).and_return(true)
      allow(CarsFactory).to receive(:getFactoryHasCompletedCars).with(model.id).and_return(false)

      expect(GuardRobotService).not_to receive(:transferModelToStore)
      CarsFactory.checkStoreStock
    end

    it 'Should transfer available stock' do
      model = CarModel.new(id:1)
      allow(CarModel).to receive(:all).and_return([model])
      allow(CarsFactory).to receive(:getStoreStock).with(model.id).and_return(true)
      allow(CarsFactory).to receive(:getFactoryHasCompletedCars).with(model.id).and_return(true)

      expect(GuardRobotService).to receive(:transferModelToStore)
      CarsFactory.checkStoreStock
    end
  end

  context 'CarsFactory.checkStoreStock' do 
    it 'Should check for stock' do
      computer = Computer.new
      car = Car.new(id:1,computer:computer)
      allow(Car).to receive(:where).and_return([car])
      allow(computer).to receive(:hasDefectiveParts).and_return(true)

      expect(CarsFactory).to receive(:getFactoryHasCompletedCars).and_return(false)
      CarsFactory.getFactoryHasCompletedCars(1)
    end
  end

  context 'CarsFactory.checkStoreStock' do 
    it 'Should check for stock' do
      computer = Computer.new
      car = Car.new(id:1,computer:computer)
      allow(Car).to receive(:where).and_return([car])
      allow(computer).to receive(:hasDefectiveParts).and_return(false)

      expect(CarsFactory).to receive(:getFactoryHasCompletedCars).and_return(true)
      CarsFactory.getFactoryHasCompletedCars(1)
    end
  end
end
