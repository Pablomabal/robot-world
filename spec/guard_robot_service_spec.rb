require 'rails_helper'

RSpec.describe GuardRobotService, type: :model do

  context 'GuardRobotService.searchCarsWithDefects' do 
    it 'should search for cars with defective parts' do
      car = Car.new(id:1)
      part = CarPart.new(part_type:"WHEEL", defective: true,car_id:car.id)
      computer = Computer.new(car: car,car_id: car.id)
      
      allow(Computer).to receive(:all).and_return([computer])
      allow(computer).to receive(:getDefectiveParts).and_return([part])

      expect(SlackRestClient).to receive(:postMessage)
      GuardRobotService.searchCarsWithDefects
    end

    it 'should search for cars with defective parts' do
      car = Car.new(id:1)
      part = CarPart.new(part_type:"WHEEL", defective: true,car_id:car.id)
      computer = Computer.new(car: car,car_id: car.id)
      
      allow(Computer).to receive(:all).and_return([computer])
      allow(computer).to receive(:getDefectiveParts).and_return([])

      expect(SlackRestClient).not_to receive(:postMessage)
      GuardRobotService.searchCarsWithDefects
    end
  end

  context 'GuardRobotService.transferModelToStore' do 
    it 'should transfer cars to store' do

      modelId = 1
      car = Car.new(id:1, car_model_id:1, state:"COMPLETED")
      computer = Computer.new(car: car,car_id: car.id)
      car.computer = computer

      allow(computer).to receive(:hasDefectiveParts).and_return(false)
      allow(Car).to receive(:where).with(:car_model_id => modelId,:state => ProductionStage::COMPLETED,:order_id => nil).and_return([car])

      expect(car).to receive(:update).with({:location => Location::STORE})

      GuardRobotService.transferModelToStore(modelId)
    end
  end
end
