class Taxi::Operation::Create < Trailblazer::Operation
  include Representer
  include Representer::Deserializer::Hash
  include Model

  model Taxi, :create

  contract Taxi::CreateForm
  representer TaxiRepresenter

  def to_model
    model
  end

  def process(params)
    validate(params) do
      model.status = :empty
      contract.save
    end
  end
end
