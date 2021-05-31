require 'change_order_dto'
class OrderController < ApplicationController

    def change_order
        CarsFactory.changeOrder(ChangeOrderDTO.new(params[:orderId],params[:newModelId]))
    end
    
end
