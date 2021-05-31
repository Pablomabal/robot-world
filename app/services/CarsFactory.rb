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

end