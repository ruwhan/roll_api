class Api::V1::BaseApiController < ApplicationController
  # include ActionController::Serialization
  include Authenticable

  protect_from_forgery with: :null_session
end
