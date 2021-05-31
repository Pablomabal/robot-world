require 'rails_helper'

RSpec.describe BuyerRobotService, type: :model do

  context 'BuyerRobotService.buyCars' do 
  

    it 'should search for a random carModel and purchase a car if available' do
        model = CarModel.new(id: 1,name:'test')
        car = Car.new(car_model_id: 1,id:2, order_id:nil)
        order = Order.new(id:2,car_id: car.id,car_model_id: model.id)
        allow(BuyerRobotService).to receive(:rand).and_return(1)
        allow(CarsFactory).to receive(:getHasStoreStock).with(model.id).and_return(true)
        allow(CarModel).to receive(:all).and_return([model])
        allow(Car).to receive(:where).with({:car_model_id=>1, :location=>"STORE", :order_id=>nil}).and_return([car])
        allow(Order).to receive(:create).and_return(order)
        expect(car).to receive(:update).with({:order_id=>order.id})
        BuyerRobotService.buyCars
    end
    

    it 'should search for a random carModel and fail if no car is available' do
      model = CarModel.new(id: 1,name:'test')
      car = Car.new(car_model_id: 1,id:2, order_id:nil)
      order = Order.new(id:2,car_id: car.id,car_model_id: model.id)
      allow(BuyerRobotService).to receive(:rand).and_return(1)
      allow(CarsFactory).to receive(:getHasStoreStock).with(model.id).and_return(false)
      allow(CarModel).to receive(:all).and_return([model])
      expect(car).not_to receive(:update).with({:order_id=>order.id})
      BuyerRobotService.buyCars
    end
  end
end
