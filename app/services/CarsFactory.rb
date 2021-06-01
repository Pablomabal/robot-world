require 'dto/Location'
require 'dto/ProductionStage'

class CarsFactory
    
    def self.checkStoreStock
        models = CarModel.all
        
        models.each do |model|
            if(getStoreStock(model.id))
                if(getFactoryHasCompletedCars(model.id))
                    GuardRobotService.transferModelToStore(model.id)
                else
                    puts 'no available cars to transfer'    
                end
            end
        end
    end

    def self.notifiyOrderPlaced(modelId)
        if (!getHasStoreStock(modelId) && getFactoryHasCompletedCars(modelId))
            GuardRobotService.transferModelToStore(modelId)
        end
    end

    def self.getHasStoreStock(modelId)
        Car.exists?(:location => Location::STORE,:car_model_id => modelId)
    end

    def self.getFactoryHasCompletedCars(modelId)
        cars = Car.where(:car_model_id => modelId,:location => Location::FACTORY ,:state => ProductionStage::COMPLETED)
        cars.each do |car|
            if !car.computer.hasDefectiveParts
                return true
            end
        end
        return false
    end

    def self.getFactoryStock(modelId)
        Car.where(:car_model_id => modelId,:location => Location::FACTORY).length
    end

    def self.getStoreStock(modelId)
        Car.where(:car_model_id => modelId,:location => Location::STORE).length
    end


    def self.pullDailyRevenue
        averageProfit = 0
        totalProfit = 0
        orders = Order.where(:created_at => (Date.today - 1.days)..Date.today)
        if(orders.length == 0)
            puts 'No cars where sold today :('
            return
        end
        carsSold = orders.length
        orders.each do |order|
            model = CarModel.where(:id => order.car_model_id)
            totalProfit = totalProfit + (model.price - model.cost_price)
        end
        averageProfit = totalProfit/orders.length
        puts "Cars sold in the last day: #{orders.length} , average profit: #{averageProfit}"
    end
end