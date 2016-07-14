class Taxi::Operation::Show < Trailblazer::Operation
  include Representer
  include Responder
  include Model

  representer TaxiRepresenter

  model Taxi, :find
end
