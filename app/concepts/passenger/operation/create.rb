class Passenger::Operation::Create < Trailblazer::Operation
  include Representer
  include Representer::Deserializer::Hash
  include Model

  model Passenger, :create

  contract Passenger::CreateForm
  representer PassengerRepresenter

  def to_model
    model
  end

  def process(params)
    validate(params) do
      contract.sync
      model.status = :calling
      model.save
    end
  end
end
