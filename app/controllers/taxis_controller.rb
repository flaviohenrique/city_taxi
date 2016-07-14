class TaxisController < ApplicationController
  respond_to :json

  def create
    respond Taxi::Operation::Create, params: create_params
  end

  def show
    respond_with present Taxi::Operation::Show
  end

  private

  def create_params
    params.permit(:name, :row, :col, :map_id)
  end
end
