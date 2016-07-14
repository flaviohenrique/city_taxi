class MapsController < ApplicationController
  respond_to :json, :html

  def create
    respond Map::Operation::Create, params: create_params
  end

  def detail
    respond Map::Operation::Detail
  end

  def index
    respond Map::Operation::List
  end

  def show
    run Map::Operation::Show
  end

  def move
    run Map::Operation::Move do |op|
      return redirect_to detail_map_path(op.model.id)
    end
  end

  def restart
    run Map::Operation::Restart do |op|
      return redirect_to detail_map_path(op.model.id)
    end
  end

  def create_params
    params.permit(:name, :file)
  end
end
