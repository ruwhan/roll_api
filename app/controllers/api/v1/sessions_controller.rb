class Api::V1::SessionsController < Api::V1::BaseApiController
  def create
    user_email = params[:session][:email]
    user_password = params[:session][:password]
    user = user_email.present? && User.find_by(email: user_email)

    if !user 
      render :json => { errors: "User is not exist" }, status: 422
    elsif user.valid_password? user_password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render :json => user, status: 200, location: [:v1, user]
    else
      render :json => { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    current_user.destroy

    head 204
  end

private
  def auth_hash
    request.env['omniauth.auth']
  end
end
