class Map::Operation::Create < Trailblazer::Operation
  extend Representer::DSL
  include Representer::Rendering
  include Model

  model Map, :create

  contract Map::Contract::Create
  representer Map::Representer::Show

  def process(params)
    validate(params) do
      contract.sync
      model.time = 0
      map_reader.read(contract.file, model).save
    end
  end

  def map_reader
    @map_reader ||= ::CityMap::FileReader.new
  end

  def to_model
    model
  end
end
