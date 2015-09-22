class Api::V1::BaseApiController < ApplicationController
  # include ActionController::Serialization
  include Authenticable

  protect_from_forgery with: :null_session
  before_filter :allow_cors
  before_filter :authenticate_with_token!, except: [:handle_cors]

  # before_filter :cors_preflight_check
  # after_filter :cors_set_access_control_headers

  # def cors_set_access_control_headers
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
  #   headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
  #   headers['Access-Control-Max-Age'] = "1728000"
  # end

  # def cors_preflight_check
  #   if request.method == 'OPTIONS'
  #     headers['Access-Control-Allow-Origin'] = '*'
  #     headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
  #     headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
  #     headers['Access-Control-Max-Age'] = '1728000'

  #     render :json => {}, status: 200
  #   end
  # end

  def handle_cors 
    p "=== handle cors ==="
    render nothing: true, status: 200
  end

private
  def allow_cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS, PATCH'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
