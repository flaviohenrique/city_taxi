module Api::V1
  class MapsController < ApplicationController
    respond_to :json

    def create
      respond Map::Operation::Create, params: create_params, namespace: [:api, :v1]
    end

    def index
      respond Map::Operation::List
    end

    def show
      respond_with present Map::Operation::Show
    end

    def create_params
      params.permit(:name, :file)
    end
  end
end
