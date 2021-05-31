require 'dto/ProductionStage'
require 'dto/Location'

class BuilderRobotService 

    @models = CarModel.all
    
    def self.generateNewCars
        for i in 0..9
            model = @models.sample
            Car.create([{
                car_model_id: model.id,
                state: ProductionStage::BASIC_STRUCTURE,
                location: Location::FACTORY
            }])
        
        end
    end

    def self.installBasicStructure
        carsToBuild = Car.where(:state => ProductionStage::BASIC_STRUCTURE).limit(10)
        carsToBuild.each do |car|
            for i in 0..3
                CarPart.create({
                    car_id: car.id,
                    part_type: 'WHEEL',
                    defective: rand < 0.02
                })
            end
            CarPart.create({
                car_id: car.id,
                part_type: 'CHASSIS',
                defective: rand < 0.01
            })
            CarPart.create({
                car_id: car.id,
                part_type: 'ENGINE',
                defective: rand < 0.01
            })
            car.update({state: ProductionStage::ELECTRONIC_DEVICES})
            end
    rescue ActiveRecord::RecordNotFound  
        return

    end
    
    def self.installElectronicDevices
        carsToBuild = Car.where( :state => ProductionStage::ELECTRONIC_DEVICES).limit(10)
        carsToBuild.each do |car|
            computer = Computer.create({
                car_id: car.id 
            })
            CarPart.create({
                car_id: car.id,
                part_type: 'LASER',
                defective: rand < 0.01
            })
            for i in 0..1
                CarPart.create({
                    car_id: car.id,
                    part_type: 'SEAT',
                    defective: rand < 0.05
                })
            end
            car.update({state: ProductionStage::DETAILING})
        rescue ActiveRecord::RecordNotFound  
            return
        end
    end

    def self.finishCar
        carsToBuild = Car.where( :state => ProductionStage::DETAILING).limit(10)
        carsToBuild.each do |car|
            car.update({state: ProductionStage::COMPLETED})
        end
    rescue ActiveRecord::RecordNotFound  
        return
    end

end