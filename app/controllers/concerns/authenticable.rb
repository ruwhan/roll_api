module Authenticable
  # Devise method overwrite
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers["Authorization"])
  end

  def authenticate_with_token!
    render :json => { errors: "Not authorized" }, status: :unauthorized unless current_user.present?
  end

  def user_signed_in? 
    current_user.present?
  end
end
