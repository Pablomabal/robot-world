class DefectivePartMessageDTO

    def initialize(partsData,carId)
        @carId = carId
        @partsData = partsData
    end
    attr_reader :carId  
    attr_reader :partsData  
end