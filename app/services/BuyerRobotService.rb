require 'dto/Location'
class BuyerRobotService

    def self.buyCars
        rand(1..10).times {
            modelToBuy = CarModel.all.sample
            if(CarsFactory.getHasStoreStock(modelToBuy.id))
                soldCar = Car.where(:location => Location::STORE,:order_id => nil,:car_model_id => modelToBuy.id).first
                order = Order.create({car_id: soldCar.id,car_model_id: modelToBuy.id})
                soldCar.update({order_id: order.id})
                CarsFactory.notifiyOrderPlaced(modelToBuy.id)
            else
                puts "Cannot place order for model #{modelToBuy.name}, no cars in Store Stock"    
            end
        }
    end

end