module Api::V1
  class PassengersController < ApplicationController
    respond_to :json

    def create
      respond Passenger::Operation::Create, params: create_params, namespace: [:api, :v1]
    end

    def show
      respond_with present Passenger::Operation::Show
    end

    def create_params
      params.permit(:name, :row, :col, :dest_row, :dest_col, :map_id)
    end
  end
end
