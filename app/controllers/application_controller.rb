class ApplicationController < ActionController::Base
  include Trailblazer::Operation::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  responders :json

  rescue_from 'ActiveRecord::RecordNotFound' do |exception|
    render json: {}, status: 404
  end

end
