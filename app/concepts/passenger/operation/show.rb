class Passenger::Operation::Show < Trailblazer::Operation
  include Representer
  include Responder
  include Model

  representer PassengerRepresenter

  model Passenger, :find
end
