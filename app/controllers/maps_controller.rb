class MapsController < ApplicationController
  respond_to :html

  def show
    respond Map::Operation::Detail
  end

  def move
    run Map::Operation::Move do |op|
      return redirect_to map_path(op.model.id)
    end
  end

  def restart
    run Map::Operation::Restart do |op|
      return redirect_to map_path(op.model.id)
    end
  end
end
