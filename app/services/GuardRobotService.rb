require 'dto/DefectivePartInfoDTO'
require 'dto/DefectivePartMessageDTO'
require 'dto/Location'
require 'dto/ProductionStage'

class GuardRobotService

    def self.searchCarsWithDefects
        computers = Computer.all
        puts computers
        computers.each do |computer|
            defectiveParts = computer.getDefectiveParts
            if defectiveParts.length > 0
                partsData = defectiveParts.map {|part| DefectivePartInfoDTO.new( part.id, part.part_type)}
                SlackRestClient.postMessage(DefectivePartMessageDTO.new(partsData  , computer.car.id))

            end
        rescue ActiveRecord::RecordNotFound  
        end
    end

    def self.transferModelToStore(modelId)
        modelCars =Car.where(:car_model_id => modelId,:state => ProductionStage::COMPLETED,:order_id => nil)
        modelCars.each do |car|
            if !car.computer.hasDefectiveParts
                car.update({:location => Location::STORE})
            end
        end
    end

    def self.transferCarsToStore
        carsToTransfer = Array.new
        computers = Computer.all
        computers.each do |computer|
            defectiveParts = computer.hasDefectiveParts
            if !defectiveParts && computer.car.state == ProductionStage::COMPLETED
                carsToTransfer << computer.car_id
            end
        rescue ActiveRecord::RecordNotFound  
        end
        if carsToTransfer.length() >0
            Car.where(:id => carsToTransfer ).update_all({:location => Location::STORE})
        end
    end

    def self.deleteAllCars
        Car.destroy_all
    end

end
